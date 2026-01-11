// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.codec.IImageEncoder

package mx.graphics.codec
{
    import flash.utils.ByteArray;
    import flash.display.BitmapData;

    public interface IImageEncoder 
    {

        function encodeByteArray(_arg_1:ByteArray, _arg_2:int, _arg_3:int, _arg_4:Boolean=true):ByteArray;
        function get contentType():String;
        function encode(_arg_1:BitmapData):ByteArray;

    }
}//package mx.graphics.codec

