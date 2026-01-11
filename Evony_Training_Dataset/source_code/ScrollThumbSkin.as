// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ScrollThumbSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.utils.ColorUtil;
    import mx.styles.StyleManager;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ScrollThumbSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};


        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint):Object
        {
            var _local_6:Object;
            var _local_5:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3, _arg_4);
            if (!cache[_local_5])
            {
                _local_6 = (cache[_local_5] = {});
                HaloColors.addHaloColors(_local_6, _arg_1, _arg_3, _arg_4);
                _local_6.borderColorDrk1 = ColorUtil.adjustBrightness2(_arg_2, -50);
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (16);
        }

        override public function get measuredHeight():Number
        {
            return (10);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_17:Array;
            var _local_18:Array;
            var _local_19:Array;
            var _local_20:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("backgroundColor");
            var _local_4:uint = getStyle("borderColor");
            var _local_5:Number = getStyle("cornerRadius");
            var _local_6:Array = getStyle("fillAlphas");
            var _local_7:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_7);
            var _local_8:Array = getStyle("highlightAlphas");
            var _local_9:uint = getStyle("themeColor");
            var _local_10:uint = 7305079;
            var _local_11:Object = calcDerivedStyles(_local_9, _local_4, _local_7[0], _local_7[1]);
            var _local_12:Number = Math.max((_local_5 - 1), 0);
            var _local_13:Object = {
                "tl":0,
                "tr":_local_12,
                "bl":0,
                "br":_local_12
            };
            _local_12 = Math.max((_local_12 - 1), 0);
            var _local_14:Object = {
                "tl":0,
                "tr":_local_12,
                "bl":0,
                "br":_local_12
            };
            var _local_15:Boolean = (((parent) && (parent.parent)) && (!(parent.parent.rotation == 0)));
            if (isNaN(_local_3))
            {
                _local_3 = 0xFFFFFF;
            };
            graphics.clear();
            drawRoundRect(1, 0, (_arg_1 - 3), _arg_2, _local_13, _local_3, 1);
            switch (name)
            {
                case "thumbUpSkin":
                default:
                    _local_17 = [_local_7[0], _local_7[1]];
                    _local_18 = [_local_6[0], _local_6[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 0);
                    if (_local_15)
                    {
                        drawRoundRect(1, 0, (_arg_1 - 2), _arg_2, _local_5, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 4),
                            "h":(_arg_2 - 2),
                            "r":_local_14
                        });
                    }
                    else
                    {
                        drawRoundRect(1, (_arg_2 - _local_12), (_arg_1 - 3), (_local_12 + 4), {
                            "tl":0,
                            "tr":0,
                            "bl":0,
                            "br":_local_12
                        }, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], ((_local_15) ? horizontalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8) : verticalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8)), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - _local_12),
                            "w":(_arg_1 - 4),
                            "h":_local_12,
                            "r":{
                                "tl":0,
                                "tr":0,
                                "bl":0,
                                "br":(_local_12 - 1)
                            }
                        });
                    };
                    drawRoundRect(1, 0, (_arg_1 - 3), _arg_2, _local_13, [_local_4, _local_11.borderColorDrk1], 1, ((_local_15) ? horizontalGradientMatrix(0, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 4),
                        "h":(_arg_2 - 2),
                        "r":_local_14
                    });
                    drawRoundRect(1, 1, (_arg_1 - 4), (_arg_2 - 2), _local_14, _local_17, _local_18, ((_local_15) ? horizontalGradientMatrix(1, 0, (_arg_1 - 2), (_arg_2 - 2)) : verticalGradientMatrix(1, 0, (_arg_1 - 2), (_arg_2 - 2))));
                    if (_local_15)
                    {
                        drawRoundRect(1, 0, ((_arg_1 - 4) / 2), (_arg_2 - 2), 0, [0xFFFFFF, 0xFFFFFF], _local_8, horizontalGradientMatrix(1, 1, (_arg_1 - 4), ((_arg_2 - 2) / 2)));
                    }
                    else
                    {
                        drawRoundRect(1, 1, (_arg_1 - 4), ((_arg_2 - 2) / 2), _local_14, [0xFFFFFF, 0xFFFFFF], _local_8, ((_local_15) ? horizontalGradientMatrix(1, 0, ((_arg_1 - 4) / 2), (_arg_2 - 2)) : verticalGradientMatrix(1, 1, (_arg_1 - 4), ((_arg_2 - 2) / 2))));
                    };
                    break;
                case "thumbOverSkin":
                    if (_local_7.length > 2)
                    {
                        _local_19 = [_local_7[2], _local_7[3]];
                    }
                    else
                    {
                        _local_19 = [_local_7[0], _local_7[1]];
                    };
                    if (_local_6.length > 2)
                    {
                        _local_20 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_20 = [_local_6[0], _local_6[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 0);
                    if (_local_15)
                    {
                        drawRoundRect(1, 0, (_arg_1 - 2), _arg_2, _local_5, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 4),
                            "h":(_arg_2 - 2),
                            "r":_local_14
                        });
                    }
                    else
                    {
                        drawRoundRect(1, (_arg_2 - _local_12), (_arg_1 - 3), (_local_12 + 4), {
                            "tl":0,
                            "tr":0,
                            "bl":0,
                            "br":_local_12
                        }, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], ((_local_15) ? horizontalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8) : verticalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8)), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - _local_12),
                            "w":(_arg_1 - 4),
                            "h":_local_12,
                            "r":{
                                "tl":0,
                                "tr":0,
                                "bl":0,
                                "br":(_local_12 - 1)
                            }
                        });
                    };
                    drawRoundRect(1, 0, (_arg_1 - 3), _arg_2, _local_13, [_local_9, _local_11.themeColDrk1], 1, ((_local_15) ? horizontalGradientMatrix(1, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 4),
                        "h":(_arg_2 - 2),
                        "r":_local_14
                    });
                    drawRoundRect(1, 1, (_arg_1 - 4), (_arg_2 - 2), _local_14, _local_19, _local_20, ((_local_15) ? horizontalGradientMatrix(1, 0, _arg_1, _arg_2) : verticalGradientMatrix(1, 0, _arg_1, _arg_2)));
                    break;
                case "thumbDownSkin":
                    if (_local_15)
                    {
                        drawRoundRect(1, 0, (_arg_1 - 2), _arg_2, _local_13, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 4),
                            "h":(_arg_2 - 2),
                            "r":_local_14
                        });
                    }
                    else
                    {
                        drawRoundRect(1, (_arg_2 - _local_12), (_arg_1 - 3), (_local_12 + 4), {
                            "tl":0,
                            "tr":0,
                            "bl":0,
                            "br":_local_12
                        }, [_local_11.borderColorDrk1, _local_11.borderColorDrk1], [1, 0], ((_local_15) ? horizontalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8) : verticalGradientMatrix(0, (_arg_2 - 4), (_arg_1 - 3), 8)), GradientType.LINEAR, null, {
                            "x":1,
                            "y":(_arg_2 - _local_12),
                            "w":(_arg_1 - 4),
                            "h":_local_12,
                            "r":{
                                "tl":0,
                                "tr":0,
                                "bl":0,
                                "br":(_local_12 - 1)
                            }
                        });
                    };
                    drawRoundRect(1, 0, (_arg_1 - 3), _arg_2, _local_13, [_local_9, _local_11.themeColDrk2], 1, ((_local_15) ? horizontalGradientMatrix(1, 0, _arg_1, _arg_2) : verticalGradientMatrix(0, 0, _arg_1, _arg_2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 4),
                        "h":(_arg_2 - 2),
                        "r":_local_14
                    });
                    drawRoundRect(1, 1, (_arg_1 - 4), (_arg_2 - 2), _local_14, [_local_11.fillColorPress1, _local_11.fillColorPress2], 1, ((_local_15) ? horizontalGradientMatrix(1, 0, _arg_1, _arg_2) : verticalGradientMatrix(1, 0, _arg_1, _arg_2)));
                    break;
                case "thumbDisabledSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, 0, 0xFFFFFF, 0);
                    drawRoundRect(1, 0, (_arg_1 - 3), _arg_2, _local_13, 0x999999, 0.5);
                    drawRoundRect(1, 1, (_arg_1 - 4), (_arg_2 - 2), _local_14, 0xFFFFFF, 0.5);
            };
            var _local_16:Number = Math.floor(((_arg_1 / 2) - 4));
            drawRoundRect(_local_16, Math.floor(((_arg_2 / 2) - 4)), 5, 1, 0, 0, 0.4);
            drawRoundRect(_local_16, Math.floor(((_arg_2 / 2) - 2)), 5, 1, 0, 0, 0.4);
            drawRoundRect(_local_16, Math.floor((_arg_2 / 2)), 5, 1, 0, 0, 0.4);
            drawRoundRect(_local_16, Math.floor(((_arg_2 / 2) + 2)), 5, 1, 0, 0, 0.4);
            drawRoundRect(_local_16, Math.floor(((_arg_2 / 2) + 4)), 5, 1, 0, 0, 0.4);
        }


    }
}//package mx.skins.halo

