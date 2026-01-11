// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.RepeatableBinding

package mx.binding
{
    import flash.events.Event;
    import mx.core.IRepeaterClient;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RepeatableBinding extends Binding 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function RepeatableBinding(_arg_1:Object, _arg_2:Function, _arg_3:Function, _arg_4:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function eventHandler(_arg_1:Event):void
        {
            if (isHandlingEvent)
            {
                return;
            };
            isHandlingEvent = true;
            execute();
            isHandlingEvent = false;
        }

        override public function execute(_arg_1:Object=null):void
        {
            var _local_2:String;
            var _local_3:Array;
            if (isExecuting)
            {
                return;
            };
            isExecuting = true;
            if (!_arg_1)
            {
                _local_2 = destString.substring(0, destString.indexOf("."));
                _arg_1 = document[_local_2];
            }
            else
            {
                if (typeof(_arg_1) == "number")
                {
                    _local_2 = destString.substring(0, destString.indexOf("."));
                    _local_3 = (document[_local_2] as Array);
                    if (_local_3)
                    {
                        _arg_1 = _local_3[_arg_1];
                    }
                    else
                    {
                        _arg_1 = null;
                    };
                };
            };
            if (_arg_1)
            {
                recursivelyProcessIDArray(_arg_1);
            };
            isExecuting = false;
        }

        private function recursivelyProcessIDArray(o:Object):void
        {
            var array:Array;
            var n:int;
            var i:int;
            var client:IRepeaterClient;
            if ((o is Array))
            {
                array = (o as Array);
                n = array.length;
                i = 0;
                while (i < n)
                {
                    recursivelyProcessIDArray(array[i]);
                    i = (i + 1);
                };
            }
            else
            {
                if ((o is IRepeaterClient))
                {
                    client = IRepeaterClient(o);
                    wrapFunctionCall(this, function ():void
                    {
                        var _local_1:Object = wrapFunctionCall(this, srcFunc, null, client.instanceIndices, client.repeaterIndices);
                        if (BindingManager.debugDestinationStrings[destString])
                        {
                            trace(((("RepeatableBinding: destString = " + destString) + ", srcFunc result = ") + _local_1));
                        };
                        destFunc(_local_1, client.instanceIndices);
                    }, o);
                };
            };
        }


    }
}//package mx.binding

