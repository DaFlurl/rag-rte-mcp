// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.DefaultDragImage

package mx.skins.halo
{
    import mx.core.SpriteAsset;
    import mx.core.IFlexDisplayObject;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DefaultDragImage extends SpriteAsset implements IFlexDisplayObject 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function DefaultDragImage()
        {
            draw(10, 10);
            super();
        }

        override public function get measuredWidth():Number
        {
            return (10);
        }

        override public function move(_arg_1:Number, _arg_2:Number):void
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }

        override public function get measuredHeight():Number
        {
            return (10);
        }

        override public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            draw(_arg_1, _arg_2);
        }

        private function draw(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Graphics = graphics;
            _local_3.clear();
            _local_3.beginFill(0xEEEEEE);
            _local_3.lineStyle(1, 8433818);
            _local_3.drawRect(0, 0, _arg_1, _arg_2);
            _local_3.endFill();
        }


    }
}//package mx.skins.halo

