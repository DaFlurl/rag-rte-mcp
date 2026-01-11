package com.evony.common.module.castle
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.AvailableBuildingListBean;
   import mx.collections.ArrayCollection;
   
   public class AvailableBuilingListResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var builingListArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function AvailableBuilingListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:AvailableBuildingListBean = null;
         var _loc6_:int = 0;
         this.builingListArray = new ArrayCollection();
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
         if(param2.builingList)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.builingList.length)
            {
               _loc5_ = new AvailableBuildingListBean(param2.builingList[_loc6_]);
               this.builingListArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setBuilingList(param1:AvailableBuildingListBean, param2:int) : void
      {
         this.builingListArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- AvailableBuilingListResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.builingListArray.length)
         {
            _loc2_ += this.getBuilingList(_loc3_).toDebugString(param1 + "builingList[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getBuilingList(param1:int) : AvailableBuildingListBean
      {
         return this.builingListArray[param1] as AvailableBuildingListBean;
      }
      
      public function copyTo(param1:AvailableBuilingListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.builingListArray,param1.builingListArray);
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
   }
}

