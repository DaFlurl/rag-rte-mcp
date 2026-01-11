package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.ArmyBean;
   import mx.collections.ArrayCollection;
   
   public class EnemyArmysUpdate extends BaseBean
   {
      public var armysArray:ArrayCollection;
      
      public function EnemyArmysUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:ArmyBean = null;
         var _loc6_:int = 0;
         this.armysArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.armys)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.armys.length)
            {
               _loc5_ = new ArmyBean(param2.armys[_loc6_]);
               this.armysArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function getArmys(param1:int) : ArmyBean
      {
         return this.armysArray[param1] as ArmyBean;
      }
      
      public function toObject() : Object
      {
         return new Object();
      }
      
      public function setArmys(param1:ArmyBean, param2:int) : void
      {
         this.armysArray[param2] = param1;
      }
      
      public function copyTo(param1:EnemyArmysUpdate) : void
      {
         CommonUtil.arrayCopy(this.armysArray,param1.armysArray);
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- EnemyArmysUpdate ----\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.armysArray.length)
         {
            _loc2_ += this.getArmys(_loc3_).toDebugString(param1 + "armys[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

