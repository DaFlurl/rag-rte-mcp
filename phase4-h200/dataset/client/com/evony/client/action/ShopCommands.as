// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ShopCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.shop.BuyResourceInfoResponse;
    import com.evony.common.module.shop.UseItemResultResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class ShopCommands 
    {

        public var _useDevilItem_callback:Function;
        public var _useTrickItem_callback:Function;
        public var _useCastleGoods_callback:Function;
        public var _buyResource_callback:Function;
        public var _useAngelItem_callback:Function;
        public var _getBuyResourceInfo_callback:Function;
        public var _Gem_Smelting_callback:Function;
        private var sender:Sender;
        public var _useGoods_callback:Function;
        public var _buy_callback:Function;


        public function buy(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._buy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.itemId = _arg_1;
            _local_4.amount = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.buy", _local_4);
            };
            return (null);
        }

        public function getBuyResourceInfo(_arg_1:int, _arg_2:Function=null):BuyResourceInfoResponse
        {
            this._getBuyResourceInfo_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("shop.getBuyResourceInfo", _local_3);
            };
            return (null);
        }

        public function useGoods(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:Function=null):UseItemResultResponse
        {
            this._useGoods_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.itemId = _arg_2;
            _local_5.num = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useGoods", _local_5);
            };
            return (null);
        }

        public function Gem_Smelting(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._Gem_Smelting_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.itemId = _arg_1;
            _local_4.bookitemId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.Gem_Smelting", _local_4);
            };
            return (null);
        }

        public function useDevilItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._useDevilItem_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.x = _arg_1;
            _local_6.y = _arg_2;
            _local_6.itemId = _arg_3;
            _local_6.paramdata = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useDevilItem", _local_6);
            };
            return (null);
        }

        public function useAngelItem(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._useAngelItem_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.playername = _arg_1;
            _local_4.itemId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useAngelItem", _local_4);
            };
            return (null);
        }

        public function buyResource(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._buyResource_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.foodUse = _arg_2;
            _local_7.woodUse = _arg_3;
            _local_7.ironUse = _arg_4;
            _local_7.stoneUse = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("shop.buyResource", _local_7);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function useCastleGoods(_arg_1:int, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._useCastleGoods_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.itemId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useCastleGoods", _local_4);
            };
            return (null);
        }

        public function useTrickItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._useTrickItem_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.armyid = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useTrickItem", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

