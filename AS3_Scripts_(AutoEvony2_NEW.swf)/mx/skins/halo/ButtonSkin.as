// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ButtonSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.core.UIComponent;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import mx.core.IButton;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ButtonSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};


        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint):Object
        {
            var _local_5:Object;
            var _local_4:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3);
            if (!cache[_local_4])
            {
                _local_5 = (cache[_local_4] = {});
                HaloColors.addHaloColors(_local_5, _arg_1, _arg_2, _arg_3);
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
            var _local_16:Number;
            var _local_17:Array;
            var _local_18:Array;
            var _local_19:Array;
            var _local_20:Array;
            var _local_21:Array;
            var _local_22:Array;
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
                _local_12 = IButton(parent).emphasized;
            };
            var _local_13:Number = Math.max(0, _local_4);
            var _local_14:Number = Math.max(0, (_local_4 - 1));
            var _local_15:Number = Math.max(0, (_local_4 - 2));
            graphics.clear();
            switch (name)
            {
                case "selectedUpSkin":
                case "selectedOverSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_14, [_local_6[1], _local_6[1]], 1, verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    return;
                case "upSkin":
                    _local_17 = [_local_6[0], _local_6[1]];
                    _local_18 = [_local_5[0], _local_5[1]];
                    if (_local_12)
                    {
                        drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":2,
                            "y":2,
                            "w":(_arg_1 - 4),
                            "h":(_arg_2 - 4),
                            "r":(_local_4 - 2)
                        });
                        drawRoundRect(2, 2, (_arg_1 - 4), (_arg_2 - 4), _local_15, _local_17, _local_18, verticalGradientMatrix(2, 2, (_arg_1 - 2), (_arg_2 - 2)));
                        drawRoundRect(2, 2, (_arg_1 - 4), ((_arg_2 - 4) / 2), {
                            "tl":_local_15,
                            "tr":_local_15,
                            "bl":0,
                            "br":0
                        }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    }
                    else
                    {
                        drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_3, _local_10], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                            "x":1,
                            "y":1,
                            "w":(_arg_1 - 2),
                            "h":(_arg_2 - 2),
                            "r":(_local_4 - 1)
                        });
                        drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_14, _local_17, _local_18, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                        drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                            "tl":_local_14,
                            "tr":_local_14,
                            "bl":0,
                            "br":0
                        }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    };
                    return;
                case "overSkin":
                    if (_local_6.length > 2)
                    {
                        _local_19 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_19 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_20 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_20 = [_local_5[0], _local_5[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":(_local_4 - 1)
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_14, _local_19, _local_20, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_14,
                        "tr":_local_14,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "downSkin":
                case "selectedDownSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_8, _local_11], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_14, [_local_9.fillColorPress1, _local_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(2, 2, (_arg_1 - 4), ((_arg_2 - 4) / 2), {
                        "tl":_local_15,
                        "tr":_local_15,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "disabledSkin":
                case "selectedDisabledSkin":
                    _local_21 = [_local_6[0], _local_6[1]];
                    _local_22 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_13, [_local_3, _local_10], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":(_local_4 - 1)
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_14, _local_21, _local_22, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    return;
            };
        }


    }
}//package mx.skins.halo

