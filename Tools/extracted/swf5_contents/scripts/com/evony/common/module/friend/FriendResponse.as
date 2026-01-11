package com.evony.common.module.friend
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.PlayerInfoBean;
   import mx.collections.ArrayCollection;
   
   public class FriendResponse extends BaseBean
   {
      public var msg:String;
      
      public var blockArrArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var friendArrArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function FriendResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc6_:PlayerInfoBean = null;
         var _loc7_:PlayerInfoBean = null;
         this.blockArrArray = new ArrayCollection();
         this.friendArrArray = new ArrayCollection();
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
         var _loc5_:int = 0;
         if(param2.blockArr)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.blockArr.length)
            {
               _loc6_ = new PlayerInfoBean(param2.blockArr[_loc5_]);
               this.blockArrArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.friendArr)
         {
            _loc7_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.friendArr.length)
            {
               _loc7_ = new PlayerInfoBean(param2.friendArr[_loc5_]);
               this.friendArrArray.addItem(_loc7_);
               _loc5_++;
            }
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- FriendResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.blockArrArray.length)
         {
            _loc2_ += this.getBlockArr(_loc3_).toDebugString(param1 + "blockArr[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.friendArrArray.length)
         {
            _loc2_ += this.getFriendArr(_loc3_).toDebugString(param1 + "friendArr[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getFriendArr(param1:int) : PlayerInfoBean
      {
         return this.friendArrArray[param1] as PlayerInfoBean;
      }
      
      public function setFriendArr(param1:PlayerInfoBean, param2:int) : void
      {
         this.friendArrArray[param2] = param1;
      }
      
      public function getBlockArr(param1:int) : PlayerInfoBean
      {
         return this.blockArrArray[param1] as PlayerInfoBean;
      }
      
      public function copyTo(param1:FriendResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.blockArrArray,param1.blockArrArray);
         CommonUtil.arrayCopy(this.friendArrArray,param1.friendArrArray);
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
      
      public function setBlockArr(param1:PlayerInfoBean, param2:int) : void
      {
         this.blockArrArray[param2] = param1;
      }
   }
}

