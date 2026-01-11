package com.skype
{
   internal class SkypeMsgBean
   {
      internal var addedAt:Number = 0;
      
      internal var callback:Function = null;
      
      internal var message:String = null;
      
      internal var isGroup:Boolean = false;
      
      internal var receiver:String = null;
      
      public function SkypeMsgBean(param1:String, param2:String, param3:Boolean = false, param4:Function = null)
      {
         super();
         this.addedAt = new Date().getTime();
         this.receiver = param1;
         this.message = param2;
         this.isGroup = param3;
         this.callback = param4;
      }
   }
}

