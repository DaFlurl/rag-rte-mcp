// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.LinearGradientFill

package com.degrafa.paint
{
    import com.degrafa.core.IGraphicsFill;
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    [Bindable(event="propertyChange")]
    public class LinearGradientFill extends GradientFillBase implements IGraphicsFill 
    {

        private var _x:Number;
        private var _height:Number;
        private var _width:Number;
        private var _y:Number;

        public function LinearGradientFill()
        {
            super.gradientType = "linear";
        }

        override public function get focalPointRatio():Number
        {
            return (0);
        }

        public function set y(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_y != _arg_1)
            {
                _local_2 = _y;
                _y = _arg_1;
                initChange("y", _local_2, _y, this);
            };
        }

        override public function end(_arg_1:Graphics):void
        {
            super.end(_arg_1);
        }

        public function get width():Number
        {
            if (!_width)
            {
                return (0);
            };
            return (_width);
        }

        override public function set focalPointRatio(_arg_1:Number):void
        {
        }

        override public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (((((_x) && (_y)) && (_width)) && (_height)))
            {
                if (_coordType == "relative")
                {
                    super.begin(_arg_1, new Rectangle((_arg_2.x + x), (_arg_2.y + y), width, height));
                }
                else
                {
                    if (_coordType == "ratio")
                    {
                        super.begin(_arg_1, new Rectangle((_arg_2.x + (x * _arg_2.width)), (_arg_2.y + (y * _arg_2.height)), (width * _arg_2.width), (height * _arg_2.height)));
                    }
                    else
                    {
                        super.begin(_arg_1, new Rectangle(x, y, width, height));
                    };
                };
            }
            else
            {
                if (((_width) && (_height)))
                {
                    if (_coordType == "relative")
                    {
                        super.begin(_arg_1, new Rectangle(_arg_2.x, _arg_2.y, width, height));
                    }
                    else
                    {
                        if (_coordType == "ratio")
                        {
                            super.begin(_arg_1, new Rectangle(_arg_2.x, _arg_2.y, (width * _arg_2.width), (height * _arg_2.height)));
                        }
                        else
                        {
                            super.begin(_arg_1, new Rectangle(0, 0, width, height));
                        };
                    };
                }
                else
                {
                    super.begin(_arg_1, _arg_2);
                };
            };
        }

        public function set width(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_width != _arg_1)
            {
                _local_2 = _width;
                _width = _arg_1;
                initChange("width", _local_2, _width, this);
            };
        }

        public function set x(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_x != _arg_1)
            {
                _local_2 = _x;
                _x = _arg_1;
                initChange("x", _local_2, _x, this);
            };
        }

        public function set derive(_arg_1:LinearGradientFill):void
        {
            if (!_x)
            {
                _x = _arg_1.x;
            };
            if (!_y)
            {
                _y = _arg_1.y;
            };
            if (!_width)
            {
                _width = _arg_1.width;
            };
            if (!_height)
            {
                _height = _arg_1.height;
            };
            if (!_spreadMethod)
            {
                _spreadMethod = _arg_1.spreadMethod;
            };
            if (!_angle)
            {
                _angle = _arg_1.angle;
            };
            if (!_blendMode)
            {
                _blendMode = _arg_1.blendMode;
            };
            if (!_interpolationMethod)
            {
                _interpolationMethod = _arg_1.interpolationMethod;
            };
            if (!_spreadMethod)
            {
                _spreadMethod = _arg_1.spreadMethod;
            };
            if (((!(_gradientStops)) && (!(_arg_1.gradientStops.length == 0))))
            {
                gradientStops = _arg_1.gradientStops;
            };
        }

        public function get height():Number
        {
            if (!_height)
            {
                return (0);
            };
            return (_height);
        }

        public function get x():Number
        {
            if (!_x)
            {
                return (0);
            };
            return (_x);
        }

        public function get y():Number
        {
            if (!_y)
            {
                return (0);
            };
            return (_y);
        }

        public function set height(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_height != _arg_1)
            {
                _local_2 = _height;
                _height = _arg_1;
                initChange("height", _local_2, _height, this);
            };
        }


    }
}//package com.degrafa.paint

