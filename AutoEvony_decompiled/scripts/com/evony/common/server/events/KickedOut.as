package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class KickedOut extends BaseBean
   {
      
      public var ip:String;
      
      public function KickedOut(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.ip != null)
         {
            this.ip = param2.ip;
         }
      }
      
      public function copyTo(param1:KickedOut) : void
      {
         param1.ip = this.ip;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- KickedOut ----\n" + (param1 + "ip = " + this.ip + "\n");
      }
      
      public function toObject() : Object
      {
         return {"ip":this.ip};
      }
   }
}

