// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.trade.SearchTradesResponse

package com.evony.common.module.trade
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.MarketTradeBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class SearchTradesResponse extends BaseBean 
    {

        public var buyersArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var sellersArray:ArrayCollection = new ArrayCollection();
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function SearchTradesResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:MarketTradeBean;
            var _local_7:MarketTradeBean;
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
            if (_arg_2.buyers)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.buyers.length)
                {
                    _local_6 = new MarketTradeBean(_arg_2.buyers[_local_5]);
                    this.buyersArray.addItem(_local_6);
                    _local_5++;
                };
            };
            if (_arg_2.sellers)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.sellers.length)
                {
                    _local_7 = new MarketTradeBean(_arg_2.sellers[_local_5]);
                    this.sellersArray.addItem(_local_7);
                    _local_5++;
                };
            };
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

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- SearchTradesResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.buyersArray.length)
            {
                _local_2 = (_local_2 + this.getBuyers(_local_3).toDebugString((((_arg_1 + "buyers[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.sellersArray.length)
            {
                _local_2 = (_local_2 + this.getSellers(_local_3).toDebugString((((_arg_1 + "sellers[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:SearchTradesResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.buyersArray, _arg_1.buyersArray);
            CommonUtil.arrayCopy(this.sellersArray, _arg_1.sellersArray);
        }

        public function setSellers(_arg_1:MarketTradeBean, _arg_2:int):void
        {
            this.sellersArray[_arg_2] = _arg_1;
        }

        public function getBuyers(_arg_1:int):MarketTradeBean
        {
            return (this.buyersArray[_arg_1] as MarketTradeBean);
        }

        public function setBuyers(_arg_1:MarketTradeBean, _arg_2:int):void
        {
            this.buyersArray[_arg_2] = _arg_1;
        }

        public function getSellers(_arg_1:int):MarketTradeBean
        {
            return (this.sellersArray[_arg_1] as MarketTradeBean);
        }


    }
}//package com.evony.common.module.trade

