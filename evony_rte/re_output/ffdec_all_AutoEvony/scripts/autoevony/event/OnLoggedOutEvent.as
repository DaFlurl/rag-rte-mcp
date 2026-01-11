package autoevony.event
{
   import flash.events.Event;
   
   public class OnLoggedOutEvent extends Event
   {
      
      public static const ON_LOGOUT_EVENT:String = "on.server.logout.event";
      
      public function OnLoggedOutEvent()
      {
         super(ON_LOGOUT_EVENT,true);
      }
   }
}

