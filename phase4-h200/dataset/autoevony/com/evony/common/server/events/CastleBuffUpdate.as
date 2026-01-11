// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CastleBuffUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuffBean;

    public class CastleBuffUpdate extends BaseBean 
    {

        public var updateType:int;
        public var buffBean:BuffBean;
        public var castleid:int;

        public function CastleBuffUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.buffBean != null)
            {
                this.buffBean = new BuffBean(_arg_2.buffBean);
            };
            if (_arg_2.castleid != null)
            {
                this.castleid = _arg_2.castleid;
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:CastleBuffUpdate):void
        {
            if (this.buffBean == null)
            {
                _arg_1.buffBean = null;
            }
            else
            {
                this.buffBean.copyTo(_arg_1.buffBean);
            };
            _arg_1.castleid = this.castleid;
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            return ({
                "buffBean":this.buffBean.toObject(),
                "castleid":this.castleid,
                "updateType":this.updateType
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ((("---- CastleBuffUpdate ----\n" + ((this.buffBean == null) ? (_arg_1 + "buffBean = null\n") : this.buffBean.toDebugString((_arg_1 + "buffBean.")))) + (((_arg_1 + "castleid = ") + this.castleid) + "\n")) + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

