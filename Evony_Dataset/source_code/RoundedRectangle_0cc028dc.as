// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.RoundedRectangle

package mx.graphics
{
    import flash.geom.Rectangle;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class RoundedRectangle extends Rectangle 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var cornerRadius:Number = 0;

        public function RoundedRectangle(_arg_1:Number=0, _arg_2:Number=0, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.cornerRadius = _arg_5;
        }

    }
}//package mx.graphics

