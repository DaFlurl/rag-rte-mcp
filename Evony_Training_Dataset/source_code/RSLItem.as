// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.RSLItem

package mx.core
{
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import mx.events.RSLEvent;
    import flash.events.ErrorEvent;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import mx.utils.LoaderUtil;
    import flash.events.Event;
    import flash.system.ApplicationDomain;

    public class RSLItem 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        protected var chainedSecurityErrorHandler:Function;
        public var total:uint = 0;
        public var loaded:uint = 0;
        private var completed:Boolean = false;
        protected var chainedRSLErrorHandler:Function;
        protected var chainedIOErrorHandler:Function;
        protected var chainedCompleteHandler:Function;
        private var errorText:String;
        protected var chainedProgressHandler:Function;
        public var urlRequest:URLRequest;
        public var rootURL:String;
        protected var url:String;
        protected var moduleFactory:IFlexModuleFactory;

        public function RSLItem(_arg_1:String, _arg_2:String=null, _arg_3:IFlexModuleFactory=null)
        {
            this.url = _arg_1;
            this.rootURL = _arg_2;
            this.moduleFactory = _arg_3;
        }

        public function itemProgressHandler(_arg_1:ProgressEvent):void
        {
            loaded = _arg_1.bytesLoaded;
            total = _arg_1.bytesTotal;
            if (chainedProgressHandler != null)
            {
                chainedProgressHandler(_arg_1);
            };
        }

        public function itemErrorHandler(_arg_1:ErrorEvent):void
        {
            errorText = decodeURI(_arg_1.text);
            completed = true;
            loaded = 0;
            total = 0;
            trace(errorText);
            if (((_arg_1.type == IOErrorEvent.IO_ERROR) && (!(chainedIOErrorHandler == null))))
            {
                chainedIOErrorHandler(_arg_1);
            }
            else
            {
                if (((_arg_1.type == SecurityErrorEvent.SECURITY_ERROR) && (!(chainedSecurityErrorHandler == null))))
                {
                    chainedSecurityErrorHandler(_arg_1);
                }
                else
                {
                    if (((_arg_1.type == RSLEvent.RSL_ERROR) && (!(chainedRSLErrorHandler == null))))
                    {
                        chainedRSLErrorHandler(_arg_1);
                    };
                };
            };
        }

        public function load(_arg_1:Function, _arg_2:Function, _arg_3:Function, _arg_4:Function, _arg_5:Function):void
        {
            var _local_6:Loader;
            chainedProgressHandler = _arg_1;
            chainedCompleteHandler = _arg_2;
            chainedIOErrorHandler = _arg_3;
            chainedSecurityErrorHandler = _arg_4;
            chainedRSLErrorHandler = _arg_5;
            _local_6 = new Loader();
            var _local_7:LoaderContext = new LoaderContext();
            urlRequest = new URLRequest(LoaderUtil.createAbsoluteURL(rootURL, url));
            _local_6.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, itemProgressHandler);
            _local_6.contentLoaderInfo.addEventListener(Event.COMPLETE, itemCompleteHandler);
            _local_6.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, itemErrorHandler);
            _local_6.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, itemErrorHandler);
            if (moduleFactory != null)
            {
                _local_7.applicationDomain = moduleFactory.info()["currentDomain"];
            }
            else
            {
                _local_7.applicationDomain = ApplicationDomain.currentDomain;
            };
            _local_6.load(urlRequest, _local_7);
        }

        public function itemCompleteHandler(_arg_1:Event):void
        {
            completed = true;
            if (chainedCompleteHandler != null)
            {
                chainedCompleteHandler(_arg_1);
            };
        }


    }
}//package mx.core

