// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.HaloBorder

package mx.skins.halo
{
    import mx.skins.RectangularBorder;
    import mx.graphics.RectangularDropShadow;
    import mx.core.EdgeMetrics;
    import mx.core.IContainer;
    import flash.display.Graphics;
    import mx.utils.ColorUtil;
    import mx.core.FlexVersion;
    import mx.styles.IStyleClient;
    import mx.styles.StyleManager;
    import flash.display.GradientType;
    import mx.core.IUIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HaloBorder extends RectangularBorder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var BORDER_WIDTHS:Object = {
            "none":0,
            "solid":1,
            "inset":2,
            "outset":2,
            "alert":3,
            "dropdown":2,
            "menuBorder":1,
            "comboNonEdit":2
        };

        mx_internal var radiusObj:Object;
        mx_internal var backgroundHole:Object;
        mx_internal var radius:Number;
        mx_internal var bRoundedCorners:Boolean;
        mx_internal var backgroundColor:Object;
        private var dropShadow:RectangularDropShadow;
        protected var _borderMetrics:EdgeMetrics;
        mx_internal var backgroundAlphaName:String;

        public function HaloBorder()
        {
            BORDER_WIDTHS["default"] = 3;
        }

        override public function styleChanged(_arg_1:String):void
        {
            if ((((((_arg_1 == null) || (_arg_1 == "styleName")) || (_arg_1 == "borderStyle")) || (_arg_1 == "borderThickness")) || (_arg_1 == "borderSides")))
            {
                _borderMetrics = null;
            };
            invalidateDisplayList();
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            if (((isNaN(_arg_1)) || (isNaN(_arg_2))))
            {
                return;
            };
            super.updateDisplayList(_arg_1, _arg_2);
            backgroundColor = getBackgroundColor();
            bRoundedCorners = false;
            backgroundAlphaName = "backgroundAlpha";
            backgroundHole = null;
            radius = 0;
            radiusObj = null;
            drawBorder(_arg_1, _arg_2);
            drawBackground(_arg_1, _arg_2);
        }

        mx_internal function drawBorder(_arg_1:Number, _arg_2:Number):void
        {
            var _local_5:Number;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:String;
            var _local_9:Number;
            var _local_10:uint;
            var _local_11:Boolean;
            var _local_12:uint;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:uint;
            var _local_16:uint;
            var _local_17:uint;
            var _local_18:uint;
            var _local_19:Boolean;
            var _local_20:Object;
            var _local_22:Number;
            var _local_23:Number;
            var _local_24:Number;
            var _local_25:Object;
            var _local_27:Number;
            var _local_28:Number;
            var _local_29:IContainer;
            var _local_30:EdgeMetrics;
            var _local_31:Boolean;
            var _local_32:Number;
            var _local_33:Array;
            var _local_34:uint;
            var _local_35:Boolean;
            var _local_36:Number;
            var _local_3:String = getStyle("borderStyle");
            var _local_4:Array = getStyle("highlightAlphas");
            var _local_21:Boolean;
            var _local_26:Graphics = graphics;
            _local_26.clear();
            if (_local_3)
            {
                switch (_local_3)
                {
                    case "none":
                        return;
                    case "inset":
                        _local_7 = getStyle("borderColor");
                        _local_22 = ColorUtil.adjustBrightness2(_local_7, -40);
                        _local_23 = ColorUtil.adjustBrightness2(_local_7, 25);
                        _local_24 = ColorUtil.adjustBrightness2(_local_7, 40);
                        _local_25 = backgroundColor;
                        if (((_local_25 === null) || (_local_25 === "")))
                        {
                            _local_25 = _local_7;
                        };
                        draw3dBorder(_local_23, _local_22, _local_24, Number(_local_25), Number(_local_25), Number(_local_25));
                        return;
                    case "outset":
                        _local_7 = getStyle("borderColor");
                        _local_22 = ColorUtil.adjustBrightness2(_local_7, -40);
                        _local_23 = ColorUtil.adjustBrightness2(_local_7, -25);
                        _local_24 = ColorUtil.adjustBrightness2(_local_7, 40);
                        _local_25 = backgroundColor;
                        if (((_local_25 === null) || (_local_25 === "")))
                        {
                            _local_25 = _local_7;
                        };
                        draw3dBorder(_local_23, _local_24, _local_22, Number(_local_25), Number(_local_25), Number(_local_25));
                        return;
                    case "alert":
                    case "default":
                        if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                        {
                            _local_27 = getStyle("backgroundAlpha");
                            _local_5 = getStyle("borderAlpha");
                            backgroundAlphaName = "borderAlpha";
                            radius = getStyle("cornerRadius");
                            bRoundedCorners = (getStyle("roundedBottomCorners").toString().toLowerCase() == "true");
                            _local_28 = ((bRoundedCorners) ? radius : 0);
                            drawDropShadow(0, 0, _arg_1, _arg_2, radius, radius, _local_28, _local_28);
                            if (!bRoundedCorners)
                            {
                                radiusObj = {};
                            };
                            _local_29 = (parent as IContainer);
                            if (_local_29)
                            {
                                _local_30 = _local_29.viewMetrics;
                                backgroundHole = {
                                    "x":_local_30.left,
                                    "y":_local_30.top,
                                    "w":Math.max(0, ((_arg_1 - _local_30.left) - _local_30.right)),
                                    "h":Math.max(0, ((_arg_2 - _local_30.top) - _local_30.bottom)),
                                    "r":0
                                };
                                if (((backgroundHole.w > 0) && (backgroundHole.h > 0)))
                                {
                                    if (_local_27 != _local_5)
                                    {
                                        drawDropShadow(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h, 0, 0, 0, 0);
                                    };
                                    _local_26.beginFill(Number(backgroundColor), _local_27);
                                    _local_26.drawRect(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h);
                                    _local_26.endFill();
                                };
                            };
                            backgroundColor = getStyle("borderColor");
                        };
                        return;
                    case "dropdown":
                        _local_12 = getStyle("dropdownBorderColor");
                        drawDropShadow(0, 0, _arg_1, _arg_2, 4, 0, 0, 4);
                        drawRoundRect(0, 0, _arg_1, _arg_2, {
                            "tl":4,
                            "tr":0,
                            "br":0,
                            "bl":4
                        }, 5068126, 1);
                        drawRoundRect(0, 0, _arg_1, _arg_2, {
                            "tl":4,
                            "tr":0,
                            "br":0,
                            "bl":4
                        }, [0xFFFFFF, 0xFFFFFF], [0.7, 0], verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                        drawRoundRect(1, 1, (_arg_1 - 1), (_arg_2 - 2), {
                            "tl":3,
                            "tr":0,
                            "br":0,
                            "bl":3
                        }, 0xFFFFFF, 1);
                        drawRoundRect(1, 2, (_arg_1 - 1), (_arg_2 - 3), {
                            "tl":3,
                            "tr":0,
                            "br":0,
                            "bl":3
                        }, [0xEEEEEE, 0xFFFFFF], 1, verticalGradientMatrix(0, 0, (_arg_1 - 1), (_arg_2 - 3)));
                        if (!isNaN(_local_12))
                        {
                            drawRoundRect(0, 0, (_arg_1 + 1), _arg_2, {
                                "tl":4,
                                "tr":0,
                                "br":0,
                                "bl":4
                            }, _local_12, 0.5);
                            drawRoundRect(1, 1, (_arg_1 - 1), (_arg_2 - 2), {
                                "tl":3,
                                "tr":0,
                                "br":0,
                                "bl":3
                            }, 0xFFFFFF, 1);
                            drawRoundRect(1, 2, (_arg_1 - 1), (_arg_2 - 3), {
                                "tl":3,
                                "tr":0,
                                "br":0,
                                "bl":3
                            }, [0xEEEEEE, 0xFFFFFF], 1, verticalGradientMatrix(0, 0, (_arg_1 - 1), (_arg_2 - 3)));
                        };
                        backgroundColor = null;
                        return;
                    case "menuBorder":
                        _local_7 = getStyle("borderColor");
                        drawRoundRect(0, 0, _arg_1, _arg_2, 0, _local_7, 1);
                        drawDropShadow(1, 1, (_arg_1 - 2), (_arg_2 - 2), 0, 0, 0, 0);
                        return;
                    case "comboNonEdit":
                        return;
                    case "controlBar":
                        if (((_arg_1 == 0) || (_arg_2 == 0)))
                        {
                            backgroundColor = null;
                            return;
                        };
                        _local_14 = getStyle("footerColors");
                        _local_31 = (!(_local_14 == null));
                        _local_32 = getStyle("borderAlpha");
                        if (_local_31)
                        {
                            _local_26.lineStyle(0, ((_local_14.length > 0) ? _local_14[1] : _local_14[0]), _local_32);
                            _local_26.moveTo(0, 0);
                            _local_26.lineTo(_arg_1, 0);
                            _local_26.lineStyle(0, 0, 0);
                            if ((((parent) && (parent.parent)) && (parent.parent is IStyleClient)))
                            {
                                radius = IStyleClient(parent.parent).getStyle("cornerRadius");
                                _local_32 = IStyleClient(parent.parent).getStyle("borderAlpha");
                            };
                            if (isNaN(radius))
                            {
                                radius = 0;
                            };
                            if (IStyleClient(parent.parent).getStyle("roundedBottomCorners").toString().toLowerCase() != "true")
                            {
                                radius = 0;
                            };
                            drawRoundRect(0, 1, _arg_1, (_arg_2 - 1), {
                                "tl":0,
                                "tr":0,
                                "bl":radius,
                                "br":radius
                            }, _local_14, _local_32, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                            if (((_local_14.length > 1) && (!(_local_14[0] == _local_14[1]))))
                            {
                                drawRoundRect(0, 1, _arg_1, (_arg_2 - 1), {
                                    "tl":0,
                                    "tr":0,
                                    "bl":radius,
                                    "br":radius
                                }, [0xFFFFFF, 0xFFFFFF], _local_4, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                                drawRoundRect(1, 2, (_arg_1 - 2), (_arg_2 - 3), {
                                    "tl":0,
                                    "tr":0,
                                    "bl":(radius - 1),
                                    "br":(radius - 1)
                                }, _local_14, _local_32, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                            };
                        };
                        backgroundColor = null;
                        return;
                    case "applicationControlBar":
                        _local_13 = getStyle("fillColors");
                        _local_5 = getStyle("backgroundAlpha");
                        _local_4 = getStyle("highlightAlphas");
                        _local_33 = getStyle("fillAlphas");
                        _local_11 = getStyle("docked");
                        _local_34 = uint(backgroundColor);
                        radius = getStyle("cornerRadius");
                        if (!radius)
                        {
                            radius = 0;
                        };
                        drawDropShadow(0, 1, _arg_1, (_arg_2 - 1), radius, radius, radius, radius);
                        if (((!(backgroundColor === null)) && (StyleManager.isValidStyleValue(backgroundColor))))
                        {
                            drawRoundRect(0, 1, _arg_1, (_arg_2 - 1), radius, _local_34, _local_5, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                        };
                        drawRoundRect(0, 1, _arg_1, (_arg_2 - 1), radius, _local_13, _local_33, verticalGradientMatrix(0, 0, _arg_1, _arg_2));
                        drawRoundRect(0, 1, _arg_1, ((_arg_2 / 2) - 1), {
                            "tl":radius,
                            "tr":radius,
                            "bl":0,
                            "br":0
                        }, [0xFFFFFF, 0xFFFFFF], _local_4, verticalGradientMatrix(0, 0, _arg_1, ((_arg_2 / 2) - 1)));
                        drawRoundRect(0, 1, _arg_1, (_arg_2 - 1), {
                            "tl":radius,
                            "tr":radius,
                            "bl":0,
                            "br":0
                        }, 0xFFFFFF, 0.3, null, GradientType.LINEAR, null, {
                            "x":0,
                            "y":2,
                            "w":_arg_1,
                            "h":(_arg_2 - 2),
                            "r":{
                                "tl":radius,
                                "tr":radius,
                                "bl":0,
                                "br":0
                            }
                        });
                        backgroundColor = null;
                        return;
                    default:
                        _local_7 = getStyle("borderColor");
                        _local_9 = getStyle("borderThickness");
                        _local_8 = getStyle("borderSides");
                        _local_35 = true;
                        radius = getStyle("cornerRadius");
                        bRoundedCorners = (getStyle("roundedBottomCorners").toString().toLowerCase() == "true");
                        _local_36 = Math.max((radius - _local_9), 0);
                        _local_20 = {
                            "x":_local_9,
                            "y":_local_9,
                            "w":(_arg_1 - (_local_9 * 2)),
                            "h":(_arg_2 - (_local_9 * 2)),
                            "r":_local_36
                        };
                        if (!bRoundedCorners)
                        {
                            radiusObj = {
                                "tl":radius,
                                "tr":radius,
                                "bl":0,
                                "br":0
                            };
                            _local_20.r = {
                                "tl":_local_36,
                                "tr":_local_36,
                                "bl":0,
                                "br":0
                            };
                        };
                        if (_local_8 != "left top right bottom")
                        {
                            _local_20.r = {
                                "tl":_local_36,
                                "tr":_local_36,
                                "bl":((bRoundedCorners) ? _local_36 : 0),
                                "br":((bRoundedCorners) ? _local_36 : 0)
                            };
                            radiusObj = {
                                "tl":radius,
                                "tr":radius,
                                "bl":((bRoundedCorners) ? radius : 0),
                                "br":((bRoundedCorners) ? radius : 0)
                            };
                            _local_8 = _local_8.toLowerCase();
                            if (_local_8.indexOf("left") == -1)
                            {
                                _local_20.x = 0;
                                _local_20.w = (_local_20.w + _local_9);
                                _local_20.r.tl = 0;
                                _local_20.r.bl = 0;
                                radiusObj.tl = 0;
                                radiusObj.bl = 0;
                                _local_35 = false;
                            };
                            if (_local_8.indexOf("top") == -1)
                            {
                                _local_20.y = 0;
                                _local_20.h = (_local_20.h + _local_9);
                                _local_20.r.tl = 0;
                                _local_20.r.tr = 0;
                                radiusObj.tl = 0;
                                radiusObj.tr = 0;
                                _local_35 = false;
                            };
                            if (_local_8.indexOf("right") == -1)
                            {
                                _local_20.w = (_local_20.w + _local_9);
                                _local_20.r.tr = 0;
                                _local_20.r.br = 0;
                                radiusObj.tr = 0;
                                radiusObj.br = 0;
                                _local_35 = false;
                            };
                            if (_local_8.indexOf("bottom") == -1)
                            {
                                _local_20.h = (_local_20.h + _local_9);
                                _local_20.r.bl = 0;
                                _local_20.r.br = 0;
                                radiusObj.bl = 0;
                                radiusObj.br = 0;
                                _local_35 = false;
                            };
                        };
                        if (((radius == 0) && (_local_35)))
                        {
                            drawDropShadow(0, 0, _arg_1, _arg_2, 0, 0, 0, 0);
                            _local_26.beginFill(_local_7);
                            _local_26.drawRect(0, 0, _arg_1, _arg_2);
                            _local_26.drawRect(_local_9, _local_9, (_arg_1 - (2 * _local_9)), (_arg_2 - (2 * _local_9)));
                            _local_26.endFill();
                        }
                        else
                        {
                            if (radiusObj)
                            {
                                drawDropShadow(0, 0, _arg_1, _arg_2, radiusObj.tl, radiusObj.tr, radiusObj.br, radiusObj.bl);
                                drawRoundRect(0, 0, _arg_1, _arg_2, radiusObj, _local_7, 1, null, null, null, _local_20);
                                radiusObj.tl = Math.max((radius - _local_9), 0);
                                radiusObj.tr = Math.max((radius - _local_9), 0);
                                radiusObj.bl = ((bRoundedCorners) ? Math.max((radius - _local_9), 0) : 0);
                                radiusObj.br = ((bRoundedCorners) ? Math.max((radius - _local_9), 0) : 0);
                            }
                            else
                            {
                                drawDropShadow(0, 0, _arg_1, _arg_2, radius, radius, radius, radius);
                                drawRoundRect(0, 0, _arg_1, _arg_2, radius, _local_7, 1, null, null, null, _local_20);
                                radius = Math.max((getStyle("cornerRadius") - _local_9), 0);
                            };
                        };
                };
            };
        }

        mx_internal function drawBackground(_arg_1:Number, _arg_2:Number):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:EdgeMetrics;
            var _local_7:Graphics;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Array;
            var _local_12:Number;
            if (((((!(backgroundColor === null)) && (!(backgroundColor === ""))) || (getStyle("mouseShield"))) || (getStyle("mouseShieldChildren"))))
            {
                _local_4 = Number(backgroundColor);
                _local_5 = 1;
                _local_6 = getBackgroundColorMetrics();
                _local_7 = graphics;
                if ((((isNaN(_local_4)) || (backgroundColor === "")) || (backgroundColor === null)))
                {
                    _local_5 = 0;
                    _local_4 = 0xFFFFFF;
                }
                else
                {
                    _local_5 = getStyle(backgroundAlphaName);
                };
                if (((!(radius == 0)) || (backgroundHole)))
                {
                    _local_8 = _local_6.bottom;
                    if (radiusObj)
                    {
                        _local_9 = Math.max((radius - Math.max(_local_6.top, _local_6.left, _local_6.right)), 0);
                        _local_10 = ((bRoundedCorners) ? Math.max((radius - Math.max(_local_6.bottom, _local_6.left, _local_6.right)), 0) : 0);
                        radiusObj = {
                            "tl":_local_9,
                            "tr":_local_9,
                            "bl":_local_10,
                            "br":_local_10
                        };
                        drawRoundRect(_local_6.left, _local_6.top, (width - (_local_6.left + _local_6.right)), (height - (_local_6.top + _local_8)), radiusObj, _local_4, _local_5, null, GradientType.LINEAR, null, backgroundHole);
                    }
                    else
                    {
                        drawRoundRect(_local_6.left, _local_6.top, (width - (_local_6.left + _local_6.right)), (height - (_local_6.top + _local_8)), radius, _local_4, _local_5, null, GradientType.LINEAR, null, backgroundHole);
                    };
                }
                else
                {
                    _local_7.beginFill(_local_4, _local_5);
                    _local_7.drawRect(_local_6.left, _local_6.top, ((_arg_1 - _local_6.right) - _local_6.left), ((_arg_2 - _local_6.bottom) - _local_6.top));
                    _local_7.endFill();
                };
            };
            var _local_3:String = getStyle("borderStyle");
            if ((((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) && ((_local_3 == "alert") || (_local_3 == "default"))) && (getStyle("headerColors") == null)))
            {
                _local_11 = getStyle("highlightAlphas");
                _local_12 = ((_local_11) ? _local_11[0] : 0.3);
                drawRoundRect(0, 0, _arg_1, _arg_2, {
                    "tl":radius,
                    "tr":radius,
                    "bl":0,
                    "br":0
                }, 0xFFFFFF, _local_12, null, GradientType.LINEAR, null, {
                    "x":0,
                    "y":1,
                    "w":_arg_1,
                    "h":(_arg_2 - 1),
                    "r":{
                        "tl":radius,
                        "tr":radius,
                        "bl":0,
                        "br":0
                    }
                });
            };
        }

        mx_internal function drawDropShadow(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number):void
        {
            var _local_11:Number;
            var _local_12:Boolean;
            if (((((getStyle("dropShadowEnabled") == false) || (getStyle("dropShadowEnabled") == "false")) || (_arg_3 == 0)) || (_arg_4 == 0)))
            {
                return;
            };
            var _local_9:Number = getStyle("shadowDistance");
            var _local_10:String = getStyle("shadowDirection");
            if (getStyle("borderStyle") == "applicationControlBar")
            {
                _local_12 = getStyle("docked");
                _local_11 = ((_local_12) ? 90 : getDropShadowAngle(_local_9, _local_10));
                _local_9 = Math.abs(_local_9);
            }
            else
            {
                _local_11 = getDropShadowAngle(_local_9, _local_10);
                _local_9 = (Math.abs(_local_9) + 2);
            };
            if (!dropShadow)
            {
                dropShadow = new RectangularDropShadow();
            };
            dropShadow.distance = _local_9;
            dropShadow.angle = _local_11;
            dropShadow.color = getStyle("dropShadowColor");
            dropShadow.alpha = 0.4;
            dropShadow.tlRadius = _arg_5;
            dropShadow.trRadius = _arg_6;
            dropShadow.blRadius = _arg_8;
            dropShadow.brRadius = _arg_7;
            dropShadow.drawShadow(graphics, _arg_1, _arg_2, _arg_3, _arg_4);
        }

        mx_internal function getBackgroundColor():Object
        {
            var _local_2:Object;
            var _local_1:IUIComponent = (parent as IUIComponent);
            if (((_local_1) && (!(_local_1.enabled))))
            {
                _local_2 = getStyle("backgroundDisabledColor");
                if (((!(_local_2 === null)) && (StyleManager.isValidStyleValue(_local_2))))
                {
                    return (_local_2);
                };
            };
            return (getStyle("backgroundColor"));
        }

        mx_internal function draw3dBorder(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):void
        {
            var _local_7:Number = width;
            var _local_8:Number = height;
            drawDropShadow(0, 0, width, height, 0, 0, 0, 0);
            var _local_9:Graphics = graphics;
            _local_9.beginFill(_arg_1);
            _local_9.drawRect(0, 0, _local_7, _local_8);
            _local_9.drawRect(1, 0, (_local_7 - 2), _local_8);
            _local_9.endFill();
            _local_9.beginFill(_arg_2);
            _local_9.drawRect(1, 0, (_local_7 - 2), 1);
            _local_9.endFill();
            _local_9.beginFill(_arg_3);
            _local_9.drawRect(1, (_local_8 - 1), (_local_7 - 2), 1);
            _local_9.endFill();
            _local_9.beginFill(_arg_4);
            _local_9.drawRect(1, 1, (_local_7 - 2), 1);
            _local_9.endFill();
            _local_9.beginFill(_arg_5);
            _local_9.drawRect(1, (_local_8 - 2), (_local_7 - 2), 1);
            _local_9.endFill();
            _local_9.beginFill(_arg_6);
            _local_9.drawRect(1, 2, (_local_7 - 2), (_local_8 - 4));
            _local_9.drawRect(2, 2, (_local_7 - 4), (_local_8 - 4));
            _local_9.endFill();
        }

        mx_internal function getBackgroundColorMetrics():EdgeMetrics
        {
            return (borderMetrics);
        }

        mx_internal function getDropShadowAngle(_arg_1:Number, _arg_2:String):Number
        {
            if (_arg_2 == "left")
            {
                return ((_arg_1 >= 0) ? 135 : 225);
            };
            if (_arg_2 == "right")
            {
                return ((_arg_1 >= 0) ? 45 : 315);
            };
            return ((_arg_1 >= 0) ? 90 : 270);
        }

        override public function get borderMetrics():EdgeMetrics
        {
            var _local_1:Number;
            var _local_3:String;
            if (_borderMetrics)
            {
                return (_borderMetrics);
            };
            var _local_2:String = getStyle("borderStyle");
            if (((_local_2 == "default") || (_local_2 == "alert")))
            {
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _borderMetrics = new EdgeMetrics(0, 0, 0, 0);
                }
                else
                {
                    return (EdgeMetrics.EMPTY);
                };
            }
            else
            {
                if (((_local_2 == "controlBar") || (_local_2 == "applicationControlBar")))
                {
                    _borderMetrics = new EdgeMetrics(1, 1, 1, 1);
                }
                else
                {
                    if (_local_2 == "solid")
                    {
                        _local_1 = getStyle("borderThickness");
                        if (isNaN(_local_1))
                        {
                            _local_1 = 0;
                        };
                        _borderMetrics = new EdgeMetrics(_local_1, _local_1, _local_1, _local_1);
                        _local_3 = getStyle("borderSides");
                        if (_local_3 != "left top right bottom")
                        {
                            if (_local_3.indexOf("left") == -1)
                            {
                                _borderMetrics.left = 0;
                            };
                            if (_local_3.indexOf("top") == -1)
                            {
                                _borderMetrics.top = 0;
                            };
                            if (_local_3.indexOf("right") == -1)
                            {
                                _borderMetrics.right = 0;
                            };
                            if (_local_3.indexOf("bottom") == -1)
                            {
                                _borderMetrics.bottom = 0;
                            };
                        };
                    }
                    else
                    {
                        _local_1 = BORDER_WIDTHS[_local_2];
                        if (isNaN(_local_1))
                        {
                            _local_1 = 0;
                        };
                        _borderMetrics = new EdgeMetrics(_local_1, _local_1, _local_1, _local_1);
                    };
                };
            };
            return (_borderMetrics);
        }


    }
}//package mx.skins.halo

