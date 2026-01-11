// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.TryGameEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.GameConfig;
    import mx.utils.StringUtil;

    public class TryGameEvent extends Event 
    {

        public static const TRYGAME:String = "Event.trygame";

        public var isTryGame:Boolean;
        public var ip:String;

        public function TryGameEvent(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(TRYGAME, _arg_3, _arg_4);
            this.isTryGame = _arg_2;
            if (!GameConfig.instance.debugMode)
            {
                this.ip = GameConfig.instance.serverIp;
            }
            else
            {
                this.ip = StringUtil.trim(_arg_1);
            };
        }

    }
}//package com.evony.events

