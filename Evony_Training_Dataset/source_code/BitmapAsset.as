// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.BitmapAsset

package mx.core
{
    import flash.display.BitmapData;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function BitmapAsset(_arg_1:BitmapData=null, _arg_2:String="auto", _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get measuredWidth():Number
        {
            if (bitmapData)
            {
                return (bitmapData.width);
            };
            return (0);
        }

        public function get measuredHeight():Number
        {
            if (bitmapData)
            {
                return (bitmapData.height);
            };
            return (0);
        }

        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            width = _arg_1;
            height = _arg_2;
        }

        public function move(_arg_1:Number, _arg_2:Number):void
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }


    }
}//package mx.core

