// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.RadioButtonIcon

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.utils.ColorUtil;
    import mx.styles.StyleManager;
    import flash.display.Graphics;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RadioButtonIcon extends Border 
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
                _local_6.borderColorDrk1 = ColorUtil.adjustBrightness2(_arg_2, -60);
            };
            return (cache[_local_5]);
        }


        override public function get measuredWidth():Number
        {
            return (14);
        }

        override public function get measuredHeight():Number
        {
            return (14);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:Array;
            var _local_16:Array;
            var _local_18:Array;
            var _local_19:Array;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:uint = getStyle("iconColor");
            var _local_4:uint = getStyle("borderColor");
            var _local_5:Array = getStyle("fillAlphas");
            var _local_6:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_6);
            var _local_7:Array = getStyle("highlightAlphas");
            var _local_8:uint = getStyle("themeColor");
            var _local_9:Object = calcDerivedStyles(_local_8, _local_4, _local_6[0], _local_6[1]);
            var _local_10:Number = ColorUtil.adjustBrightness2(_local_4, -50);
            var _local_11:Number = ColorUtil.adjustBrightness2(_local_8, -25);
            var _local_12:Number = (width / 2);
            var _local_17:Graphics = graphics;
            _local_17.clear();
            switch (name)
            {
                case "upIcon":
                    _local_13 = [_local_6[0], _local_6[1]];
                    _local_14 = [_local_5[0], _local_5[1]];
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_4, _local_10], [100, 100], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, _local_13, _local_14, [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_12,
                        "tr":_local_12,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(0, 0, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "overIcon":
                    if (_local_6.length > 2)
                    {
                        _local_18 = [_local_6[2], _local_6[3]];
                    }
                    else
                    {
                        _local_18 = [_local_6[0], _local_6[1]];
                    };
                    if (_local_5.length > 2)
                    {
                        _local_19 = [_local_5[2], _local_5[3]];
                    }
                    else
                    {
                        _local_19 = [_local_5[0], _local_5[1]];
                    };
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_8, _local_11], [100, 100], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, _local_18, _local_19, [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_12,
                        "tr":_local_12,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(0, 0, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "downIcon":
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_8, _local_11], [100, 100], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_9.fillColorPress1, _local_9.fillColorPress2], [100, 100], [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_12,
                        "tr":_local_12,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(0, 0, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    return;
                case "disabledIcon":
                    _local_15 = [_local_6[0], _local_6[1]];
                    _local_16 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_4, _local_10], [0.5, 0.5], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, _local_15, _local_16, [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    return;
                case "selectedUpIcon":
                case "selectedOverIcon":
                case "selectedDownIcon":
                    _local_13 = [_local_6[0], _local_6[1]];
                    _local_14 = [_local_5[0], _local_5[1]];
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_4, _local_10], [100, 100], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, _local_13, _local_14, [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), {
                        "tl":_local_12,
                        "tr":_local_12,
                        "bl":0,
                        "br":0
                    }, [0xFFFFFF, 0xFFFFFF], _local_7, verticalGradientMatrix(0, 0, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    _local_17.beginFill(_local_3);
                    _local_17.drawCircle(_local_12, _local_12, 2);
                    _local_17.endFill();
                    return;
                case "selectedDisabledIcon":
                    _local_15 = [_local_6[0], _local_6[1]];
                    _local_16 = [Math.max(0, (_local_5[0] - 0.15)), Math.max(0, (_local_5[1] - 0.15))];
                    _local_17.beginGradientFill(GradientType.LINEAR, [_local_4, _local_10], [0.5, 0.5], [0, 0xFF], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                    _local_17.drawCircle(_local_12, _local_12, _local_12);
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_17.beginGradientFill(GradientType.LINEAR, _local_15, _local_16, [0, 0xFF], verticalGradientMatrix(1, 1, (_arg_1 - 2), (_arg_2 - 2)));
                    _local_17.drawCircle(_local_12, _local_12, (_local_12 - 1));
                    _local_17.endFill();
                    _local_3 = getStyle("disabledIconColor");
                    _local_17.beginFill(_local_3);
                    _local_17.drawCircle(_local_12, _local_12, 2);
                    _local_17.endFill();
                    return;
            };
        }


    }
}//package mx.skins.halo

