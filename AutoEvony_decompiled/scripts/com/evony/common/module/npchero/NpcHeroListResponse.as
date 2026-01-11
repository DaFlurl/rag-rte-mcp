package com.evony.common.module.npchero
{
   import com.evony.common.*;
   import com.evony.common.beans.*;
   import mx.collections.ArrayCollection;
   
   public class NpcHeroListResponse extends BaseBean
   {
      
      public var packageId:Number;
      
      public var msg:String;
      
      public var simpleNpcHerosArray:ArrayCollection;
      
      public var npcHerosArray:ArrayCollection;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function NpcHeroListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc6_:NpcHeroBean = null;
         var _loc7_:SimpleNpcHeroBean = null;
         this.npcHerosArray = new ArrayCollection();
         this.simpleNpcHerosArray = new ArrayCollection();
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
         if(param2.npcHeros)
         {
            _loc6_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.npcHeros.length)
            {
               _loc6_ = new NpcHeroBean(param2.npcHeros[_loc5_]);
               this.npcHerosArray.addItem(_loc6_);
               _loc5_++;
            }
         }
         if(param2.simpleNpcHeros)
         {
            _loc7_ = null;
            _loc5_ = 0;
            while(_loc5_ < param2.simpleNpcHeros.length)
            {
               _loc7_ = new SimpleNpcHeroBean(param2.simpleNpcHeros[_loc5_]);
               this.simpleNpcHerosArray.addItem(_loc7_);
               _loc5_++;
            }
         }
      }
      
      public function getSimpleNpcHeros(param1:int) : SimpleNpcHeroBean
      {
         return this.simpleNpcHerosArray[param1] as SimpleNpcHeroBean;
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
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:String = "---- NpcHeroListResponse ----\n";
         _loc2_ += param1 + "errorMsg = " + this.errorMsg + "\n";
         _loc2_ += param1 + "msg = " + this.msg + "\n";
         _loc2_ += param1 + "ok = " + this.ok + "\n";
         _loc2_ += param1 + "packageId = " + this.packageId + "\n";
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.npcHerosArray.length)
         {
            _loc2_ += this.getNpcHeros(_loc3_).toDebugString(param1 + "npcHeros[" + _loc3_ + "].");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.simpleNpcHerosArray.length)
         {
            _loc2_ += this.getSimpleNpcHeros(_loc3_).toDebugString(param1 + "simpleNpcHeros[" + _loc3_ + "].");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setSimpleNpcHeros(param1:SimpleNpcHeroBean, param2:int) : void
      {
         this.simpleNpcHerosArray[param2] = param1;
      }
      
      public function getNpcHeros(param1:int) : NpcHeroBean
      {
         return this.npcHerosArray[param1] as NpcHeroBean;
      }
      
      public function copyTo(param1:NpcHeroListResponse) : void
      {
         param1.errorMsg = this.errorMsg;
         param1.msg = this.msg;
         param1.ok = this.ok;
         param1.packageId = this.packageId;
         CommonUtil.arrayCopy(this.npcHerosArray,param1.npcHerosArray);
         CommonUtil.arrayCopy(this.simpleNpcHerosArray,param1.simpleNpcHerosArray);
      }
      
      public function setNpcHeros(param1:NpcHeroBean, param2:int) : void
      {
         this.npcHerosArray[param2] = param1;
      }
   }
}

