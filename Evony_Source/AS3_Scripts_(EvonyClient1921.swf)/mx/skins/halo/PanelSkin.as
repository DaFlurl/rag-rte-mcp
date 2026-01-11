// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.PanelSkin

package mx.skins.halo
{
    import mx.core.EdgeMetrics;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import flash.display.Graphics;
    import mx.core.IContainer;
    import mx.core.FlexVersion;
    import mx.core.IUIComponent;
    import flash.display.GradientType;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PanelSkin extends HaloBorder 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var panels:Object = {};

        private var oldControlBarHeight:Number;
        protected var _panelBorderMetrics:EdgeMetrics;
        private var oldHeaderHeight:Number;


        private static function isPanel(parent:Object):Boolean
        {
            var s:String;
            var x:XML;
            s = getQualifiedClassName(parent);
            if (panels[s] == 1)
            {
                return (true);
            };
            if (panels[s] == 0)
            {
                return (false);
            };
            if (s == "mx.containers::Panel")
            {
                (panels[s] == 1);
                return (true);
            };
            x = describeType(parent);
            var xmllist:XMLList = x.extendsClass.(@type == "mx.containers::Panel");
            if (xmllist.length() == 0)
            {
                panels[s] = 0;
                return (false);
            };
            panels[s] = 1;
            return (true);
        }


        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            if ((((((((((_arg_1 == null) || (_arg_1 == "styleName")) || (_arg_1 == "borderStyle")) || (_arg_1 == "borderThickness")) || (_arg_1 == "borderThicknessTop")) || (_arg_1 == "borderThicknessBottom")) || (_arg_1 == "borderThicknessLeft")) || (_arg_1 == "borderThicknessRight")) || (_arg_1 == "borderSides")))
            {
                _panelBorderMetrics = null;
            };
            invalidateDisplayList();
        }

        override mx_internal function drawBorder(_arg_1:Number, _arg_2:Number):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Graphics;
            var _local_8:IContainer;
            var _local_9:EdgeMetrics;
            super.drawBorder(_arg_1, _arg_2);
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return;
            };
            var _local_3:String = getStyle("borderStyle");
            if (_local_3 == "default")
            {
                _local_4 = getStyle("backgroundAlpha");
                _local_5 = getStyle("borderAlpha");
                backgroundAlphaName = "borderAlpha";
                radiusObj = null;
                radius = getStyle("cornerRadius");
                bRoundedCorners = (getStyle("roundedBottomCorners").toString().toLowerCase() == "true");
                _local_6 = ((bRoundedCorners) ? radius : 0);
                _local_7 = graphics;
                drawDropShadow(0, 0, _arg_1, _arg_2, radius, radius, _local_6, _local_6);
                if (!bRoundedCorners)
                {
                    radiusObj = {};
                };
                _local_8 = (parent as IContainer);
                if (_local_8)
                {
                    _local_9 = _local_8.viewMetrics;
                    backgroundHole = {
                        "x":_local_9.left,
                        "y":_local_9.top,
                        "w":Math.max(0, ((_arg_1 - _local_9.left) - _local_9.right)),
                        "h":Math.max(0, ((_arg_2 - _local_9.top) - _local_9.bottom)),
                        "r":0
                    };
                    if (((backgroundHole.w > 0) && (backgroundHole.h > 0)))
                    {
                        if (_local_4 != _local_5)
                        {
                            drawDropShadow(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h, 0, 0, 0, 0);
                        };
                        _local_7.beginFill(Number(backgroundColor), _local_4);
                        _local_7.drawRect(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h);
                        _local_7.endFill();
                    };
                };
                backgroundColor = getStyle("borderColor");
            };
        }

        override public function get borderMetrics():EdgeMetrics
        {
            var _local_4:Number;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (super.borderMetrics);
            };
            var _local_1:Boolean = isPanel(parent);
            var _local_2:IUIComponent = ((_local_1) ? Object(parent)._controlBar : null);
            var _local_3:Number = ((_local_1) ? Object(parent).getHeaderHeightProxy() : NaN);
            if (((_local_2) && (_local_2.includeInLayout)))
            {
                _local_4 = _local_2.getExplicitOrMeasuredHeight();
            };
            if (((!(_local_4 == oldControlBarHeight)) && (!((isNaN(oldControlBarHeight)) && (isNaN(_local_4))))))
            {
                _panelBorderMetrics = null;
            };
            if (((!(_local_3 == oldHeaderHeight)) && (!((isNaN(_local_3)) && (isNaN(oldHeaderHeight))))))
            {
                _panelBorderMetrics = null;
            };
            if (_panelBorderMetrics)
            {
                return (_panelBorderMetrics);
            };
            var _local_5:EdgeMetrics = super.borderMetrics;
            var _local_6:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0);
            var _local_7:Number = getStyle("borderThickness");
            var _local_8:Number = getStyle("borderThicknessLeft");
            var _local_9:Number = getStyle("borderThicknessTop");
            var _local_10:Number = getStyle("borderThicknessRight");
            var _local_11:Number = getStyle("borderThicknessBottom");
            _local_6.left = (_local_5.left + ((isNaN(_local_8)) ? _local_7 : _local_8));
            _local_6.top = (_local_5.top + ((isNaN(_local_9)) ? _local_7 : _local_9));
            _local_6.right = (_local_5.bottom + ((isNaN(_local_10)) ? _local_7 : _local_10));
            _local_6.bottom = (_local_5.bottom + ((isNaN(_local_11)) ? (((_local_2) && (!(isNaN(_local_9)))) ? _local_9 : ((isNaN(_local_8)) ? _local_7 : _local_8)) : _local_11));
            oldHeaderHeight = _local_3;
            if (!isNaN(_local_3))
            {
                _local_6.top = (_local_6.top + _local_3);
            };
            oldControlBarHeight = _local_4;
            if (!isNaN(_local_4))
            {
                _local_6.bottom = (_local_6.bottom + _local_4);
            };
            _panelBorderMetrics = _local_6;
            return (_panelBorderMetrics);
        }

        override mx_internal function drawBackground(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Array;
            var _local_4:Number;
            super.drawBackground(_arg_1, _arg_2);
            if (((getStyle("headerColors") == null) && (getStyle("borderStyle") == "default")))
            {
                _local_3 = getStyle("highlightAlphas");
                _local_4 = ((_local_3) ? _local_3[0] : 0.3);
                drawRoundRect(0, 0, _arg_1, _arg_2, {
                    "tl":radius,
                    "tr":radius,
                    "bl":0,
                    "br":0
                }, 0xFFFFFF, _local_4, null, GradientType.LINEAR, null, {
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

        override mx_internal function getBackgroundColorMetrics():EdgeMetrics
        {
            if (getStyle("borderStyle") == "default")
            {
                return (EdgeMetrics.EMPTY);
            };
            return (super.borderMetrics);
        }


    }
}//package mx.skins.halo

