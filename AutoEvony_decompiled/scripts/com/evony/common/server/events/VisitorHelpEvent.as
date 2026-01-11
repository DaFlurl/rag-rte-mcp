package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class VisitorHelpEvent extends BaseBean
   {
      
      public var visitorID:String;
      
      public var visitorName:String;
      
      public function VisitorHelpEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.visitorID != null)
         {
            this.visitorID = param2.visitorID;
         }
         if(param2.visitorName != null)
         {
            this.visitorName = param2.visitorName;
         }
      }
      
      public function copyTo(param1:VisitorHelpEvent) : void
      {
         param1.visitorID = this.visitorID;
         param1.visitorName = this.visitorName;
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- VisitorHelpEvent ----\n" + (param1 + "visitorID = " + this.visitorID + "\n") + (param1 + "visitorName = " + this.visitorName + "\n");
      }
      
      public function toObject() : Object
      {
         return {
            "visitorID":this.visitorID,
            "visitorName":this.visitorName
         };
      }
   }
}

