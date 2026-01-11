// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ScrollArrowSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.utils.ColorUtil;
    import mx.controls.scrollClasses.ScrollBar;
    import mx.styles.StyleManager;
    import flash.display.Graphics;
    import mx.core.FlexVersion;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollArrowSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var cache:Object = {};


        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint):Object
        {
            var _local_6:Object;
            var _local_5:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3, _arg_4);
            if (!cache[_local_5])
            {
                _local_6 = (cache[_local_5] = {});
                HaloColors.addHaloColors(_local_6, _arg_1, _arg_3, _arg_4);
                _local_6.borderColorDrk1 = ColorUtil.adjustBrightness2(_arg_2, -25);
                _local_6.borderColorDrk2 = ColorUtil.adjustBrightness2(_arg_2, -50);
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (ScrollBar.THICKNESS);
        }

        override public function get measuredHeight():Number
        {
            return (ScrollBar.THICKNESS);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_13:Array;
            var _local_15:Array;
            var _local_16:Array;
            var _local_17:Array;
            var _local_18:Array;
            var _local_19:Array;
            var _local_20:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("backgroundColor");
            var _local_4:uint = getStyle("borderColor");
            var _local_5:Array = getStyle("fillAlphas");
            var _local_6:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_6);
            var _local_7:Array = getStyle("highlightAlphas");
            var _local_8:uint = getStyle("themeColor");
            var _local_9:* = (name.charAt(0) == "u");
            var _local_10:uint = getStyle("iconColor");
            var _local_11:Object = calcDerivedStyles(_local_8, _local_4, _local_6[0], _local_6[1]);
            var _local_12:Boolean = (((parent) && (parent.parent)) && (!(parent.parent.rotation == 0)));
            if (((_local_9) && (!(_local_12))))
            {
                _local_13 = [_local_4, _local_11.borderColorDrk1];
            }
            else
            {
                _local_13 = [_local_11.borderColorDrk1, _local_11.borderColorDrk2];
            };
            var _local_14:Graphics = graphics;
            _local_14.clear();
            if (isNaN(_local_3))
            {
                _local_3 = 0xFFFFFF;
            };
            if (((FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0) || (name.indexOf("Disabled") == -1)))
            {
                drawRoundRect(0, 0, _arg_1, _arg_2, 0, _local_3, 1);
            };
            switch (name)
            {
                case "upArrowUpSkin":
                    if (!_local_12)
                    {
                        drawRoundRect(1, (_arg_2 - 4), (_arg_1 - 2), 8, 0, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], verticalGradientMatrix(1, (_arg_2 - 4), (_arg_1 - 2), 8), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - 4),
                            "w":(_arg_1 - 2),
                            "h":4,
                            "r":0
                        });
                    };
                case "downArrowUpSkin":
                    _local_15 = [_local_6[0], _local_6[1]];
                    _local_16 = [_local_5[0], _local_5[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, _local_13, 1, ((_local_12) ? horizontalGradientMatrix(0, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_15, _local_16, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - (2 / 2)))));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - (2 / 2)), 0, [0xFFFFFF, 0xFFFFFF], _local_7, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - (2 / 2)))));
                    break;
                case "upArrowOverSkin":
                    if (!_local_12)
                    {
                        drawRoundRect(1, (_arg_2 - 4), (_arg_1 - 2), 8, 0, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], verticalGradientMatrix(1, (_arg_2 - 4), (_arg_1 - 2), 8), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - 4),
                            "w":(_arg_1 - 2),
                            "h":4,
                            "r":0
                        });
                    };
                case "downArrowOverSkin":
                    if (_local_6.length > 2)
                    {
                        _local_17 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_17 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_18 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_18 = [_local_5[0], _local_5[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 1);
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11.themeColDrk1], 1, ((_local_12) ? horizontalGradientMatrix(0, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_17, _local_18, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2))));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - (2 / 2)), 0, [0xFFFFFF, 0xFFFFFF], _local_7, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - (2 / 2)))));
                    break;
                case "upArrowDownSkin":
                    if (!_local_12)
                    {
                        drawRoundRect(1, (_arg_2 - 4), (_arg_1 - 2), 8, 0, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], ((_local_12) ? horizontalGradientMatrix(1, (_arg_2 - 4), (_arg_1 - 2), 8) : verticalGradientMatrix(1, (_arg_2 - 4), (_arg_1 - 2), 8)), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - 4),
                            "w":(_arg_1 - 2),
                            "h":4,
                            "r":0
                        });
                    };
                case "downArrowDownSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, [_local_8, _local_11.themeColDrk1], 1, ((_local_12) ? horizontalGradientMatrix(0, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":0
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, [_local_11.fillColorPress1, _local_11.fillColorPress2], 1, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2))));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - (2 / 2)), 0, [0xFFFFFF, 0xFFFFFF], _local_7, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - (2 / 2)))));
                    break;
                case "upArrowDisabledSkin":
                    if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                    {
                        if (!_local_12)
                        {
                            drawRoundRect(1, (_arg_2 - 4), (_arg_1 - 2), 8, 0, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [0.5, 0], verticalGradientMatrix(1, (_arg_2 - 4), (_arg_1 - 2), 8), GradientType.LINEAR, null, {
                                "x":1,
                                "y":(_arg_2 - 4),
                                "w":(_arg_1 - 2),
                                "h":4,
                                "r":0
                            });
                        };
                    };
                case "downArrowDisabledSkin":
                    if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                    {
                        _local_19 = [_local_6[0], _local_6[1]];
                        _local_20 = [(_local_5[0] - 0.15), (_local_5[1] - 0.15)];
                        drawRoundRect(0, 0, _arg_1, _arg_2, 0, _local_13, 0.5, ((_local_12) ? horizontalGradientMatrix(0, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 2),
                            "h":(_arg_2 - 2),
                            "r":0
                        });
                        drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, _local_19, _local_20, ((_local_12) ? horizontalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - (2 / 2)))));
                        _local_10 = getStyle("disabledIconColor");
                    }
                    else
                    {
                        drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 0);
                        return;
                    };
                    break;
                default:
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 0);
                    return;
            };
            _local_14.beginFill(_local_10);
            if (_local_9)
            {
                _local_14.moveTo((_arg_1 / 2), 6);
                _local_14.lineTo((_arg_1 - 5), (_arg_2 - 6));
                _local_14.lineTo(5, (_arg_2 - 6));
                _local_14.lineTo((_arg_1 / 2), 6);
            }
            else
            {
                _local_14.moveTo((_arg_1 / 2), (_arg_2 - 6));
                _local_14.lineTo((_arg_1 - 5), 6);
                _local_14.lineTo(5, 6);
                _local_14.lineTo((_arg_1 / 2), (_arg_2 - 6));
            };
            _local_14.endFill();
        }


    }
}//package mx.skins.halo

