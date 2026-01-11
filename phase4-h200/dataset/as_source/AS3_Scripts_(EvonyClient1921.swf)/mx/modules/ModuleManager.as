// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.modules.ModuleManager

package mx.modules
{
    import mx.core.mx_internal;
    import mx.core.IFlexModuleFactory;

    use namespace mx_internal;

    public class ModuleManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function getModule(_arg_1:String):IModuleInfo
        {
            return (getSingleton().getModule(_arg_1));
        }

        private static function getSingleton():Object
        {
            if (!ModuleManagerGlobals.managerSingleton)
            {
                ModuleManagerGlobals.managerSingleton = new ModuleManagerImpl();
            };
            return (ModuleManagerGlobals.managerSingleton);
        }

        public static function getAssociatedFactory(_arg_1:Object):IFlexModuleFactory
        {
            return (getSingleton().getAssociatedFactory(_arg_1));
        }


    }
}//package mx.modules

import flash.events.EventDispatcher;
import mx.modules.IModuleInfo;
import mx.events.ModuleEvent;
import mx.core.IFlexModuleFactory;
import flash.system.ApplicationDomain;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;
import flash.utils.getQualifiedClassName;
import flash.display.Loader;
import flash.utils.Dictionary;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.events.ErrorEvent;
import flash.system.LoaderContext;
import flash.net.URLRequest;
import flash.system.Security;

class ModuleInfoProxy extends EventDispatcher implements IModuleInfo 
{

    /*private*/ var _data:Object;
    /*private*/ var info:ModuleInfo;
    /*private*/ var referenced:Boolean = false;

    public function ModuleInfoProxy(_arg_1:ModuleInfo)
    {
        this.info = _arg_1;
        _arg_1.addEventListener(ModuleEvent.SETUP, moduleEventHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.PROGRESS, moduleEventHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.READY, moduleEventHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.ERROR, moduleEventHandler, false, 0, true);
        _arg_1.addEventListener(ModuleEvent.UNLOAD, moduleEventHandler, false, 0, true);
    }

    public function get loaded():Boolean
    {
        return (info.loaded);
    }

    public function release():void
    {
        if (referenced)
        {
            info.removeReference();
            referenced = false;
        };
    }

    public function get error():Boolean
    {
        return (info.error);
    }

    public function get factory():IFlexModuleFactory
    {
        return (info.factory);
    }

    public function publish(_arg_1:IFlexModuleFactory):void
    {
        info.publish(_arg_1);
    }

    public function set data(_arg_1:Object):void
    {
        _data = _arg_1;
    }

    public function get ready():Boolean
    {
        return (info.ready);
    }

    public function load(_arg_1:ApplicationDomain=null, _arg_2:SecurityDomain=null, _arg_3:ByteArray=null):void
    {
        var _local_4:ModuleEvent;
        info.resurrect();
        if (!referenced)
        {
            info.addReference();
            referenced = true;
        };
        if (info.error)
        {
            dispatchEvent(new ModuleEvent(ModuleEvent.ERROR));
        }
        else
        {
            if (info.loaded)
            {
                if (info.setup)
                {
                    dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
                    if (info.ready)
                    {
                        _local_4 = new ModuleEvent(ModuleEvent.PROGRESS);
                        _local_4.bytesLoaded = info.size;
                        _local_4.bytesTotal = info.size;
                        dispatchEvent(_local_4);
                        dispatchEvent(new ModuleEvent(ModuleEvent.READY));
                    };
                };
            }
            else
            {
                info.load(_arg_1, _arg_2, _arg_3);
            };
        };
    }

    /*private*/ function moduleEventHandler(_arg_1:ModuleEvent):void
    {
        dispatchEvent(_arg_1);
    }

    public function get url():String
    {
        return (info.url);
    }

    public function get data():Object
    {
        return (_data);
    }

    public function get setup():Boolean
    {
        return (info.setup);
    }

    public function unload():void
    {
        info.unload();
        info.removeEventListener(ModuleEvent.SETUP, moduleEventHandler);
        info.removeEventListener(ModuleEvent.PROGRESS, moduleEventHandler);
        info.removeEventListener(ModuleEvent.READY, moduleEventHandler);
        info.removeEventListener(ModuleEvent.ERROR, moduleEventHandler);
        info.removeEventListener(ModuleEvent.UNLOAD, moduleEventHandler);
    }


}

class ModuleManagerImpl extends EventDispatcher 
{

    /*private*/ var moduleList:Object = {};


