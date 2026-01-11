// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.Flex

package mx.containers.utilityClasses
{
    import mx.core.IUIComponent;
    import mx.core.FlexVersion;
    import mx.core.Container;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Flex 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        public static function flexChildWidthsProportionally(_arg_1:Container, _arg_2:Number, _arg_3:Number):Number
        {
            var _local_6:Array;
            var _local_7:FlexChildInfo;
            var _local_8:IUIComponent;
            var _local_9:int;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_4:Number = _arg_2;
            var _local_5:Number = 0;
            _local_6 = [];
            var _local_10:int = _arg_1.numChildren;
            _local_9 = 0;
            while (_local_9 < _local_10)
            {
                _local_8 = IUIComponent(_arg_1.getChildAt(_local_9));
                _local_11 = _local_8.percentWidth;
                _local_12 = _local_8.percentHeight;
                if (((!(isNaN(_local_12))) && (_local_8.includeInLayout)))
                {
                    _local_13 = Math.max(_local_8.minHeight, Math.min(_local_8.maxHeight, ((_local_12 >= 100) ? _arg_3 : ((_arg_3 * _local_12) / 100))));
                }
                else
                {
                    _local_13 = _local_8.getExplicitOrMeasuredHeight();
                };
                if (((!(isNaN(_local_11))) && (_local_8.includeInLayout)))
                {
                    _local_5 = (_local_5 + _local_11);
                    _local_7 = new FlexChildInfo();
                    _local_7.percent = _local_11;
                    _local_7.min = _local_8.minWidth;
                    _local_7.max = _local_8.maxWidth;
                    _local_7.height = _local_13;
                    _local_7.child = _local_8;
                    _local_6.push(_local_7);
                }
                else
                {
                    _local_14 = _local_8.getExplicitOrMeasuredWidth();
                    if (((_local_8.scaleX == 1) && (_local_8.scaleY == 1)))
                    {
                        _local_8.setActualSize(Math.floor(_local_14), Math.floor(_local_13));
                    }
                    else
                    {
                        _local_8.setActualSize(_local_14, _local_13);
                    };
                    if (_local_8.includeInLayout)
                    {
                        _local_4 = (_local_4 - _local_8.width);
                    };
                };
                _local_9++;
            };
            if (_local_5)
            {
                _local_4 = flexChildrenProportionally(_arg_2, _local_4, _local_5, _local_6);
                _local_10 = _local_6.length;
                _local_9 = 0;
                while (_local_9 < _local_10)
                {
                    _local_7 = _local_6[_local_9];
                    _local_8 = _local_7.child;
                    if (((_local_8.scaleX == 1) && (_local_8.scaleY == 1)))
                    {
                        _local_8.setActualSize(Math.floor(_local_7.size), Math.floor(_local_7.height));
                    }
                    else
                    {
                        _local_8.setActualSize(_local_7.size, _local_7.height);
                    };
                    _local_9++;
                };
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    distributeExtraWidth(_arg_1, _arg_2);
                };
            };
            return (_local_4);
        }

        public static function distributeExtraHeight(_arg_1:Container, _arg_2:Number):void
        {
            var _local_5:int;
            var _local_6:Number;
            var _local_9:IUIComponent;
            var _local_10:Number;
            var _local_11:Number;
            var _local_3:int = _arg_1.numChildren;
            var _local_4:Boolean;
            var _local_7:Number = _arg_2;
            var _local_8:Number = 0;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_9 = IUIComponent(_arg_1.getChildAt(_local_5));
                if (_local_9.includeInLayout)
                {
                    _local_10 = _local_9.height;
                    _local_6 = _local_9.percentHeight;
                    _local_8 = (_local_8 + _local_10);
                    if (!isNaN(_local_6))
                    {
                        _local_11 = Math.ceil(((_local_6 / 100) * _arg_2));
                        if (_local_11 > _local_10)
                        {
                            _local_4 = true;
                        };
                    };
                };
                _local_5++;
            };
            if (!_local_4)
            {
                return;
            };
            _local_7 = (_local_7 - _local_8);
            var _local_12:Boolean = true;
            while (((_local_12) && (_local_7 > 0)))
            {
                _local_12 = false;
                _local_5 = 0;
                while (_local_5 < _local_3)
                {
                    _local_9 = IUIComponent(_arg_1.getChildAt(_local_5));
                    _local_10 = _local_9.height;
                    _local_6 = _local_9.percentHeight;
                    if ((((!(isNaN(_local_6))) && (_local_9.includeInLayout)) && (_local_10 < _local_9.maxHeight)))
                    {
                        _local_11 = Math.ceil(((_local_6 / 100) * _arg_2));
                        if (_local_11 > _local_10)
                        {
                            _local_9.setActualSize(_local_9.width, (_local_10 + 1));
                            _local_7--;
                            _local_12 = true;
                            if (_local_7 == 0)
                            {
                                return;
                            };
                        };
                    };
                    _local_5++;
                };
            };
        }

        public static function distributeExtraWidth(_arg_1:Container, _arg_2:Number):void
        {
            var _local_5:int;
            var _local_6:Number;
            var _local_9:IUIComponent;
            var _local_10:Number;
            var _local_11:Number;
            var _local_3:int = _arg_1.numChildren;
            var _local_4:Boolean;
            var _local_7:Number = _arg_2;
            var _local_8:Number = 0;
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_9 = IUIComponent(_arg_1.getChildAt(_local_5));
                if (_local_9.includeInLayout)
                {
                    _local_10 = _local_9.width;
                    _local_6 = _local_9.percentWidth;
                    _local_8 = (_local_8 + _local_10);
                    if (!isNaN(_local_6))
                    {
                        _local_11 = Math.ceil(((_local_6 / 100) * _arg_2));
                        if (_local_11 > _local_10)
                        {
                            _local_4 = true;
                        };
                    };
                };
                _local_5++;
            };
            if (!_local_4)
            {
                return;
            };
            _local_7 = (_local_7 - _local_8);
            var _local_12:Boolean = true;
            while (((_local_12) && (_local_7 > 0)))
            {
                _local_12 = false;
                _local_5 = 0;
                while (_local_5 < _local_3)
                {
                    _local_9 = IUIComponent(_arg_1.getChildAt(_local_5));
                    _local_10 = _local_9.width;
                    _local_6 = _local_9.percentWidth;
                    if ((((!(isNaN(_local_6))) && (_local_9.includeInLayout)) && (_local_10 < _local_9.maxWidth)))
                    {
                        _local_11 = Math.ceil(((_local_6 / 100) * _arg_2));
                        if (_local_11 > _local_10)
                        {
                            _local_9.setActualSize((_local_10 + 1), _local_9.height);
                            _local_7--;
                            _local_12 = true;
                            if (_local_7 == 0)
                            {
                                return;
                            };
                        };
                    };
                    _local_5++;
                };
            };
        }

        public static function flexChildrenProportionally(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Array):Number
        {
            var _local_6:Number;
            var _local_7:Boolean;
            var _local_9:*;
            var _local_10:*;
            var _local_11:*;
            var _local_12:*;
            var _local_13:*;
            var _local_14:*;
            var _local_5:int = _arg_4.length;
            var _local_8:Number = (_arg_2 - ((_arg_1 * _arg_3) / 100));
            if (_local_8 > 0)
            {
                _arg_2 = (_arg_2 - _local_8);
            };
            do 
            {
                _local_6 = 0;
                _local_7 = true;
                _local_9 = (_arg_2 / _arg_3);
                _local_10 = 0;
                while (_local_10 < _local_5)
                {
                    _local_11 = _arg_4[_local_10];
                    _local_12 = (_local_11.percent * _local_9);
                    if (_local_12 < _local_11.min)
                    {
                        _local_13 = _local_11.min;
                        _local_11.size = _local_13;
                        _arg_4[_local_10] = _arg_4[--_local_5];
                        _arg_4[_local_5] = _local_11;
                        _arg_3 = (_arg_3 - _local_11.percent);
                        _arg_2 = (_arg_2 - _local_13);
                        _local_7 = false;
                        break;
                    };
                    if (_local_12 > _local_11.max)
                    {
                        _local_14 = _local_11.max;
                        _local_11.size = _local_14;
                        _arg_4[_local_10] = _arg_4[--_local_5];
                        _arg_4[_local_5] = _local_11;
                        _arg_3 = (_arg_3 - _local_11.percent);
                        _arg_2 = (_arg_2 - _local_14);
                        _local_7 = false;
                        break;
                    };
                    _local_11.size = _local_12;
                    _local_6 = (_local_6 + _local_12);
                    _local_10++;
                };
            } while ((!(_local_7)));
            return (Math.max(0, Math.floor((_arg_2 - _local_6))));
        }

        public static function flexChildHeightsProportionally(_arg_1:Container, _arg_2:Number, _arg_3:Number):Number
        {
            var _local_7:FlexChildInfo;
            var _local_8:IUIComponent;
            var _local_9:int;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_4:Number = _arg_2;
            var _local_5:Number = 0;
            var _local_6:Array = [];
            var _local_10:int = _arg_1.numChildren;
            _local_9 = 0;
            while (_local_9 < _local_10)
            {
                _local_8 = IUIComponent(_arg_1.getChildAt(_local_9));
                _local_11 = _local_8.percentWidth;
                _local_12 = _local_8.percentHeight;
                if (((!(isNaN(_local_11))) && (_local_8.includeInLayout)))
                {
                    _local_13 = Math.max(_local_8.minWidth, Math.min(_local_8.maxWidth, ((_local_11 >= 100) ? _arg_3 : ((_arg_3 * _local_11) / 100))));
                }
                else
                {
                    _local_13 = _local_8.getExplicitOrMeasuredWidth();
                };
                if (((!(isNaN(_local_12))) && (_local_8.includeInLayout)))
                {
                    _local_5 = (_local_5 + _local_12);
                    _local_7 = new FlexChildInfo();
                    _local_7.percent = _local_12;
                    _local_7.min = _local_8.minHeight;
                    _local_7.max = _local_8.maxHeight;
                    _local_7.width = _local_13;
                    _local_7.child = _local_8;
                    _local_6.push(_local_7);
                }
                else
                {
                    _local_14 = _local_8.getExplicitOrMeasuredHeight();
                    if (((_local_8.scaleX == 1) && (_local_8.scaleY == 1)))
                    {
                        _local_8.setActualSize(Math.floor(_local_13), Math.floor(_local_14));
                    }
                    else
                    {
                        _local_8.setActualSize(_local_13, _local_14);
                    };
                    if (_local_8.includeInLayout)
                    {
                        _local_4 = (_local_4 - _local_8.height);
                    };
                };
                _local_9++;
            };
            if (_local_5)
            {
                _local_4 = flexChildrenProportionally(_arg_2, _local_4, _local_5, _local_6);
                _local_10 = _local_6.length;
                _local_9 = 0;
                while (_local_9 < _local_10)
                {
                    _local_7 = _local_6[_local_9];
                    _local_8 = _local_7.child;
                    if (((_local_8.scaleX == 1) && (_local_8.scaleY == 1)))
                    {
                        _local_8.setActualSize(Math.floor(_local_7.width), Math.floor(_local_7.size));
                    }
                    else
                    {
                        _local_8.setActualSize(_local_7.width, _local_7.size);
                    };
                    _local_9++;
                };
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    distributeExtraHeight(_arg_1, _arg_2);
                };
            };
            return (_local_4);
        }


    }
}//package mx.containers.utilityClasses

