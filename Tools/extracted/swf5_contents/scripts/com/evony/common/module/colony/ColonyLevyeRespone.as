package com.evony.common.module.colony
{
   import com.evony.common.BaseBean;
   
   public class ColonyLevyeRespone extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var armyType:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var amount:int;
      
      public function ColonyLevyeRespone(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.amount != null)
         {
            this.amount = param2.amount;
         }
         if(param2.armyType != null)
         {
            this.armyType = param2.armyType;
         }
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.msg != null)
         {
            this.msg = param2.msg;
         }
         if(param2.ok != null)
         {
            this.ok = param2.ok;
         }
         if(param2.packageId != null)
         {
            this.packageId = param2.packageId;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- ColonyLevyeRespone ----\n" + (param1 + "amount = " + this.amount + "\n") + (param1 + "armyType = " + this.armyType + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
      }
      
      public function toObject() : Object
      {
         return {
            "amount":this.amount,
            "armyType":this.armyType,
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
      
      public function copyTo(param1:ColonyLevyeRespone) : void
      {
         param1.amount = this.amount;
         param1.armyType = this.armyType;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
      }
   }
}

