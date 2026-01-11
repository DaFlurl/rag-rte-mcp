package com.evony.common.module.celeb
{
   import com.evony.common.BaseBean;
   import com.evony.common.CommonUtil;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.beans.RankAllianceBean;
   import mx.collections.ArrayCollection;
   
   public class CelebResponse extends BaseBean
   {
      public var errorMsg:String;
      
      public var msg:String;
      
      public var playerBeanArray:ArrayCollection;
      
      public var allianceBeanArray:ArrayCollection;
      
      public var packageId:Number;
      
      public var ok:int;
      
      public function CelebResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc6_:RankAllianceBean = null;
         var _loc7_:PlayerInfoBean = null;
         this.allianceBeanArray = new ArrayCollection();
         this.playerBeanArray = new ArrayCollection();
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
         var _loc5_:int = 0;
         if(param2.allianceBean)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.allianceBean.length)
            {
               _loc6_ = new RankAllianceBean(param2.allianceBean[_loc5_]);
               this.allianceBeanArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.playerBean)
         {
            _loc7_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.playerBean.length)
            {
               _loc7_ = new PlayerInfoBean(param2.playerBean[_loc5_]);
               this.playerBeanArray.addItem(_loc7_);
               _loc5_++;
            }
         }
      }
      
      public function getPlayerBean(param1:int) : PlayerInfoBean
      {
         return this.playerBeanArray[param1] as PlayerInfoBean;
      }
      
      public function setAllianceBean(param1:RankAllianceBean, param2:int) : void
      {
         this.allianceBeanArray[param2] = param1;
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
         var _loc2_:String = "---- CelebResponse ----\n" + (param1 + "errorMsg = " + this.errorMsg + "\n") + (param1 + "msg = " + this.msg + "\n") + (param1 + "ok = " + this.ok + "\n") + (param1 + "packageId = " + this.packageId + "\n");
         var _loc3_:int = 0;
         while(_loc3_ < this.allianceBeanArray.length)
         {
            _loc2_ += this.getAllianceBean(_loc3_).toDebugString(param1 + "allianceBean[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.playerBeanArray.length)
         {
            _loc2_ += this.getPlayerBean(_loc3_).toDebugString(param1 + "playerBean[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function copyTo(param1:CelebResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.allianceBeanArray,param1.allianceBeanArray);
         CommonUtil.arrayCopy(this.playerBeanArray,param1.playerBeanArray);
      }
      
      public function setPlayerBean(param1:PlayerInfoBean, param2:int) : void
      {
         this.playerBeanArray[param2] = param1;
      }
      
      public function getAllianceBean(param1:int) : RankAllianceBean
      {
         return this.allianceBeanArray[param1] as RankAllianceBean;
      }
   }
}

