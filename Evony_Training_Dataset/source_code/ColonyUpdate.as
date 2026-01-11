// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.ColonyUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class ColonyUpdate extends BaseBean 
    {

        public var castleId:int;
        public var colonyBeansArray:ArrayCollection = new ArrayCollection();

        public function ColonyUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            var _local_6:* = null;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
            };
            if (_arg_2.colonyBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.colonyBeans.length)
                {
                    _local_6 = new ColonyBean(_arg_2.colonyBeans[_local_5]);
                    this.colonyBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function copyTo(_arg_1:ColonyUpdate):void
        {
            _arg_1.castleId = this.castleId;
            CommonUtil.arrayCopy(this.colonyBeansArray, _arg_1.colonyBeansArray);
        }

        public function getColonyBeans(_arg_1:int):ColonyBean
        {
            return (this.colonyBeansArray[_arg_1] as ColonyBean);
        }

        public function setColonyBeans(_arg_1:ColonyBean, _arg_2:int):void
        {
            this.colonyBeansArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- ColonyUpdate ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.colonyBeansArray.length)
            {
                _local_3 = (_local_3 + this.getColonyBeans(_local_2).toDebugString((((_arg_1 + "colonyBeans[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.castleId = this.castleId;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

