// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.BuildingQueueUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.common.beans.*;

    public class BuildingQueueUpdate extends BaseBean 
    {

        public var castleId:int;
        public var buildingQueueBean:BuildingQueueBean;

        public function BuildingQueueUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.buildingQueueBean != null)
            {
                this.buildingQueueBean = new BuildingQueueBean(_arg_2.buildingQueueBean);
            };
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
        }

        public function copyTo(_arg_1:BuildingQueueUpdate):void
        {
            if (buildingQueueBean != null)
            {
                this.buildingQueueBean.copyTo(_arg_1.buildingQueueBean);
            }
            else
            {
                _arg_1.buildingQueueBean = null;
            };
            _arg_1.castleId = this.castleId;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.buildingQueueBean = this.buildingQueueBean.toObject();
            _local_1.castleId = this.castleId;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- BuildingQueueUpdate ----\n";
            if (buildingQueueBean != null)
            {
                _local_2 = (_local_2 + this.buildingQueueBean.toDebugString((_arg_1 + "buildingQueueBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "buildingQueueBean = null\n"));
            };
            return (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
        }


    }
}//package com.evony.common.server.events

