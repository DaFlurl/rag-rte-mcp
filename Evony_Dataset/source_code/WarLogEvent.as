package autoevony.event
{
   import flash.events.Event;
   
   public class WarLogEvent extends Event
   {
      public static const MESSAGE:int = 0;
      
      public static const ERROR:int = 1;
      
      public static const TYPE:String = "LogWarEventType";
      
      public var logText:String;
      
      public var logType:int;
      
      public function WarLogEvent(param1:String, param2:int = 0)
      {
         super(TYPE);
         this.logType = param2;
         this.logText = param1;
      }
   }
}

