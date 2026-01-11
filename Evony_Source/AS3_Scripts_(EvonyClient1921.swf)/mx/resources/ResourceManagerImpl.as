// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.resources.ResourceManagerImpl

package mx.resources
{
    import flash.events.EventDispatcher;
    import mx.core.mx_internal;
    import mx.utils.StringUtil;
    import flash.system.ApplicationDomain;
    import mx.modules.IModuleInfo;
    import flash.utils.Timer;
    import mx.modules.ModuleManager;
    import mx.events.ModuleEvent;
    import mx.events.ResourceEvent;
    import flash.events.TimerEvent;
    import flash.system.SecurityDomain;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import flash.system.Capabilities;

    use namespace mx_internal;

    public class ResourceManagerImpl extends EventDispatcher implements IResourceManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var instance:IResourceManager;

        private var initializedForNonFrameworkApp:Boolean = false;
        private var _localeChain:Array;

        private var localeMap:Object = {};
        private var resourceModules:Object = {};


        public static function getInstance():IResourceManager
        {
            if (!instance)
            {
                instance = new (ResourceManagerImpl)();
            };
            return (instance);
        }


        public function get localeChain():Array
        {
            return (_localeChain);
        }

        public function set localeChain(_arg_1:Array):void
        {
            _localeChain = _arg_1;
            update();
        }

        [Bindable("change")]
        public function getStringArray(_arg_1:String, _arg_2:String, _arg_3:String=null):Array
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (null);
            };
            var _local_5:* = _local_4.content[_arg_2];
            var _local_6:Array = String(_local_5).split(",");
            var _local_7:int = _local_6.length;
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                _local_6[_local_8] = StringUtil.trim(_local_6[_local_8]);
                _local_8++;
            };
            return (_local_6);
        }

        mx_internal function installCompiledResourceBundle(_arg_1:ApplicationDomain, _arg_2:String, _arg_3:String):void
        {
            var _local_4:String;
            var _local_5:String = _arg_3;
            var _local_6:int = _arg_3.indexOf(":");
            if (_local_6 != -1)
            {
                _local_4 = _arg_3.substring(0, _local_6);
                _local_5 = _arg_3.substring((_local_6 + 1));
            };
            if (getResourceBundle(_arg_2, _arg_3))
            {
                return;
            };
            var _local_7:* = (((_arg_2 + "$") + _local_5) + "_properties");
            if (_local_4 != null)
            {
                _local_7 = ((_local_4 + ".") + _local_7);
            };
            var _local_8:Class;
            if (_arg_1.hasDefinition(_local_7))
            {
                _local_8 = Class(_arg_1.getDefinition(_local_7));
            };
            if (!_local_8)
            {
                _local_7 = _arg_3;
                if (_arg_1.hasDefinition(_local_7))
                {
                    _local_8 = Class(_arg_1.getDefinition(_local_7));
                };
            };
            if (!_local_8)
            {
                _local_7 = (_arg_3 + "_properties");
                if (_arg_1.hasDefinition(_local_7))
                {
                    _local_8 = Class(_arg_1.getDefinition(_local_7));
                };
            };
            if (!_local_8)
            {
                throw (new Error((((("Could not find compiled resource bundle '" + _arg_3) + "' for locale '") + _arg_2) + "'.")));
            };
            var _local_9:ResourceBundle = ResourceBundle(new (_local_8)());
            _local_9.mx_internal::_locale = _arg_2;
            _local_9.mx_internal::_bundleName = _arg_3;
            addResourceBundle(_local_9);
        }

        [Bindable("change")]
        public function getString(_arg_1:String, _arg_2:String, _arg_3:Array=null, _arg_4:String=null):String
        {
            var _local_5:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_4);
            if (!_local_5)
            {
                return (null);
            };
            var _local_6:String = String(_local_5.content[_arg_2]);
            if (_arg_3)
            {
                _local_6 = StringUtil.substitute(_local_6, _arg_3);
            };
            return (_local_6);
        }

        public function loadResourceModule(url:String, updateFlag:Boolean=true, applicationDomain:ApplicationDomain=null, securityDomain:SecurityDomain=null):IEventDispatcher
        {
            var moduleInfo:IModuleInfo;
            var resourceEventDispatcher:ResourceEventDispatcher;
            var timer:Timer;
            var timerHandler:Function;
            moduleInfo = ModuleManager.getModule(url);
            resourceEventDispatcher = new ResourceEventDispatcher(moduleInfo);
            var readyHandler:Function = function (_arg_1:ModuleEvent):void
            {
                var _local_2:* = _arg_1.module.factory.create();
                resourceModules[_arg_1.module.url].resourceModule = _local_2;
                if (updateFlag)
                {
                    update();
                };
            };
            moduleInfo.addEventListener(ModuleEvent.READY, readyHandler, false, 0, true);
            var errorHandler:Function = function (_arg_1:ModuleEvent):void
            {
                var _local_3:ResourceEvent;
                var _local_2:String = ("Unable to load resource module from " + url);
                if (resourceEventDispatcher.willTrigger(ResourceEvent.ERROR))
                {
                    _local_3 = new ResourceEvent(ResourceEvent.ERROR, _arg_1.bubbles, _arg_1.cancelable);
                    _local_3.bytesLoaded = 0;
                    _local_3.bytesTotal = 0;
                    _local_3.errorText = _local_2;
                    resourceEventDispatcher.dispatchEvent(_local_3);
                }
                else
                {
                    throw (new Error(_local_2));
                };
            };
            moduleInfo.addEventListener(ModuleEvent.ERROR, errorHandler, false, 0, true);
            resourceModules[url] = new ResourceModuleInfo(moduleInfo, readyHandler, errorHandler);
            timer = new Timer(0);
            timerHandler = function (_arg_1:TimerEvent):void
            {
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                timer.stop();
                moduleInfo.load(applicationDomain, securityDomain);
            };
            timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
            timer.start();
            return (resourceEventDispatcher);
        }

        public function getLocales():Array
        {
            var _local_2:String;
            var _local_1:Array = [];
            for (_local_2 in localeMap)
            {
                _local_1.push(_local_2);
            };
            return (_local_1);
        }

        public function removeResourceBundlesForLocale(_arg_1:String):void
        {
            delete localeMap[_arg_1];
        }

        public function getResourceBundle(_arg_1:String, _arg_2:String):IResourceBundle
        {
            var _local_3:Object = localeMap[_arg_1];
            if (!_local_3)
            {
                return (null);
            };
            return (_local_3[_arg_2]);
        }

        private function dumpResourceModule(_arg_1:*):void
        {
            var _local_2:ResourceBundle;
            var _local_3:String;
            for each (_local_2 in _arg_1.resourceBundles)
            {
                trace(_local_2.locale, _local_2.bundleName);
                for (_local_3 in _local_2.content)
                {
                };
            };
        }

        public function addResourceBundle(_arg_1:IResourceBundle):void
        {
            var _local_2:String = _arg_1.locale;
            var _local_3:String = _arg_1.bundleName;
            if (!localeMap[_local_2])
            {
                localeMap[_local_2] = {};
            };
            localeMap[_local_2][_local_3] = _arg_1;
        }

        [Bindable("change")]
        public function getObject(_arg_1:String, _arg_2:String, _arg_3:String=null):*
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (undefined);
            };
            return (_local_4.content[_arg_2]);
        }

        [Bindable("change")]
        public function getInt(_arg_1:String, _arg_2:String, _arg_3:String=null):int
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (0);
            };
            var _local_5:* = _local_4.content[_arg_2];
            return (int(_local_5));
        }

        private function findBundle(_arg_1:String, _arg_2:String, _arg_3:String):IResourceBundle
        {
            supportNonFrameworkApps();
            return ((_arg_3 != null) ? getResourceBundle(_arg_3, _arg_1) : findResourceBundleWithResource(_arg_1, _arg_2));
        }

        private function supportNonFrameworkApps():void
        {
            if (initializedForNonFrameworkApp)
            {
                return;
            };
            initializedForNonFrameworkApp = true;
            if (getLocales().length > 0)
            {
                return;
            };
            var _local_1:ApplicationDomain = ApplicationDomain.currentDomain;
            if (!_local_1.hasDefinition("_CompiledResourceBundleInfo"))
            {
                return;
            };
            var _local_2:Class = Class(_local_1.getDefinition("_CompiledResourceBundleInfo"));
            var _local_3:Array = _local_2.compiledLocales;
            var _local_4:Array = _local_2.compiledResourceBundleNames;
            installCompiledResourceBundles(_local_1, _local_3, _local_4);
            localeChain = _local_3;
        }

        public function getBundleNamesForLocale(_arg_1:String):Array
        {
            var _local_3:String;
            var _local_2:Array = [];
            for (_local_3 in localeMap[_arg_1])
            {
                _local_2.push(_local_3);
            };
            return (_local_2);
        }

        public function getPreferredLocaleChain():Array
        {
            return (LocaleSorter.sortLocalesByPreference(getLocales(), getSystemPreferredLocales(), null, true));
        }

        [Bindable("change")]
        public function getNumber(_arg_1:String, _arg_2:String, _arg_3:String=null):Number
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (NaN);
            };
            var _local_5:* = _local_4.content[_arg_2];
            return (Number(_local_5));
        }

        public function update():void
        {
            dispatchEvent(new Event(Event.CHANGE));
        }

        [Bindable("change")]
        public function getClass(_arg_1:String, _arg_2:String, _arg_3:String=null):Class
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (null);
            };
            var _local_5:* = _local_4.content[_arg_2];
            return (_local_5 as Class);
        }

        public function removeResourceBundle(_arg_1:String, _arg_2:String):void
        {
            delete localeMap[_arg_1][_arg_2];
            if (getBundleNamesForLocale(_arg_1).length == 0)
            {
                delete localeMap[_arg_1];
            };
        }

        public function initializeLocaleChain(_arg_1:Array):void
        {
            localeChain = LocaleSorter.sortLocalesByPreference(_arg_1, getSystemPreferredLocales(), null, true);
        }

        public function findResourceBundleWithResource(_arg_1:String, _arg_2:String):IResourceBundle
        {
            var _local_5:String;
            var _local_6:Object;
            var _local_7:ResourceBundle;
            if (!_localeChain)
            {
                return (null);
            };
            var _local_3:int = _localeChain.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = localeChain[_local_4];
                _local_6 = localeMap[_local_5];
                if (_local_6)
                {
                    _local_7 = _local_6[_arg_1];
                    if (_local_7)
                    {
                        if ((_arg_2 in _local_7.content))
                        {
                            return (_local_7);
                        };
                    };
                };
                _local_4++;
            };
            return (null);
        }

        [Bindable("change")]
        public function getUint(_arg_1:String, _arg_2:String, _arg_3:String=null):uint
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (0);
            };
            var _local_5:* = _local_4.content[_arg_2];
            return (uint(_local_5));
        }

        private function getSystemPreferredLocales():Array
        {
            var _local_1:Array;
            if (Capabilities["languages"])
            {
                _local_1 = Capabilities["languages"];
            }
            else
            {
                _local_1 = [Capabilities.language];
            };
            return (_local_1);
        }

        public function installCompiledResourceBundles(_arg_1:ApplicationDomain, _arg_2:Array, _arg_3:Array):void
        {
            var _local_7:String;
            var _local_8:int;
            var _local_9:String;
            var _local_4:int = ((_arg_2) ? _arg_2.length : 0);
            var _local_5:int = ((_arg_3) ? _arg_3.length : 0);
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                _local_7 = _arg_2[_local_6];
                _local_8 = 0;
                while (_local_8 < _local_5)
                {
                    _local_9 = _arg_3[_local_8];
                    (mx_internal::installCompiledResourceBundle(_arg_1, _local_7, _local_9));
                    _local_8++;
                };
                _local_6++;
            };
        }

        [Bindable("change")]
        public function getBoolean(_arg_1:String, _arg_2:String, _arg_3:String=null):Boolean
        {
            var _local_4:IResourceBundle = findBundle(_arg_1, _arg_2, _arg_3);
            if (!_local_4)
            {
                return (false);
            };
            var _local_5:* = _local_4.content[_arg_2];
            return (String(_local_5).toLowerCase() == "true");
        }

        public function unloadResourceModule(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_3:ResourceModuleInfo = resourceModules[_arg_1];
            if (!_local_3)
            {
                return;
            };
            if (_local_3.resourceModule)
            {
                _local_4 = _local_3.resourceModule.resourceBundles;
                if (_local_4)
                {
                    _local_5 = _local_4.length;
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        _local_7 = _local_4[_local_6].locale;
                        _local_8 = _local_4[_local_6].bundleName;
                        removeResourceBundle(_local_7, _local_8);
                        _local_6++;
                    };
                };
            };
            resourceModules[_arg_1] = null;
            delete resourceModules[_arg_1];
            _local_3.moduleInfo.unload();
            if (_arg_2)
            {
                this.update();
            };
        }


    }
}//package mx.resources

