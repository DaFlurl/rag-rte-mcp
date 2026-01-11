// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.validators.IValidatorListener

package mx.validators
{
    import mx.events.ValidationResultEvent;

    public interface IValidatorListener 
    {

        function set errorString(_arg_1:String):void;
        function get validationSubField():String;
        function validationResultHandler(_arg_1:ValidationResultEvent):void;
        function set validationSubField(_arg_1:String):void;
        function get errorString():String;

    }
}//package mx.validators

