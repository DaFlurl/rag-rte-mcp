package com.evony.common.module.hero
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.DisappearHeroBean;
   import mx.collections.ArrayCollection;
   
   public class DisappearHeroResponse extends BaseBean
   {
      
      public var herosArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function DisappearHeroResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:DisappearHeroBean = null;
         var _loc6_:int = 0;
         this.herosArray = new ArrayCollection();
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
         if(param2.heros)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.heros.length)
            {
               _loc5_ = new DisappearHeroBean(param2.heros[_loc6_]);
               this.herosArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function getHeros(param1:int) : DisappearHeroBean
      {
         return this.herosArray[param1] as DisappearHeroBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- DisappearHeroResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.herosArray.length)
         {
            _loc2_ += this.getHeros(_loc3_).toDebugString(param1 + "heros[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:DisappearHeroResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.herosArray,param1.herosArray);
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
      
      public function setHeros(param1:DisappearHeroBean, param2:int) : void
      {
         this.herosArray[param2] = param1;
      }
   }
}

