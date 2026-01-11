package com.evony.common.server.events
{
   import com.evony.common.*;
   
   public class DeclaredWarStatusChange extends BaseBean
   {
      public var status:int;
      
      public var userName:String;
      
      public function DeclaredWarStatusChange(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:* = 0;
         super(param1,param3,param4);
         if(param2.status != null)
         {
            this.status = param2.status;
         }
         if(param2.userName != null)
         {
            this.userName = param2.userName;
         }
      }
      
      public function copyTo(param1:DeclaredWarStatusChange) : void
      {
         param1.status = this.status;
         param1.userName = this.userName;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         var _loc2_:* = 0;
         var _loc3_:* = "---- DeclaredWarStatusChange ----\n";
         _loc3_ += param1 + "status = " + this.status + "\n";
         return _loc3_ + (param1 + "userName = " + this.userName + "\n");
      }
      
      public function toObject() : Object
      {
         var _loc1_:* = new Object();
         _loc1_.status = this.status;
         _loc1_.userName = this.userName;
         return _loc1_;
      }
   }
}

