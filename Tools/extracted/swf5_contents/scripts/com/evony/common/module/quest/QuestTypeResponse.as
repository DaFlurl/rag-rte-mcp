package com.evony.common.module.quest
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.QuestTypeBean;
   import mx.collections.ArrayCollection;
   
   public class QuestTypeResponse extends BaseBean
   {
      public var typesArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function QuestTypeResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:QuestTypeBean = null;
         var _loc6_:int = 0;
         this.typesArray = new ArrayCollection();
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
         if(param2.types)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.types.length)
            {
               _loc5_ = new QuestTypeBean(param2.types[_loc6_]);
               this.typesArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function getTypes(param1:int) : QuestTypeBean
      {
         return this.typesArray[param1] as QuestTypeBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- QuestTypeResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.typesArray.length)
         {
            _loc2_ += this.getTypes(_loc3_).toDebugString(param1 + "types[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:QuestTypeResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.typesArray,param1.typesArray);
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
      
      public function setTypes(param1:QuestTypeBean, param2:int) : void
      {
         this.typesArray[param2] = param1;
      }
   }
}

