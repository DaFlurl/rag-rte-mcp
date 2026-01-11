// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.trade.TransingTradeListResponse

package com.evony.common.module.trade
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.TransingTradeBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class TransingTradeListResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var transingTradesArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function TransingTradeListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:TransingTradeBean;
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
            if (_arg_2.transingTrades)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.transingTrades.length)
                {
                    _local_6 = new TransingTradeBean(_arg_2.transingTrades[_local_5]);
                    this.transingTradesArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setTransingTrades(_arg_1:TransingTradeBean, _arg_2:int):void
        {
            this.transingTradesArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- TransingTradeListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.transingTradesArray.length)
            {
                _local_2 = (_local_2 + this.getTransingTrades(_local_3).toDebugString((((_arg_1 + "transingTrades[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:TransingTradeListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.transingTradesArray, _arg_1.transingTradesArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }

        public function getTransingTrades(_arg_1:int):TransingTradeBean
        {
            return (this.transingTradesArray[_arg_1] as TransingTradeBean);
        }


    }
}//package com.evony.common.module.trade

