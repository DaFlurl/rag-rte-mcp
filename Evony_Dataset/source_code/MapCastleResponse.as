package com.evony.common.module.common
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.MapCastleBean;
   import mx.collections.ArrayCollection;
   
   public class MapCastleResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var castleArrayArray:ArrayCollection;
      
      public function MapCastleResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:MapCastleBean = null;
         var _loc6_:int = 0;
         this.castleArrayArray = new ArrayCollection();
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
         if(param2.castleArray)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.castleArray.length)
            {
               _loc5_ = new MapCastleBean(param2.castleArray[_loc6_]);
               this.castleArrayArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setCastleArray(param1:MapCastleBean, param2:int) : void
      {
         this.castleArrayArray[param2] = param1;
      }
      
      public function getCastleArray(param1:int) : MapCastleBean
      {
         return this.castleArrayArray[param1] as MapCastleBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- MapCastleResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.castleArrayArray.length)
         {
            _loc2_ += this.getCastleArray(_loc3_).toDebugString(param1 + "castleArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:MapCastleResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.castleArrayArray,param1.castleArrayArray);
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

