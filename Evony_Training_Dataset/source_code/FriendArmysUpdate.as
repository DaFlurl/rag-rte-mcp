// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.FriendArmysUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.CommonUtil;

    public class FriendArmysUpdate extends BaseBean 
    {

        public var armysArray:ArrayCollection = new ArrayCollection();

        public function FriendArmysUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:ArmyBean;
            var _local_6:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.armys)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.armys.length)
                {
                    _local_5 = new ArmyBean(_arg_2.armys[_local_6]);
                    this.armysArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function getArmys(_arg_1:int):ArmyBean
        {
            return (this.armysArray[_arg_1] as ArmyBean);
        }

        public function toObject():Object
        {
            return (new Object());
        }

        public function setArmys(_arg_1:ArmyBean, _arg_2:int):void
        {
            this.armysArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:FriendArmysUpdate):void
        {
            CommonUtil.arrayCopy(this.armysArray, _arg_1.armysArray);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- FriendArmysUpdate ----\n";
            var _local_3:int;
            while (_local_3 < this.armysArray.length)
            {
                _local_2 = (_local_2 + this.getArmys(_local_3).toDebugString((((_arg_1 + "armys[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

