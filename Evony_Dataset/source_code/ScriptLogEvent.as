package autoevony.event
{
   import autoevony.scripts.CityState;
   import flash.events.Event;
   
   public class ScriptLogEvent extends Event
   {
      public static const MESSAGE:int = 0;
      
      public static const ERROR:int = 1;
      
      public static const TYPE:String = "LogEventType";
      
      public var logText:String;
      
      public var logType:int;
      
      public var logCity:CityState;
      
      public function ScriptLogEvent(param1:String, param2:int = 0, param3:CityState = null)
      {
         super(TYPE);
         this.logText = param1;
         this.logType = param2;
         this.logCity = param3;
      }
   }
}

