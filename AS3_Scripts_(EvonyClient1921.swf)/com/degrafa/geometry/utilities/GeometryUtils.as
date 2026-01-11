// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.utilities.GeometryUtils

package com.degrafa.geometry.utilities
{
    import flash.geom.Rectangle;
    import com.degrafa.geometry.command.CommandStack;
    import flash.geom.Point;

    public class GeometryUtils 
    {

        private static var half:Number = 0.5;
        private static var bezBoundsRect:Rectangle = new Rectangle();
        private static var sx:Number;
        private static var sy:Number;
        private static var m1:Number;
        private static var m2:Number;
        private static var m3:Number;
        private static var dx:Number;
        private static var dy:Number;
        private static var dx1:Number;
        private static var dx2:Number;
        private static var returnResult:Array;


        public static function cubicToQuadratic(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:CommandStack):Array
        {
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            var _local_22:Number;
            if (!returnResult)
            {
                returnResult = [];
            };
            dx1 = (_arg_3 - _arg_1);
            dx2 = (_arg_5 - _arg_7);
            if ((((_arg_2 == _arg_8) && (_arg_4 == _arg_2)) && (_arg_6 == _arg_8)))
            {
                returnResult.push(_arg_10.addLineTo(_arg_7, _arg_8));
                return (returnResult);
            };
            if ((((!(dx1)) && (!(dx2))) && (_arg_1 == _arg_7)))
            {
                returnResult.push(_arg_10.addLineTo(_arg_7, _arg_8));
                return (returnResult);
            };
            if (!dx1)
            {
                sx = _arg_1;
                sy = ((((_arg_6 - _arg_8) / dx2) * (_arg_1 - _arg_7)) + _arg_8);
                dx = ((((_arg_1 + _arg_7) + (sx * 4)) - ((_arg_3 + _arg_5) * 3)) * 0.125);
                dy = ((((_arg_2 + _arg_8) + (sy * 4)) - ((_arg_4 + _arg_6) * 3)) * 0.125);
            }
            else
            {
                if (!dx2)
                {
                    sx = _arg_7;
                    sy = ((((_arg_4 - _arg_2) / dx1) * (_arg_7 - _arg_1)) + _arg_2);
                    dx = ((((_arg_1 + _arg_7) + (sx * 4)) - ((_arg_3 + _arg_5) * 3)) * 0.125);
                    dy = ((((_arg_2 + _arg_8) + (sy * 4)) - ((_arg_4 + _arg_6) * 3)) * 0.125);
                }
                else
                {
                    m1 = ((_arg_4 - _arg_2) / dx1);
                    m2 = ((_arg_6 - _arg_8) / dx2);
                    if (Math.abs(m1) == Math.abs(m2))
                    {
                        m3 = ((_arg_8 - _arg_2) / (_arg_7 - _arg_1));
                        if (((m1 == m2) && (m3 == m1)))
                        {
                            returnResult.push(_arg_10.addLineTo(_arg_7, _arg_8));
                            return (returnResult);
                        };
                        if ((((m1 > m3) && (m2 < m3)) || ((m1 < m3) && (m2 > m3))))
                        {
                            sx = ((_arg_3 + _arg_5) / 2);
                            sy = ((_arg_4 + _arg_6) / 2);
                            dx = ((((_arg_1 + _arg_7) + (sx * 4)) - ((_arg_3 + _arg_5) * 3)) * 0.125);
                            dy = ((((_arg_2 + _arg_8) + (sy * 4)) - ((_arg_4 + _arg_6) * 3)) * 0.125);
                        }
                        else
                        {
                            dx = _arg_9;
                            dy = _arg_9;
                        };
                    }
                    else
                    {
                        sx = (((((-(m2) * _arg_7) + _arg_8) + (m1 * _arg_1)) - _arg_2) / (m1 - m2));
                        sy = ((m1 * (sx - _arg_1)) + _arg_2);
                        dx = ((((_arg_1 + _arg_7) + (sx * 4)) - ((_arg_3 + _arg_5) * 3)) * 0.125);
                        dy = ((((_arg_2 + _arg_8) + (sy * 4)) - ((_arg_4 + _arg_6) * 3)) * 0.125);
                    };
                };
            };
            if (((dx * dx) + (dy * dy)) > _arg_9)
            {
                _local_11 = ((_arg_1 + _arg_3) * half);
                _local_12 = ((_arg_2 + _arg_4) * half);
                _local_13 = ((_arg_3 + _arg_5) * half);
                _local_14 = ((_arg_4 + _arg_6) * half);
                _local_15 = ((_arg_5 + _arg_7) * half);
                _local_16 = ((_arg_6 + _arg_8) * half);
                _local_17 = ((_local_11 + _local_13) * half);
                _local_18 = ((_local_12 + _local_14) * half);
                _local_19 = ((_local_13 + _local_15) * half);
                _local_20 = ((_local_14 + _local_16) * half);
                _local_21 = ((_local_17 + _local_19) * half);
                _local_22 = ((_local_18 + _local_20) * half);
                cubicToQuadratic(_arg_1, _arg_2, _local_11, _local_12, _local_17, _local_18, _local_21, _local_22, _arg_9, _arg_10);
                cubicToQuadratic(_local_21, _local_22, _local_19, _local_20, _local_15, _local_16, _arg_7, _arg_8, _arg_9, _arg_10);
            }
            else
            {
                returnResult.push(_arg_10.addCurveTo(sx, sy, _arg_7, _arg_8));
            };
            return (returnResult);
        }

        public static function lineIntersects(_arg_1:Point, _arg_2:Point, _arg_3:Point, _arg_4:Point):Point
        {
            var _local_5:Number = _arg_1.x;
            var _local_6:Number = _arg_1.y;
            var _local_7:Number = _arg_4.x;
            var _local_8:Number = _arg_4.y;
            var _local_9:Number = (_arg_2.x - _local_5);
            var _local_10:Number = (_arg_3.x - _local_7);
            var _local_11:Point = new Point();
            if (!((_local_9) || (_local_10)))
            {
                _local_11.x = 0;
                _local_11.y = 0;
            };
            var _local_12:Number = ((_arg_2.y - _local_6) / _local_9);
            var _local_13:Number = ((_arg_3.y - _local_8) / _local_10);
            if (!_local_9)
            {
                _local_11.x = _local_5;
                _local_11.y = ((_local_13 * (_local_5 - _local_7)) + _local_8);
                return (_local_11);
            };
            if (!_local_10)
            {
                _local_11.x = _local_7;
                _local_11.y = ((_local_12 * (_local_7 - _local_5)) + _local_6);
                return (_local_11);
            };
            var _local_14:Number = (((((-(_local_13) * _local_7) + _local_8) + (_local_12 * _local_5)) - _local_6) / (_local_12 - _local_13));
            var _local_15:Number = ((_local_12 * (_local_14 - _local_5)) + _local_6);
            _local_11.x = _local_14;
            _local_11.y = _local_15;
            return (_local_11);
        }

        public static function splitBezier(_arg_1:Point, _arg_2:Point, _arg_3:Point, _arg_4:Point):Object
        {
            var _local_5:Point = midPoint(_arg_1, _arg_2);
            var _local_6:Point = midPoint(_arg_2, _arg_3);
            var _local_7:Point = midPoint(_arg_3, _arg_4);
            var _local_8:Point = midPoint(_local_5, _local_6);
            var _local_9:Point = midPoint(_local_6, _local_7);
            var _local_10:Point = midPoint(_local_8, _local_9);
            return ({
                "b0":{
                    "p1":_arg_1,
                    "c1":_local_5,
                    "c2":_local_8,
                    "p2":_local_10
                },
                "b1":{
                    "p1":_local_10,
                    "c1":_local_9,
                    "c2":_local_7,
                    "p2":_arg_4
                }
            });
        }

        public static function barycenter(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Number
        {
            return (((((1 - _arg_4) * (1 - _arg_4)) * _arg_1) + (((2 * (1 - _arg_4)) * _arg_4) * _arg_2)) + ((_arg_4 * _arg_4) * _arg_3));
        }

        public static function perimeter(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Number
        {
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_7:Number = _arg_1;
            var _local_8:Number = _arg_2;
            var _local_9:Number = 0;
            var _local_15:Number = 0;
            while (_local_15 <= 1)
            {
                _local_10 = barycenter(_arg_1, _arg_3, _arg_5, _local_15);
                _local_11 = barycenter(_arg_2, _arg_4, _arg_6, _local_15);
                _local_12 = Math.abs((_local_10 - _local_7));
                _local_13 = Math.abs((_local_11 - _local_8));
                _local_14 = Math.sqrt(((_local_12 * _local_12) + (_local_13 * _local_13)));
                _local_9 = (_local_9 + _local_14);
                _local_7 = _local_10;
                _local_8 = _local_11;
                _local_15 = (_local_15 + 0.001);
            };
            return (_local_9);
        }

        public static function rotatePointOnCenterPoint(_arg_1:Point, _arg_2:Point, _arg_3:Number):Point
        {
            var _local_4:Point = new Point();
            var _local_5:Number = ((_arg_3 / 180) * Math.PI);
            _local_4.x = (_arg_2.x + ((Math.cos(_local_5) * (_arg_1.x - _arg_2.x)) - (Math.sin(_local_5) * (_arg_1.y - _arg_2.y))));
            _local_4.y = (_arg_2.y + ((Math.sin(_local_5) * (_arg_1.x - _arg_2.x)) + (Math.cos(_local_5) * (_arg_1.y - _arg_2.y))));
            return (_local_4);
        }

        public static function midPoint(_arg_1:Point, _arg_2:Point):Point
        {
            return (new Point(((_arg_1.x + _arg_2.x) * half), ((_arg_1.y + _arg_2.y) * half)));
        }

        public static function roundTo(_arg_1:Number, _arg_2:Number):Number
        {
            return (Math.round((_arg_1 * Math.pow(10, _arg_2))) / Math.pow(10, _arg_2));
        }

        public static function radiusToDegress(_arg_1:Number):Number
        {
            return (_arg_1 * (180 / Math.PI));
        }

        public static function pointOnQuadraticCurve(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Object
        {
            var _local_8:Number = (_arg_1 / 100);
            return ({
                "x":(_arg_2 + (_local_8 * (((2 * (1 - _local_8)) * (_arg_4 - _arg_2)) + (_local_8 * (_arg_6 - _arg_2))))),
                "y":(_arg_3 + (_local_8 * (((2 * (1 - _local_8)) * (_arg_5 - _arg_3)) + (_local_8 * (_arg_7 - _arg_3)))))
            });
        }

        public static function degressToRadius(_arg_1:Number):Number
        {
            return (_arg_1 * (Math.PI / 180));
        }

        public static function bezierBounds(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Rectangle
        {
            var _local_7:Number;
            if (((_arg_1 == _arg_3) && (_arg_3 == _arg_5)))
            {
                bezBoundsRect.x = _arg_1;
                bezBoundsRect.y = Math.min(_arg_2, _arg_6);
                bezBoundsRect.width = 0.0001;
                bezBoundsRect.height = Math.abs((_arg_6 - _arg_2));
                return (bezBoundsRect);
            };
            if (((_arg_2 == _arg_4) && (_arg_4 == _arg_6)))
            {
                bezBoundsRect.x = Math.min(_arg_1, _arg_5);
                bezBoundsRect.y = _arg_2;
                bezBoundsRect.width = Math.abs((_arg_5 - _arg_1));
                bezBoundsRect.height = 0.0001;
                return (bezBoundsRect);
            };
            if (_arg_2 > _arg_6)
            {
                if (_arg_4 > _arg_6)
                {
                    bezBoundsRect.y = _arg_6;
                }
                else
                {
                    _local_7 = (-(_arg_4 - _arg_2) / ((_arg_6 - (2 * _arg_4)) + _arg_2));
                    bezBoundsRect.y = (((((1 - _local_7) * (1 - _local_7)) * _arg_2) + (((2 * _local_7) * (1 - _local_7)) * _arg_4)) + ((_local_7 * _local_7) * _arg_6));
                };
            }
            else
            {
                if (_arg_4 > _arg_2)
                {
                    bezBoundsRect.y = _arg_2;
                }
                else
                {
                    _local_7 = (-(_arg_4 - _arg_2) / ((_arg_6 - (2 * _arg_4)) + _arg_2));
                    bezBoundsRect.y = (((((1 - _local_7) * (1 - _local_7)) * _arg_2) + (((2 * _local_7) * (1 - _local_7)) * _arg_4)) + ((_local_7 * _local_7) * _arg_6));
                };
            };
            if (_arg_2 > _arg_6)
            {
                if (_arg_4 < _arg_2)
                {
                    bezBoundsRect.bottom = _arg_2;
                }
                else
                {
                    _local_7 = (-(_arg_4 - _arg_2) / ((_arg_6 - (2 * _arg_4)) + _arg_2));
                    bezBoundsRect.bottom = (((((1 - _local_7) * (1 - _local_7)) * _arg_2) + (((2 * _local_7) * (1 - _local_7)) * _arg_4)) + ((_local_7 * _local_7) * _arg_6));
                };
            }
            else
            {
                if (_arg_6 > _arg_4)
                {
                    bezBoundsRect.bottom = _arg_6;
                }
                else
                {
                    _local_7 = (-(_arg_4 - _arg_2) / ((_arg_6 - (2 * _arg_4)) + _arg_2));
                    bezBoundsRect.bottom = (((((1 - _local_7) * (1 - _local_7)) * _arg_2) + (((2 * _local_7) * (1 - _local_7)) * _arg_4)) + ((_local_7 * _local_7) * _arg_6));
                };
            };
            if (_arg_1 > _arg_5)
            {
                if (_arg_3 > _arg_5)
                {
                    bezBoundsRect.x = _arg_5;
                }
                else
                {
                    _local_7 = (-(_arg_3 - _arg_1) / ((_arg_5 - (2 * _arg_3)) + _arg_1));
                    bezBoundsRect.x = (((((1 - _local_7) * (1 - _local_7)) * _arg_1) + (((2 * _local_7) * (1 - _local_7)) * _arg_3)) + ((_local_7 * _local_7) * _arg_5));
                };
            }
            else
            {
                if (_arg_3 > _arg_1)
                {
                    bezBoundsRect.x = _arg_1;
                }
                else
                {
                    _local_7 = (-(_arg_3 - _arg_1) / ((_arg_5 - (2 * _arg_3)) + _arg_1));
                    bezBoundsRect.x = (((((1 - _local_7) * (1 - _local_7)) * _arg_1) + (((2 * _local_7) * (1 - _local_7)) * _arg_3)) + ((_local_7 * _local_7) * _arg_5));
                };
            };
            if (_arg_1 > _arg_5)
            {
                if (_arg_3 < _arg_1)
                {
                    bezBoundsRect.right = _arg_1;
                }
                else
                {
                    _local_7 = (-(_arg_3 - _arg_1) / ((_arg_5 - (2 * _arg_3)) + _arg_1));
                    bezBoundsRect.right = (((((1 - _local_7) * (1 - _local_7)) * _arg_1) + (((2 * _local_7) * (1 - _local_7)) * _arg_3)) + ((_local_7 * _local_7) * _arg_5));
                };
            }
            else
            {
                if (_arg_3 < _arg_5)
                {
                    bezBoundsRect.right = _arg_5;
                }
                else
                {
                    _local_7 = (-(_arg_3 - _arg_1) / ((_arg_5 - (2 * _arg_3)) + _arg_1));
                    bezBoundsRect.right = (((((1 - _local_7) * (1 - _local_7)) * _arg_1) + (((2 * _local_7) * (1 - _local_7)) * _arg_3)) + ((_local_7 * _local_7) * _arg_5));
                };
            };
            return (bezBoundsRect);
        }

        public static function rotatePoint(_arg_1:Point, _arg_2:Number):Point
        {
            var _local_3:Number = Math.sqrt((Math.pow(_arg_1.x, 2) + Math.pow(_arg_1.y, 2)));
            _arg_2 = (Math.atan2(_arg_1.y, _arg_1.x) + degressToRadius(_arg_2));
            return (new Point(roundTo((_local_3 * Math.cos(_arg_2)), 3), roundTo((_local_3 * Math.sin(_arg_2)), 3)));
        }


    }
}//package com.degrafa.geometry.utilities

