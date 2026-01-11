package autoevony.event
{
   public class EventHandler
   {
      public var type:String;
      
      public var callBack:Function;
      
      public function EventHandler(param1:String, param2:Function)
      {
         super();
         this.type = param1;
         this.callBack = param2;
      }
   }
}

