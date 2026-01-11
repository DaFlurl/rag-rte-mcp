// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ToolTipEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.IToolTip;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToolTipEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const TOOL_TIP_CREATE:String = "toolTipCreate";
        public static const TOOL_TIP_END:String = "toolTipEnd";
        public static const TOOL_TIP_HIDE:String = "toolTipHide";
        public static const TOOL_TIP_SHOW:String = "toolTipShow";
        public static const TOOL_TIP_SHOWN:String = "toolTipShown";
        public static const TOOL_TIP_START:String = "toolTipStart";

        public var toolTip:IToolTip;

        public function ToolTipEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:IToolTip=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.toolTip = _arg_4;
        }

        override public function clone():Event
        {
            return (new ToolTipEvent(type, bubbles, cancelable, toolTip));
        }


    }
}//package mx.events

