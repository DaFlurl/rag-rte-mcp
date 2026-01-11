// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.RSLEvent

package mx.events
{
    import flash.events.ProgressEvent;
    import mx.core.mx_internal;
    import flash.display.LoaderInfo;
    import flash.net.URLRequest;
    import flash.events.Event;

    use namespace mx_internal;

    public class RSLEvent extends ProgressEvent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const RSL_COMPLETE:String = "rslComplete";
        public static const RSL_ERROR:String = "rslError";
        public static const RSL_PROGRESS:String = "rslProgress";

        public var loaderInfo:LoaderInfo;
        public var errorText:String;
        public var rslIndex:int;
        public var rslTotal:int;
        public var url:URLRequest;

        public function RSLEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:int=-1, _arg_6:int=-1, _arg_7:int=-1, _arg_8:URLRequest=null, _arg_9:String=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            this.rslIndex = _arg_6;
            this.rslTotal = _arg_7;
            this.url = _arg_8;
            this.errorText = _arg_9;
        }

        override public function clone():Event
        {
            return (new RSLEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, rslIndex, rslTotal, url, errorText));
        }


    }
}//package mx.events

