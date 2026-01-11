// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CastleUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.CastleBean;

    public class CastleUpdate extends BaseBean 
    {

        public var castleBean:CastleBean;
        public var updateType:int;

        public function CastleUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleBean != null)
            {
                this.castleBean = new CastleBean(_arg_2.castleBean);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:CastleUpdate):void
        {
            if (this.castleBean != null)
            {
                this.castleBean.copyTo(_arg_1.castleBean);
            }
            else
            {
                _arg_1.castleBean = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            return ({
                "castleBean":this.castleBean.toObject(),
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (("---- CastleUpdate ----\n" + ((this.castleBean != null) ? this.castleBean.toDebugString((_arg_1 + "castleBean.")) : (_arg_1 + "castleBean = null\n"))) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

