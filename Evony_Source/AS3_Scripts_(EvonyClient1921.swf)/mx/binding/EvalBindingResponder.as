// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.EvalBindingResponder

package mx.binding
{
    import mx.rpc.IResponder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EvalBindingResponder implements IResponder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var binding:Binding;
        private var object:Object;

        public function EvalBindingResponder(_arg_1:Binding, _arg_2:Object)
        {
            this.binding = _arg_1;
            this.object = _arg_2;
        }

        public function fault(_arg_1:Object):void
        {
        }

        public function result(_arg_1:Object):void
        {
            binding.execute(object);
        }


    }
}//package mx.binding

