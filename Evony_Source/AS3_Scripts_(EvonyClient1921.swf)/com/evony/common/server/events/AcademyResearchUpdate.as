// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.AcademyResearchUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.beans.*;

    public class AcademyResearchUpdate extends BaseBean 
    {

        public var castleId:int;
        public var researchBean:AvailableResearchListBean;

        public function AcademyResearchUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.researchBean != null)
            {
                this.researchBean = new AvailableResearchListBean(_arg_2.researchBean);
            };
        }

        public function copyTo(_arg_1:AcademyResearchUpdate):void
        {
            _arg_1.castleId = this.castleId;
            if (researchBean != null)
            {
                this.researchBean.copyTo(_arg_1.researchBean);
            }
            else
            {
                _arg_1.researchBean = null;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleId = this.castleId;
            _local_1.researchBean = this.researchBean.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- AcademyResearchUpdate ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            if (researchBean != null)
            {
                _local_2 = (_local_2 + this.researchBean.toDebugString((_arg_1 + "researchBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "researchBean = null\n"));
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

