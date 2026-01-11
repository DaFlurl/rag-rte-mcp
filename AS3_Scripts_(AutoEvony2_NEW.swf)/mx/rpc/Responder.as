// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.rpc.Responder

package mx.rpc
{
    public class Responder implements IResponder 
    {

        private var _faultHandler:Function;
        private var _resultHandler:Function;

        public function Responder(_arg_1:Function, _arg_2:Function)
        {
            _resultHandler = _arg_1;
            _faultHandler = _arg_2;
        }

        public function result(_arg_1:Object):void
        {
            _resultHandler(_arg_1);
        }

        public function fault(_arg_1:Object):void
        {
            _faultHandler(_arg_1);
        }


    }
}//package mx.rpc

