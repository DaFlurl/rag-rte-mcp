package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.gemstone.GemstoneRespone;
   
   public class EquipmentCommands
   {
      
      public var _EnhancedByGemStone_callback:Function;
      
      public var _WearAllEquipmenttech_callback:Function;
      
      public var _TakeOffEquipmenttech_callback:Function;
      
      public var _EnhancedStarByGemStone_callback:Function;
      
      private var sender:Sender;
      
      public var _TakeOffAllEquipmenttech_callback:Function;
      
      public var _WearEquipmenttech_callback:Function;
      
      public function EquipmentCommands()
      {
         super();
      }
      
      public function WearEquipmenttech(param1:int, param2:String, param3:int, param4:int, param5:Function = null) : CommandResponse
      {
         this._WearEquipmenttech_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.WearEquipmenttech",{
               "heroid":param1,
               "Equipmenttechid":param2,
               "AddAttributeType":param3,
               "pos":param4
            });
         }
         return null;
      }
      
      public function TakeOffAllEquipmenttech(param1:int, param2:Function = null) : CommandResponse
      {
         this._TakeOffAllEquipmenttech_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.TakeOffAllEquipmenttech",{"heroid":param1});
         }
         return null;
      }
      
      public function EnhancedStarByGemStone(param1:String, param2:int, param3:int, param4:Function = null) : GemstoneRespone
      {
         this._EnhancedStarByGemStone_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.EnhancedStarByGemStone",{
               "gemstoneid":param1,
               "count":param2,
               "pos":param3
            });
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function WearAllEquipmenttech(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._WearAllEquipmenttech_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.WearAllEquipmenttech",{
               "heroid":param1,
               "AddAttributeType":param2
            });
         }
         return null;
      }
      
      public function TakeOffEquipmenttech(param1:int, param2:String, param3:int, param4:Function = null) : CommandResponse
      {
         this._TakeOffEquipmenttech_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.TakeOffEquipmenttech",{
               "heroid":param1,
               "Equipmenttechid":param2,
               "pos":param3
            });
         }
         return null;
      }
      
      public function EnhancedByGemStone(param1:String, param2:int, param3:int, param4:Function = null) : GemstoneRespone
      {
         this._EnhancedByGemStone_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("equipment.EnhancedByGemStone",{
               "gemstoneid":param1,
               "pos":param2,
               "lv":param3
            });
         }
         return null;
      }
   }
}

