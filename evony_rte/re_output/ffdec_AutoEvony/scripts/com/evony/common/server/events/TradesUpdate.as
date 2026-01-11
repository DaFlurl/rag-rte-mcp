package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.TradeBean;
   
   public class TradesUpdate extends BaseBean
   {
      
      public var updateType:int;
      
      public var tradeBean:TradeBean;
      
      public var castleId:int;
      
      public function TradesUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.tradeBean != null)
         {
            this.tradeBean = new TradeBean(param2.tradeBean);
         }
         if(param2.updateType != null)
         {
            this.updateType = param2.updateType;
         }
      }
      
      public function copyTo(param1:TradesUpdate) : void
      {
         param1.castleId = this.castleId;
         if(this.tradeBean != null)
         {
            this.tradeBean.copyTo(param1.tradeBean);
         }
         else
         {
            param1.tradeBean = null;
         }
         param1.updateType = this.updateType;
      }
      
      public function toObject() : Object
      {
         return {
            "castleId":this.castleId,
            "tradeBean":this.tradeBean.toObject(),
            "updateType":this.updateType
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- TradesUpdate ----\n" + (param1 + "castleId = " + this.castleId + "\n") + (this.tradeBean != null ? this.tradeBean.toDebugString(param1 + "tradeBean.") : param1 + "tradeBean = null\n") + (param1 + "updateType = " + this.updateType + "\n");
      }
   }
}

