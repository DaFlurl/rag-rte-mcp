// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ShopCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.shop.BuyResourceInfoResponse;
    import com.evony.common.module.shop.UseItemResultResponse;

    public class ShopCommands 
    {

        public var _useDevilItem_callback:Function;
        public var _useTrickItem_callback:Function;
        public var mesgID:String = "shop.shopUrl";
        public var _useCastleGoods_callback:Function;
        public var _buyResource_callback:Function;
        public var serialID:uint = 1145225233;
        public var _useAngelItem_callback:Function;
        public var _getBuyResourceInfo_callback:Function;
        public var _Gem_Smelting_callback:Function;
        private var sender:Sender;
        public var _useGoods_callback:Function;
        public var _buy_callback:Function;


        public function buy(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._buy_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.buy", {
                    "itemId":_arg_1,
                    "amount":_arg_2
                });
            };
            return (null);
        }

        public function getBuyResourceInfo(_arg_1:int, _arg_2:Function=null):BuyResourceInfoResponse
        {
            this._getBuyResourceInfo_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.getBuyResourceInfo", {"castleId":_arg_1});
            };
            return (null);
        }

        public function Gem_Smelting(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._Gem_Smelting_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.Gem_Smelting", {
                    "itemId":_arg_1,
                    "bookitemId":_arg_2
                });
            };
            return (null);
        }

        public function useDevilItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._useDevilItem_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.useDevilItem", {
                    "x":_arg_1,
                    "y":_arg_2,
                    "itemId":_arg_3,
                    "paramdata":_arg_4
                });
            };
            return (null);
        }

        public function useGoods(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:Function=null):UseItemResultResponse
        {
            this._useGoods_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.useGoods", {
                    "castleId":_arg_1,
                    "itemId":_arg_2,
                    "num":_arg_3
                });
            };
            return (null);
        }

        public function useAngelItem(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._useAngelItem_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.useAngelItem", {
                    "playername":_arg_1,
                    "itemId":_arg_2
                });
            };
            return (null);
        }

        public function buyResource(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._buyResource_callback = _arg_6;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.buyResource", {
                    "castleId":_arg_1,
                    "foodUse":_arg_2,
                    "woodUse":_arg_3,
                    "ironUse":_arg_4,
                    "stoneUse":_arg_5
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
            var _local_2:Object = _arg_1;
            if (this.mesgID.length > 4)
            {
                this.mesgID = this.mesgID.charAt(3);
            };
            if (((!(this.sender == null)) && (_local_2.hasOwnProperty(this.mesgID))))
            {
                this.sender[this.mesgID] = this.serialID;
            };
        }

        public function useCastleGoods(_arg_1:int, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._useCastleGoods_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.useCastleGoods", {
                    "castleId":_arg_1,
                    "itemId":_arg_2
                });
            };
            return (null);
        }

        public function useTrickItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._useTrickItem_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("shop.useTrickItem", {
                    "castleId":_arg_1,
                    "armyid":_arg_2,
                    "itemId":_arg_3
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

