// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.TabSkin

package mx.skins.halo
{
    import mx.skins.Border;
    import mx.core.EdgeMetrics;
    import mx.utils.ColorUtil;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import mx.core.UIComponent;
    import flash.display.DisplayObjectContainer;
    import mx.styles.StyleManager;
    import mx.styles.IStyleClient;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TabSkin extends Border 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};
        private static var tabnavs:Object = {};

        private var _borderMetrics:EdgeMetrics = new EdgeMetrics(1, 1, 1, 1);


        private static function calcDerivedStyles(_arg_1:uint, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:uint, _arg_6:uint):Object
        {
            var _local_8:Object;
            var _local_7:String = HaloColors.getCacheKey(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            if (!cache[_local_7])
            {
                _local_8 = (cache[_local_7] = {});
                HaloColors.addHaloColors(_local_8, _arg_1, _arg_5, _arg_6);
                _local_8.borderColorDrk1 = ColorUtil.adjustBrightness2(_arg_2, 10);
                _local_8.falseFillColorBright1 = ColorUtil.adjustBrightness(_arg_3, 15);
                _local_8.falseFillColorBright2 = ColorUtil.adjustBrightness(_arg_4, 15);
            };
            return (cache[_local_7]);
        }

        private static function isTabNavigator(parent:Object):Boolean
        {
            var s:String;
            var x:XML;
            s = getQualifiedClassName(parent);
            if (tabnavs[s] == 1)
            {
                return (true);
            };
            if (tabnavs[s] == 0)
            {
                return (false);
            };
            if (s == "mx.containers::TabNavigator")
            {
                (tabnavs[s] == 1);
                return (true);
            };
            x = describeType(parent);
            var xmllist:XMLList = x.extendsClass.(@type == "mx.containers::TabNavigator");
            if (xmllist.length() == 0)
            {
                tabnavs[s] = 0;
                return (false);
            };
            tabnavs[s] = 1;
            return (true);
        }


        override public function get measuredWidth():Number
        {
            return (UIComponent.DEFAULT_MEASURED_MIN_WIDTH);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_19:Array;
            var _local_20:Array;
            var _local_21:Array;
            var _local_22:Array;
            var _local_23:Array;
            var _local_24:Array;
            var _local_25:DisplayObjectContainer;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = getStyle("backgroundAlpha");
            var _local_4:Number = getStyle("backgroundColor");
            var _local_5:uint = getStyle("borderColor");
            var _local_6:Number = getStyle("cornerRadius");
            var _local_7:Array = getStyle("fillAlphas");
            var _local_8:Array = getStyle("fillColors");
            StyleManager.getColorNames(_local_8);
            var _local_9:Array = getStyle("highlightAlphas");
            var _local_10:uint = getStyle("themeColor");
            var _local_11:Array = [];
            _local_11[0] = ColorUtil.adjustBrightness2(_local_8[0], -5);
            _local_11[1] = ColorUtil.adjustBrightness2(_local_8[1], -5);
            var _local_12:Object = calcDerivedStyles(_local_10, _local_5, _local_11[0], _local_11[1], _local_8[0], _local_8[1]);
            var _local_13:Boolean = ((((!(parent == null)) && (!(parent.parent == null))) && (!(parent.parent.parent == null))) && (isTabNavigator(parent.parent.parent)));
            var _local_14:Number = 1;
            if (_local_13)
            {
                _local_14 = Object(parent.parent.parent).borderMetrics.top;
            };
            var _local_15:Boolean = (((_local_13) && (!(IStyleClient(parent.parent.parent).getStyle("borderStyle") == "none"))) && (_local_14 >= 0));
            var _local_16:Number = Math.max((_local_6 - 2), 0);
            var _local_17:Object = {
                "tl":_local_6,
                "tr":_local_6,
                "bl":0,
                "br":0
            };
            var _local_18:Object = {
                "tl":_local_16,
                "tr":_local_16,
                "bl":0,
                "br":0
            };
            graphics.clear();
            switch (name)
            {
                case "upSkin":
                    _local_19 = [_local_11[0], _local_11[1]];
                    _local_20 = [_local_7[0], _local_7[1]];
                    drawRoundRect(0, 0, _arg_1, (_arg_2 - 1), _local_17, [_local_12.borderColorDrk1, _local_5], 1, verticalGradientMatrix(0, 0, _arg_1, _arg_2), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_18
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_18, _local_19, _local_20, verticalGradientMatrix(0, 2, (_arg_1 - 2), (_arg_2 - 6)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), _local_18, [0xFFFFFF, 0xFFFFFF], _local_9, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    if (_local_15)
                    {
                        drawRoundRect(0, (_arg_2 - _local_14), _arg_1, _local_14, 0, _local_5, _local_7[1]);
                    };
                    drawRoundRect(0, (_arg_2 - 2), _arg_1, 1, 0, 0, 0.09);
                    drawRoundRect(0, (_arg_2 - 3), _arg_1, 1, 0, 0, 0.03);
                    return;
                case "overSkin":
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
                    drawRoundRect(0, 0, _arg_1, (_arg_2 - 1), _local_17, [_local_10, _local_12.themeColDrk2], 1, verticalGradientMatrix(0, 0, _arg_1, (_arg_2 - 6)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_18
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_18, [_local_12.falseFillColorBright1, _local_12.falseFillColorBright2], _local_22, verticalGradientMatrix(2, 2, (_arg_1 - 2), (_arg_2 - 2)));
                    drawRoundRect(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2), _local_18, [0xFFFFFF, 0xFFFFFF], _local_9, verticalGradientMatrix(1, 1, (_arg_1 - 2), ((_arg_2 - 2) / 2)));
                    if (_local_15)
                    {
                        drawRoundRect(0, (_arg_2 - _local_14), _arg_1, _local_14, 0, _local_5, _local_7[1]);
                    };
                    drawRoundRect(0, (_arg_2 - 2), _arg_1, 1, 0, 0, 0.09);
                    drawRoundRect(0, (_arg_2 - 3), _arg_1, 1, 0, 0, 0.03);
                    return;
                case "disabledSkin":
                    _local_23 = [_local_8[0], _local_8[1]];
                    _local_24 = [Math.max(0, (_local_7[0] - 0.15)), Math.max(0, (_local_7[1] - 0.15))];
                    drawRoundRect(0, 0, _arg_1, (_arg_2 - 1), _local_17, [_local_12.borderColorDrk1, _local_5], 0.5, verticalGradientMatrix(0, 0, _arg_1, (_arg_2 - 6)));
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_18, _local_23, _local_24, verticalGradientMatrix(0, 2, (_arg_1 - 2), (_arg_2 - 2)));
                    if (_local_15)
                    {
                        drawRoundRect(0, (_arg_2 - _local_14), _arg_1, _local_14, 0, _local_5, _local_7[1]);
                    };
                    drawRoundRect(0, (_arg_2 - 2), _arg_1, 1, 0, 0, 0.09);
                    drawRoundRect(0, (_arg_2 - 3), _arg_1, 1, 0, 0, 0.03);
                    return;
                case "downSkin":
                case "selectedUpSkin":
                case "selectedDownSkin":
                case "selectedOverSkin":
                case "selectedDisabledSkin":
                    if (isNaN(_local_4))
                    {
                        _local_25 = parent;
                        while (_local_25)
                        {
                            if ((_local_25 is IStyleClient))
                            {
                                _local_4 = IStyleClient(_local_25).getStyle("backgroundColor");
                            };
                            if (!isNaN(_local_4)) break;
                            _local_25 = _local_25.parent;
                        };
                        if (isNaN(_local_4))
                        {
                            _local_4 = 0xFFFFFF;
                        };
                    };
                    drawRoundRect(0, 0, _arg_1, (_arg_2 - 1), _local_17, [_local_12.borderColorDrk1, _local_5], 1, verticalGradientMatrix(0, 0, _arg_1, (_arg_2 - 2)), GradientType.LINEAR, null, {
                        "x":1,
                        "y":1,
                        "w":(_arg_1 - 2),
                        "h":(_arg_2 - 2),
                        "r":_local_18
                    });
                    drawRoundRect(1, 1, (_arg_1 - 2), (_arg_2 - 2), _local_18, _local_4, _local_3);
                    if (_local_15)
                    {
                        drawRoundRect(1, (_arg_2 - _local_14), (_arg_1 - 2), _local_14, 0, _local_4, _local_3);
                    };
                    return;
            };
        }

        override public function get measuredHeight():Number
        {
            return (UIComponent.DEFAULT_MEASURED_MIN_HEIGHT);
        }

        override public function get borderMetrics():EdgeMetrics
        {
            return (_borderMetrics);
        }


    }
}//package mx.skins.halo

