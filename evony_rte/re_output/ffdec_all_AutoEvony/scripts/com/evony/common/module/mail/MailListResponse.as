package com.evony.common.module.mail
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.MailBean;
   import mx.collections.ArrayCollection;
   
   public class MailListResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var pageNo:int;
      
      public var totalPage:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var mailsArray:ArrayCollection;
      
      public function MailListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:MailBean = null;
         var _loc6_:int = 0;
         this.mailsArray = new ArrayCollection();
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
         if(param2.mails)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.mails.length)
            {
               _loc5_ = new MailBean(param2.mails[_loc6_]);
               this.mailsArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setMails(param1:MailBean, param2:int) : void
      {
         this.mailsArray[param2] = param1;
      }
      
      public function getMails(param1:int) : MailBean
      {
         return this.mailsArray[param1] as MailBean;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "pageNo":this.pageNo,
            "loc1.totalPage":this.totalPage
         };
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- MailListResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "pageNo = " + this.pageNo + "\n") + (param1 + "totalPage = " + this.totalPage + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.mailsArray.length)
         {
            _loc2_ += this.getMails(_loc3_).toDebugString(param1 + "mails[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:MailListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.pageNo = this.pageNo;
         param1.totalPage = this.totalPage;
         CommonUtil.arrayCopy(this.mailsArray,param1.mailsArray);
      }
   }
}

