// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.Binding

package mx.binding
{
    import flash.utils.Dictionary;
    import mx.collections.errors.ItemPendingError;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Binding 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        mx_internal var destFunc:Function;
        mx_internal var srcFunc:Function;
        mx_internal var destString:String;
        mx_internal var document:Object;
        private var hasHadValue:Boolean;
        mx_internal var disabledRequests:Dictionary;
        mx_internal var isExecuting:Boolean;
        mx_internal var isHandlingEvent:Boolean;
        public var twoWayCounterpart:Binding;
        private var wrappedFunctionSuccessful:Boolean;
        mx_internal var _isEnabled:Boolean;
        public var uiComponentWatcher:int;
        private var lastValue:Object;

        public function Binding(_arg_1:Object, _arg_2:Function, _arg_3:Function, _arg_4:String)
        {
            this.document = _arg_1;
            this.srcFunc = _arg_2;
            this.destFunc = _arg_3;
            this.destString = _arg_4;
            _isEnabled = true;
            isExecuting = false;
            isHandlingEvent = false;
            hasHadValue = false;
            uiComponentWatcher = -1;
            BindingManager.addBinding(_arg_1, _arg_4, this);
        }

        private function registerDisabledExecute(_arg_1:Object):void
        {
            if (_arg_1 != null)
            {
                disabledRequests = ((disabledRequests != null) ? disabledRequests : new Dictionary(true));
                disabledRequests[_arg_1] = true;
            };
        }

        protected function wrapFunctionCall(thisArg:Object, wrappedFunction:Function, object:Object=null, ... args):Object
        {
            var result:Object;
            wrappedFunctionSuccessful = false;
            try
            {
                result = wrappedFunction.apply(thisArg, args);
                wrappedFunctionSuccessful = true;
                return (result);
            }
            catch(itemPendingError:ItemPendingError)
            {
                itemPendingError.addResponder(new EvalBindingResponder(this, object));
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace(((("Binding: destString = " + destString) + ", error = ") + itemPendingError));
                };
            }
            catch(rangeError:RangeError)
            {
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace(((("Binding: destString = " + destString) + ", error = ") + rangeError));
                };
            }
            catch(error:Error)
            {
                if ((((((!(error.errorID == 1006)) && (!(error.errorID == 1009))) && (!(error.errorID == 1010))) && (!(error.errorID == 1055))) && (!(error.errorID == 1069))))
                {
                    throw (error);
                };
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace(((("Binding: destString = " + destString) + ", error = ") + error));
                };
            };
            return (null);
        }

        public function watcherFired(commitEvent:Boolean, cloneIndex:int):void
        {
            if (isHandlingEvent)
            {
                return;
            };
            try
            {
                isHandlingEvent = true;
                execute(cloneIndex);
            }
            finally
            {
                isHandlingEvent = false;
            };
        }

        private function nodeSeqEqual(_arg_1:XMLList, _arg_2:XMLList):Boolean
        {
            var _local_4:uint;
            var _local_3:uint = _arg_1.length();
            if (_local_3 == _arg_2.length())
            {
                _local_4 = 0;
                while (((_local_4 < _local_3) && (_arg_1[_local_4] === _arg_2[_local_4])))
                {
                    _local_4++;
                };
                return (_local_4 == _local_3);
            };
            return (false);
        }

        mx_internal function set isEnabled(_arg_1:Boolean):void
        {
            _isEnabled = _arg_1;
            if (_arg_1)
            {
                processDisabledRequests();
            };
        }

        private function processDisabledRequests():void
        {
            var _local_1:Object;
            if (disabledRequests != null)
            {
                for (_local_1 in disabledRequests)
                {
                    execute(_local_1);
                };
                disabledRequests = null;
            };
        }

        public function execute(o:Object=null):void
        {
            if (!isEnabled)
            {
                if (o != null)
                {
                    registerDisabledExecute(o);
                };
                return;
            };
            if (((isExecuting) || ((twoWayCounterpart) && (twoWayCounterpart.isExecuting))))
            {
                hasHadValue = true;
                return;
            };
            try
            {
                isExecuting = true;
                wrapFunctionCall(this, innerExecute, o);
            }
            finally
            {
                isExecuting = false;
            };
        }

        mx_internal function get isEnabled():Boolean
        {
            return (_isEnabled);
        }

        private function innerExecute():void
        {
            var _local_1:Object = wrapFunctionCall(document, srcFunc);
            if (BindingManager.debugDestinationStrings[destString])
            {
                trace(((("Binding: destString = " + destString) + ", srcFunc result = ") + _local_1));
            };
            if (((hasHadValue) || (wrappedFunctionSuccessful)))
            {
                if (((!(((lastValue is XML) && (lastValue.hasComplexContent())) && (lastValue === _local_1))) && (!((((lastValue is XMLList) && (lastValue.hasComplexContent())) && (_local_1 is XMLList)) && (nodeSeqEqual((lastValue as XMLList), (_local_1 as XMLList)))))))
                {
                    destFunc.call(document, _local_1);
                    lastValue = _local_1;
                    hasHadValue = true;
                };
            };
        }


    }
}//package mx.binding

