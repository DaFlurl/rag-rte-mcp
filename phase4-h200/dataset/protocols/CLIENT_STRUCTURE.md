# Evony Age II - Client Structure

> **"Inside the Evony Flash Client"** - Architecture and Component Analysis

---

## Overview

The Evony Age II Flash client (`EvonyClient.swf`) is a complex ActionScript 3 application. This document details its internal structure for reverse engineering purposes.

---

## Package Structure

```
com.evony/
├── client/                    # Main client code
│   ├── Main.as               # Entry point
│   ├── LoginManager.as       # Authentication
│   ├── SessionManager.as     # Connection handling
│   └── GameManager.as        # Core game logic
│
├── view/                      # UI components
│   ├── MainView.as           # Main game interface
│   ├── MapView.as            # World map rendering
│   ├── CityView.as           # City management
│   ├── BattleView.as         # Combat interface
│   └── ChatView.as           # Chat panel
│
├── model/                     # Data models
│   ├── PlayerBean.as         # Player data
│   ├── CityBean.as           # City data
│   ├── ArmyBean.as           # Army data
│   ├── HeroBean.as           # Hero data
│   └── AllianceBean.as       # Alliance data
│
├── net/                       # Networking
│   ├── SocketHandler.as      # TCP connection
│   ├── CommandFactory.as     # Command creation
│   ├── ResponseHandler.as    # Server responses
│   └── AMFSerializer.as      # AMF encoding
│
├── common/                    # Shared utilities
│   ├── constants/            # Game constants
│   ├── utils/                # Helper functions
│   └── vo/                   # Value objects
│
└── resources/                 # Asset management
    ├── AssetManager.as       # Resource loader
    ├── TextureManager.as     # Image handling
    └── SoundManager.as       # Audio handling
```

---

## Core Classes

### `Main.as` - Entry Point

```actionscript
package com.evony.client {
    import flash.display.Sprite;
    import flash.net.SharedObject;
    
    public class Main extends Sprite {
        private var _sol:SharedObject;
        private var _session:SessionManager;
        private var _gameManager:GameManager;
        
        public function Main() {
            // Load saved credentials
            _sol = SharedObject.getLocal("cevony_sol");
            
            // Initialize systems
            initialize();
        }
        
        private function initialize():void {
            // Setup managers
            _session = new SessionManager();
            _gameManager = new GameManager();
            
            // Check auto-login
            if (_sol.data.autoLogin) {
                autoLogin();
            } else {
                showLoginScreen();
            }
        }
    }
}
```

### `SessionManager.as` - Connection Handler

```actionscript
package com.evony.client {
    import flash.net.Socket;
    import flash.events.Event;
    
    public class SessionManager {
        private var _socket:Socket;
        private var _serverHost:String;
        private var _serverPort:int = 443;
        private var _sessionToken:String;
        
        public function connect(server:String):void {
            _serverHost = server;
            _socket = new Socket();
            _socket.connect(_serverHost, _serverPort);
        }
        
        public function send(command:Object):void {
            var amf:ByteArray = AMFSerializer.encode(command);
            _socket.writeBytes(amf);
            _socket.flush();
        }
    }
}
```

### `CommandFactory.as` - Command Builder

```actionscript
package com.evony.net {
    public class CommandFactory {
        private static var _seq:int = 0;
        
        public static function createCommand(
            cmd:String, 
            params:Object = null
        ):Object {
            return {
                cmd: cmd,
                seq: ++_seq,
                data: params
            };
        }
        
        // Convenience methods
        public static function login(user:String, pass:String):Object {
            return createCommand("login.login", {
                username: user,
                password: pass
            });
        }
        
        public static function attackNPC(level:int, count:int):Object {
            return createCommand("army.attackNpc", {
                level: level,
                waves: count
            });
        }
    }
}
```

---

## Data Models

### PlayerBean

```actionscript
public class PlayerBean {
    public var playerId:int;
    public var playerName:String;
    public var level:int;
    public var prestige:int;
    public var honor:int;
    public var gold:int;
    public var gameCoin:int;
    public var allianceId:int;
    public var allianceName:String;
    public var cities:Array; // CityBean[]
    public var heroes:Array; // HeroBean[]
}
```

