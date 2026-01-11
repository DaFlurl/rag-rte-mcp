// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.ResourceModuleRSLItem

package mx.core
{
    import flash.events.IOErrorEvent;
    import mx.events.ResourceEvent;
    import mx.resources.ResourceManager;
    import mx.resources.IResourceManager;
    import flash.events.IEventDispatcher;

    public class ResourceModuleRSLItem extends RSLItem 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function ResourceModuleRSLItem(_arg_1:String)
        {
            super(_arg_1);
        }

        private function resourceErrorHandler(_arg_1:ResourceEvent):void
        {
            var _local_2:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _local_2.text = _arg_1.errorText;
            super.itemErrorHandler(_local_2);
        }

        override public function load(_arg_1:Function, _arg_2:Function, _arg_3:Function, _arg_4:Function, _arg_5:Function):void
        {
            chainedProgressHandler = _arg_1;
            chainedCompleteHandler = _arg_2;
            chainedIOErrorHandler = _arg_3;
            chainedSecurityErrorHandler = _arg_4;
            chainedRSLErrorHandler = _arg_5;
            var _local_6:IResourceManager = ResourceManager.getInstance();
            var _local_7:IEventDispatcher = _local_6.loadResourceModule(url);
            _local_7.addEventListener(ResourceEvent.PROGRESS, itemProgressHandler);
            _local_7.addEventListener(ResourceEvent.COMPLETE, itemCompleteHandler);
            _local_7.addEventListener(ResourceEvent.ERROR, resourceErrorHandler);
        }


    }
}//package mx.core

