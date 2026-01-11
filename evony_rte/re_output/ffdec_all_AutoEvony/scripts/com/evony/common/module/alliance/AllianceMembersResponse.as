package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.PlayerInfoBean;
   import mx.collections.ArrayCollection;
   
   public class AllianceMembersResponse extends BaseBean
   {
      
      public var membersArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function AllianceMembersResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:PlayerInfoBean = null;
         var _loc6_:int = 0;
         this.membersArray = new ArrayCollection();
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
         if(param2.members)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.members.length)
            {
               _loc5_ = new PlayerInfoBean(param2.members[_loc6_]);
               this.membersArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function getMembers(param1:int) : PlayerInfoBean
      {
         return this.membersArray[param1] as PlayerInfoBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- AllianceMembersResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.membersArray.length)
         {
            _loc2_ += this.getMembers(_loc3_).toDebugString(param1 + "membersArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:AllianceMembersResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.membersArray,param1.membersArray);
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
      
      public function setMembers(param1:PlayerInfoBean, param2:int) : void
      {
         this.membersArray[param2] = param1;
      }
   }
}

