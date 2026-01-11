// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.validators.ValidationResult

package mx.validators
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ValidationResult 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var subField:String;
        public var errorCode:String;
        public var isError:Boolean;
        public var errorMessage:String;

        public function ValidationResult(_arg_1:Boolean, _arg_2:String="", _arg_3:String="", _arg_4:String="")
        {
            this.isError = _arg_1;
            this.subField = _arg_2;
            this.errorMessage = _arg_4;
            this.errorCode = _arg_3;
        }

    }
}//package mx.validators

