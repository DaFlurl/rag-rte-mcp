// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.quest.QuestRewardRespone

package com.evony.common.module.quest
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class QuestRewardRespone extends BaseBean 
    {

        public var errorMsg:String;
        public var packageId:Number;
        public var msg:String;
        public var itemBeansArray:ArrayCollection = new ArrayCollection();
        public var ok:int;

        public function QuestRewardRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            var _local_6:* = null;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
            if (_arg_2.itemBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.itemBeans.length)
                {
                    _local_6 = new ItemBean(_arg_2.itemBeans[_local_5]);
                    this.itemBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setItemBeans(_arg_1:ItemBean, _arg_2:int):void
        {
            this.itemBeansArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:QuestRewardRespone):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.itemBeansArray, _arg_1.itemBeansArray);
        }

        public function getItemBeans(_arg_1:int):ItemBean
        {
            return (this.itemBeansArray[_arg_1] as ItemBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- QuestRewardRespone ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.itemBeansArray.length)
            {
                _local_3 = (_local_3 + this.getItemBeans(_local_2).toDebugString((((_arg_1 + "itemBeans[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.quest

