package com.evony.common.module.castle
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.*;
   
   public class CastleSignResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var packageId:Number;
      
      public var ok:int;
      
      public var errorMsg:String;
      
      public var castleSignInfoArrArray:ArrayCollection;
      
      public function CastleSignResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         var _loc6_:* = null;
         this.castleSignInfoArrArray = new ArrayCollection();
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
         if(param2.castleSignInfoArr)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.castleSignInfoArr.length)
            {
               _loc6_ = new CastleSignInfoBean(param2.castleSignInfoArr[_loc5_]);
               this.castleSignInfoArrArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function getCastleSignInfoArr(param1:int) : CastleSignInfoBean
      {
         return this.castleSignInfoArrArray[param1] as CastleSignInfoBean;
      }
      
      public function copyTo(param1:CastleSignResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.castleSignInfoArrArray,param1.castleSignInfoArrArray);
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- CastleSignResponse ----\n";
         _loc3_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc3_ += param1 + "msg = " + this.msg + "\n";
         _loc3_ += param1 + "ok = " + this.ok + "\n";
         _loc3_ += param1 + "packageId = " + this.packageId + "\n";
         _loc2_ = 0;
         while(_loc2_ < this.castleSignInfoArrArray.length)
         {
            _loc3_ += this.getCastleSignInfoArr(_loc2_).toDebugString(param1 + "castleSignInfoArr[" + _loc2_ + "].");
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.msg = this.msg;
         _loc1_.ok = this.ok;
         _loc1_.packageId = this.packageId;
         return _loc1_;
      }
      
      public function setCastleSignInfoArr(param1:CastleSignInfoBean, param2:int) : void
      {
         this.castleSignInfoArrArray[param2] = param1;
      }
   }
}