import mx.resources.IResourceModule;
import mx.modules.IModuleInfo;
import flash.events.EventDispatcher;
import mx.events.ModuleEvent;
import mx.events.ResourceEvent;

class ResourceModuleInfo 
{

    public var resourceModule:IResourceModule;
    public var errorHandler:Function;
    public var readyHandler:Function;
    public var moduleInfo:IModuleInfo;

    public function ResourceModuleInfo(_arg_1:IModuleInfo, _arg_2:Function, _arg_3:Function)
    {
        this.moduleInfo = _arg_1;
        this.readyHandler = _arg_2;
        this.errorHandler = _arg_3;
    }

}

class ResourceEventDispatcher extends EventDispatcher 
{

    public function ResourceEventDispatcher(_arg_1:IModuleInfo)
    {
        _arg_1.addEventListener(ModuleEvent.ERROR, moduleInfo_errorHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.PROGRESS, moduleInfo_progressHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.READY, moduleInfo_readyHandler, false, 0, true);
    }

    /*private*/ function moduleInfo_progressHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:ResourceEvent = new ResourceEvent(ResourceEvent.PROGRESS, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        dispatchEvent(_local_2);
    }

    /*private*/ function moduleInfo_readyHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:ResourceEvent = new ResourceEvent(ResourceEvent.COMPLETE);
        dispatchEvent(_local_2);
    }

    /*private*/ function moduleInfo_errorHandler(_arg_1:ModuleEvent):void
    {
        var _local_2:ResourceEvent = new ResourceEvent(ResourceEvent.ERROR, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        _local_2.errorText = _arg_1.errorText;
        dispatchEvent(_local_2);
    }


}


