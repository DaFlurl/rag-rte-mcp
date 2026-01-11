// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ValidationResultEvent

package mx.events
{
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ValidationResultEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const INVALID:String = "invalid";
        public static const VALID:String = "valid";

        public var results:Array;
        public var field:String;

        public function ValidationResultEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String=null, _arg_5:Array=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.field = _arg_4;
            this.results = _arg_5;
        }

        public function get message():String
        {
            var _local_1:* = "";
            var _local_2:int = results.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (results[_local_3].isError)
                {
                    _local_1 = (_local_1 + ((_local_1 == "") ? "" : "\n"));
                    _local_1 = (_local_1 + results[_local_3].errorMessage);
                };
                _local_3++;
            };
            return (_local_1);
        }

        override public function clone():Event
        {
            return (new ValidationResultEvent(type, bubbles, cancelable, field, results));
        }


    }
}//package mx.events

