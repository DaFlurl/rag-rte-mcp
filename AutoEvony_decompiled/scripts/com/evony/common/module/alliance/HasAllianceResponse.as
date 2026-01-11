package com.evony.common.module.alliance
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.IndexAllianceInfoBean;
   import com.evony.common.beans.UnitAlliance;
   import mx.collections.ArrayCollection;
   
   public class HasAllianceResponse extends BaseBean
   {
      
      public var msg:String;
      
      public var middleListArray:ArrayCollection = new ArrayCollection();
      
      public var indexAllianceInfoBean:IndexAllianceInfoBean;
      
      public var packageId:Number;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public var serialVersionUID:Number;
      
      public var friendlyListArray:ArrayCollection = new ArrayCollection();
      
      public var enemyListArray:ArrayCollection = new ArrayCollection();
      
      public function HasAllianceResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.errorMsg != null)
         {
            this.errorMsg = param2.errorMsg;
         }
         if(param2.indexAllianceInfoBean != null)
         {
            this.indexAllianceInfoBean = new IndexAllianceInfoBean(param2.indexAllianceInfoBean);
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
         if(param2.serialVersionUID != null)
         {
            this.serialVersionUID = param2.serialVersionUID;
         }
         var _loc5_:int = 0;
         var _loc6_:UnitAlliance = null;
         if(param2.enemyList)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.enemyList.length)
            {
               _loc6_ = new UnitAlliance(param2.enemyList[_loc5_]);
               this.enemyListArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.friendlyList)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.friendlyList.length)
            {
               _loc6_ = new UnitAlliance(param2.friendlyList[_loc5_]);
               this.friendlyListArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.middleList)
         {
            _loc5_ = 0;
            while(_loc5_ < param2.middleList.length)
            {
               _loc6_ = new UnitAlliance(param2.middleList[_loc5_]);
               this.middleListArray.addItem(_loc6_);
               _loc5_++;
            }
         }
      }
      
      public function setEnemyList(param1:UnitAlliance, param2:int) : void
      {
         this.enemyListArray[param2] = param1;
      }
      
      public function getMiddleList(param1:int) : UnitAlliance
      {
         return this.middleListArray[param1] as UnitAlliance;
      }
      
      public function setMiddleList(param1:UnitAlliance, param2:int) : void
      {
         this.middleListArray[param2] = param1;
      }
      
      public function getEnemyList(param1:int) : UnitAlliance
      {
         return this.enemyListArray[param1] as UnitAlliance;
      }
      
      public function toObject() : Object
      {
         return {
            "errorMsg":this.errorMsg,
            "indexAllianceInfoBean":this.indexAllianceInfoBean.toObject(),
            "msg":this.msg,
            "ok":this.ok,
            "packageId":this.packageId,
            "serialVersionUID":this.serialVersionUID
         };
      }
      
      public function getFriendlyList(param1:int) : UnitAlliance
      {
         return this.friendlyListArray[param1] as UnitAlliance;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- HasAllianceResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n");
         if(this.indexAllianceInfoBean != null)
         {
            _loc2_ += this.indexAllianceInfoBean.toDebugString(param1 + "indexAllianceInfoBean.");
         }
         else
         {
            _loc2_ += param1 + "indexAllianceInfoBean = null\n";
         }
         _loc2_ += param1 + "msg = " + this.msg + "\n" + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n") + (param1 + "serialVersionUID = " + this.serialVersionUID + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.enemyListArray.length)
         {
            _loc2_ += this.getEnemyList(_loc3_).toDebugString(param1 + "enemyList[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.friendlyListArray.length)
         {
            _loc2_ += this.getFriendlyList(_loc3_).toDebugString(param1 + "friendlyList[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.middleListArray.length)
         {
            _loc2_ += this.getMiddleList(_loc3_).toDebugString(param1 + "middleList[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:HasAllianceResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         if(this.indexAllianceInfoBean != null)
         {
            this.indexAllianceInfoBean.copyTo(param1.indexAllianceInfoBean);
         }
         else
         {
            param1.indexAllianceInfoBean = null;
         }
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         param1.serialVersionUID = this.serialVersionUID;
         CommonUtil.arrayCopy(this.enemyListArray,param1.enemyListArray);
         CommonUtil.arrayCopy(this.friendlyListArray,param1.friendlyListArray);
         CommonUtil.arrayCopy(this.middleListArray,param1.middleListArray);
      }
      
      public function setFriendlyList(param1:UnitAlliance, param2:int) : void
      {
         this.friendlyListArray[param2] = param1;
      }
   }
}

