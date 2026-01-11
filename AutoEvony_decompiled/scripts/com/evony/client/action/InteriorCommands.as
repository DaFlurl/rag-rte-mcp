package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.interior.ResourceProduceDataResponse;
   
   public class InteriorCommands
   {
      
      public var _pacifyPeople_callback:Function;
      
      public var _modifyTaxRate_callback:Function;
      
      public var _modifyCommenceRate_callback:Function;
      
      private var sender:Sender;
      
      public var _taxation_callback:Function;
      
      public var _getResourceProduceData_callback:Function;
      
      public function InteriorCommands()
      {
         super();
      }
      
      public function modifyTaxRate(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._modifyTaxRate_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("interior.modifyTaxRate",{
               "castleId":param1,
               "tax":param2
            });
         }
         return null;
      }
      
      public function taxation(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._taxation_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("interior.taxation",{
               "castleId":param1,
               "typeId":param2
            });
         }
         return null;
      }
      
      public function getResourceProduceData(param1:int, param2:Function = null) : ResourceProduceDataResponse
      {
         this._getResourceProduceData_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("interior.getResourceProduceData",{"castleId":param1});
         }
         return null;
      }
      
      public function modifyCommenceRate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
      {
         this._modifyCommenceRate_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("interior.modifyCommenceRate",{
               "castleId":param1,
               "foodrate":param2,
               "woodrate":param3,
               "stonerate":param4,
               "ironrate":param5
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function pacifyPeople(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._pacifyPeople_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("interior.pacifyPeople",{
               "castleId":param1,
               "typeId":param2
            });
         }
         return null;
      }
   }
}

