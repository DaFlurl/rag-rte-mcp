package com.evony.common.module.hero
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.RandomHeroBean;
   
   public class RandomHeroResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var randomherobean:RandomHeroBean;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function RandomHeroResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
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
         if(param2.randomherobean != null)
         {
            this.randomherobean = new RandomHeroBean(param2.randomherobean);
         }
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "randomherobean":this.randomherobean.toObject()
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- RandomHeroResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (this.randomherobean == null ? param1 + "randomherobean = null\n" : this.randomherobean.toDebugString(param1 + "randomherobean."));
      }
      
      public function copyTo(param1:RandomHeroResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         if(this.randomherobean == null)
         {
            param1.randomherobean = null;
         }
         else
         {
            this.randomherobean.copyTo(param1.randomherobean);
         }
      }
   }
}

