package autoevony.event
{
   import flash.events.Event;
   
   public class OnLoginEvent extends Event
   {
      
      public static const ON_LOGIN_EVENT:String = "on.server.login.event";
      
      public static const LOGIN_TYPE_EV:int = 0;
      
      public static const LOGIN_TYPE_FB:int = 1;
      
      public var loginType:int = 0;
      
      public function OnLoginEvent(param1:int = 0)
      {
         super(ON_LOGIN_EVENT,true);
         this.loginType = param1;
      }
   }
}

