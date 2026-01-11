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
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.getMyTradeList", {"castleId":_arg_1});
            };
            return (null);
        }

        public function newTrade(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Function=null):CommandResponse
        {
            this._newTrade_callback = _arg_6;
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.newTrade", {
                    "castleId":_arg_1,
                    "resType":_arg_2,
                    "tradeType":_arg_3,
                    "amount":_arg_4,
                    "price":_arg_5
                });
            };
            return (null);
        }

        public function cancelTrade(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancelTrade_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.cancelTrade", {
                    "castleId":_arg_1,
                    "tradeId":_arg_2
                });
            };
            return (null);
        }

        public function speedUpTrans(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._speedUpTrans_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.speedUpTrans", {
                    "castleId":_arg_1,
                    "transingTradeId":_arg_2,
                    "itemId":_arg_3
                });
            };
            return (null);
        }

        public function searchTrades(_arg_1:int, _arg_2:Function=null):SearchTradesResponse
        {
            this._searchTrades_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.searchTrades", {"resType":_arg_1});
            };
            return (null);
        }

        public function getTransingTradeList(_arg_1:int, _arg_2:Function=null):TransingTradeListResponse
        {
            this._getTransingTradeList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("trade.getTransingTradeList", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

