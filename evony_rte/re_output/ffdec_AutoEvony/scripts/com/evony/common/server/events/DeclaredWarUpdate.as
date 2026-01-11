package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.PlayerDeclaredWarBean;
   import mx.collections.ArrayCollection;
   
   public class DeclaredWarUpdate extends BaseBean
   {
      
      public var declaredWarBeansArray:ArrayCollection;
      
      public function DeclaredWarUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:int = 0;
         var _loc6_:PlayerDeclaredWarBean = null;
         this.declaredWarBeansArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.declaredWarBeans)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.declaredWarBeans.length)
            {
               _loc6_ = new PlayerDeclaredWarBean(param2.declaredWarBeans[_loc5_]);
               this.declaredWarBeansArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function copyTo(param1:DeclaredWarUpdate) : void
      {
         CommonUtil.arrayCopy(this.declaredWarBeansArray,param1.declaredWarBeansArray);
      }
      
      public function setDeclaredWarBeans(param1:PlayerDeclaredWarBean, param2:int) : void
      {
         this.declaredWarBeansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- DeclaredWarUpdate ----\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.declaredWarBeansArray.length)
         {
            _loc2_ += this.getDeclaredWarBeans(_loc3_).toDebugString(param1 + "declaredWarBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function toObject() : Object
      {
         return new Object();
      }
      
      public function getDeclaredWarBeans(param1:int) : PlayerDeclaredWarBean
      {
         return this.declaredWarBeansArray[param1] as PlayerDeclaredWarBean;
      }
   }
}

