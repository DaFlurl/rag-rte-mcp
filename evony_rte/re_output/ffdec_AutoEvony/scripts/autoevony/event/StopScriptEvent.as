package autoevony.event
{
   import flash.events.Event;
   
   public class StopScriptEvent extends Event
   {
      
      public static const STOP_SCRIPT:String = "LogWarEventType";
      
      public var castleId:int;
      
      public function StopScriptEvent(param1:int)
      {
         super(STOP_SCRIPT);
         this.castleId = param1;
      }
   }
}

