// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.RectangularDropShadow

package mx.graphics
{
    import mx.core.mx_internal;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.display.Graphics;
    import mx.core.FlexShape;
    import flash.display.Shape;
    import mx.utils.GraphicsUtil;
    import flash.filters.DropShadowFilter;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    use namespace mx_internal;

    public class RectangularDropShadow 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var leftShadow:BitmapData;
        private var _tlRadius:Number = 0;
        private var _trRadius:Number = 0;
        private var _angle:Number = 45;
        private var topShadow:BitmapData;
        private var _distance:Number = 4;
        private var rightShadow:BitmapData;
        private var _alpha:Number = 0.4;
        private var shadow:BitmapData;
        private var _brRadius:Number = 0;
        private var _blRadius:Number = 0;
        private var _color:int = 0;
        private var bottomShadow:BitmapData;
        private var changed:Boolean = true;


        public function get blRadius():Number
        {
            return (_blRadius);
        }

        public function set brRadius(_arg_1:Number):void
        {
            if (_brRadius != _arg_1)
            {
                _brRadius = _arg_1;
                changed = true;
            };
        }

        public function set color(_arg_1:int):void
        {
            if (_color != _arg_1)
            {
                _color = _arg_1;
                changed = true;
            };
        }

        public function drawShadow(_arg_1:Graphics, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):void
        {
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            if (changed)
            {
                createShadowBitmaps();
                changed = false;
            };
            _arg_4 = Math.ceil(_arg_4);
            _arg_5 = Math.ceil(_arg_5);
            var _local_6:int = ((leftShadow) ? leftShadow.width : 0);
            var _local_7:int = ((rightShadow) ? rightShadow.width : 0);
            var _local_8:int = ((topShadow) ? topShadow.height : 0);
            var _local_9:int = ((bottomShadow) ? bottomShadow.height : 0);
            var _local_10:int = (_local_6 + _local_7);
            var _local_11:int = (_local_8 + _local_9);
            var _local_12:Number = ((_arg_5 + _local_11) / 2);
            var _local_13:Number = ((_arg_4 + _local_10) / 2);
            var _local_14:Matrix = new Matrix();
            if (((leftShadow) || (topShadow)))
            {
                _local_15 = Math.min((tlRadius + _local_10), _local_13);
                _local_16 = Math.min((tlRadius + _local_11), _local_12);
                _local_14.tx = (_arg_2 - _local_6);
                _local_14.ty = (_arg_3 - _local_8);
                _arg_1.beginBitmapFill(shadow, _local_14);
                _arg_1.drawRect((_arg_2 - _local_6), (_arg_3 - _local_8), _local_15, _local_16);
                _arg_1.endFill();
            };
            if (((rightShadow) || (topShadow)))
            {
                _local_17 = Math.min((trRadius + _local_10), _local_13);
                _local_18 = Math.min((trRadius + _local_11), _local_12);
                _local_14.tx = (((_arg_2 + _arg_4) + _local_7) - shadow.width);
                _local_14.ty = (_arg_3 - _local_8);
                _arg_1.beginBitmapFill(shadow, _local_14);
                _arg_1.drawRect((((_arg_2 + _arg_4) + _local_7) - _local_17), (_arg_3 - _local_8), _local_17, _local_18);
                _arg_1.endFill();
            };
            if (((leftShadow) || (bottomShadow)))
            {
                _local_19 = Math.min((blRadius + _local_10), _local_13);
                _local_20 = Math.min((blRadius + _local_11), _local_12);
                _local_14.tx = (_arg_2 - _local_6);
                _local_14.ty = (((_arg_3 + _arg_5) + _local_9) - shadow.height);
                _arg_1.beginBitmapFill(shadow, _local_14);
                _arg_1.drawRect((_arg_2 - _local_6), (((_arg_3 + _arg_5) + _local_9) - _local_20), _local_19, _local_20);
                _arg_1.endFill();
            };
            if (((rightShadow) || (bottomShadow)))
            {
                _local_21 = Math.min((brRadius + _local_10), _local_13);
                _local_22 = Math.min((brRadius + _local_11), _local_12);
                _local_14.tx = (((_arg_2 + _arg_4) + _local_7) - shadow.width);
                _local_14.ty = (((_arg_3 + _arg_5) + _local_9) - shadow.height);
                _arg_1.beginBitmapFill(shadow, _local_14);
                _arg_1.drawRect((((_arg_2 + _arg_4) + _local_7) - _local_21), (((_arg_3 + _arg_5) + _local_9) - _local_22), _local_21, _local_22);
                _arg_1.endFill();
            };
            if (leftShadow)
            {
                _local_14.tx = (_arg_2 - _local_6);
                _local_14.ty = 0;
                _arg_1.beginBitmapFill(leftShadow, _local_14);
                _arg_1.drawRect((_arg_2 - _local_6), ((_arg_3 - _local_8) + _local_16), _local_6, ((((_arg_5 + _local_8) + _local_9) - _local_16) - _local_20));
                _arg_1.endFill();
            };
            if (rightShadow)
            {
                _local_14.tx = (_arg_2 + _arg_4);
                _local_14.ty = 0;
                _arg_1.beginBitmapFill(rightShadow, _local_14);
                _arg_1.drawRect((_arg_2 + _arg_4), ((_arg_3 - _local_8) + _local_18), _local_7, ((((_arg_5 + _local_8) + _local_9) - _local_18) - _local_22));
                _arg_1.endFill();
            };
            if (topShadow)
            {
                _local_14.tx = 0;
                _local_14.ty = (_arg_3 - _local_8);
                _arg_1.beginBitmapFill(topShadow, _local_14);
                _arg_1.drawRect(((_arg_2 - _local_6) + _local_15), (_arg_3 - _local_8), ((((_arg_4 + _local_6) + _local_7) - _local_15) - _local_17), _local_8);
                _arg_1.endFill();
            };
            if (bottomShadow)
            {
                _local_14.tx = 0;
                _local_14.ty = (_arg_3 + _arg_5);
                _arg_1.beginBitmapFill(bottomShadow, _local_14);
                _arg_1.drawRect(((_arg_2 - _local_6) + _local_19), (_arg_3 + _arg_5), ((((_arg_4 + _local_6) + _local_7) - _local_19) - _local_21), _local_9);
                _arg_1.endFill();
            };
        }

        public function get brRadius():Number
        {
            return (_brRadius);
        }

        public function get angle():Number
        {
            return (_angle);
        }

        private function createShadowBitmaps():void
        {
            var _local_1:Number = ((Math.max(tlRadius, blRadius) + (2 * distance)) + Math.max(trRadius, brRadius));
            var _local_2:Number = ((Math.max(tlRadius, trRadius) + (2 * distance)) + Math.max(blRadius, brRadius));
            if (((_local_1 < 0) || (_local_2 < 0)))
            {
                return;
            };
            var _local_3:Shape = new FlexShape();
            var _local_4:Graphics = _local_3.graphics;
            _local_4.beginFill(0xFFFFFF);
            GraphicsUtil.drawRoundRectComplex(_local_4, 0, 0, _local_1, _local_2, tlRadius, trRadius, blRadius, brRadius);
            _local_4.endFill();
            var _local_5:BitmapData = new BitmapData(_local_1, _local_2, true, 0);
            _local_5.draw(_local_3, new Matrix());
            var _local_6:DropShadowFilter = new DropShadowFilter(distance, angle, color, alpha);
            _local_6.knockout = true;
            var _local_7:Rectangle = new Rectangle(0, 0, _local_1, _local_2);
            var _local_8:Rectangle = _local_5.generateFilterRect(_local_7, _local_6);
            var _local_9:Number = (_local_7.left - _local_8.left);
            var _local_10:Number = (_local_8.right - _local_7.right);
            var _local_11:Number = (_local_7.top - _local_8.top);
            var _local_12:Number = (_local_8.bottom - _local_7.bottom);
            shadow = new BitmapData(_local_8.width, _local_8.height);
            shadow.applyFilter(_local_5, _local_7, new Point(_local_9, _local_11), _local_6);
            var _local_13:Point = new Point(0, 0);
            var _local_14:Rectangle = new Rectangle();
            if (_local_9 > 0)
            {
                _local_14.x = 0;
                _local_14.y = ((tlRadius + _local_11) + _local_12);
                _local_14.width = _local_9;
                _local_14.height = 1;
                leftShadow = new BitmapData(_local_9, 1);
                leftShadow.copyPixels(shadow, _local_14, _local_13);
            }
            else
            {
                leftShadow = null;
            };
            if (_local_10 > 0)
            {
                _local_14.x = (shadow.width - _local_10);
                _local_14.y = ((trRadius + _local_11) + _local_12);
                _local_14.width = _local_10;
                _local_14.height = 1;
                rightShadow = new BitmapData(_local_10, 1);
                rightShadow.copyPixels(shadow, _local_14, _local_13);
            }
            else
            {
                rightShadow = null;
            };
            if (_local_11 > 0)
            {
                _local_14.x = ((tlRadius + _local_9) + _local_10);
                _local_14.y = 0;
                _local_14.width = 1;
                _local_14.height = _local_11;
                topShadow = new BitmapData(1, _local_11);
                topShadow.copyPixels(shadow, _local_14, _local_13);
            }
            else
            {
                topShadow = null;
            };
            if (_local_12 > 0)
            {
                _local_14.x = ((blRadius + _local_9) + _local_10);
                _local_14.y = (shadow.height - _local_12);
                _local_14.width = 1;
                _local_14.height = _local_12;
                bottomShadow = new BitmapData(1, _local_12);
                bottomShadow.copyPixels(shadow, _local_14, _local_13);
            }
            else
            {
                bottomShadow = null;
            };
        }

        public function get alpha():Number
        {
            return (_alpha);
        }

        public function get color():int
        {
            return (_color);
        }

        public function set angle(_arg_1:Number):void
        {
            if (_angle != _arg_1)
            {
                _angle = _arg_1;
                changed = true;
            };
        }

        public function set trRadius(_arg_1:Number):void
        {
            if (_trRadius != _arg_1)
            {
                _trRadius = _arg_1;
                changed = true;
            };
        }

        public function set tlRadius(_arg_1:Number):void
        {
            if (_tlRadius != _arg_1)
            {
                _tlRadius = _arg_1;
                changed = true;
            };
        }

        public function get trRadius():Number
        {
            return (_trRadius);
        }

        public function set distance(_arg_1:Number):void
        {
            if (_distance != _arg_1)
            {
                _distance = _arg_1;
                changed = true;
            };
        }

        public function get distance():Number
        {
            return (_distance);
        }

        public function get tlRadius():Number
        {
            return (_tlRadius);
        }

        public function set alpha(_arg_1:Number):void
        {
            if (_alpha != _arg_1)
            {
                _alpha = _arg_1;
                changed = true;
            };
        }

        public function set blRadius(_arg_1:Number):void
        {
            if (_blRadius != _arg_1)
            {
                _blRadius = _arg_1;
                changed = true;
            };
        }


    }
}//package mx.graphics

