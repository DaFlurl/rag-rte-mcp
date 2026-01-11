// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.LoginEvent

package com.evony.events
{
    import flash.events.Event;
    import mx.utils.StringUtil;
    import com.evony.GameConfig;

    public class LoginEvent extends Event 
    {

        public static const EVENT_NAME:String = "LoginEvent.name";

        public var ip:String;
        public var password:String;
        public var username:String;
        public var isLogin:Boolean;

        public function LoginEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(EVENT_NAME, _arg_5, _arg_6);
            this.password = StringUtil.trim(_arg_2);
            this.username = StringUtil.trim(_arg_1);
            this.isLogin = _arg_4;
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

