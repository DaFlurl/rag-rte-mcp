// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.BindingManager

package mx.binding
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BindingManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        internal static var debugDestinationStrings:Object = {};


        public static function executeBindings(_arg_1:Object, _arg_2:String, _arg_3:Object):void
        {
            var _local_4:String;
            if (((!(_arg_2)) || (_arg_2 == "")))
            {
                return;
            };
            if (((((_arg_1) && ((_arg_1 is IBindingClient) || (_arg_1.hasOwnProperty("_bindingsByDestination")))) && (_arg_1._bindingsByDestination)) && (_arg_1._bindingsBeginWithWord[getFirstWord(_arg_2)])))
            {
                for (_local_4 in _arg_1._bindingsByDestination)
                {
                    if (_local_4.charAt(0) == _arg_2.charAt(0))
                    {
                        if ((((_local_4.indexOf((_arg_2 + ".")) == 0) || (_local_4.indexOf((_arg_2 + "[")) == 0)) || (_local_4 == _arg_2)))
                        {
                            _arg_1._bindingsByDestination[_local_4].execute(_arg_3);
                        };
                    };
                };
            };
        }

        public static function addBinding(_arg_1:Object, _arg_2:String, _arg_3:Binding):void
        {
            if (!_arg_1._bindingsByDestination)
            {
                _arg_1._bindingsByDestination = {};
                _arg_1._bindingsBeginWithWord = {};
            };
            _arg_1._bindingsByDestination[_arg_2] = _arg_3;
            _arg_1._bindingsBeginWithWord[getFirstWord(_arg_2)] = true;
        }

        public static function debugBinding(_arg_1:String):void
        {
            debugDestinationStrings[_arg_1] = true;
        }

        private static function getFirstWord(_arg_1:String):String
        {
            var _local_2:int = _arg_1.indexOf(".");
            var _local_3:int = _arg_1.indexOf("[");
            if (_local_2 == _local_3)
            {
                return (_arg_1);
            };
            var _local_4:int = Math.min(_local_2, _local_3);
            if (_local_4 == -1)
            {
                _local_4 = Math.max(_local_2, _local_3);
            };
            return (_arg_1.substr(0, _local_4));
        }

        public static function setEnabled(_arg_1:Object, _arg_2:Boolean):void
        {
            var _local_3:Array;
            var _local_4:uint;
            var _local_5:Binding;
            if (((_arg_1 is IBindingClient) && (_arg_1._bindings)))
            {
                _local_3 = (_arg_1._bindings as Array);
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    _local_5 = _local_3[_local_4];
                    _local_5.isEnabled = _arg_2;
                    _local_4++;
                };
            };
        }


    }
}//package mx.binding

