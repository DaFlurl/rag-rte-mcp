// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.LinearGradient

package mx.graphics
{
    import flash.geom.Matrix;
    import flash.display.GradientType;
    import mx.core.mx_internal;
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    use namespace mx_internal;

    public class LinearGradient extends GradientBase implements IFill 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var matrix:Matrix = new Matrix();
        private var _rotation:Number = 0;


        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            matrix.createGradientBox(_arg_2.width, _arg_2.height, _rotation, _arg_2.left, _arg_2.top);
            _arg_1.beginGradientFill(GradientType.LINEAR, mx_internal::colors, mx_internal::alphas, mx_internal::ratios, matrix);
        }

        [Bindable("propertyChange")]
        public function get angle():Number
        {
            return ((_rotation / Math.PI) * 180);
        }

        public function set angle(_arg_1:Number):void
        {
            var _local_2:Number = _rotation;
            _rotation = ((_arg_1 / 180) * Math.PI);
            (mx_internal::dispatchGradientChangedEvent("angle", _local_2, _rotation));
        }

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
        }


    }
}//package mx.graphics

