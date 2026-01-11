// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.FunctionReturnWatcher

package mx.binding
{
    import flash.events.IEventDispatcher;
    import mx.core.EventPriority;
    import flash.events.Event;
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

        public function FunctionReturnWatcher(_arg_1:String, _arg_2:Object, _arg_3:Function, _arg_4:Object, _arg_5:Array, _arg_6:Function=null)
        {
            super(_arg_5);
            this.functionName = _arg_1;
            this.document = _arg_2;
            this.parameterFunction = _arg_3;
            this.events = _arg_4;
            this.functionGetter = _arg_6;
        }

        override protected function shallowClone():Watcher
        {
            return (new FunctionReturnWatcher(functionName, document, parameterFunction, events, listeners, functionGetter));
        }

        override public function updateParent(_arg_1:Object):void
        {
            if (!(_arg_1 is Watcher))
            {
                setupParentObj(_arg_1);
            }
            else
            {
                if (_arg_1 == parentWatcher)
                {
                    setupParentObj(parentWatcher.value);
                };
            };
            updateFunctionReturn();
        }

        private function setupParentObj(_arg_1:Object):void
        {
            var _local_2:IEventDispatcher;
            var _local_3:String;
            if ((((!(parentObj == null)) && (parentObj is IEventDispatcher)) && (!(events == null))))
            {
                _local_2 = (parentObj as IEventDispatcher);
                for (_local_3 in events)
                {
                    _local_2.removeEventListener(_local_3, eventHandler);
                };
            };
            parentObj = _arg_1;
            if ((((!(parentObj == null)) && (parentObj is IEventDispatcher)) && (!(events == null))))
            {
                _local_2 = (parentObj as IEventDispatcher);
                for (_local_3 in events)
                {
                    if (_local_3 != "__NoChangeEvent__")
                    {
                        _local_2.addEventListener(_local_3, eventHandler, false, EventPriority.BINDING, true);
                    };
                };
            };
        }

        public function updateFunctionReturn():void
        {
            wrapUpdate(function ():void
            {
                if (functionGetter != null)
                {
                    value = functionGetter(functionName).apply(parentObj, parameterFunction.apply(document));
                }
                else
                {
                    value = parentObj[functionName].apply(parentObj, parameterFunction.apply(document));
                };
                updateChildren();
            });
        }

        public function eventHandler(_arg_1:Event):void
        {
            updateFunctionReturn();
            notifyListeners(events[_arg_1.type]);
        }


    }
}//package mx.binding

