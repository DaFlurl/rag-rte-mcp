package com.evony.common.module.quest
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.QuestBean;
   import mx.collections.ArrayCollection;
   
   public class QuestListResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var questsArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function QuestListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:QuestBean = null;
         var _loc6_:int = 0;
         this.questsArray = new ArrayCollection();
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
         if(param2.quests)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.quests.length)
            {
               _loc5_ = new QuestBean(param2.quests[_loc6_]);
               this.questsArray.addItem(_loc5_);
               _loc6_++;
            }
         }
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
      
      public function getQuests(param1:int) : QuestBean
      {
         return this.questsArray[param1] as QuestBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- QuestListResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.questsArray.length)
         {
            _loc2_ += this.getQuests(_loc3_).toDebugString(param1 + "quests[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:QuestListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.questsArray,param1.questsArray);
      }
      
      public function setQuests(param1:QuestBean, param2:int) : void
      {
         this.questsArray[param2] = param1;
      }
   }
}

