// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ComboBoxArrowSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.styles.StyleManager;
    import mx.utils.ColorUtil;
    import flash.display.Graphics;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ComboBoxArrowSkin extends Border 
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
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (22);
        }

        override public function get measuredHeight():Number
        {
            return (22);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_19:Array;
            var _local_20:Array;
            var _local_21:Array;
            var _local_22:Array;
            var _local_23:Array;
            var _local_24:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:uint = getStyle("iconColor");
            var _local_4:uint = getStyle("borderColor");
            var _local_5:Number = getStyle("cornerRadius");
            var _local_6:Number = getStyle("dropdownBorderColor");
            var _local_7:Array = getStyle("fillAlphas");
            var _local_8:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_8);
            var _local_9:Array = getStyle("highlightAlphas");
            var _local_10:uint = getStyle("themeColor");
            if (!isNaN(_local_6))
            {
                _local_4 = _local_6;
            };
            var _local_11:Object = calcDerivedStyles(_local_10, _local_4, _local_8[0], _local_8[1]);
            var _local_12:Number = ColorUtil.adjustBrightness2(_local_4, -50);
            var _local_13:Number = ColorUtil.adjustBrightness2(_local_10, -25);
            var _local_14:Number = Math.max((_local_5 - 1), 0);
            var _local_15:Object = {
                "tl":0,
                "tr":_local_5,
                "bl":0,
                "br":_local_5
            };
            var _local_16:Object = {
                "tl":0,
                "tr":_local_14,
                "bl":0,
                "br":_local_14
            };
            var _local_17:Boolean = true;
            if (name.indexOf("editable") < 0)
            {
                _local_17 = false;
                _local_15.tl = (_local_15.bl = _local_5);
                _local_16.tl = (_local_16.bl = _local_14);
            };
            var _local_18:Graphics = graphics;
            _local_18.clear();
            switch (name)
            {
                case "upSkin":
                case "editableUpSkin":
                    _local_19 = [_local_8[0], _local_8[1]];
                    _local_20 = [_local_7[0], _local_7[1]];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_15, [_local_4, _local_12], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_16
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_16, _local_19, _local_20, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_14,
                        "tr":_local_14,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_9, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    if (!_local_17)
                    {
                        drawRoundRect((_arg_1 - 22), 4, 1, (_arg_2 - 8), 0, _local_4, 1);
                        drawRoundRect((_arg_1 - 21), 4, 1, (_arg_2 - 8), 0, 0xFFFFFF, 0.2);
                    };
                    break;
                case "overSkin":
                case "editableOverSkin":
                    if (_local_8.length > 2)
                    {
                        _local_21 = [_local_8[2], _local_8[3]];
                    }
                    else
                    {
                        _local_21 = [_local_8[0], _local_8[1]];
                    };
                    if (_local_7.length > 2)
                    {
                        _local_22 = [_local_7[2], _local_7[3]];
                    }
                    else
                    {
                        _local_22 = [_local_7[0], _local_7[1]];
                    };
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_15, [_local_10, _local_13], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_16
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_16, _local_21, _local_22, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_14,
                        "tr":_local_14,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_9, verticalGradientMatrix(0, 0, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    if (!_local_17)
                    {
                        drawRoundRect((_arg_1 - 22), 4, 1, (_arg_2 - 8), 0, _local_11.themeColDrk2, 1);
                        drawRoundRect((_arg_1 - 21), 4, 1, (_arg_2 - 8), 0, 0xFFFFFF, 0.2);
                    };
                    break;
                case "downSkin":
                case "editableDownSkin":
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_15, [_local_10, _local_13], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_16, [_local_11.fillColorPress1, _local_11.fillColorPress2], 1, verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_14,
                        "tr":_local_14,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_9, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    if (!_local_17)
                    {
                        drawRoundRect((_arg_1 - 22), 4, 1, (_arg_2 - 8), 0, _local_13, 1);
                        drawRoundRect((_arg_1 - 21), 4, 1, (_arg_2 - 8), 0, 0xFFFFFF, 0.2);
                    };
                    break;
                case "disabledSkin":
                case "editableDisabledSkin":
                    _local_23 = [_local_8[0], _local_8[1]];
                    _local_24 = [Math.max(0, (_local_7[0] - 0.15)), Math.max(0, (_local_7[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, _arg_2, _local_15, [_local_4, _local_12], 0.5, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_16
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_16, _local_23, _local_24, verticalGradientMatrix(0, 0, (_arg_1 - 2), (_arg_2 - 2)));
                    if (!_local_17)
                    {
                        drawRoundRect((_arg_1 - 22), 4, 1, (_arg_2 - 8), 0, 0x999999, 0.5);
                    };
                    _local_3 = getStyle("disabledIconColor");
                    break;
            };
            _local_18.beginFill(_local_3);
            _local_18.moveTo((_arg_1 - 11.5), ((_arg_2 / 2) + 3));
            _local_18.lineTo((_arg_1 - 15), ((_arg_2 / 2) - 2));
            _local_18.lineTo((_arg_1 - 8), ((_arg_2 / 2) - 2));
            _local_18.lineTo((_arg_1 - 11.5), ((_arg_2 / 2) + 3));
            _local_18.endFill();
        }


    }
}//package mx.skins.halo

