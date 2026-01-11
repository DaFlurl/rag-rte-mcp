package com.evony.common.module.colony
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.ArmyBean;
   import mx.collections.ArrayCollection;
   
   public class ColonialArmyResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var armyBeansArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function ColonialArmyResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:ArmyBean = null;
         var _loc6_:int = 0;
         this.armyBeansArray = new ArrayCollection();
         super(param1,param3,param4);
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
         if(param2.armyBeans)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.armyBeans.length)
            {
               _loc5_ = new ArmyBean(param2.armyBeans[_loc6_]);
               this.armyBeansArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setArmyBeans(param1:ArmyBean, param2:int) : void
      {
         this.armyBeansArray[param2] = param1;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- ColonialArmyResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.armyBeansArray.length)
         {
            _loc2_ += this.getArmyBeans(_loc3_).toDebugString(param1 + "armyBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getArmyBeans(param1:int) : ArmyBean
      {
         return this.armyBeansArray[param1] as ArmyBean;
      }
      
      public function copyTo(param1:ColonialArmyResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.armyBeansArray,param1.armyBeansArray);
      }
   }
}

