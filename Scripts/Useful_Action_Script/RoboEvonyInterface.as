package com.evony.useful {
    import flash.events.EventDispatcher;
    import flash.events.Event;
    
    public class RoboEvonyInterface extends EventDispatcher {
        private static var _instance:RoboEvonyInterface;
        private var _scriptManager:ScriptManager;
        private var _activeScripts:Object = {};
        private var _selectedCities:Array = [];
        
        // Script window states
        private var _goalWindowActive:Boolean = false;
        private var _actionWindowActive:Boolean = false;
        
        public function RoboEvonyInterface() {
            if (_instance) {
                throw new Error("Singleton - use getInstance()");
            }
            initialize();
        }
        
        public static function getInstance():RoboEvonyInterface {
            if (!_instance) {
                _instance = new RoboEvonyInterface();
            }
            return _instance;
        }
        
        private function initialize():void {
            _scriptManager = ScriptManager.getInstance();
            initializeRoboEvonyHooks();
        }
        
        /**
         * Initialize hooks into RoboEvony's script windows
         */
        private function initializeRoboEvonyHooks():void {
            // Hook into RoboEvony's script windows
            try {
                // Connect to Goals window
                RoboEvony.goals.addEventListener(
                    "scriptStart",
                    onGoalScriptStart
                );
                RoboEvony.goals.addEventListener(
                    "scriptStop",
                    onGoalScriptStop
                );
                
                // Connect to Actions window
                RoboEvony.actions.addEventListener(
                    "scriptStart",
                    onActionScriptStart
                );
                RoboEvony.actions.addEventListener(
                    "scriptStop",
                    onActionScriptStop
                );
                
                // Connect to city selection
                RoboEvony.cities.addEventListener(
                    "selectionChange",
                    onCitySelectionChange
                );
            } catch (e:Error) {
                trace("Error connecting to RoboEvony: " + e.message);
            }
        }
        
        /**
         * Send script to RoboEvony's script window
         */
        public function sendToScriptWindow(
            script:String,
            type:String = "action",
            cities:Array = null
        ):Object {
            var result:Object = {
                success: false,
                scriptId: "",
                errors: [],
                targetCities: []
            };
            
            try {
                // Validate script
                validateScript(script);
                
                // Generate unique script ID
                var scriptId:String = generateScriptId();
                
                // Determine target cities
                var targetCities:Array = cities || _selectedCities;
                if (targetCities.length == 0) {
                    targetCities = RoboEvony.cities.getAllCities();
                }
                
                // Send to appropriate window
                if (type == "goal" && _goalWindowActive) {
                    RoboEvony.goals.loadScript(script, targetCities);
                    result.scriptId = "goal_" + scriptId;
                } else if (type == "action" && _actionWindowActive) {
                    RoboEvony.actions.loadScript(script, targetCities);
                    result.scriptId = "action_" + scriptId;
                } else {
                    throw new Error("Script window not active: " + type);
                }
                
                // Track active script
                _activeScripts[result.scriptId] = {
                    type: type,
                    cities: targetCities,
                    content: script,
                    startTime: new Date().time
                };
                
                result.success = true;
                result.targetCities = targetCities;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Stop a running script
         */
        public function stopScript(scriptId:String):Boolean {
            if (!_activeScripts[scriptId]) {
                return false;
            }
            
            var script:Object = _activeScripts[scriptId];
            
            try {
                if (script.type == "goal") {
                    RoboEvony.goals.stopScript(scriptId);
                } else {
                    RoboEvony.actions.stopScript(scriptId);
                }
                
                delete _activeScripts[scriptId];
                return true;
            } catch (e:Error) {
                trace("Error stopping script: " + e.message);
                return false;
            }
        }
        
        /**
         * Get active scripts
         */
        public function getActiveScripts():Object {
            return _activeScripts;
        }
        
        /**
         * Set window state
         */
        public function setWindowState(
            window:String,
            active:Boolean
        ):void {
            if (window == "goal") {
                _goalWindowActive = active;
            } else if (window == "action") {
                _actionWindowActive = active;
            }
        }
        
        /**
         * Update selected cities
         */
        public function updateSelectedCities(cities:Array):void {
            _selectedCities = cities;
        }
        
        /**
         * Generate script from AI chat
         */
        public function generateScriptFromChat(
            intent:String,
            params:Object,
            cities:Array = null
        ):Object {
            var result:Object = {
                success: false,
                script: "",
                errors: []
            };
            
            try {
                // Determine script type and template
                var scriptType:String = determineScriptType(intent);
                var template:Object = _scriptManager.getTemplates()[scriptType];
                
                if (!template) {
                    throw new Error("No template found for intent: " + intent);
                }
                
                // Generate script
                var script:String = ScriptTemplate.generateScript(
                    scriptType,
                    template.subtype,
                    params
                );
                
                // Send to RoboEvony
                var sendResult:Object = sendToScriptWindow(
                    script,
                    "action",
                    cities
                );
                
                if (!sendResult.success) {
                    throw new Error(
                        "Failed to send script: " + 
                        sendResult.errors.join(", ")
                    );
                }
                
                result.success = true;
                result.script = script;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        // Event handlers
        private function onGoalScriptStart(e:Event):void {
            // Handle script start in Goals window
        }
        
        private function onGoalScriptStop(e:Event):void {
            // Handle script stop in Goals window
        }
        
        private function onActionScriptStart(e:Event):void {
            // Handle script start in Actions window
        }
        
        private function onActionScriptStop(e:Event):void {
            // Handle script stop in Actions window
        }
        
        private function onCitySelectionChange(e:Event):void {
            // Update selected cities
            _selectedCities = RoboEvony.cities.getSelectedCities();
        }
        
        // Helper functions
        private function validateScript(script:String):void {
            // Basic validation
            if (!script || script.length == 0) {
                throw new Error("Empty script");
            }
            
            // Check for common syntax errors
            if (script.indexOf("function") == -1) {
                throw new Error("Script must contain at least one function");
            }
            
            // Add more validation as needed
        }
        
        private function generateScriptId():String {
            return new Date().time.toString() + 
                   "_" + 
                   Math.floor(Math.random() * 1000);
        }
        
        private function determineScriptType(intent:String):String {
            // Map chat intent to script type
            var intentMap:Object = {
                "attack": "battle",
                "gather": "resource",
                "build": "timing",
                "research": "timing",
                "transport": "resource",
                "train": "battle"
            };
            
            return intentMap[intent.toLowerCase()] || "action";
        }
    }
}
