// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ButtonBarButtonSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import mx.utils.ColorUtil;
    import mx.core.UIComponent;
    import mx.styles.StyleManager;
    import mx.core.IButton;
    import mx.containers.BoxDirection;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ButtonBarButtonSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};
        private static var bbars:Object = {};


        private static function isButtonBar(parent:Object):Boolean
        {
            var s:String;
            var x:XML;
            s = getQualifiedClassName(parent);
            if (bbars[s] == 1)
            {
                return (true);
            };
            if (bbars[s] == 0)
            {
                return (false);
            };
            if (s == "mx.controls::ButtonBar")
            {
                (bbars[s] == 1);
                return (true);
            };
            x = describeType(parent);
            var xmllist:XMLList = x.extendsClass.(@type == "mx.controls::ButtonBar");
            if (xmllist.length() == 0)
            {
                bbars[s] = 0;
                return (false);
            };
            bbars[s] = 1;
            return (true);
        }

        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint):Object
        {
            var _local_5:Object;
            var _local_4:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3);
            if (!cache[_local_4])
            {
                _local_5 = (cache[_local_4] = {});
                HaloColors.addHaloColors(_local_5, _arg_1, _arg_2, _arg_3);
                _local_5.innerEdgeColor1 = ColorUtil.adjustBrightness2(_arg_2, -10);
                _local_5.innerEdgeColor2 = ColorUtil.adjustBrightness2(_arg_3, -25);
            };
            return (cache[_local_4]);
        }


        override public function get measuredWidth():Number
        {
            return (UIComponent.DEFAULT_MEASURED_MIN_WIDTH);
        }

        override public function get measuredHeight():Number
        {
            return (UIComponent.DEFAULT_MEASURED_MIN_HEIGHT);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_13:Number;
            var _local_22:int;
            var _local_23:Array;
            var _local_24:Array;
            var _local_25:Array;
            var _local_26:Array;
            var _local_27:Array;
            var _local_28:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:uint = getStyle("borderColor");
            var _local_4:Number = getStyle("cornerRadius");
            var _local_5:Array = getStyle("fillAlphas");
            var _local_6:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_6);
            var _local_7:Array = getStyle("highlightAlphas");
            var _local_8:uint = getStyle("themeColor");
            var _local_9:Object = calcDerivedStyles(_local_8, _local_6[0], _local_6[1]);
            var _local_10:Number = ColorUtil.adjustBrightness2(_local_3, -50);
            var _local_11:Number = ColorUtil.adjustBrightness2(_local_8, -25);
            var _local_12:Boolean;
            if ((parent is IButton))
            {
                _local_12 = (parent as IButton).emphasized;
            };
            var _local_14:Object = ((((parent) && (parent.parent)) && (isButtonBar(parent.parent))) ? parent.parent : null);
            var _local_15:Boolean = true;
            var _local_16:int;
            if (_local_14)
            {
                if (_local_14.direction == BoxDirection.VERTICAL)
                {
                    _local_15 = false;
                };
                _local_22 = _local_14.getChildIndex(parent);
                _local_16 = ((_local_22 == 0) ? -1 : ((_local_22 == (_local_14.numChildren - 1)) ? 1 : 0));
            };
            var _local_17:Object = getCornerRadius(_local_16, _local_15, _local_4);
            var _local_18:Object = getCornerRadius(_local_16, _local_15, _local_4);
            var _local_19:Object = getCornerRadius(_local_16, _local_15, (_local_4 - 1));
            var _local_20:Object = getCornerRadius(_local_16, _local_15, (_local_4 - 2));
            var _local_21:Object = getCornerRadius(_local_16, _local_15, (_local_4 - 3));
            graphics.clear();
            switch (name)
            {
                case "selectedUpSkin":
                case "selectedOverSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":2,
                        "y":2,
                        "w":(_arg_1 - 4),
                        "h":(_arg_2 - 4),
                        "r":_local_20
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_19, [_local_6[1], _local_6[1]], [_local_5[0], _local_5[1]], verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    return;
                case "upSkin":
                    _local_23 = [_local_6[0], _local_6[1]];
                    _local_24 = [_local_5[0], _local_5[1]];
                    if (_local_12)
                    {
                        drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":2,
                            "y":2,
                            "w":(_arg_1 - 4),
                            "h":(_arg_2 - 4),
                            "r":_local_20
                        });
                        drawRoundRect(2, 2, (_arg_1 - 4), (_arg_2 - 4), _local_20, _local_23, _local_24, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                        if (!(_local_17 is Number))
                        {
                            _local_17.bl = (_local_17.br = 0);
                        };
                        drawRoundRect(2, 2, (_arg_1 - 4), ((_arg_2 - 4) / 2), _local_17, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(2, 2, (_arg_1 - 2), ((_arg_2 - 4) / 2)));
                    }
                    else
                    {
                        drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_3, _local_10], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 2),
                            "h":(_arg_2 - 2),
                            "r":_local_19
                        });
                        drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_19, _local_23, _local_24, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                        if (!(_local_17 is Number))
                        {
                            _local_17.bl = (_local_17.br = 0);
                        };
                        drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), _local_17, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    };
                    return;
                case "overSkin":
                    if (_local_6.length > 2)
                    {
                        _local_25 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_25 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_26 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_26 = [_local_5[0], _local_5[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_8, _local_9.themeColDrk1], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_19
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_19, _local_25, _local_26, verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    if (!(_local_17 is Number))
                    {
                        _local_17.bl = (_local_17.br = 0);
                    };
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), _local_17, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "downSkin":
                case "selectedDownSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_8, _local_9.themeColDrk1], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_19, [_local_9.fillColorPress1, _local_9.fillColorPress2], 1, verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    if (!(_local_17 is Number))
                    {
                        _local_17.bl = (_local_17.br = 0);
                    };
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), _local_17, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "disabledSkin":
                case "selectedDisabledSkin":
                    _local_27 = [_local_6[0], _local_6[1]];
                    _local_28 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_18, [_local_3, _local_10], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_19
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_19, _local_27, _local_28, verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    return;
            };
        }

        private function getCornerRadius(_arg_1:int, _arg_2:Boolean, _arg_3:Number):Object
        {
            if (_arg_1 == 0)
            {
                return (0);
            };
            _arg_3 = Math.max(0, _arg_3);
            if (_arg_2)
            {
                if (_arg_1 == -1)
                {
                    return ({
                        "tl":_arg_3,
                        "tr":0,
                        "bl":_arg_3,
                        "br":0
                    });
                };
                return ({
                    "tl":0,
                    "tr":_arg_3,
                    "bl":0,
                    "br":_arg_3
                });
            };
            if (_arg_1 == -1)
            {
                return ({
                    "tl":_arg_3,
                    "tr":_arg_3,
                    "bl":0,
                    "br":0
                });
            };
            return ({
                "tl":0,
                "tr":0,
                "bl":_arg_3,
                "br":_arg_3
            });
        }


    }
}//package mx.skins.halo

