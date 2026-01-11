// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.TextFieldFactory

package mx.core
{
    import flash.utils.Dictionary;
    import flash.text.TextField;

    use namespace mx_internal;

    public class TextFieldFactory implements ITextFieldFactory 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var instance:ITextFieldFactory;

        private var textFields:Dictionary = new Dictionary(true);


        public static function getInstance():ITextFieldFactory
        {
            if (!instance)
            {
                instance = new (TextFieldFactory)();
            };
            return (instance);
        }


        public function createTextField(_arg_1:IFlexModuleFactory):TextField
        {
            var _local_4:Object;
            var _local_2:TextField;
            var _local_3:Dictionary = textFields[_arg_1];
            if (_local_3)
            {
                for (_local_4 in _local_3)
                {
                    _local_2 = TextField(_local_4);
                    break;
                };
            };
            if (!_local_2)
            {
                if (_arg_1)
                {
                    _local_2 = TextField(_arg_1.create("flash.text.TextField"));
                }
                else
                {
                    _local_2 = new TextField();
                };
                if (!_local_3)
                {
                    _local_3 = new Dictionary(true);
                };
                _local_3[_local_2] = 1;
                textFields[_arg_1] = _local_3;
            };
            return (_local_2);
        }


    }
}//package mx.core

