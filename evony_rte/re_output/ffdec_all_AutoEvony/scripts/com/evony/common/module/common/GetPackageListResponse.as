package com.evony.common.module.common
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.PackageBean;
   import mx.collections.ArrayCollection;
   
   public class GetPackageListResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var packagesArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function GetPackageListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:PackageBean = null;
         var _loc6_:int = 0;
         this.packagesArray = new ArrayCollection();
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
         if(param2.packages)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.packages.length)
            {
               _loc5_ = new PackageBean(param2.packages[_loc6_]);
               this.packagesArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function getPackages(param1:int) : PackageBean
      {
         return this.packagesArray[param1] as PackageBean;
      }
      
      public function setPackages(param1:PackageBean, param2:int) : void
      {
         this.packagesArray[param2] = param1;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- GetPackageListResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         var _loc3_:int = 0;
         while(_loc3_ < this.packagesArray.length)
         {
            _loc2_ += this.getPackages(_loc3_).toDebugString(param1 + "packages[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:GetPackageListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.packagesArray,param1.packagesArray);
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
   }
}

