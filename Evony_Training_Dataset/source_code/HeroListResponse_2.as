package com.evony.common.module.hero
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class HeroListResponse extends BaseBean
   {
      public var herosArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var posCount:int;
      
      public var ok:int;
      
      public function HeroListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:int = 0;
         var _loc6_:HeroBean = null;
         super(param1,param3,param4);
         this.herosArray = new ArrayCollection();
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
         if(param2.posCount != null)
         {
            this.posCount = param2.posCount;
         }
         if(param2.heros)
         {
            _loc5_ = 0;
            _loc6_ = null;
            while(_loc5_ < param2.heros.length)
            {
               _loc6_ = new HeroBean(param2.heros[_loc5_]);
               this.herosArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function getHeros(param1:int) : HeroBean
      {
         return this.herosArray[param1] as HeroBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- HeroListResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ += param1 + "posCount = " + this.posCount + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.herosArray.length)
         {
            _loc2_ += this.getHeros(_loc3_).toDebugString(param1 + "heros[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:HeroListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.posCount = this.posCount;
         CommonUtil.arrayCopy(this.herosArray,param1.herosArray);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         _loc1_.posCount = this.posCount;
         return _loc1_;
      }
      
      public function setHeros(param1:HeroBean, param2:int) : void
      {
         this.herosArray[param2] = param1;
      }
   }
}

