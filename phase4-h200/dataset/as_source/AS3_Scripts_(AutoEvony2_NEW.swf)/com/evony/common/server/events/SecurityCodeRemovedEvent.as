// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.SecurityCodeRemovedEvent

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class SecurityCodeRemovedEvent extends BaseBean 
    {

        public var isSetSecurityCode:Boolean;

        public function SecurityCodeRemovedEvent(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.isSetSecurityCode != null)
            {
                this.isSetSecurityCode = _arg_2.isSetSecurityCode;
            };
        }

        public function copyTo(_arg_1:SecurityCodeRemovedEvent):void
        {
            _arg_1.isSetSecurityCode = this.isSetSecurityCode;
        }

        public function toObject():Object
        {
            return ({"isSetSecurityCode":this.isSetSecurityCode});
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- SecurityCodeRemovedEvent ----\n" + (((_arg_1 + "isSetSecurityCode = ") + this.isSetSecurityCode) + "\n"));
        }


    }
}//package com.evony.common.server.events

