package com.evony.client.action
{
   import com.evony.common.*;
   import com.evony.common.module.capital.*;
   
   public class CapitalCommands
   {
      
      public var _getUsedPoliciesTimes_callback:Function;
      
      public var _levyTaxes_callback:Function;
      
      public var _reduceArmaments_callback:Function;
      
      public var _levyFood_callback:Function;
      
      public var _getLeftPoliciesTimes_callback:Function;
      
      internal var sender:Sender;
      
      public var _levyArmy_callback:Function;
      
      public var _levyPopulation_callback:Function;
      
      public function CapitalCommands()
      {
         super();
      }
      
      public function levyArmy(param1:int, param2:int, param3:Function = null) : CapitalCommandResponse
      {
         this._levyArmy_callback = param3;
         var _loc4_:Object = new Object();
         _loc4_.castleId = param1;
         _loc4_.targetFieldId = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.levyArmy",_loc4_);
         }
         return null;
      }
      
      public function getUsedPoliciesTimes(param1:int, param2:Function = null) : CapitalCommandResponse
      {
         this._getUsedPoliciesTimes_callback = param2;
         var _loc3_:Object = new Object();
         _loc3_.castleId = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.getUsedPoliciesTimes",_loc3_);
         }
         return null;
      }
      
      public function levyPopulation(param1:int, param2:int, param3:Function = null) : CapitalCommandResponse
      {
         this._levyPopulation_callback = param3;
         var _loc4_:Object = new Object();
         _loc4_.castleId = param1;
         _loc4_.targetFieldId = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.levyPopulation",_loc4_);
         }
         return null;
      }
      
      public function reduceArmaments(param1:int, param2:int, param3:Function = null) : CapitalCommandResponse
      {
         this._reduceArmaments_callback = param3;
         var _loc4_:Object = new Object();
         _loc4_.castleId = param1;
         _loc4_.targetFieldId = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.reduceArmaments",_loc4_);
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function getLeftPoliciesTimes(param1:int, param2:Function = null) : CapitalCommandResponse
      {
         this._getLeftPoliciesTimes_callback = param2;
         var _loc3_:Object = new Object();
         _loc3_.castleId = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.getLeftPoliciesTimes",_loc3_);
         }
         return null;
      }
      
      public function levyFood(param1:int, param2:int, param3:Function = null) : CapitalCommandResponse
      {
         this._levyFood_callback = param3;
         var _loc4_:Object = new Object();
         _loc4_.castleId = param1;
         _loc4_.targetFieldId = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.levyFood",_loc4_);
         }
         return null;
      }
      
      public function levyTaxes(param1:int, param2:int, param3:Function = null) : CapitalCommandResponse
      {
         this._levyTaxes_callback = param3;
         var _loc4_:Object = new Object();
         _loc4_.castleId = param1;
         _loc4_.targetFieldId = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("capital.levyTaxes",_loc4_);
         }
         return null;
      }
   }
}

