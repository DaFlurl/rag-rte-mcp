// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.StyleManagerImpl

package mx.styles
{
    import mx.core.mx_internal;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.managers.SystemManagerGlobals;
    import flash.events.IEventDispatcher;
    import mx.modules.IModuleInfo;
    import mx.events.ModuleEvent;
    import mx.core.FlexVersion;
    import flash.utils.Timer;
    import mx.modules.ModuleManager;
    import mx.events.StyleEvent;
    import flash.events.TimerEvent;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;

    use namespace mx_internal;

    public class StyleManagerImpl implements IStyleManager2 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var inheritingTextFormatStyles:Object = {
            "align":true,
            "bold":true,
            "color":true,
            "font":true,
            "indent":true,
            "italic":true,
            "size":true
        };
        private static var sizeInvalidatingStyles:Object = {
            "borderStyle":true,
            "borderThickness":true,
            "fontAntiAliasType":true,
            "fontFamily":true,
            "fontGridFitType":true,
            "fontSharpness":true,
            "fontSize":true,
            "fontStyle":true,
            "fontThickness":true,
            "fontWeight":true,
            "headerHeight":true,
            "horizontalAlign":true,
            "horizontalGap":true,
            "kerning":true,
            "leading":true,
            "letterSpacing":true,
            "paddingBottom":true,
            "paddingLeft":true,
            "paddingRight":true,
            "paddingTop":true,
            "strokeWidth":true,
            "tabHeight":true,
            "tabWidth":true,
            "verticalAlign":true,
            "verticalGap":true
        };
        private static var parentSizeInvalidatingStyles:Object = {
            "bottom":true,
            "horizontalCenter":true,
            "left":true,
            "right":true,
            "top":true,
            "verticalCenter":true,
            "baseline":true
        };
        private static var parentDisplayListInvalidatingStyles:Object = {
            "bottom":true,
            "horizontalCenter":true,
            "left":true,
            "right":true,
            "top":true,
            "verticalCenter":true,
            "baseline":true
        };
        private static var colorNames:Object = {
            "transparent":"transparent",
            "black":0,
            "blue":0xFF,
            "green":0x8000,
            "gray":0x808080,
            "silver":0xC0C0C0,
            "lime":0xFF00,
            "olive":0x808000,
            "white":0xFFFFFF,
            "yellow":0xFFFF00,
            "maroon":0x800000,
            "navy":128,
            "red":0xFF0000,
            "purple":0x800080,
            "teal":0x8080,
            "fuchsia":0xFF00FF,
            "aqua":0xFFFF,
            "magenta":0xFF00FF,
            "cyan":0xFFFF,
            "halogreen":8453965,
            "haloblue":40447,
            "haloorange":0xFFB600,
            "halosilver":11455193
        };
        private static var instance:IStyleManager2;

        private var _stylesRoot:Object;

        private var _selectors:Object = {};
        private var styleModules:Object = {};
        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _inheritingStyles:Object = {};
        private var _typeSelectorCache:Object = {};


        public static function getInstance():IStyleManager2
        {
            if (!instance)
            {
                instance = new (StyleManagerImpl)();
            };
            return (instance);
        }


        public function setStyleDeclaration(_arg_1:String, _arg_2:CSSStyleDeclaration, _arg_3:Boolean):void
        {
            _arg_2.selectorRefCount++;
            _selectors[_arg_1] = _arg_2;
            typeSelectorCache = {};
            if (_arg_3)
            {
                styleDeclarationsChanged();
            };
        }

        public function registerParentDisplayListInvalidatingStyle(_arg_1:String):void
        {
            parentDisplayListInvalidatingStyles[_arg_1] = true;
        }

        public function getStyleDeclaration(_arg_1:String):CSSStyleDeclaration
        {
            var _local_2:int;
            if (_arg_1.charAt(0) != ".")
            {
                _local_2 = _arg_1.lastIndexOf(".");
                if (_local_2 != -1)
                {
                    _arg_1 = _arg_1.substr((_local_2 + 1));
                };
            };
            return (_selectors[_arg_1]);
        }

        public function set typeSelectorCache(_arg_1:Object):void
        {
            _typeSelectorCache = _arg_1;
        }

        public function isColorName(_arg_1:String):Boolean
        {
            return (!(colorNames[_arg_1.toLowerCase()] === undefined));
        }

        public function set inheritingStyles(_arg_1:Object):void
        {
            _inheritingStyles = _arg_1;
        }

        public function getColorNames(_arg_1:Array):void
        {
            var _local_4:uint;
            if (!_arg_1)
            {
                return;
            };
            var _local_2:int = _arg_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (((!(_arg_1[_local_3] == null)) && (isNaN(_arg_1[_local_3]))))
                {
                    _local_4 = getColorName(_arg_1[_local_3]);
                    if (_local_4 != StyleManager.NOT_A_COLOR)
                    {
                        _arg_1[_local_3] = _local_4;
                    };
                };
                _local_3++;
            };
        }

        public function isInheritingTextFormatStyle(_arg_1:String):Boolean
        {
            return (inheritingTextFormatStyles[_arg_1] == true);
        }

        public function registerParentSizeInvalidatingStyle(_arg_1:String):void
        {
            parentSizeInvalidatingStyles[_arg_1] = true;
        }

        public function registerColorName(_arg_1:String, _arg_2:uint):void
        {
            colorNames[_arg_1.toLowerCase()] = _arg_2;
        }

        public function isParentSizeInvalidatingStyle(_arg_1:String):Boolean
        {
            return (parentSizeInvalidatingStyles[_arg_1] == true);
        }

        public function registerInheritingStyle(_arg_1:String):void
        {
            inheritingStyles[_arg_1] = true;
        }

        public function set stylesRoot(_arg_1:Object):void
        {
            _stylesRoot = _arg_1;
        }

        public function get typeSelectorCache():Object
        {
            return (_typeSelectorCache);
        }

        public function isParentDisplayListInvalidatingStyle(_arg_1:String):Boolean
        {
            return (parentDisplayListInvalidatingStyles[_arg_1] == true);
        }

        public function isSizeInvalidatingStyle(_arg_1:String):Boolean
        {
            return (sizeInvalidatingStyles[_arg_1] == true);
        }

        public function styleDeclarationsChanged():void
        {
            var _local_4:Object;
            var _local_1:Array = SystemManagerGlobals.topLevelSystemManagers;
            var _local_2:int = _local_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = _local_1[_local_3];
                _local_4.regenerateStyleCache(true);
                _local_4.notifyStyleChangeInChildren(null, true);
                _local_3++;
            };
        }

        public function isValidStyleValue(_arg_1:*):Boolean
        {
            return (!(_arg_1 === undefined));
        }

        public function loadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false):IEventDispatcher
        {
            return (loadStyleDeclarations2(_arg_1, _arg_2));
        }

        public function get inheritingStyles():Object
        {
            return (_inheritingStyles);
        }

        public function unloadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_4:IModuleInfo;
            var _local_3:StyleModuleInfo = styleModules[_arg_1];
            if (_local_3)
            {
                _local_3.styleModule.unload();
                _local_4 = _local_3.module;
                _local_4.unload();
                _local_4.removeEventListener(ModuleEvent.READY, _local_3.readyHandler);
                _local_4.removeEventListener(ModuleEvent.ERROR, _local_3.errorHandler);
                styleModules[_arg_1] = null;
            };
            if (_arg_2)
            {
                styleDeclarationsChanged();
            };
        }

        public function getColorName(_arg_1:Object):uint
        {
            var _local_2:Number;
            var _local_3:*;
            if ((_arg_1 is String))
            {
                if (_arg_1.charAt(0) == "#")
                {
                    _local_2 = Number(("0x" + _arg_1.slice(1)));
                    return ((isNaN(_local_2)) ? StyleManager.NOT_A_COLOR : uint(_local_2));
                };
                if (((_arg_1.charAt(1) == "x") && (_arg_1.charAt(0) == "0")))
                {
                    _local_2 = Number(_arg_1);
                    return ((isNaN(_local_2)) ? StyleManager.NOT_A_COLOR : uint(_local_2));
                };
                _local_3 = colorNames[_arg_1.toLowerCase()];
                if (_local_3 === undefined)
                {
                    return (StyleManager.NOT_A_COLOR);
                };
                return (uint(_local_3));
            };
            return (uint(_arg_1));
        }

        public function isInheritingStyle(_arg_1:String):Boolean
        {
            return (inheritingStyles[_arg_1] == true);
        }

        public function get stylesRoot():Object
        {
            return (_stylesRoot);
        }

        public function initProtoChainRoots():void
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                delete _inheritingStyles["textDecoration"];
                delete _inheritingStyles["leading"];
            };
            if (!stylesRoot)
            {
                stylesRoot = _selectors["global"].addStyleToProtoChain({}, null);
            };
        }

        public function loadStyleDeclarations2(url:String, update:Boolean=true, applicationDomain:ApplicationDomain=null, securityDomain:SecurityDomain=null):IEventDispatcher
        {
            var module:IModuleInfo;
            var styleEventDispatcher:StyleEventDispatcher;
            var timer:Timer;
            var timerHandler:Function;
            module = ModuleManager.getModule(url);
            var readyHandler:Function = function (_arg_1:ModuleEvent):void
            {
                var _local_2:IStyleModule = IStyleModule(_arg_1.module.factory.create());
                styleModules[_arg_1.module.url].styleModule = _local_2;
                if (update)
                {
                    styleDeclarationsChanged();
                };
            };
            module.addEventListener(ModuleEvent.READY, readyHandler, false, 0, true);
            styleEventDispatcher = new StyleEventDispatcher(module);
            var errorHandler:Function = function (_arg_1:ModuleEvent):void
            {
                var _local_3:StyleEvent;
                var _local_2:String = resourceManager.getString("styles", "unableToLoad", [_arg_1.errorText, url]);
                if (styleEventDispatcher.willTrigger(StyleEvent.ERROR))
                {
                    _local_3 = new StyleEvent(StyleEvent.ERROR, _arg_1.bubbles, _arg_1.cancelable);
                    _local_3.bytesLoaded = 0;
                    _local_3.bytesTotal = 0;
                    _local_3.errorText = _local_2;
                    styleEventDispatcher.dispatchEvent(_local_3);
                }
                else
                {
                    throw (new Error(_local_2));
                };
            };
            module.addEventListener(ModuleEvent.ERROR, errorHandler, false, 0, true);
            styleModules[url] = new StyleModuleInfo(module, readyHandler, errorHandler);
            timer = new Timer(0);
            timerHandler = function (_arg_1:TimerEvent):void
            {
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                timer.stop();
                module.load(applicationDomain, securityDomain);
            };
            timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
            timer.start();
            return (styleEventDispatcher);
        }

        public function registerSizeInvalidatingStyle(_arg_1:String):void
        {
            sizeInvalidatingStyles[_arg_1] = true;
        }

        public function clearStyleDeclaration(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:CSSStyleDeclaration = getStyleDeclaration(_arg_1);
            if (((_local_3) && (_local_3.selectorRefCount > 0)))
            {
                _local_3.selectorRefCount--;
            };
            delete _selectors[_arg_1];
            if (_arg_2)
            {
                styleDeclarationsChanged();
            };
        }

        public function get selectors():Array
        {
            var _local_2:String;
            var _local_1:Array = [];
            for (_local_2 in _selectors)
            {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }


    }
}//package mx.styles

