// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.utils.StyleUtil

package com.degrafa.core.utils
{
    import flash.utils.Dictionary;
    import mx.graphics.IFill;
    import com.degrafa.paint.ComplexFill;
    import com.degrafa.paint.SolidFill;
    import com.degrafa.core.Measure;
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import com.degrafa.paint.BitmapFill;
    import flash.geom.Point;
    import flash.filters.DropShadowFilter;
    import mx.graphics.SolidColor;
    import com.degrafa.paint.GradientStop;
    import com.degrafa.paint.LinearGradientFill;

    public class StyleUtil 
    {

        public static var LEGACY:String = "BETA";
        private static var functions:Dictionary;


        private static function resolveFillFromArray(_arg_1:Array):IFill
        {
            var _local_5:Object;
            var _local_6:IFill;
            if (LEGACY == "ALPHA")
            {
                return (resolveFillFromArrayOld(_arg_1));
            };
            var _local_2:ComplexFill = new ComplexFill();
            var _local_3:Array = (_local_2.fills = new Array());
            var _local_4:int = _arg_1.length;
            while (_local_4-- > 0)
            {
                _local_5 = _arg_1[_local_4];
                _local_6 = resolveFill(_local_5);
                _local_3.push(_local_6);
            };
            return (_local_2);
        }

        private static function resolveShadowFromArray(_arg_1:Array):Array
        {
            var _local_2:Array = new Array();
            var _local_3:int = _arg_1.length;
            while (_local_3-- > 0)
            {
                _local_2.push(resolveShadow(_arg_1[_local_3]));
            };
            return (_local_2);
        }

        private static function resolveFillFromArrayOld(_arg_1:Array):IFill
        {
            var _local_4:Object;
            var _local_5:IFill;
            var _local_2:ComplexFill = new ComplexFill();
            var _local_3:Array = (_local_2.fills = new Array());
            for each (_local_4 in (_arg_1 as Array))
            {
                _local_5 = resolveFill(_local_4);
                _local_3.push(_local_5);
            };
            return (_local_2);
        }

        private static function resolveFillFromString(_arg_1:String):IFill
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            if (_arg_1.toLowerCase() == "none")
            {
                return (null);
            };
            if (_arg_1.indexOf(" ") > 0)
            {
                return (resolveGradientFromString(_arg_1));
            };
            return (new SolidFill(ColorUtil.resolveColor(_arg_1)));
        }

        public static function splitString(_arg_1:String):Array
        {
            var _local_2:Array = _arg_1.split(" ");
            var _local_3:uint;
            while (_local_3 < _local_2.length)
            {
                if (_local_2[_local_3] == "")
                {
                    _local_2.splice(_local_3, 1);
                    _local_3--;
                };
                _local_3++;
            };
            return (_local_2);
        }

        private static function resolveMeasureFromString(_arg_1:String):Measure
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:String;
            if (_arg_1 == null)
            {
                return (null);
            };
            switch (_arg_1)
            {
                case "bottom":
                case "right":
                    return (new Measure(100, Measure.PERCENT));
                case "top":
                case "left":
                    return (new Measure(0, Measure.PIXELS));
                case "center":
                    return (new Measure(50, Measure.PERCENT));
            };
            _arg_1 = _arg_1.replace(" ", "");
            var _local_2:int = _arg_1.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _arg_1.charAt(_local_3);
                switch (_local_4)
                {
                    case "0":
                    case "1":
                    case "2":
                    case "3":
                    case "4":
                    case "5":
                    case "6":
                    case "7":
                    case "8":
                    case "9":
                    case "-":
                        break;
                    default:
                        _local_5 = Number(_arg_1.substring(0, _local_3));
                        _local_6 = _arg_1.substring(_local_3);
                        switch (_local_6)
                        {
                            case "px":
                                return (new Measure(_local_5, Measure.PIXELS));
                            case "pt":
                                return (new Measure(_local_5, Measure.POINTS));
                            case "%":
                                return (new Measure(_local_5, Measure.PERCENT));
                            case "deg":
                                return (new Measure(_local_5, Measure.DEGREES));
                            case "in":
                                return (new Measure(_local_5, Measure.INCHES));
                            default:
                                return (null);
                        };
                };
                _local_3++;
            };
            return (new Measure(Number(_arg_1)));
        }

        public static function resolveFill(_arg_1:Object, _arg_2:IFill=null):IFill
        {
            if ((_arg_1 is uint))
            {
                return (new SolidFill((_arg_1 as uint), 1));
            };
            if (((((_arg_1 is Class) || (_arg_1 is BitmapData)) || (_arg_1 is Bitmap)) || (_arg_1 is DisplayObject)))
            {
                return (new BitmapFill(_arg_1));
            };
            if ((_arg_1 is String))
            {
                return (resolveFillFromString((_arg_1 as String)));
            };
            if ((_arg_1 is Array))
            {
                return (resolveFillFromArray((_arg_1 as Array)));
            };
            if ((_arg_1 is IFill))
            {
                return (_arg_1 as IFill);
            };
            return (_arg_2);
        }

        public static function expandProperty(_arg_1:Object, _arg_2:Array):Array
        {
            var _local_6:Object;
            var _local_3:Array = splitString(_arg_1.toString());
            var _local_4:int = _arg_2.length;
            var _local_5:int = _local_3.length;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_2[_local_5];
                if (((_local_6 is int) && (_local_6 < 0)))
                {
                    _local_3.push(_local_3[(_local_5 + _local_6)]);
                }
                else
                {
                    _local_3.push(_local_6);
                };
                _local_5++;
            };
            return (_local_3);
        }

        public static function resolveMeasure(_arg_1:Object, _arg_2:Measure=null):Measure
        {
            if ((((_arg_1 is Number) || (_arg_1 is int)) || (_arg_1 is uint)))
            {
                return (new Measure((_arg_1 as Number)));
            };
            if ((_arg_1 is String))
            {
                return (resolveMeasureFromString((_arg_1 as String)));
            };
            return (_arg_2);
        }

        private static function resolvePositionFromArray(_arg_1:Array):Array
        {
            var _local_4:Object;
            if (LEGACY == "ALPHA")
            {
                return (resolvePositionFromArrayOld(_arg_1));
            };
            var _local_2:Array = new Array();
            var _local_3:int = _arg_1.length;
            while (_local_3-- > 0)
            {
                _local_4 = _arg_1[_local_3];
                if ((_local_4 is String))
                {
                    _local_2.push(resolvePositionFromString((_local_4 as String)));
                }
                else
                {
                    _local_2.push(_local_4);
                };
            };
            return (_local_2);
        }

        public static function resolveRadius(_arg_1:Object, _arg_2:Point=null):Object
        {
            if ((_arg_1 is Number))
            {
                return ({
                    "x":new Measure(Number(_arg_1)),
                    "y":new Measure(Number(_arg_1))
                });
            };
            return ({
                "x":new Measure(0),
                "y":new Measure(0)
            });
        }

        private static function resolveRepeatFromArrayOld(_arg_1:Array):Array
        {
            var _local_3:Object;
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1)
            {
                if ((_local_3 is String))
                {
                    _local_2.push(resolveRepeatFromString((_local_3 as String)));
                }
                else
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        public static function resolveRepeat(_arg_1:Object, _arg_2:Array=null):Array
        {
            if ((_arg_1 is String))
            {
                return ([resolveRepeatFromString((_arg_1 as String))]);
            };
            if ((_arg_1 is Array))
            {
                return (resolveRepeatFromArray((_arg_1 as Array)));
            };
            return (_arg_2);
        }

        private static function resolveRepeatFromArray(_arg_1:Array):Array
        {
            var _local_4:Object;
            if (LEGACY == "ALPHA")
            {
                return (resolveRepeatFromArrayOld(_arg_1));
            };
            var _local_2:Array = new Array();
            var _local_3:int = _arg_1.length;
            while (_local_3-- > 0)
            {
                _local_4 = _arg_1[_local_3];
                if ((_local_4 is String))
                {
                    _local_2.push(resolveRepeatFromString((_local_4 as String)));
                }
                else
                {
                    _local_2.push(_local_4);
                };
            };
            return (_local_2);
        }

        private static function resolveRepeatFromString(_arg_1:String):Object
        {
            switch (_arg_1)
            {
                case "repeat":
                    return ({
                        "x":"repeat",
                        "y":"repeat"
                    });
                case "repeat-x":
                    return ({
                        "x":"repeat",
                        "y":"none"
                    });
                case "repeat-y":
                    return ({
                        "x":"none",
                        "y":"repeat"
                    });
                case "no-repeat":
                    return ({
                        "x":"none",
                        "y":"none"
                    });
                case "space":
                    return ({
                        "x":"space",
                        "y":"space"
                    });
                case "stretch":
                    return ({
                        "x":"stretch",
                        "y":"stretch"
                    });
                default:
                    return ({
                        "x":"repeat",
                        "y":"repeat"
                    });
            };
        }

        public static function registerFunction(_arg_1:String, _arg_2:Function):void
        {
            if (functions == null)
            {
                functions = new Dictionary();
            };
            functions[_arg_1] = _arg_2;
        }

        public static function resolveShadow(_arg_1:Object, _arg_2:Array=null):Array
        {
            if ((_arg_1 is Array))
            {
                return (resolveShadowFromArray((_arg_1 as Array)));
            };
            if (((((_arg_1 is String) || (_arg_1 is Number)) || (_arg_1 is int)) || (_arg_1 is uint)))
            {
                return ([resolveShadowFromString(_arg_1.toString())]);
            };
            return (_arg_2);
        }

        private static function resolvePositionFromArrayOld(_arg_1:Array):Array
        {
            var _local_3:Object;
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1)
            {
                if ((_local_3 is String))
                {
                    _local_2.push(resolvePositionFromString((_local_3 as String)));
                }
                else
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        private static function resolveShadowFromString(_arg_1:String):DropShadowFilter
        {
            var _local_2:DropShadowFilter = new DropShadowFilter(0, 0, 0, 1, 0, 0);
            var _local_3:Array = expandProperty(_arg_1, [0, -1, 0, 0]);
            var _local_4:Point = new Point(resolveLength(_local_3[0]), resolveLength(_local_3[1]));
            _local_2.distance = Math.sqrt((Math.pow(_local_4.x, 2) + Math.pow(_local_4.y, 2)));
            _local_2.angle = (Math.atan2(_local_4.y, _local_4.x) * (180 / Math.PI));
            _local_2.blurX = (_local_2.blurY = resolveLength(_local_3[2]));
            _local_2.color = (resolveFill(_local_3[3]) as SolidColor).color;
            return (_local_2);
        }

        private static function resolvePositionFromString(_arg_1:String):Object
        {
            var _local_2:Array = expandProperty(_arg_1, ["top", -1]);
            return ({
                "x":resolveMeasureFromString((_local_2[1] as String)),
                "y":resolveMeasureFromString((_local_2[0] as String))
            });
        }

        private static function resolveLength(_arg_1:Object):Number
        {
            return (Number(_arg_1));
        }

        public static function resolvePosition(_arg_1:Object, _arg_2:Array=null):Array
        {
            if ((_arg_1 is String))
            {
                return ([resolvePositionFromString((_arg_1 as String))]);
            };
            if ((_arg_1 is Array))
            {
                return (resolvePositionFromArray((_arg_1 as Array)));
            };
            return (_arg_2);
        }

        private static function resolveGradientFromString(_arg_1:String):IFill
        {
            var _local_5:int;
            var _local_6:Measure;
            var _local_7:GradientStop;
            var _local_8:Measure;
            var _local_9:Measure;
            var _local_10:IFill;
            var _local_2:LinearGradientFill = new LinearGradientFill();
            _local_2.gradientStops = new Array();
            var _local_3:Array = splitString(_arg_1);
            var _local_4:int = _local_3.length;
            if (_local_4 > 0)
            {
                _local_5 = 0;
                _local_6 = resolveMeasure(_local_3[0]);
                if (((!(_local_6 == null)) && (_local_6.unit == Measure.DEGREES)))
                {
                    _local_2.angle = _local_6.value;
                    _local_5 = 1;
                };
                while (_local_5 < _local_4)
                {
                    _local_7 = new GradientStop();
                    _local_8 = resolveMeasureFromString(_local_3[_local_5]);
                    if (_local_8 != null)
                    {
                        _local_7.ratio = _local_8.value;
                        _local_7.ratioUnit = _local_8.unit;
                        _local_5++;
                    };
                    _local_9 = resolveMeasureFromString(_local_3[_local_5]);
                    if (_local_9 != null)
                    {
                        _local_7.alpha = (Number(_local_9) / 100);
                        _local_5++;
                    };
                    _local_10 = new SolidColor(ColorUtil.resolveColor(_local_3[_local_5]));
                    if (((!(_local_10 == null)) && (_local_10 is SolidColor)))
                    {
                        _local_7.color = (_local_10 as SolidColor).color;
                        _local_5++;
                    };
                    _local_2.gradientStops.push(_local_7);
                };
            };
            return (_local_2);
        }


    }
}//package com.degrafa.core.utils

