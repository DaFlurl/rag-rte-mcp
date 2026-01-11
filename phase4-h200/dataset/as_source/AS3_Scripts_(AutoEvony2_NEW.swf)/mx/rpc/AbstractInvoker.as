// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.AbstractInvoker

package mx.rpc
{
    import flash.events.EventDispatcher;
    import mx.logging.ILogger;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.logging.Log;
    import mx.rpc.events.FaultEvent;
    import mx.messaging.events.MessageEvent;
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.events.MessageFaultEvent;
    import mx.rpc.events.AbstractEvent;
    import flash.events.Event;
    import flash.utils.getQualifiedClassName;
    import mx.utils.ObjectProxy;
    import mx.messaging.messages.IMessage;
    import mx.rpc.events.ResultEvent;
    import mx.netmon.NetworkMonitor;
    import mx.rpc.events.InvokeEvent;
    import mx.messaging.errors.MessagingError;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AbstractInvoker extends EventDispatcher 
    {

        mx_internal static const BINDING_RESULT:String = "resultForBinding";

        mx_internal var _makeObjectsBindable:Boolean;
        public var operationManager:Function;
        mx_internal var _responseHeaders:Array;
        private var _asyncRequest:AsyncRequest;
        private var _log:ILogger;
        mx_internal var activeCalls:ActiveCalls;
        public var resultType:Class;
        public var resultElementType:Class;
        mx_internal var _result:Object;
        private var resourceManager:IResourceManager = ResourceManager.getInstance();

        public function AbstractInvoker()
        {
            _log = Log.getLogger("mx.rpc.AbstractInvoker");
            activeCalls = new ActiveCalls();
        }

        mx_internal function getNetmonId():String
        {
            return (null);
        }

        public function cancel(_arg_1:String=null):AsyncToken
        {
            if (_arg_1 != null)
            {
                return (activeCalls.removeCall(_arg_1));
            };
            return (activeCalls.cancelLast());
        }

        mx_internal function faultHandler(_arg_1:MessageFaultEvent):void
        {
            var _local_4:Fault;
            var _local_5:FaultEvent;
            var _local_2:MessageEvent = MessageEvent.createEvent(MessageEvent.MESSAGE, _arg_1.message);
            var _local_3:AsyncToken = preHandle(_local_2);
            if (((((_local_3 == null) && (!(AsyncMessage(_arg_1.message).correlationId == null))) && (!(AsyncMessage(_arg_1.message).correlationId == ""))) && (!(_arg_1.faultCode == "Client.Authentication"))))
            {
                return;
            };
            if (processFault(_arg_1.message, _local_3))
            {
                _local_4 = new Fault(_arg_1.faultCode, _arg_1.faultString, _arg_1.faultDetail);
                _local_4.content = _arg_1.message.body;
                _local_4.rootCause = _arg_1.rootCause;
                _local_5 = FaultEvent.createEvent(_local_4, _local_3, _arg_1.message);
                _local_5.headers = _responseHeaders;
                dispatchRpcEvent(_local_5);
            };
        }

        public function clearResult(_arg_1:Boolean=true):void
        {
            if (_arg_1)
            {
                setResult(null);
            }
            else
            {
                _result = null;
            };
        }

        mx_internal function get asyncRequest():AsyncRequest
        {
            if (_asyncRequest == null)
            {
                _asyncRequest = new AsyncRequest();
            };
            return (_asyncRequest);
        }

        mx_internal function dispatchRpcEvent(_arg_1:AbstractEvent):void
        {
            _arg_1.callTokenResponders();
            if (!_arg_1.isDefaultPrevented())
            {
                dispatchEvent(_arg_1);
            };
        }

        [Bindable("resultForBinding")]
        public function get lastResult():Object
        {
            return (_result);
        }

        public function setResult(_arg_1:Object):void
        {
            _result = _arg_1;
            dispatchEvent(new Event(BINDING_RESULT));
        }

        mx_internal function set asyncRequest(_arg_1:AsyncRequest):void
        {
            _asyncRequest = _arg_1;
        }

        mx_internal function preHandle(_arg_1:MessageEvent):AsyncToken
        {
            return (activeCalls.removeCall(AsyncMessage(_arg_1.message).correlationId));
        }

        mx_internal function processResult(_arg_1:IMessage, _arg_2:AsyncToken):Boolean
        {
            var _local_3:Object = _arg_1.body;
            if ((((makeObjectsBindable) && (!(_local_3 == null))) && (getQualifiedClassName(_local_3) == "Object")))
            {
                _result = new ObjectProxy(_local_3);
            }
            else
            {
                _result = _local_3;
            };
            return (true);
        }

        mx_internal function resultHandler(_arg_1:MessageEvent):void
        {
            var _local_3:ResultEvent;
            var _local_2:AsyncToken = preHandle(_arg_1);
            if (_local_2 == null)
            {
                return;
            };
            if (processResult(_arg_1.message, _local_2))
            {
                dispatchEvent(new Event(BINDING_RESULT));
                _local_3 = ResultEvent.createEvent(_result, _local_2, _arg_1.message);
                _local_3.headers = _responseHeaders;
                dispatchRpcEvent(_local_3);
            };
        }

        mx_internal function monitorRpcEvent(_arg_1:AbstractEvent):void
        {
            if (NetworkMonitor.isMonitoring())
            {
                if ((_arg_1 is ResultEvent))
                {
                    NetworkMonitor.monitorResult(_arg_1.message, ResultEvent(_arg_1).result);
                }
                else
                {
                    if ((_arg_1 is FaultEvent))
                    {
                        NetworkMonitor.monitorFault(_arg_1.message, FaultEvent(_arg_1).fault);
                    };
                };
            };
        }

        mx_internal function processFault(_arg_1:IMessage, _arg_2:AsyncToken):Boolean
        {
            return (true);
        }

        mx_internal function invoke(message:IMessage, token:AsyncToken=null):AsyncToken
        {
            var fault:Fault;
            var errorText:String;
            if (token == null)
            {
                token = new AsyncToken(message);
            }
            else
            {
                token.setMessage(message);
            };
            activeCalls.addCall(message.messageId, token);
            try
            {
                asyncRequest.invoke(message, new Responder(resultHandler, faultHandler));
                dispatchRpcEvent(InvokeEvent.createEvent(token, message));
            }
            catch(e:MessagingError)
            {
                _log.warn(e.toString());
                errorText = resourceManager.getString("rpc", "cannotConnectToDestination", [asyncRequest.destination]);
                fault = new Fault("InvokeFailed", e.toString(), errorText);
                new AsyncDispatcher(dispatchRpcEvent, [FaultEvent.createEvent(fault, token, message)], 10);
            }
            catch(e2:Error)
            {
                _log.warn(e2.toString());
                fault = new Fault("InvokeFailed", e2.message);
                new AsyncDispatcher(dispatchRpcEvent, [FaultEvent.createEvent(fault, token, message)], 10);
            };
            return (token);
        }

        public function set makeObjectsBindable(_arg_1:Boolean):void
        {
            _makeObjectsBindable = _arg_1;
        }

        public function get makeObjectsBindable():Boolean
        {
            return (_makeObjectsBindable);
        }


    }
}//package mx.rpc

