// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.BuildComplate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.beans.*;

    public class BuildComplate extends BaseBean 
    {

        public var castleId:int;
        public var buildingBean:BuildingBean;

        public function BuildComplate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.buildingBean != null)
            {
                this.buildingBean = new BuildingBean(_arg_2.buildingBean);
            };
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
        }

        public function copyTo(_arg_1:BuildComplate):void
        {
            if (buildingBean != null)
            {
                this.buildingBean.copyTo(_arg_1.buildingBean);
            }
            else
            {
                _arg_1.buildingBean = null;
            };
            _arg_1.castleId = this.castleId;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.buildingBean = this.buildingBean.toObject();
            _local_1.castleId = this.castleId;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- BuildComplate ----\n";
            if (buildingBean != null)
            {
                _local_2 = (_local_2 + this.buildingBean.toDebugString((_arg_1 + "buildingBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "buildingBean = null\n"));
            };
            return (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
        }


    }
}//package com.evony.common.server.events

