package com.evony.common
{
   import flash.events.Event;
   
   public class NoListenerEvent extends Event
   {
      
      public static const EVENT:String = "NoListenerEvent";
      
      internal var bean:BaseBean;
      
      internal var cmd:String;
      
      public function NoListenerEvent(param1:String, param2:BaseBean, param3:Boolean = false, param4:Boolean = false)
      {
         super(EVENT,param3,param4);
         this.cmd = param1;
         this.bean = param2;
      }
      
      public function getResponseName() : String
      {
         return this.cmd;
      }
      
      public function getBean() : BaseBean
      {
         return this.bean;
      }
   }
}

