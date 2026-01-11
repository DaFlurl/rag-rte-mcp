package autoevony.event
{
   import flash.events.Event;
   
   public class CityStateResponseEvent extends Event
   {
      public static const TYPE:String = "CityStateResponseEvent";
      
      public var response:Object;
      
      public var textcolor:String;
      
      public var message:String;
      
      public function CityStateResponseEvent(param1:Object, param2:String = "", param3:String = "#000000")
      {
         super(TYPE);
         this.message = param2;
         this.response = param1;
         this.textcolor = param3;
      }
   }
}

