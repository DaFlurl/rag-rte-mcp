// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.logging.errors.InvalidCategoryError

package mx.logging.errors
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class InvalidCategoryError extends Error 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function InvalidCategoryError(_arg_1:String)
        {
            super(_arg_1);
        }

        public function toString():String
        {
            return (String(message));
        }


    }
}//package mx.logging.errors

