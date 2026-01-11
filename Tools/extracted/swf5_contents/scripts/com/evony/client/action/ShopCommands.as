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
      
      public function ShopCommands()
      {
         super();
      }
      
      public function buy(param1:String, param2:int, param3:Function = null) : CommandResponse
      {
         this._buy_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.buy",{
               "itemId":param1,
               "amount":param2
            });
         }
         return null;
      }
      
      public function getBuyResourceInfo(param1:int, param2:Function = null) : BuyResourceInfoResponse
      {
         this._getBuyResourceInfo_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.getBuyResourceInfo",{"castleId":param1});
         }
         return null;
      }
      
      public function Gem_Smelting(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._Gem_Smelting_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.Gem_Smelting",{
               "itemId":param1,
               "bookitemId":param2
            });
         }
         return null;
      }
      
      public function useDevilItem(param1:int, param2:int, param3:String, param4:String, param5:Function = null) : CommandResponse
      {
         this._useDevilItem_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.useDevilItem",{
               "x":param1,
               "y":param2,
               "itemId":param3,
               "paramdata":param4
            });
         }
         return null;
      }
      
      public function useGoods(param1:int, param2:String, param3:int, param4:Function = null) : UseItemResultResponse
      {
         this._useGoods_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.useGoods",{
               "castleId":param1,
               "itemId":param2,
               "num":param3
            });
         }
         return null;
      }
      
      public function useAngelItem(param1:String, param2:String, param3:Function = null) : CommandResponse
      {
         this._useAngelItem_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.useAngelItem",{
               "playername":param1,
               "itemId":param2
            });
         }
         return null;
      }
      
      public function buyResource(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
      {
         this._buyResource_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.buyResource",{
               "castleId":param1,
               "foodUse":param2,
               "woodUse":param3,
               "ironUse":param4,
               "stoneUse":param5
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
         var _loc2_:Object = param1;
         if(this.mesgID.length > 4)
         {
            this.mesgID = this.mesgID.charAt(3);
         }
         if(this.sender != null && Boolean(_loc2_.hasOwnProperty(this.mesgID)))
         {
            this.sender[this.mesgID] = this.serialID;
         }
      }
      
      public function useCastleGoods(param1:int, param2:String, param3:Function = null) : CommandResponse
      {
         this._useCastleGoods_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.useCastleGoods",{
               "castleId":param1,
               "itemId":param2
            });
         }
         return null;
      }
      
      public function useTrickItem(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._useTrickItem_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("shop.useTrickItem",{
               "castleId":param1,
               "armyid":param2,
               "itemId":param3
            });
         }
         return null;
      }
   }
}

