// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.PlayerBuffUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuffBean;

    public class PlayerBuffUpdate extends BaseBean 
    {

        public var updateType:int;
        public var buffBean:BuffBean;

        public function PlayerBuffUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.buffBean != null)
            {
                this.buffBean = new BuffBean(_arg_2.buffBean);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:PlayerBuffUpdate):void
        {
            if (this.buffBean != null)
            {
                this.buffBean.copyTo(_arg_1.buffBean);
            }
            else
            {
                _arg_1.buffBean = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            return ({
                "buffBean":this.buffBean.toObject(),
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (("---- PlayerBuffUpdate ----\n" + ((this.buffBean != null) ? this.buffBean.toDebugString((_arg_1 + "buffBean.")) : (_arg_1 + "buffBean = null\n"))) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

