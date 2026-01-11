package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.AllianceAddPlayerInfoBean;
   import mx.collections.ArrayCollection;
   
   public class AllianceInviteBeanResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var allianceAddPlayerInfoBeanListArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function AllianceInviteBeanResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:AllianceAddPlayerInfoBean = null;
         var _loc6_:int = 0;
         this.allianceAddPlayerInfoBeanListArray = new ArrayCollection();
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
         if(param2.allianceAddPlayerInfoBeanList)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.allianceAddPlayerInfoBeanList.length)
            {
               _loc5_ = new AllianceAddPlayerInfoBean(param2.allianceAddPlayerInfoBeanList[_loc6_]);
               this.allianceAddPlayerInfoBeanListArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setAllianceAddPlayerInfoBeanList(param1:AllianceAddPlayerInfoBean, param2:int) : void
      {
         this.allianceAddPlayerInfoBeanListArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- AllianceInviteBeanResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.allianceAddPlayerInfoBeanListArray.length)
         {
            _loc2_ += this.getAllianceAddPlayerInfoBeanList(_loc3_).toDebugString(param1 + "allianceAddPlayerInfoBeanList[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAllianceAddPlayerInfoBeanList(param1:int) : AllianceAddPlayerInfoBean
      {
         return this.allianceAddPlayerInfoBeanListArray[param1] as AllianceAddPlayerInfoBean;
      }
      
      public function copyTo(param1:AllianceInviteBeanResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.allianceAddPlayerInfoBeanListArray,param1.allianceAddPlayerInfoBeanListArray);
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

