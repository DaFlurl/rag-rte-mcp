// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.Fault

package mx.rpc
{
    public class Fault extends Error 
    {

        public var rootCause:Object;
        protected var _faultCode:String;
        protected var _faultString:String;
        public var content:Object;
        protected var _faultDetail:String;

        public function Fault(_arg_1:String, _arg_2:String, _arg_3:String=null)
        {
            super((((((("faultCode:" + _arg_1) + " faultString:'") + _arg_2) + "' faultDetail:'") + _arg_3) + "'"));
            this._faultCode = _arg_1;
            this._faultString = ((_arg_2) ? _arg_2 : "");
            this._faultDetail = _arg_3;
        }

        public function get faultString():String
        {
            return (_faultString);
        }

        public function toString():String
        {
            var _local_1:* = "[RPC Fault";
            _local_1 = (_local_1 + ((' faultString="' + faultString) + '"'));
            _local_1 = (_local_1 + ((' faultCode="' + faultCode) + '"'));
            return (_local_1 + ((' faultDetail="' + faultDetail) + '"]'));
        }

        public function get faultCode():String
        {
            return (_faultCode);
        }

        public function get faultDetail():String
        {
            return (_faultDetail);
        }


    }
}//package mx.rpc

