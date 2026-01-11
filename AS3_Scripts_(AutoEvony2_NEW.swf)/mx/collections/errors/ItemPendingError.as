// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.errors.ItemPendingError

package mx.collections.errors
{
    import mx.rpc.IResponder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ItemPendingError extends Error 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _responders:Array;

        public function ItemPendingError(_arg_1:String)
        {
            super(_arg_1);
        }

        public function get responders():Array
        {
            return (_responders);
        }

        public function addResponder(_arg_1:IResponder):void
        {
            if (!_responders)
            {
                _responders = [];
            };
            _responders.push(_arg_1);
        }


    }
}//package mx.collections.errors

