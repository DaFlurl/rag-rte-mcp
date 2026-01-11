// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.AdvancedRectangle

package com.degrafa.geometry
{
    import com.degrafa.IGeometry;
    import mx.graphics.IFill;
    import flash.geom.Rectangle;
    import flash.display.Graphics;
    import com.degrafa.geometry.layout.LayoutConstraint;
    import mx.graphics.IStroke;
    import mx.graphics.SolidColor;
    import mx.graphics.Stroke;

    public class AdvancedRectangle extends Geometry implements IGeometry 
    {

        public var topFill:IFill;
        public var rightWidth:Number;
        public var bottomRightRadiusX:Number;
        public var bottomRightRadiusY:Number;
        public var topLeftFill:IFill;
        public var leftFill:IFill;
        public var topRightRadiusX:Number;
        public var topRightRadiusY:Number;
        public var rightFill:IFill;
        public var bottomFill:IFill;
        public var backgroundFill:IFill;
        public var bottomLeftRadiusX:Number;
        public var bottomLeftRadiusY:Number;
        public var bottomWidth:Number;
        public var topLeftRadiusY:Number;
        public var topLeftRadiusX:Number;
        public var bottomLeftFill:IFill;
        public var bottomRightFill:IFill;
        public var topWidth:Number;
        public var topRightFill:IFill;
        public var leftWidth:Number;


        override public function set percentWidth(_arg_1:Number):void
        {
        }

        override public function set verticalCenter(_arg_1:Number):void
        {
        }

        override public function set maxWidth(_arg_1:Number):void
        {
        }

        private function drawLeftBorder(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (leftFill != null)
            {
                _local_3 = new Rectangle(0, topLeftRadiusY, leftWidth, ((_arg_2.height - topLeftRadiusY) - bottomLeftRadiusY));
                _arg_1.lineStyle(0, 0, 0);
                leftFill.begin(_arg_1, _local_3);
                _arg_1.moveTo(0, topLeftRadiusY);
                _arg_1.lineTo(leftWidth, Math.max(topLeftRadiusY, topWidth));
                _arg_1.lineTo(leftWidth, (_arg_2.height - Math.max(bottomLeftRadiusY, bottomWidth)));
                _arg_1.lineTo(0, (_arg_2.height - bottomLeftRadiusY));
                _arg_1.lineTo(0, topLeftRadiusY);
                leftFill.end(_arg_1);
            };
        }

        private function drawRightBorder(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (rightFill != null)
            {
                _local_3 = new Rectangle(0, topRightRadiusY, rightWidth, ((_arg_2.height - topRightRadiusY) - bottomRightRadiusY));
                _arg_1.lineStyle(0, 0, 0);
                rightFill.begin(_arg_1, _local_3);
                _arg_1.moveTo(_arg_2.width, Math.max(topRightRadiusY, topWidth));
                _arg_1.lineTo(_arg_2.width, (_arg_2.height - bottomRightRadiusY));
                _arg_1.lineTo((_arg_2.width - rightWidth), (_arg_2.height - Math.max(bottomRightRadiusY, bottomWidth)));
                _arg_1.lineTo((_arg_2.width - rightWidth), Math.max(topRightRadiusY, topWidth));
                _arg_1.lineTo(_arg_2.width, Math.max(topRightRadiusY, topWidth));
                rightFill.end(_arg_1);
            };
        }

        override public function set width(_arg_1:Number):void
        {
        }

        override public function set minY(_arg_1:Number):void
        {
        }

        override public function set bottom(_arg_1:Number):void
        {
        }

        override public function set maintainAspectRatio(_arg_1:Boolean):void
        {
        }

        private function drawBackground(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle = new Rectangle((_arg_2.x + leftWidth), (_arg_2.y + topWidth), (_arg_2.width - (leftWidth + rightWidth)), (_arg_2.height - (topWidth + bottomWidth)));
            backgroundFill.begin(_arg_1, _local_3);
            _arg_1.moveTo(leftWidth, (topWidth + topLeftRadiusY));
            _arg_1.lineTo((_arg_2.width - Math.max(rightWidth, topRightRadiusX)), topWidth);
            if ((((topRightRadiusX > 0) && (topRightRadiusX > rightWidth)) && (topRightRadiusY > topWidth)))
            {
                _arg_1.curveTo((_arg_2.width - rightWidth), topWidth, (_arg_2.width - rightWidth), topRightRadiusY);
            }
            else
            {
                _arg_1.lineTo((_arg_2.width - rightWidth), Math.max(topWidth, topRightRadiusY));
            };
            _arg_1.lineTo((_arg_2.width - rightWidth), ((_arg_2.height - bottomWidth) - bottomRightRadiusY));
            if (bottomRightRadiusX > 0)
            {
                _arg_1.curveTo(_arg_2.width, _arg_2.height, (_arg_2.width - bottomRightRadiusX), (_arg_2.height - bottomWidth));
            };
            _arg_1.lineTo(Math.max(leftWidth, bottomLeftRadiusX), (_arg_2.height - bottomWidth));
            if (bottomLeftRadiusX > 0)
            {
                _arg_1.curveTo(leftWidth, (_arg_2.height - bottomWidth), leftWidth, (_arg_2.height - Math.max(bottomWidth, bottomLeftRadiusY)));
            };
            _arg_1.lineTo(leftWidth, (topWidth + topLeftRadiusY));
            if (topLeftRadiusX > 0)
            {
                _arg_1.curveTo(0, 0, (leftWidth + topLeftRadiusX), topWidth);
            };
            _arg_1.lineTo((_arg_2.width - Math.max(rightWidth, topRightRadiusX)), topWidth);
            backgroundFill.end(_arg_1);
        }

        override public function set minX(_arg_1:Number):void
        {
        }

        override public function set maxY(_arg_1:Number):void
        {
        }

        override public function set percentHeight(_arg_1:Number):void
        {
        }

        private function drawBottomBorder(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (bottomFill != null)
            {
                _local_3 = new Rectangle(bottomLeftRadiusX, 0, ((_arg_2.width - bottomLeftRadiusX) - bottomRightRadiusX), bottomWidth);
                _arg_1.lineStyle(0, 0, 0);
                bottomFill.begin(_arg_1, _local_3);
                _arg_1.moveTo(Math.max(bottomLeftRadiusX, leftWidth), (_arg_2.height - bottomWidth));
                _arg_1.lineTo((_arg_2.width - Math.max(bottomRightRadiusX, rightWidth)), (_arg_2.height - bottomWidth));
                _arg_1.lineTo((_arg_2.width - bottomRightRadiusX), _arg_2.height);
                _arg_1.lineTo(bottomLeftRadiusX, _arg_2.height);
                _arg_1.lineTo(Math.max(bottomLeftRadiusX, leftWidth), (_arg_2.height - bottomWidth));
                _arg_1.endFill();
                bottomFill.end(_arg_1);
            };
        }

        override public function set left(_arg_1:Number):void
        {
        }

        private function drawTopRightRadius(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (topRightRadiusX > 0)
            {
                _local_3 = new Rectangle((_arg_2.width - Math.max(rightWidth, topRightRadiusX)), 0, Math.max(topRightRadiusX, rightWidth), Math.max(topRightRadiusY, topWidth));
                topRightFill.begin(_arg_1, _local_3);
                _arg_1.moveTo((_arg_2.width - topRightRadiusX), 0);
                _arg_1.curveTo(_arg_2.width, 0, _arg_2.width, Math.max(topRightRadiusY, topWidth));
                _arg_1.lineTo((_arg_2.width - rightWidth), Math.max(topRightRadiusY, topWidth));
                _arg_1.curveTo((_arg_2.width - rightWidth), topWidth, (_arg_2.width - Math.max(topRightRadiusX, rightWidth)), topWidth);
                _arg_1.lineTo((_arg_2.width - Math.max(topRightRadiusX, rightWidth)), 0);
                topRightFill.end(_arg_1);
            };
        }

        override public function get layoutConstraint():LayoutConstraint
        {
            return (null);
        }

        override public function set minWidth(_arg_1:Number):void
        {
        }

        override public function set minHeight(_arg_1:Number):void
        {
        }

        override public function set right(_arg_1:Number):void
        {
        }

        override public function set horizontalCenter(_arg_1:Number):void
        {
        }

        override public function set top(_arg_1:Number):void
        {
        }

        override public function draw(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_6:IStroke;
            var _local_3:Boolean = ((((((((topWidth == rightWidth) == bottomWidth) == leftWidth) && (topLeftRadiusX == topLeftRadiusY)) && (topRightRadiusX == topRightRadiusY)) && (bottomLeftRadiusX == bottomLeftRadiusY)) && (bottomRightRadiusX == bottomRightRadiusY)) && (isEquivalentSolidFill([topFill, rightFill, bottomFill, leftFill])));
            var _local_4:Boolean = ((_local_3) && (((topLeftRadiusX == topRightRadiusX) == bottomLeftRadiusX) == bottomRightRadiusX));
            var _local_5:Boolean = ((_local_4) && (topLeftRadiusX == 0));
            if ((((_local_5) || (_local_4)) || (_local_3)))
            {
                _local_6 = convertSolidColorToStroke((topFill as SolidColor), topWidth);
                _local_6.apply(_arg_1);
                backgroundFill.begin(_arg_1, _arg_2);
                if (_local_5)
                {
                    _arg_1.drawRect(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height);
                }
                else
                {
                    if (_local_4)
                    {
                        _arg_1.drawRoundRect(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height, topLeftRadiusX, topLeftRadiusY);
                    }
                    else
                    {
                        if (_local_3)
                        {
                            _arg_1.drawRoundRectComplex(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height, topLeftRadiusX, topRightRadiusX, bottomLeftRadiusX, bottomRightRadiusX);
                        };
                    };
                };
                backgroundFill.end(_arg_1);
            }
            else
            {
                drawLeftBorder(_arg_1, _arg_2);
                drawTopLeftRadius(_arg_1, _arg_2);
                drawTopBorder(_arg_1, _arg_2);
                drawTopRightRadius(_arg_1, _arg_2);
                drawRightBorder(_arg_1, _arg_2);
                drawBottomLeftRadius(_arg_1, _arg_2);
                drawBottomBorder(_arg_1, _arg_2);
                drawBottomRightRadius(_arg_1, _arg_2);
                drawBackground(_arg_1, _arg_2);
            };
        }

        private function convertSolidColorToStroke(_arg_1:SolidColor, _arg_2:Number):IStroke
        {
            if (_arg_1 != null)
            {
                return (new Stroke(_arg_1.color, _arg_2, _arg_1.alpha));
            };
            return (new Stroke(0, 0, 0));
        }

        private function drawTopLeftRadius(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (topLeftRadiusX > 0)
            {
                topLeftFill.begin(_arg_1, _arg_2);
                _arg_1.moveTo(0, topLeftRadiusY);
                _arg_1.curveTo(0, 0, topLeftRadiusX, 0);
                _arg_1.lineTo(Math.max(topLeftRadiusX, leftWidth), topWidth);
                _arg_1.curveTo(leftWidth, topWidth, leftWidth, Math.max(topLeftRadiusY, topWidth));
                _arg_1.lineTo(0, topLeftRadiusY);
                topLeftFill.end(_arg_1);
            };
        }

        private function drawBottomRightRadius(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (bottomRightRadiusX > 0)
            {
                bottomRightFill.begin(_arg_1, _arg_2);
                _arg_1.moveTo(_arg_2.width, (_arg_2.height - bottomRightRadiusY));
                _arg_1.curveTo(_arg_2.width, _arg_2.height, (_arg_2.width - bottomRightRadiusX), _arg_2.height);
                _arg_1.lineTo(Math.min((_arg_2.width - bottomRightRadiusX), _arg_2.width), (_arg_2.height - bottomWidth));
                _arg_1.curveTo((_arg_2.width - rightWidth), (_arg_2.height - bottomWidth), (_arg_2.width - rightWidth), Math.min((_arg_2.height - bottomRightRadiusY), _arg_2.height));
                _arg_1.lineTo(_arg_2.width, (_arg_2.height - bottomRightRadiusY));
                bottomRightFill.end(_arg_1);
            };
        }

        override public function set layoutConstraint(_arg_1:LayoutConstraint):void
        {
        }

        override public function get layoutRectangle():Rectangle
        {
            return (null);
        }

        override public function set height(_arg_1:Number):void
        {
        }

        override public function set maxX(_arg_1:Number):void
        {
        }

        override public function set maxHeight(_arg_1:Number):void
        {
        }

        private function drawBottomLeftRadius(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (bottomLeftRadiusX > 0)
            {
                _local_3 = new Rectangle(0, (_arg_2.height - Math.max(bottomWidth, bottomLeftRadiusY)), Math.max(leftWidth, bottomLeftRadiusX), Math.max(bottomWidth, bottomLeftRadiusY));
                bottomLeftFill.begin(_arg_1, _local_3);
                _arg_1.moveTo(bottomLeftRadiusX, _arg_2.height);
                _arg_1.curveTo(0, _arg_2.height, 0, (_arg_2.height - bottomLeftRadiusY));
                _arg_1.lineTo(leftWidth, Math.min((_arg_2.height - bottomLeftRadiusY), (_arg_2.height - bottomWidth)));
                _arg_1.curveTo(leftWidth, (_arg_2.height - bottomWidth), Math.max(bottomLeftRadiusX, leftWidth), (_arg_2.height - bottomWidth));
                _arg_1.lineTo(bottomLeftRadiusX, _arg_2.height);
                bottomLeftFill.end(_arg_1);
            };
        }

        override public function set y(_arg_1:Number):void
        {
        }

        override public function set x(_arg_1:Number):void
        {
        }

        private function isEquivalentSolidFill(_arg_1:Array):Boolean
        {
            var _local_2:SolidColor;
            var _local_3:IFill;
            var _local_4:SolidColor;
            for each (_local_3 in _arg_1)
            {
                if (((_local_3 is SolidColor) || (_local_3 == null)))
                {
                    if (_local_2 != null)
                    {
                        _local_4 = (_local_3 as SolidColor);
                        if (((!(_local_4.color == _local_2.color)) || (_local_4.alpha == _local_2.alpha)))
                        {
                            return (false);
                        };
                    };
                    _local_2 = (_local_3 as SolidColor);
                }
                else
                {
                    return (false);
                };
            };
            return (true);
        }

        private function drawTopBorder(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Rectangle;
            if (topFill != null)
            {
                _local_3 = new Rectangle(topLeftRadiusX, 0, ((_arg_2.width - topLeftRadiusX) - topRightRadiusX), topWidth);
                _arg_1.lineStyle(0, 0, 0);
                topFill.begin(_arg_1, _local_3);
                _arg_1.moveTo(topLeftRadiusX, 0);
                _arg_1.lineTo((_arg_2.width - topRightRadiusX), 0);
                _arg_1.lineTo((_arg_2.width - Math.max(topRightRadiusX, rightWidth)), topWidth);
                _arg_1.lineTo(Math.max(topLeftRadiusX, leftWidth), topWidth);
                _arg_1.lineTo(topLeftRadiusX, 0);
                topFill.end(_arg_1);
            };
        }


    }
}//package com.degrafa.geometry

