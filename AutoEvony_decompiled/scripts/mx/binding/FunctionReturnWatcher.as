package mx.binding
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import mx.core.EventPriority;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class FunctionReturnWatcher extends Watcher
   {
      
      mx_internal static const VERSION:String = "3.6.0.21751";
      
      private var parameterFunction:Function;
      
      private var functionName:String;
      
      private var functionGetter:Function;
      
      public var parentWatcher:Watcher;
      
      private var parentObj:Object;
      
      private var events:Object;
      
      private var document:Object;
      
      public function FunctionReturnWatcher(param1:String, param2:Object, param3:Function, param4:Object, param5:Array, param6:Function = null)
      {
         super(param5);
         this.functionName = param1;
         this.document = param2;
         this.parameterFunction = param3;
         this.events = param4;
         this.functionGetter = param6;
      }
      
      override protected function shallowClone() : Watcher
      {
         return new FunctionReturnWatcher(functionName,document,parameterFunction,events,listeners,functionGetter);
      }
      
      override public function updateParent(param1:Object) : void
      {
         if(!(param1 is Watcher))
         {
            setupParentObj(param1);
         }
         else if(param1 == parentWatcher)
         {
            setupParentObj(parentWatcher.value);
         }
         updateFunctionReturn();
      }
      
      private function setupParentObj(param1:Object) : void
      {
         var _loc2_:IEventDispatcher = null;
         var _loc3_:String = null;
         if(parentObj != null && parentObj is IEventDispatcher && events != null)
         {
            _loc2_ = parentObj as IEventDispatcher;
            for(_loc3_ in events)
            {
               _loc2_.removeEventListener(_loc3_,eventHandler);
            }
         }
         parentObj = param1;
         if(parentObj != null && parentObj is IEventDispatcher && events != null)
         {
            _loc2_ = parentObj as IEventDispatcher;
            for(_loc3_ in events)
            {
               if(_loc3_ != "__NoChangeEvent__")
               {
                  _loc2_.addEventListener(_loc3_,eventHandler,false,EventPriority.BINDING,true);
               }
            }
         }
      }
      
      public function updateFunctionReturn() : void
      {
         wrapUpdate(function():void
         {
            if(functionGetter != null)
            {
               value = functionGetter(functionName).apply(parentObj,parameterFunction.apply(document));
            }
            else
            {
               value = parentObj[functionName].apply(parentObj,parameterFunction.apply(document));
            }
            updateChildren();
         });
      }
      
      public function eventHandler(param1:Event) : void
      {
         updateFunctionReturn();
         notifyListeners(events[param1.type]);
      }
   }
}