    public function getModule(_arg_1:String):IModuleInfo
    {
        var _local_2:ModuleInfo = (moduleList[_arg_1] as ModuleInfo);
        if (!_local_2)
        {
            _local_2 = new ModuleInfo(_arg_1);
            moduleList[_arg_1] = _local_2;
        };
        return (new ModuleInfoProxy(_local_2));
    }

    public function getAssociatedFactory(object:Object):IFlexModuleFactory
    {
        var m:Object;
        var info:ModuleInfo;
        var domain:ApplicationDomain;
        var cls:Class;
        var className:String = getQualifiedClassName(object);
        for each (m in moduleList)
        {
            info = (m as ModuleInfo);
            if (info.ready)
            {
                domain = info.applicationDomain;
                try
                {
                    cls = Class(domain.getDefinition(className));
                    if ((object is cls))
                    {
                        return (info.factory);
                    };
                }
                catch(error:Error)
                {
                };
            };
        };
        return (null);
    }


}

class ModuleInfo extends EventDispatcher 
{

    /*private*/ var _error:Boolean = false;
    /*private*/ var loader:Loader;
    /*private*/ var factoryInfo:FactoryInfo;
    /*private*/ var limbo:Dictionary;
    /*private*/ var _loaded:Boolean = false;
    /*private*/ var _ready:Boolean = false;
    /*private*/ var numReferences:int = 0;
    /*private*/ var _url:String;
    /*private*/ var _setup:Boolean = false;

    public function ModuleInfo(_arg_1:String)
    {
        _url = _arg_1;
    }

    /*private*/ function clearLoader():void
    {
        if (loader)
        {
            if (loader.contentLoaderInfo)
            {
                loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
                loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
                loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
                loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            };
            try
            {
                if (loader.content)
                {
                    loader.content.removeEventListener("ready", readyHandler);
                    loader.content.removeEventListener("error", moduleErrorHandler);
                };
            }
            catch(error:Error)
            {
            };
            if (_loaded)
            {
                try
                {
                    loader.close();
                }
                catch(error:Error)
                {
                };
            };
            try
            {
                loader.unload();
            }
            catch(error:Error)
            {
            };
            loader = null;
        };
    }

    public function get size():int
    {
        return (((!(limbo)) && (factoryInfo)) ? factoryInfo.bytesTotal : 0);
    }

    public function get loaded():Boolean
    {
        return ((limbo) ? false : _loaded);
    }

    public function release():void
    {
        if (((_ready) && (!(limbo))))
        {
            limbo = new Dictionary(true);
            limbo[factoryInfo] = 1;
            factoryInfo = null;
        }
        else
        {
            unload();
        };
    }

    public function get error():Boolean
    {
        return ((limbo) ? false : _error);
    }

    public function get factory():IFlexModuleFactory
    {
        return (((!(limbo)) && (factoryInfo)) ? factoryInfo.factory : null);
    }

    public function completeHandler(_arg_1:Event):void
    {
        var _local_2:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = loader.contentLoaderInfo.bytesLoaded;
        _local_2.bytesTotal = loader.contentLoaderInfo.bytesTotal;
        dispatchEvent(_local_2);
    }

    public function publish(_arg_1:IFlexModuleFactory):void
    {
        if (factoryInfo)
        {
            return;
        };
        if (_url.indexOf("published://") != 0)
        {
            return;
        };
        factoryInfo = new FactoryInfo();
        factoryInfo.factory = _arg_1;
        _loaded = true;
        _setup = true;
        _ready = true;
        _error = false;
        dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
        dispatchEvent(new ModuleEvent(ModuleEvent.PROGRESS));
        dispatchEvent(new ModuleEvent(ModuleEvent.READY));
    }

    public function initHandler(event:Event):void
    {
        var moduleEvent:ModuleEvent;
        factoryInfo = new FactoryInfo();
        try
        {
            factoryInfo.factory = (loader.content as IFlexModuleFactory);
        }
        catch(error:Error)
        {
        };
        if (!factoryInfo.factory)
        {
            moduleEvent = new ModuleEvent(ModuleEvent.ERROR, event.bubbles, event.cancelable);
            moduleEvent.bytesLoaded = 0;
            moduleEvent.bytesTotal = 0;
            moduleEvent.errorText = "SWF is not a loadable module";
            dispatchEvent(moduleEvent);
            return;
        };
        loader.content.addEventListener("ready", readyHandler);
        loader.content.addEventListener("error", moduleErrorHandler);
        try
        {
            factoryInfo.applicationDomain = loader.contentLoaderInfo.applicationDomain;
        }
        catch(error:Error)
        {
        };
        _setup = true;
        dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
    }

