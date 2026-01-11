package com.evony.common.module.tech
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.AvailableResearchListBean;
   import mx.collections.ArrayCollection;
   
   public class AvailableResearchListResponse extends BaseBean
   {
      public var msg:String;
      
      public var academyCount:int;
      
      public var packageId:Number;
      
      public var acailableResearchBeansArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function AvailableResearchListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:AvailableResearchListBean = null;
         var _loc6_:int = 0;
         this.acailableResearchBeansArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.academyCount != null)
         {
            this.academyCount = param2.academyCount;
         }
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
         if(param2.acailableResearchBeans)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.acailableResearchBeans.length)
            {
               _loc5_ = new AvailableResearchListBean(param2.acailableResearchBeans[_loc6_]);
               this.acailableResearchBeansArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function toObject() : Object
      {
         return {
            "academyCount":this.academyCount,
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId
         };
      }
      
      public function setAcailableResearchBeans(param1:AvailableResearchListBean, param2:int) : void
      {
         this.acailableResearchBeansArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- AvailableResearchListResponse ----\n" + (param1 + "academyCount = " + this.academyCount + "\n") + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.acailableResearchBeansArray.length)
         {
            _loc2_ += this.getAcailableResearchBeans(_loc3_).toDebugString(param1 + "acailableResearchBeans[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getAcailableResearchBeans(param1:int) : AvailableResearchListBean
      {
         return this.acailableResearchBeansArray[param1] as AvailableResearchListBean;
      }
      
      public function copyTo(param1:AvailableResearchListResponse) : void
      {
         param1.academyCount = this.academyCount;
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.acailableResearchBeansArray,param1.acailableResearchBeansArray);
      }
   }
}

