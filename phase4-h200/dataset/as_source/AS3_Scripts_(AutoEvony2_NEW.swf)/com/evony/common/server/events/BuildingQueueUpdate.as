// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.BuildingQueueUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class BuildingQueueUpdate extends BaseBean 
    {

        public var castleId:int;
        public var buildingQueueBean:BuildingQueueBean;

        public function BuildingQueueUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
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
            if (this.buildingQueueBean == null)
            {
                _arg_1.buildingQueueBean = null;
            }
            else
            {
                this.buildingQueueBean.copyTo(_arg_1.buildingQueueBean);
            };
            _arg_1.castleId = this.castleId;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- BuildingQueueUpdate ----\n";
            if (this.buildingQueueBean == null)
            {
                _local_3 = (_local_3 + (_arg_1 + "buildingQueueBean = null\n"));
            }
            else
            {
                _local_3 = (_local_3 + this.buildingQueueBean.toDebugString((_arg_1 + "buildingQueueBean.")));
            };
            return (_local_3 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.buildingQueueBean = this.buildingQueueBean.toObject();
            _local_1.castleId = this.castleId;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

