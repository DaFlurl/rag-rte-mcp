package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class SecurityCodeRemovedEvent extends BaseBean
   {
      
      public var isSetSecurityCode:Boolean;
      
      public function SecurityCodeRemovedEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.isSetSecurityCode != null)
         {
            this.isSetSecurityCode = param2.isSetSecurityCode;
         }
      }
      
      public function copyTo(param1:SecurityCodeRemovedEvent) : void
      {
         param1.isSetSecurityCode = this.isSetSecurityCode;
      }
      
      public function toObject() : Object
      {
         return {"isSetSecurityCode":this.isSetSecurityCode};
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- SecurityCodeRemovedEvent ----\n" + (param1 + "isSetSecurityCode = " + this.isSetSecurityCode + "\n");
      }
   }
}

