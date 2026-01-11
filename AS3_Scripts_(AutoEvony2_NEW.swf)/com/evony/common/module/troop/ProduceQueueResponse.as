// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.troop.ProduceQueueResponse

package com.evony.common.module.troop
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AllProduceBean;
    import com.evony.common.CommonUtil;

    public class ProduceQueueResponse extends BaseBean 
    {

        public var msg:String;
        public var ok:int;
        public var allProduceQueueArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var errorMsg:String;

        public function ProduceQueueResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:AllProduceBean;
            var _local_6:int;
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
            if (_arg_2.allProduceQueue)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.allProduceQueue.length)
                {
                    _local_5 = new AllProduceBean(_arg_2.allProduceQueue[_local_6]);
                    this.allProduceQueueArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((("---- ProduceQueueResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.allProduceQueueArray.length)
            {
                _local_2 = (_local_2 + this.getAllProduceQueue(_local_3).toDebugString((((_arg_1 + "allProduceQueueArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function setAllProduceQueue(_arg_1:AllProduceBean, _arg_2:int):void
        {
            this.allProduceQueueArray[_arg_2] = _arg_1;
        }

        public function toObject():Object
        {
            return ({
                "msg":this.msg,
                "errorMsg":this.errorMsg,
                "ok":this.ok,
                "packageId":this.packageId,
                "allProduceQueueArray":this.allProduceQueueArray
            });
        }

        public function getAllProduceQueue(_arg_1:int):AllProduceBean
        {
            return (this.allProduceQueueArray[_arg_1] as AllProduceBean);
        }

        public function copyTo(_arg_1:ProduceQueueResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allProduceQueueArray, _arg_1.allProduceQueueArray);
        }


    }
}//package com.evony.common.module.troop

