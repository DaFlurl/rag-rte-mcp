// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.messaging.FlexClient

package mx.messaging
{
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FlexClient extends EventDispatcher 
    {

        mx_internal static const NULL_FLEXCLIENT_ID:String = "nil";
        private static var _instance:FlexClient;

        private var _waitForFlexClientId:Boolean = false;
        private var _id:String;


        public static function getInstance():FlexClient
        {
            if (_instance == null)
            {
                _instance = new (FlexClient)();
            };
            return (_instance);
        }


        [Bindable(event="propertyChange")]
        public function get id():String
        {
            return (_id);
        }

        [Bindable(event="propertyChange")]
        mx_internal function get waitForFlexClientId():Boolean
        {
            return (_waitForFlexClientId);
        }

        public function set id(_arg_1:String):void
        {
            var _local_2:PropertyChangeEvent;
            if (_id != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "id", _id, _arg_1);
                _id = _arg_1;
                dispatchEvent(_local_2);
            };
        }

        mx_internal function set waitForFlexClientId(_arg_1:Boolean):void
        {
            var _local_2:PropertyChangeEvent;
            if (_waitForFlexClientId != _arg_1)
            {
                _local_2 = PropertyChangeEvent.createUpdateEvent(this, "waitForFlexClientId", _waitForFlexClientId, _arg_1);
                _waitForFlexClientId = _arg_1;
                dispatchEvent(_local_2);
            };
        }


    }
}//package mx.messaging

