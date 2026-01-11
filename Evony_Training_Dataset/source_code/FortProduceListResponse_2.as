package com.evony.common.module.fortifications
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.FortProduceListBean;
   import mx.collections.ArrayCollection;
   
   public class FortProduceListResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var fortListArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function FortProduceListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:FortProduceListBean = null;
         var _loc6_:int = 0;
         this.fortListArray = new ArrayCollection();
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
         if(param2.fortList)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.fortList.length)
            {
               _loc5_ = new FortProduceListBean(param2.fortList[_loc6_]);
               this.fortListArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setFortList(param1:FortProduceListBean, param2:int) : void
      {
         this.fortListArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- FortProduceListResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.fortListArray.length)
         {
            _loc2_ += this.getFortList(_loc3_).toDebugString(param1 + "fortList[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:FortProduceListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.fortListArray,param1.fortListArray);
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
      
      public function getFortList(param1:int) : FortProduceListBean
      {
         return this.fortListArray[param1] as FortProduceListBean;
      }
   }
}

