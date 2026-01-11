package com.evony.common.module.report
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.ReportBean;
   import mx.collections.ArrayCollection;
   
   public class ReportListResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var pageNo:int;
      
      public var totalPage:int;
      
      public var errorMsg:String;
      
      public var reportsArray:ArrayCollection;
      
      public var ok:int;
      
      public function ReportListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:ReportBean = null;
         var _loc6_:int = 0;
         this.reportsArray = new ArrayCollection();
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
         if(param2.pageNo != null)
         {
            this.pageNo = param2.pageNo;
         }
         if(param2.totalPage != null)
         {
            this.totalPage = param2.totalPage;
         }
         if(param2.reports)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.reports.length)
            {
               _loc5_ = new ReportBean(param2.reports[_loc6_]);
               this.reportsArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function toObject() : Object
      {
         return {
            "ok":this.ok,
            "packageId":this.packageId,
            "msg":this.msg,
            "errorMsg":this.errorMsg,
            "pageNo":this.pageNo,
            "totalPage":this.totalPage,
            "reportsArray":this.reportsArray
         };
      }
      
      public function getReports(param1:int) : ReportBean
      {
         return this.reportsArray[param1] as ReportBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- ReportListResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "pageNo = " + this.pageNo + "\n") + (param1 + "totalPage = " + this.totalPage + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.reportsArray.length)
         {
            _loc2_ += this.getReports(_loc3_).toDebugString(param1 + "reportsArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:ReportListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.totalPage = this.totalPage;
         CommonUtil.arrayCopy(this.reportsArray,param1.reportsArray);
      }
      
      public function setReports(param1:ReportBean, param2:int) : void
      {
         this.reportsArray[param2] = param1;
      }
   }
}

