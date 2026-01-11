package com.evony.common.module.common
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.MapCastleBean;
   import mx.collections.ArrayCollection;
   
   public class MapInfoResponse extends BaseBean
   {
      public var msg:String;
      
      public var packageId:Number;
      
      public var y1:int;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var castlesArray:ArrayCollection;
      
      public var y2:int;
      
      public var mapStr:String;
      
      public var x1:int;
      
      public var x2:int;
      
      public function MapInfoResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:MapCastleBean = null;
         var _loc6_:int = 0;
         this.castlesArray = new ArrayCollection();
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.mapStr != null)
         {
            this.mapStr = param2.mapStr;
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
         if(param2.x1 != null)
         {
            this.x1 = param2.x1;
         }
         if(param2.x2 != null)
         {
            this.x2 = param2.x2;
         }
         if(param2.y1 != null)
         {
            this.y1 = param2.y1;
         }
         if(param2.y2 != null)
         {
            this.y2 = param2.y2;
         }
         if(param2.castles)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.castles.length)
            {
               _loc5_ = new MapCastleBean(param2.castles[_loc6_]);
               this.castlesArray.addItem(_loc5_);
               _loc6_++;
            }
         }
      }
      
      public function setCastles(param1:MapCastleBean, param2:int) : void
      {
         this.castlesArray[param2] = param1;
      }
      
      public function getCastles(param1:int) : MapCastleBean
      {
         return this.castlesArray[param1] as MapCastleBean;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- MapInfoResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "mapStr = " + this.mapStr + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "x1 = " + this.x1 + "\n") + (param1 + "x2 = " + this.x2 + "\n") + (param1 + "y1 = " + this.y1 + "\n") + (param1 + "y2 = " + this.y2 + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.castlesArray.length)
         {
            _loc2_ += this.getCastles(_loc3_).toDebugString(param1 + "castles[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:MapInfoResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.mapStr = this.mapStr;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.x1 = this.x1;
         param1.x2 = this.x2;
         param1.y1 = this.y1;
         param1.y2 = this.y2;
         CommonUtil.arrayCopy(this.castlesArray,param1.castlesArray);
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "mapStr":this.mapStr,
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "x1":this.x1,
            "x2":this.x2,
            "y1":this.y1,
            "y2":this.y2
         };
      }
   }
}