### CityBean

```actionscript
public class CityBean {
    public var cityId:int;
    public var name:String;
    public var x:int;
    public var y:int;
    public var level:int;
    public var population:int;
    public var resources:ResourceBean;
    public var buildings:Array; // BuildingBean[]
    public var troops:TroopBean;
    public var buildQueue:Array;
    public var techQueue:Array;
}
```

### ResourceBean

```actionscript
public class ResourceBean {
    public var gold:int;
    public var food:int;
    public var wood:int;
    public var stone:int;
    public var iron:int;
    
    // Production rates per hour
    public var goldRate:int;
    public var foodRate:int;
    public var woodRate:int;
    public var stoneRate:int;
    public var ironRate:int;
}
```

---

## UI Component Hierarchy

```
MainView
├── TopPanel
│   ├── ResourceDisplay
│   ├── QuestButton
│   └── SettingsButton
├── LeftPanel
│   ├── MiniMap
│   ├── AllianceInfo
│   └── ChatPanel
├── CenterArea
│   ├── MapView (World)
│   │   ├── TileRenderer
│   │   └── UnitRenderer
│   └── CityView (City)
│       ├── BuildingGrid
│       └── QueueDisplay
├── RightPanel
│   ├── HeroList
│   └── ArmyList
└── BottomPanel
    ├── ActionBar
    └── StatusDisplay
```

---

## Event System

### Custom Events

```actionscript
// Game events
GameEvent.LOGIN_SUCCESS
GameEvent.LOGIN_FAILED
GameEvent.SESSION_EXPIRED
GameEvent.SERVER_MESSAGE

// City events
CityEvent.BUILDING_COMPLETE
CityEvent.RESEARCH_COMPLETE
CityEvent.TROOPS_TRAINED

// Army events
ArmyEvent.MARCH_STARTED
ArmyEvent.MARCH_ARRIVED
ArmyEvent.ATTACK_RESULT
ArmyEvent.DEFENSE_RESULT

// Chat events
ChatEvent.MESSAGE_RECEIVED
ChatEvent.ALLIANCE_NEWS
```

---

## Asset Structure

### Embedded Resources

```
assets/
├── ui/
│   ├── buttons/
│   ├── panels/
│   ├── icons/
│   └── backgrounds/
├── map/
│   ├── tiles/
│   ├── terrain/
│   └── decorations/
├── units/
│   ├── buildings/
│   ├── troops/
│   └── heroes/
└── audio/
    ├── ui/
    ├── battle/
    └── music/
```

### Loading System

```actionscript
AssetManager.load("map/tiles", onTilesLoaded);
AssetManager.load("units/buildings", onBuildingsLoaded);

TextureManager.getTexture("building_barracks_level_5");
SoundManager.play("battle_victory");
```

---

## Security Analysis

### Credential Storage

```actionscript
// In cevony_sol.sol
SharedObject.data = {
    username: "player",
    password: MD5("plaintext"),  // Weak!
    server: "svr12.evony.com",
    autoLogin: true,
    rememberPass: true
};
```

### Network Security

- SSL/TLS for transport
- No payload encryption
- MD5 for password hashing (weak)
- Plain session tokens

### Vulnerability Points

1. **SharedObject storage** - Unencrypted credentials
2. **MD5 passwords** - Vulnerable to rainbow tables
3. **Plain tokens** - Session hijacking possible
4. **Client-side validation** - Can be bypassed

---

## Deobfuscation Notes

### Common Obfuscation

- Renamed classes/methods
- String encryption
- Control flow obfuscation
- Dummy code insertion

### Analysis Tips

1. Search for `SharedObject` references
2. Find `Socket.connect()` calls
3. Locate string constants (URLs, commands)
4. Trace event handlers

---

## Related Documentation

- `evony_architecture.svg` - Visual client structure
- `EVONY_PROTOCOL.md` - Network protocol
- `BOT_SCRIPTING.md` - Bot integration

---

*Document Version: 1.0.0 | For educational purposes only*
