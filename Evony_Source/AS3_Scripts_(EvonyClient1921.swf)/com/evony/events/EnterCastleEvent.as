// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.EnterCastleEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.MsgDispacther;

    public class EnterCastleEvent extends Event 
    {

        public static const EVENT_NAME:String = "ButtonPanel.switchToInner";

        public var isSwitchToInner:Boolean;

        public function EnterCastleEvent(_arg_1:Boolean=true, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(EVENT_NAME, _arg_2, _arg_3);
            this.isSwitchToInner = _arg_1;
        }

        public static function enterCastle(_arg_1:Boolean):void
        {
            MsgDispacther.getInstance().dispatchEvent(new EnterCastleEvent(_arg_1));
        }


    }
}//package com.evony.events

