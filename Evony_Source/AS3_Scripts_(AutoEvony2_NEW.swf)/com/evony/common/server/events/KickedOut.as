// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.KickedOut

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class KickedOut extends BaseBean 
    {

        public var ip:String;

        public function KickedOut(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.ip != null)
            {
                this.ip = _arg_2.ip;
            };
        }

        public function copyTo(_arg_1:KickedOut):void
        {
            _arg_1.ip = this.ip;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- KickedOut ----\n" + (((_arg_1 + "ip = ") + this.ip) + "\n"));
        }

        public function toObject():Object
        {
            return ({"ip":this.ip});
        }


    }
}//package com.evony.common.server.events