    public function resurrect():void
    {
        var _local_1:Object;
        if (((!(factoryInfo)) && (limbo)))
        {
            for (_local_1 in limbo)
            {
                factoryInfo = (_local_1 as FactoryInfo);
                break;
            };
            limbo = null;
        };
        if (!factoryInfo)
        {
            if (_loaded)
            {
                dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
            };
            loader = null;
            _loaded = false;
            _setup = false;
            _ready = false;
            _error = false;
        };
    }

    public function errorHandler(_arg_1:ErrorEvent):void
    {
        _error = true;
        var _local_2:ModuleEvent = new ModuleEvent(ModuleEvent.ERROR, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = 0;
        _local_2.bytesTotal = 0;
        _local_2.errorText = _arg_1.text;
        dispatchEvent(_local_2);
    }

    public function get ready():Boolean
    {
        return ((limbo) ? false : _ready);
    }

    /*private*/ function loadBytes(_arg_1:ApplicationDomain, _arg_2:ByteArray):void
    {
        var _local_3:LoaderContext = new LoaderContext();
        _local_3.applicationDomain = ((_arg_1) ? _arg_1 : new ApplicationDomain(ApplicationDomain.currentDomain));
        if (("allowLoadBytesCodeExecution" in _local_3))
        {
            _local_3["allowLoadBytesCodeExecution"] = true;
        };
        loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        loader.loadBytes(_arg_2, _local_3);
    }

    public function removeReference():void
    {
        numReferences--;
        if (numReferences == 0)
        {
            release();
        };
    }

    public function addReference():void
    {
        numReferences++;
    }

    public function progressHandler(_arg_1:ProgressEvent):void
    {
        var _local_2:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS, _arg_1.bubbles, _arg_1.cancelable);
        _local_2.bytesLoaded = _arg_1.bytesLoaded;
        _local_2.bytesTotal = _arg_1.bytesTotal;
        dispatchEvent(_local_2);
    }

    public function load(_arg_1:ApplicationDomain=null, _arg_2:SecurityDomain=null, _arg_3:ByteArray=null):void
    {
        if (_loaded)
        {
            return;
        };
        _loaded = true;
        limbo = null;
        if (_arg_3)
        {
            loadBytes(_arg_1, _arg_3);
            return;
        };
        if (_url.indexOf("published://") == 0)
        {
            return;
        };
        var _local_4:URLRequest = new URLRequest(_url);
        var _local_5:LoaderContext = new LoaderContext();
        _local_5.applicationDomain = ((_arg_1) ? _arg_1 : new ApplicationDomain(ApplicationDomain.currentDomain));
        _local_5.securityDomain = _arg_2;
        if (((_arg_2 == null) && (Security.sandboxType == Security.REMOTE)))
        {
            _local_5.securityDomain = SecurityDomain.currentDomain;
        };
        loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        loader.load(_local_4, _local_5);
    }

    public function get url():String
    {
        return (_url);
    }

    public function get applicationDomain():ApplicationDomain
    {
        return (((!(limbo)) && (factoryInfo)) ? factoryInfo.applicationDomain : null);
    }

    public function moduleErrorHandler(_arg_1:Event):void
    {
        var _local_2:ModuleEvent;
        _ready = true;
        factoryInfo.bytesTotal = loader.contentLoaderInfo.bytesTotal;
        clearLoader();
        if ((_arg_1 is ModuleEvent))
        {
            _local_2 = ModuleEvent(_arg_1);
        }
        else
        {
            _local_2 = new ModuleEvent(ModuleEvent.ERROR);
        };
        dispatchEvent(_local_2);
    }

    public function readyHandler(_arg_1:Event):void
    {
        _ready = true;
        factoryInfo.bytesTotal = loader.contentLoaderInfo.bytesTotal;
        var _local_2:ModuleEvent = new ModuleEvent(ModuleEvent.READY);
        _local_2.bytesLoaded = loader.contentLoaderInfo.bytesLoaded;
        _local_2.bytesTotal = loader.contentLoaderInfo.bytesTotal;
        clearLoader();
        dispatchEvent(_local_2);
    }

    public function get setup():Boolean
    {
        return ((limbo) ? false : _setup);
    }

    public function unload():void
    {
        clearLoader();
        if (_loaded)
        {
            dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
        };
        limbo = null;
        factoryInfo = null;
        _loaded = false;
        _setup = false;
        _ready = false;
        _error = false;
    }


}

class FactoryInfo 
{

    public var bytesTotal:int = 0;
    public var factory:IFlexModuleFactory;
    public var applicationDomain:ApplicationDomain;


}


