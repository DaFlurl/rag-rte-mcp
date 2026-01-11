// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.RegisterResponse

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerBean;

    public class RegisterResponse extends BaseBean 
    {

        public static const CREATE_RESULT_NAME_DUP:int = -1;
        public static const CREATE_RESULT_ZONE_FULL:int = -2;
        public static const CREATE_RESULT_HAVE_CREATED:int = -3;

        public var packageId:Number;
        public var player:PlayerBean;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function RegisterResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
            if (_arg_2.player != null)
            {
                this.player = new PlayerBean(_arg_2.player);
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((((("---- RegisterResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + ((this.player != null) ? this.player.toDebugString((_arg_1 + "player.")) : (_arg_1 + "player = null\n")));
        }

        public function copyTo(_arg_1:RegisterResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (this.player != null)
            {
                this.player.copyTo(_arg_1.player);
            }
            else
            {
                _arg_1.player = null;
            };
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "player":this.player.toObject()
            });
        }


    }
}//package com.evony.common.server.events

