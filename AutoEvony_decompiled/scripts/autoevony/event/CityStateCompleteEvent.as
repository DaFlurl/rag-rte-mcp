package autoevony.event
{
   import flash.events.Event;
   
   public class CityStateCompleteEvent extends Event
   {
      
      public static const TYPE:String = "CityStateCompleteEvent";
      
      public var response:Object;
      
      public function CityStateCompleteEvent(param1:Object)
      {
         super(TYPE);
         this.response = param1;
      }
   }
}

