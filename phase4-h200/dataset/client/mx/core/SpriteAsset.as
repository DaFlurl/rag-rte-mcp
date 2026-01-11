// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.SpriteAsset

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class SpriteAsset extends FlexSprite implements IFlexAsset, IFlexDisplayObject, IBorder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _measuredHeight:Number;
        private var _measuredWidth:Number;

        public function SpriteAsset()
        {
            _measuredWidth = width;
            _measuredHeight = height;
        }

        public function get measuredWidth():Number
        {
            return (_measuredWidth);
        }

        public function get measuredHeight():Number
        {
            return (_measuredHeight);
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

        public function get borderMetrics():EdgeMetrics
        {
            if (scale9Grid == null)
            {
                return (EdgeMetrics.EMPTY);
            };
            return (new EdgeMetrics(scale9Grid.left, scale9Grid.top, Math.ceil((measuredWidth - scale9Grid.right)), Math.ceil((measuredHeight - scale9Grid.bottom))));
        }


    }
}//package mx.core

