// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.MercenaryUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.MercenaryBean;
    import com.evony.common.beans.*;

    public class MercenaryUpdate extends BaseBean 
    {

        public var castleId:int;
        public var mercenaryBean:MercenaryBean;

        public function MercenaryUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
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
            if (mercenaryBean != null)
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
            var _local_1:Object = new Object();
            _local_1.castleId = this.castleId;
            _local_1.mercenaryBean = this.mercenaryBean.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- MercenaryUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            if (mercenaryBean != null)
            {
                _local_2 = (_local_2 + this.mercenaryBean.toDebugString((_arg_1 + "mercenaryBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "mercenaryBean = null\n"));
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

