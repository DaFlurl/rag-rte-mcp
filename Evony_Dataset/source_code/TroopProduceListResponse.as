package com.evony.common.module.troop
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.TroopProduceListBean;
   import mx.collections.ArrayCollection;
   
   public class TroopProduceListResponse extends BaseBean
   {
      public var packageId:Number;
      
      public var msg:String;
      
      public var troopListArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function TroopProduceListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:TroopProduceListBean = null;
         var _loc6_:int = 0;
         this.troopListArray = new ArrayCollection();
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
         if(param2.troopList)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < param2.troopList.length)
            {
               _loc5_ = new TroopProduceListBean(param2.troopList[_loc6_]);
               this.troopListArray.addItem(_loc5_);
               _loc6_++;
            }
         }
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
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- TroopProduceListResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.troopListArray.length)
         {
            _loc2_ += this.getTroopList(_loc3_).toDebugString(param1 + "troopListArray[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setTroopList(param1:TroopProduceListBean, param2:int) : void
      {
         this.troopListArray[param2] = param1;
      }
      
      public function copyTo(param1:TroopProduceListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.troopListArray,param1.troopListArray);
      }
      
      public function getTroopList(param1:int) : TroopProduceListBean
      {
         return this.troopListArray[param1] as TroopProduceListBean;
      }
   }
}

