package com.evony.common.server.events
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class ColonyUpdate extends BaseBean
   {
      public var castleId:int;
      
      public var colonyBeansArray:ArrayCollection;
      
      public function ColonyUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.colonyBeansArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.castleId != null)
         {
            this.castleId = param2.castleId;
         }
         if(param2.colonyBeans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.colonyBeans.length)
            {
               _loc6_ = new ColonyBean(param2.colonyBeans[_loc5_]);
               this.colonyBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function copyTo(param1:ColonyUpdate) : void
      {
         param1.castleId = this.castleId;
         CommonUtil.arrayCopy(this.colonyBeansArray,param1.colonyBeansArray);
      }
      
      public function getColonyBeans(param1:int) : ColonyBean
      {
         return this.colonyBeansArray[param1] as ColonyBean;
      }
      
      public function setColonyBeans(param1:ColonyBean, param2:int) : void
      {
         this.colonyBeansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- ColonyUpdate ----\n";
         _loc3_ += param1 + "castleId = " + this.castleId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.colonyBeansArray.length)
         {
            _loc3_ += this.getColonyBeans(_loc2_).toDebugString(param1 + "colonyBeans[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.castleId = this.castleId;
         return _loc1_;
      }
   }
}

