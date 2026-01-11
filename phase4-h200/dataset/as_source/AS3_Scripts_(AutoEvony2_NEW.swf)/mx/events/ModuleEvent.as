// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ModuleEvent

package mx.events
{
    import flash.events.ProgressEvent;
    import mx.core.mx_internal;
    import mx.modules.IModuleInfo;
    import flash.events.Event;

    use namespace mx_internal;

    public class ModuleEvent extends ProgressEvent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ERROR:String = "error";
        public static const PROGRESS:String = "progress";
        public static const READY:String = "ready";
        public static const SETUP:String = "setup";
        public static const UNLOAD:String = "unload";

        public var errorText:String;
        private var _module:IModuleInfo;

        public function ModuleEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:uint=0, _arg_5:uint=0, _arg_6:String=null, _arg_7:IModuleInfo=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            this.errorText = _arg_6;
            this._module = _arg_7;
        }

        public function get module():IModuleInfo
        {
            if (_module)
            {
                return (_module);
            };
            return (target as IModuleInfo);
        }

        override public function clone():Event
        {
            return (new ModuleEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, errorText, module));
        }


    }
}//package mx.events

