// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.RegisterEvent

package com.evony.events
{
    import flash.events.Event;
    import mx.utils.StringUtil;
    import com.evony.GameConfig;

    public class RegisterEvent extends Event 
    {

        public static const EVENT_NAME:String = "RegisterEvent.name";

        public var register:Boolean;
        public var ip:String;
        public var password:String;
        public var username:String;

        public function RegisterEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(EVENT_NAME, _arg_5, _arg_6);
            this.password = StringUtil.trim(_arg_2);
            this.username = StringUtil.trim(_arg_1);
            this.register = _arg_4;
            if (!GameConfig.instance.debugMode)
            {
                this.ip = GameConfig.instance.serverIp;
            }
            else
            {
                this.ip = StringUtil.trim(_arg_3);
            };
        }

    }
}//package com.evony.events

