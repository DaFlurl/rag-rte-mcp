package com.skype
{
   public class SkypeResponse
   {
      public var msg:String;
      
      public var errorMsg:String;
      
      public var ok:int;
      
      public function SkypeResponse(param1:int, param2:String = "", param3:String = "")
      {
         super();
         this.ok = param1;
         this.msg = param2;
         this.errorMsg = param3;
      }
   }
}

