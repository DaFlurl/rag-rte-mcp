package com.evony.common
{
   import flash.events.Event;
   
   public class BaseBean extends Event
   {
      public function BaseBean(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return "";
      }
   }
}

