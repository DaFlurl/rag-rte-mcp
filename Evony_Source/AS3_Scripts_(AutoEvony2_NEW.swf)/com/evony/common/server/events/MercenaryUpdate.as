// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.MercenaryUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.MercenaryBean;

    public class MercenaryUpdate extends BaseBean 
    {

        public var castleId:int;
        public var mercenaryBean:MercenaryBean;

        public function MercenaryUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.mercenaryBean != null)
            {
                this.mercenaryBean = new MercenaryBean(_arg_2.mercenaryBean);
            };
        }

        public function copyTo(_arg_1:MercenaryUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (this.mercenaryBean != null)
            {
                this.mercenaryBean.copyTo(_arg_1.mercenaryBean);
            }
            else
            {
                _arg_1.mercenaryBean = null;
            };
        }

        public function toObject():Object
        {
            return ({
                "castleId":this.castleId,
                "mercenaryBean":this.mercenaryBean.toObject()
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (("---- MercenaryUpdate ----\n" + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + ((this.mercenaryBean != null) ? this.mercenaryBean.toDebugString((_arg_1 + "mercenaryBean.")) : (_arg_1 + "mercenaryBean = null\n")));
        }


    }
}//package com.evony.common.server.events

