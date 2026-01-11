package com.evony.common.module.troop
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.AllProduceBean;
   import mx.collections.ArrayCollection;
   
   public class ProduceQueueResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var ok:int;
      
      public var allProduceQueueArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var errorMsg:String;
      
      public function ProduceQueueResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:AllProduceBean = null;
         var _loc6_:int = 0;
         this.allProduceQueueArray = new ArrayCollection();
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
         if(param2.allProduceQueue)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.allProduceQueue.length)
            {
               _loc5_ = new AllProduceBean(param2.allProduceQueue[_loc6_]);
               this.allProduceQueueArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- ProduceQueueResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.allProduceQueueArray.length)
         {
            _loc2_ += this.getAllProduceQueue(_loc3_).toDebugString(param1 + "allProduceQueueArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setAllProduceQueue(param1:AllProduceBean, param2:int) : void
      {
         this.allProduceQueueArray[param2] = param1;
      }
      
      public function toObject() : Object
      {
         return {
            "msg":this.msg,
            "errorMsg":this.errorMsg,
            "ok":this.ok,
            "packageId":this.packageId,
            "allProduceQueueArray":this.allProduceQueueArray
         };
      }
      
      public function getAllProduceQueue(param1:int) : AllProduceBean
      {
         return this.allProduceQueueArray[param1] as AllProduceBean;
      }
      
      public function copyTo(param1:ProduceQueueResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.allProduceQueueArray,param1.allProduceQueueArray);
      }
   }
}

