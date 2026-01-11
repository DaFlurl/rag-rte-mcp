// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TradeCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.trade.TradeListResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.trade.SearchTradesResponse;
    import com.evony.common.module.trade.TransingTradeListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class TradeCommands 
    {

        public var _newTrade_callback:Function;
        public var _getMyTradeList_callback:Function;
        public var _searchTrades_callback:Function;
        public var _getTransingTradeList_callback:Function;
        private var sender:Sender;
        public var _cancelTrade_callback:Function;
        public var _speedUpTrans_callback:Function;


        public function getMyTradeList(_arg_1:int, _arg_2:Function=null):TradeListResponse
        {
            this._getMyTradeList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.getMyTradeList", _local_3);
            };
            return (null);
        }

        public function newTrade(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Function=null):CommandResponse
        {
            this._newTrade_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.resType = _arg_2;
            _local_7.tradeType = _arg_3;
            _local_7.amount = _arg_4;
            _local_7.price = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("trade.newTrade", _local_7);
            };
            return (null);
        }

        public function cancelTrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancelTrade_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.tradeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("trade.cancelTrade", _local_4);
            };
            return (null);
        }

        public function speedUpTrans(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpTrans_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.transingTradeId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("trade.speedUpTrans", _local_5);
            };
            return (null);
        }

        public function searchTrades(_arg_1:int, _arg_2:Function=null):SearchTradesResponse
        {
            this._searchTrades_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.resType = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.searchTrades", _local_3);
            };
            return (null);
        }

        public function getTransingTradeList(_arg_1:int, _arg_2:Function=null):TransingTradeListResponse
        {
            this._getTransingTradeList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.getTransingTradeList", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

