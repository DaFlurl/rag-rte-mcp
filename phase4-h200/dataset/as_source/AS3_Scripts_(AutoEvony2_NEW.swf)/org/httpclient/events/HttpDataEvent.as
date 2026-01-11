// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.events.HttpDataEvent

package org.httpclient.events
{
    import flash.events.Event;
    import flash.utils.ByteArray;

    public class HttpDataEvent extends Event 
    {

        public static const DATA:String = "httpData";

        private var _bytes:ByteArray;

        public function HttpDataEvent(_arg_1:ByteArray, _arg_2:String="httpData", _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            super(_arg_2, _arg_3, _arg_4);
            this._bytes = _arg_1;
        }

        public function readUTFBytes():String
        {
            return (this._bytes.readUTFBytes(this._bytes.length));
        }

        public function get bytes():ByteArray
        {
            return (this._bytes);
        }


    }
}//package org.httpclient.events