import flash.events.EventDispatcher;
import mx.events.ModuleEvent;
import mx.modules.IModuleInfo;
import mx.events.StyleEvent;
import mx.styles.IStyleModule;

class StyleEventDispatcher extends EventDispatcher 
{

    public function StyleEventDispatcher(_arg_1:IModuleInfo)
    {
        _arg_1.addEventListener(ModuleEvent.ERROR, moduleInfo_errorHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.PROGRESS, moduleInfo_progressHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.READY, moduleInfo_readyHandler, false, 0, true);
    }

    /*private*/ function moduleInfo_progressHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:StyleEvent = new StyleEvent(StyleEvent.PROGRESS, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        dispatchEvent(_local_2);
    }

    /*private*/ function moduleInfo_readyHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:StyleEvent = new StyleEvent(StyleEvent.COMPLETE);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        dispatchEvent(_local_2);
    }

    /*private*/ function moduleInfo_errorHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:StyleEvent = new StyleEvent(StyleEvent.ERROR, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        _local_2.errorText = _arg_1.errorText;
        dispatchEvent(_local_2);
    }


}

class StyleModuleInfo 
{

    public var errorHandler:Function;
    public var readyHandler:Function;
    public var module:IModuleInfo;
    public var styleModule:IStyleModule;

    public function StyleModuleInfo(_arg_1:IModuleInfo, _arg_2:Function, _arg_3:Function)
    {
        this.module = _arg_1;
        this.readyHandler = _arg_2;
        this.errorHandler = _arg_3;
    }

}


