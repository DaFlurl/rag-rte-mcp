// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IInvalidating

package mx.core
{
    public interface IInvalidating 
    {

        function validateNow():void;
        function invalidateSize():void;
        function invalidateDisplayList():void;
        function invalidateProperties():void;

    }
}//package mx.core

