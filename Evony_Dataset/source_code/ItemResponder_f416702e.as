// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.ItemResponder

package mx.collections
{
    import mx.rpc.IResponder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ItemResponder implements IResponder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _faultHandler:Function;
        private var _token:Object;
        private var _resultHandler:Function;

        public function ItemResponder(_arg_1:Function, _arg_2:Function, _arg_3:Object=null)
        {
            _resultHandler = _arg_1;
            _faultHandler = _arg_2;
            _token = _arg_3;
        }

        public function result(_arg_1:Object):void
        {
            _resultHandler(_arg_1, _token);
        }

        public function fault(_arg_1:Object):void
        {
            _faultHandler(_arg_1, _token);
        }


    }
}//package mx.collections

