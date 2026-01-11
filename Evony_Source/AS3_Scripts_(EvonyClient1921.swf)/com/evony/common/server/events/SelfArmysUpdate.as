// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.SelfArmysUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class SelfArmysUpdate extends BaseBean 
    {

        public var armysArray:ArrayCollection = new ArrayCollection();

        public function SelfArmysUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:ArmyBean;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.armys)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.armys.length)
                {
                    _local_6 = new ArmyBean(_arg_2.armys[_local_5]);
                    this.armysArray.addItem(_local_6);
                    _local_5++;
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

        public function copyTo(_arg_1:SelfArmysUpdate):void
        {
            CommonUtil.arrayCopy(this.armysArray, _arg_1.armysArray);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- SelfArmysUpdate ----\n";
            _local_3 = 0;
            while (_local_3 < this.armysArray.length)
            {
                _local_2 = (_local_2 + this.getArmys(_local_3).toDebugString((((_arg_1 + "armys[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.evony.common.server.events

