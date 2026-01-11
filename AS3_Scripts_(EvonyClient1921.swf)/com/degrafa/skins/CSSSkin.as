// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.skins.CSSSkin

package com.degrafa.skins
{
    import mx.skins.Border;
    import com.degrafa.paint.ComplexFill;
    import com.degrafa.core.Measure;
    import mx.graphics.IFill;
    import mx.core.EdgeMetrics;
    import com.degrafa.geometry.AdvancedRectangle;
    import com.degrafa.core.utils.StyleUtil;
    import com.degrafa.paint.SolidFill;
    import mx.graphics.SolidColor;
    import mx.graphics.LinearGradient;
    import mx.graphics.GradientEntry;
    import com.degrafa.paint.BlendFill;
    import com.degrafa.paint.BitmapFill;
    import flash.geom.Rectangle;

    public class CSSSkin extends Border 
    {

        private static const ASSET_CLASS:String = "assetClass";
        private static const BACKGROUND_COLOR:String = "backgroundColor";
        private static const BACKGROUND_IMAGE:String = "backgroundImage";
        private static const BACKGROUND_REPEAT:String = "backgroundRepeat";
        private static const BACKGROUND_POSITION:String = "backgroundPosition";
        private static const BOX_SHADOW:String = "boxShadow";
        private static const BACKGROUND_BLEND:String = "backgroundBlend";
        private static const BORDER_ALPHA:String = "borderAlpha";
        private static const BORDER_TOP_WIDTH:String = "borderTopWidth";
        private static const BORDER_RIGHT_WIDTH:String = "borderRightWidth";
        private static const BORDER_BOTTOM_WIDTH:String = "borderBottomWidth";
        private static const BORDER_LEFT_WIDTH:String = "borderLeftWidth";
        private static const BORDER_WIDTH:String = "borderWidth";
        private static const BORDER_COLOR:String = "borderColor";
        private static const BORDER_TOP_COLOR:String = "borderTopColor";
        private static const BORDER_RIGHT_COLOR:String = "borderRightColor";
        private static const BORDER_BOTTOM_COLOR:String = "borderBottomColor";
        private static const BORDER_LEFT_COLOR:String = "borderLeftColor";
        private static const BORDER_TOP_RIGHT_RADIUS:String = "borderTopRightRadius";
        private static const BORDER_BOTTOM_RIGHT_RADIUS:String = "borderBottomRightRadius";
        private static const BORDER_BOTTOM_LEFT_RADIUS:String = "borderBottomLeftRadius";
        private static const BORDER_TOP_LEFT_RADIUS:String = "borderTopLeftRadius";

        private var borderLeftWidthChanged:Boolean;
        private var backgroundRepeatChanged:Boolean;
        private var borderColorChanged:Boolean;
        private var backgroundColorChanged:Boolean;
        private var borderBottomWidthChanged:Boolean;
        private var backgroundImageChanged:Boolean;
        private var assetClassChanged:Boolean;
        private var background:ComplexFill;
        private var borderLeftWidth:Measure;
        private var borderTopWidthChanged:Boolean;
        private var backgroundPositionChanged:Boolean;
        private var borderRightColorChanged:Boolean;
        private var borderBottomLeftRadiusChanged:Boolean;
        private var borderBottomLeftRadius:Object;
        private var borderRightWidth:Measure;
        private var borderWidthChanged:Boolean;
        private var assetClass:Class;
        private var backgroundRepeat:Array;
        private var borderTopRightRadiusChanged:Boolean;
        private var boxShadowChanged:Boolean;
        private var backgroundBlendChanged:Boolean;
        private var borderTopLeftRadiusChanged:Boolean;
        private var borderLeftFill:IFill;
        private var borderRightWidthChanged:Boolean;
        private var borderTopRightRadius:Object;
        private var borderBottomWidth:Measure;
        private var borderBottomFill:IFill;
        private var backgroundChanged:Boolean;
        private var borderTopFill:IFill;
        private var borderMetricsChanged:Boolean;
        private var backgroundBlend:Array;
        private var borderLeftColorChanged:Boolean;
        private var backgroundImage:IFill;
        private var backgroundColor:IFill;
        private var borderBottomRightRadius:Object;
        private var boxShadow:Array;
        private var borderBottomRightRadiusChanged:Boolean;
        private var borderTopWidth:Measure;
        private var borderBottomColorChanged:Boolean;
        private var borderTopLeftRadius:Object;
        private var borderRightFill:IFill;
        private var _borderMetrics:EdgeMetrics;
        private var borderTopColorChanged:Boolean;

        private var box:AdvancedRectangle = new AdvancedRectangle();
        private var backgroundPosition:Array = [];

        public function CSSSkin()
        {
            _borderMetrics = EdgeMetrics.EMPTY;
            background = new ComplexFill();
            refreshStyles();
        }

        private function resolveAssetsFromArray(_arg_1:Array):Array
        {
            var _local_3:Object;
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1)
            {
                if ((_local_3 is String))
                {
                    _local_2.push(resolveAssetsFromString((_local_3 as String)));
                }
                else
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        private function updateBoxShadow():void
        {
            cleanFilters(boxShadow);
            var _local_1:Object = getStyle(BOX_SHADOW);
            boxShadow = StyleUtil.resolveShadow(_local_1);
            applyFilters(boxShadow);
        }

        private function updateBorderColor():void
        {
            var _local_4:IFill;
            if (StyleUtil.LEGACY == "ALPHA")
            {
                return (updateBorderColorOld());
            };
            var _local_1:Object = getStyle(BORDER_COLOR);
            var _local_2:Array = StyleUtil.expandProperty(_local_1, [0, -1, -2, -2]);
            var _local_3:int;
            while (_local_3 < 4)
            {
                _local_4 = StyleUtil.resolveFill(_local_2[_local_3]);
                (_local_4 as SolidFill).alpha = getStyle(BORDER_ALPHA);
                switch (_local_3)
                {
                    case 0:
                        borderTopFill = _local_4;
                        break;
                    case 1:
                        borderRightFill = _local_4;
                        break;
                    case 2:
                        borderBottomFill = _local_4;
                        break;
                    case 3:
                        borderLeftFill = _local_4;
                        break;
                };
                _local_3++;
            };
        }

        private function updateAssetClass():void
        {
            var _local_1:Object = getStyle(ASSET_CLASS);
            if ((_local_1 is Class))
            {
                assetClass = (_local_1 as Class);
            }
            else
            {
                assetClass = null;
            };
        }

        private function updateBackgroundPosition():void
        {
            var _local_1:Object = getStyle(BACKGROUND_POSITION);
            backgroundPosition = StyleUtil.resolvePosition(_local_1, []);
        }

        private function updateBorderColorOld():void
        {
            var _local_4:IFill;
            var _local_1:Object = getStyle(BORDER_COLOR);
            var _local_2:Array = StyleUtil.expandProperty(_local_1, [0, -1, -2, -2]);
            var _local_3:int;
            while (_local_3 < 4)
            {
                _local_4 = StyleUtil.resolveFill(_local_2[_local_3]);
                (_local_4 as SolidFill).alpha = getStyle(BORDER_ALPHA);
                switch (_local_3)
                {
                    case 0:
                        borderLeftFill = _local_4;
                        break;
                    case 1:
                        borderTopFill = _local_4;
                        break;
                    case 2:
                        borderRightFill = _local_4;
                        break;
                    case 3:
                        borderBottomFill = _local_4;
                        break;
                };
                _local_3++;
            };
        }

        private function updateBorderRadius(_arg_1:String):void
        {
            var _local_2:Object = getStyle(_arg_1);
            var _local_3:Object = StyleUtil.resolveRadius(_local_2);
            switch (_arg_1)
            {
                case BORDER_TOP_LEFT_RADIUS:
                    borderTopLeftRadius = _local_3;
                    return;
                case BORDER_TOP_RIGHT_RADIUS:
                    borderTopRightRadius = _local_3;
                    return;
                case BORDER_BOTTOM_LEFT_RADIUS:
                    borderBottomLeftRadius = _local_3;
                    return;
                case BORDER_BOTTOM_RIGHT_RADIUS:
                    borderBottomRightRadius = _local_3;
                    return;
            };
        }

        private function resolveAssetsFromString(_arg_1:String):Object
        {
            var _local_2:Object;
            if (assetClass)
            {
                _local_2 = assetClass[_arg_1];
            };
            if (_local_2 != null)
            {
                return (_local_2);
            };
            return (_arg_1);
        }

        private function updateBackgroundRepeat():void
        {
            var _local_1:Object = getStyle(BACKGROUND_REPEAT);
            backgroundRepeat = StyleUtil.resolveRepeat(_local_1, []);
        }

        private function updateBorderSide(_arg_1:String):void
        {
            var _local_2:Object = getStyle(_arg_1);
            var _local_3:Measure = StyleUtil.resolveMeasure(_local_2);
            switch (_arg_1)
            {
                case BORDER_LEFT_WIDTH:
                    borderLeftWidth = _local_3;
                    return;
                case BORDER_TOP_WIDTH:
                    borderTopWidth = _local_3;
                    return;
                case BORDER_RIGHT_WIDTH:
                    borderRightWidth = _local_3;
                    return;
                case BORDER_BOTTOM_WIDTH:
                    borderBottomWidth = _local_3;
                    return;
            };
        }

        private function updateBorderWidth():void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:Measure;
            if (StyleUtil.LEGACY == "ALPHA")
            {
                return (updateBorderWidthOld());
            };
            var _local_1:Object = getStyle(BORDER_WIDTH);
            if (_local_1 != null)
            {
                _local_2 = StyleUtil.expandProperty(_local_1, [0, -1, -2, -2]);
                _local_3 = 0;
                while (_local_3 < 4)
                {
                    _local_4 = StyleUtil.resolveMeasure(_local_2[_local_3]);
                    switch (_local_3)
                    {
                        case 0:
                            borderTopWidth = _local_4;
                            break;
                        case 1:
                            borderRightWidth = _local_4;
                            break;
                        case 2:
                            borderBottomWidth = _local_4;
                            break;
                        case 3:
                            borderLeftWidth = _local_4;
                            break;
                    };
                    _local_3++;
                };
            };
        }

        private function cleanFilters(_arg_1:Array):void
        {
            var _local_2:Array;
            var _local_3:Object;
            var _local_4:int;
            if (parent)
            {
                _local_2 = parent.filters;
                for each (_local_3 in _arg_1)
                {
                    _local_4 = _local_2.indexOf(_local_3);
                    if (_local_4 >= 0)
                    {
                        _local_2.splice(_local_4, 1);
                    };
                };
            };
        }

        private function updateBorderFill(_arg_1:String):void
        {
            var _local_2:Object = getStyle(_arg_1);
            var _local_3:IFill = StyleUtil.resolveFill(_local_2, new SolidColor(0xFFFFFF, 1));
            (_local_3 as SolidColor).alpha = getStyle(BORDER_ALPHA);
            switch (_arg_1)
            {
                case BORDER_TOP_COLOR:
                    return;
                case BORDER_RIGHT_COLOR:
                    return;
                case BORDER_BOTTOM_COLOR:
                    return;
                case BORDER_LEFT_COLOR:
                    return;
            };
        }

        private function createTransition(_arg_1:IFill, _arg_2:IFill, _arg_3:Number):IFill
        {
            var _local_4:LinearGradient;
            if (((_arg_1 is SolidColor) && (_arg_2 is SolidColor)))
            {
                _local_4 = new LinearGradient();
                _local_4.entries = [new GradientEntry((_arg_1 as SolidColor).color, 0, (_arg_1 as SolidColor).alpha), new GradientEntry((_arg_2 as SolidColor).color, 1, (_arg_2 as SolidColor).alpha)];
                _local_4.angle = _arg_3;
                return (_local_4);
            };
            return (_arg_1);
        }

        private function applyBlend(_arg_1:IFill, _arg_2:String):void
        {
            _arg_1 = new BlendFill(_arg_1, _arg_2);
        }

        private function resolveAssets(_arg_1:Object):Object
        {
            if ((_arg_1 is Array))
            {
                return (resolveAssetsFromArray((_arg_1 as Array)));
            };
            if ((_arg_1 is String))
            {
                return (resolveAssetsFromString((_arg_1 as String)));
            };
            return (_arg_1);
        }

        private function refreshStyles():void
        {
            styleChanged(ASSET_CLASS);
            styleChanged(BACKGROUND_COLOR);
            styleChanged(BACKGROUND_IMAGE);
            styleChanged(BACKGROUND_REPEAT);
            styleChanged(BACKGROUND_POSITION);
            styleChanged(BACKGROUND_BLEND);
            styleChanged(BOX_SHADOW);
            borderTopWidth = new Measure();
            borderRightWidth = new Measure();
            borderBottomWidth = new Measure();
            borderLeftWidth = new Measure();
            styleChanged(BORDER_ALPHA);
            styleChanged(BORDER_WIDTH);
            styleChanged(BORDER_TOP_RIGHT_RADIUS);
            styleChanged(BORDER_BOTTOM_RIGHT_RADIUS);
            styleChanged(BORDER_BOTTOM_LEFT_RADIUS);
            styleChanged(BORDER_TOP_LEFT_RADIUS);
            styleChanged(BORDER_COLOR);
            styleChanged(BORDER_TOP_COLOR);
            styleChanged(BORDER_RIGHT_COLOR);
            styleChanged(BORDER_BOTTOM_COLOR);
            styleChanged(BORDER_LEFT_COLOR);
        }

        private function applyRepeat(_arg_1:BitmapFill, _arg_2:Object):void
        {
            if (_arg_2 != null)
            {
                _arg_1.repeatX = (_arg_2.x as String);
                _arg_1.repeatY = (_arg_2.y as String);
            }
            else
            {
                _arg_1.repeatX = BitmapFill.REPEAT;
                _arg_1.repeatY = BitmapFill.REPEAT;
            };
        }

        private function applyFilters(_arg_1:Array):void
        {
            var _local_2:Array;
            if (parent)
            {
                _local_2 = parent.filters;
            };
        }

        private function applyPosition(_arg_1:BitmapFill, _arg_2:Object):void
        {
            var _local_3:Measure;
            var _local_4:Measure;
            if (_arg_2 != null)
            {
                _local_3 = (_arg_2.x as Measure);
                _local_4 = (_arg_2.y as Measure);
            }
            else
            {
                _local_3 = new Measure();
                _local_4 = new Measure();
            };
            _arg_1.offsetX = _local_3.value;
            _arg_1.offsetXUnit = _local_3.unit;
            _arg_1.offsetY = _local_4.value;
            _arg_1.offsetYUnit = _local_4.unit;
        }

        private function updateBackgroundBlend():void
        {
            var _local_1:Object = getStyle(BACKGROUND_BLEND);
            if ((_local_1 is String))
            {
                backgroundBlend = [_local_1];
            }
            else
            {
                if ((_local_1 is Array))
                {
                    backgroundBlend = (_local_1 as Array).concat();
                    if (StyleUtil.LEGACY != "ALPHA")
                    {
                        backgroundBlend.reverse();
                    };
                }
                else
                {
                    backgroundBlend = [];
                };
            };
        }

        private function applyBackgroundImageSettings():void
        {
            var _local_1:ComplexFill;
            var _local_2:int;
            var _local_3:int;
            var _local_4:IFill;
            if ((backgroundImage is ComplexFill))
            {
                _local_1 = (backgroundImage as ComplexFill);
                _local_2 = _local_1.fills.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (_local_1.fills[_local_3] as IFill);
                    if ((_local_4 is BitmapFill))
                    {
                        applyRepeat((_local_4 as BitmapFill), backgroundRepeat[_local_3]);
                        applyPosition((_local_4 as BitmapFill), backgroundPosition[_local_3]);
                    };
                    if ((backgroundBlend[_local_3] is String))
                    {
                        _local_4 = new BlendFill(_local_4, (backgroundBlend[_local_3] as String));
                    };
                    _local_1.fills[_local_3] = _local_4;
                    _local_3++;
                };
            }
            else
            {
                if ((backgroundImage is BitmapFill))
                {
                    if (backgroundRepeat != null)
                    {
                        applyRepeat((backgroundImage as BitmapFill), backgroundRepeat[0]);
                    };
                    if (backgroundPosition != null)
                    {
                        applyPosition((backgroundImage as BitmapFill), backgroundPosition[0]);
                    };
                    if (((!(backgroundBlend == null)) && (backgroundBlend[0] is String)))
                    {
                        backgroundImage = new BlendFill(backgroundImage, (backgroundBlend[0] as String));
                    };
                }
                else
                {
                    if (backgroundImage != null)
                    {
                        if ((backgroundBlend[0] is String))
                        {
                            backgroundImage = new BlendFill(backgroundImage, (backgroundBlend[0] as String));
                        };
                    };
                };
            };
        }

        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            switch (_arg_1)
            {
                case ASSET_CLASS:
                    assetClassChanged = true;
                    return;
                case BACKGROUND_COLOR:
                    backgroundColorChanged = true;
                    invalidateDisplayList();
                    return;
                case BACKGROUND_IMAGE:
                    backgroundImageChanged = true;
                    invalidateDisplayList();
                    return;
                case BACKGROUND_REPEAT:
                    backgroundRepeatChanged = true;
                    invalidateDisplayList();
                    return;
                case BACKGROUND_POSITION:
                    backgroundPositionChanged = true;
                    invalidateDisplayList();
                    return;
                case BACKGROUND_BLEND:
                    backgroundBlendChanged = true;
                    invalidateDisplayList();
                    return;
                case BOX_SHADOW:
                    boxShadowChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_ALPHA:
                    invalidateDisplayList();
                    return;
                case BORDER_TOP_WIDTH:
                    borderTopWidthChanged = true;
                    borderMetricsChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_RIGHT_WIDTH:
                    borderRightWidthChanged = true;
                    borderMetricsChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_BOTTOM_WIDTH:
                    borderBottomWidthChanged = true;
                    borderMetricsChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_LEFT_WIDTH:
                    borderLeftWidthChanged = true;
                    borderMetricsChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_WIDTH:
                    borderWidthChanged = true;
                    borderMetricsChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_TOP_RIGHT_RADIUS:
                    borderTopRightRadiusChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_BOTTOM_RIGHT_RADIUS:
                    borderBottomRightRadiusChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_BOTTOM_LEFT_RADIUS:
                    borderBottomLeftRadiusChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_TOP_LEFT_RADIUS:
                    borderTopLeftRadiusChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_COLOR:
                    borderColorChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_TOP_COLOR:
                    borderTopColorChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_RIGHT_COLOR:
                    borderRightColorChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_BOTTOM_COLOR:
                    borderBottomColorChanged = true;
                    invalidateDisplayList();
                    return;
                case BORDER_LEFT_COLOR:
                    borderLeftColorChanged = true;
                    invalidateDisplayList();
                    return;
            };
        }

        private function updateBackgroundColor():void
        {
            var _local_1:Object = getStyle(BACKGROUND_COLOR);
            backgroundColor = StyleUtil.resolveFill(_local_1);
        }

        private function updateBackgroundImage():void
        {
            var _local_1:Object = resolveAssets(getStyle(BACKGROUND_IMAGE));
            backgroundImage = StyleUtil.resolveFill(_local_1);
        }

        private function updateBorderWidthOld():void
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:Measure;
            var _local_1:Object = getStyle(BORDER_WIDTH);
            if (_local_1 != null)
            {
                _local_2 = StyleUtil.expandProperty(_local_1, [0, -1, -2, -2]);
                _local_3 = 0;
                while (_local_3 < 4)
                {
                    _local_4 = StyleUtil.resolveMeasure(_local_2[_local_3]);
                    switch (_local_3)
                    {
                        case 0:
                            borderLeftWidth = _local_4;
                            break;
                        case 1:
                            borderTopWidth = _local_4;
                            break;
                        case 2:
                            borderRightWidth = _local_4;
                            break;
                        case 3:
                            borderBottomWidth = _local_4;
                            break;
                    };
                    _local_3++;
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            commitStyles();
            graphics.clear();
            if (borderLeftWidth != null)
            {
                box.leftWidth = borderLeftWidth.relativeTo(_arg_1);
            };
            if (borderTopWidth != null)
            {
                box.topWidth = borderTopWidth.relativeTo(_arg_2);
            };
            if (borderTopWidth != null)
            {
                box.rightWidth = borderRightWidth.relativeTo(_arg_1);
            };
            if (borderTopWidth != null)
            {
                box.bottomWidth = borderBottomWidth.relativeTo(_arg_2);
            };
            box.leftFill = borderLeftFill;
            box.topFill = borderTopFill;
            box.rightFill = borderRightFill;
            box.bottomFill = borderBottomFill;
            box.topLeftFill = createTransition(box.leftFill, box.topFill, -45);
            box.topRightFill = createTransition(box.topFill, box.rightFill, 45);
            box.bottomLeftFill = createTransition(box.leftFill, box.bottomFill, 45);
            box.bottomRightFill = createTransition(box.bottomFill, box.rightFill, -45);
            box.topLeftRadiusX = (borderTopLeftRadius.x as Measure).relativeTo(_arg_1);
            box.topLeftRadiusY = (borderTopLeftRadius.y as Measure).relativeTo(_arg_2);
            box.topRightRadiusX = (borderTopRightRadius.x as Measure).relativeTo(_arg_1);
            box.topRightRadiusY = (borderTopRightRadius.y as Measure).relativeTo(_arg_2);
            box.bottomLeftRadiusX = (borderBottomLeftRadius.x as Measure).relativeTo(_arg_1);
            box.bottomLeftRadiusY = (borderBottomLeftRadius.y as Measure).relativeTo(_arg_2);
            box.bottomRightRadiusX = (borderBottomRightRadius.x as Measure).relativeTo(_arg_1);
            box.bottomRightRadiusY = (borderBottomRightRadius.y as Measure).relativeTo(_arg_2);
            box.draw(graphics, new Rectangle(0, 0, _arg_1, _arg_2));
        }

        protected function commitStyles():void
        {
            if (assetClassChanged)
            {
                updateAssetClass();
                assetClassChanged = true;
            };
            var _local_1:Boolean;
            if (backgroundColorChanged)
            {
                updateBackgroundColor();
                backgroundColorChanged = false;
                _local_1 = true;
            };
            if (backgroundImageChanged)
            {
                updateBackgroundImage();
                backgroundImageChanged = false;
                _local_1 = true;
            };
            if (backgroundRepeatChanged)
            {
                updateBackgroundRepeat();
                backgroundRepeatChanged = false;
            };
            if (backgroundPositionChanged)
            {
                updateBackgroundPosition();
                backgroundPositionChanged = false;
            };
            if (backgroundBlendChanged)
            {
                updateBackgroundBlend();
                backgroundBlendChanged = false;
                _local_1 = true;
            };
            if (boxShadowChanged)
            {
                updateBoxShadow();
                boxShadowChanged = false;
            };
            if (borderWidthChanged)
            {
                updateBorderWidth();
                borderWidthChanged = false;
            };
            if (borderTopWidthChanged)
            {
                updateBorderSide(BORDER_TOP_WIDTH);
                borderTopWidthChanged = false;
            };
            if (borderRightWidthChanged)
            {
                updateBorderSide(BORDER_RIGHT_WIDTH);
                borderRightWidthChanged = false;
            };
            if (borderBottomWidthChanged)
            {
                updateBorderSide(BORDER_BOTTOM_WIDTH);
                borderBottomWidthChanged = false;
            };
            if (borderLeftWidthChanged)
            {
                updateBorderSide(BORDER_LEFT_WIDTH);
                borderLeftWidthChanged = false;
            };
            if (borderTopRightRadiusChanged)
            {
                updateBorderRadius(BORDER_TOP_RIGHT_RADIUS);
                borderTopRightRadiusChanged = false;
            };
            if (borderBottomRightRadiusChanged)
            {
                updateBorderRadius(BORDER_BOTTOM_RIGHT_RADIUS);
                borderBottomRightRadiusChanged = false;
            };
            if (borderBottomLeftRadiusChanged)
            {
                updateBorderRadius(BORDER_BOTTOM_LEFT_RADIUS);
                borderBottomLeftRadiusChanged = false;
            };
            if (borderTopLeftRadiusChanged)
            {
                updateBorderRadius(BORDER_TOP_LEFT_RADIUS);
                borderTopLeftRadiusChanged = false;
            };
            applyBackgroundImageSettings();
            if (_local_1)
            {
                background.fills = new Array();
                ComplexFill.add(backgroundColor, background);
                ComplexFill.add(backgroundImage, background);
            };
            box.backgroundFill = background;
            if (borderColorChanged)
            {
                updateBorderColor();
                borderColorChanged = false;
            };
            if (borderTopColorChanged)
            {
                updateBorderFill(BORDER_TOP_COLOR);
                borderTopColorChanged = false;
            };
            if (borderRightColorChanged)
            {
                updateBorderFill(BORDER_RIGHT_COLOR);
                borderRightColorChanged = false;
            };
            if (borderBottomColorChanged)
            {
                updateBorderFill(BORDER_BOTTOM_COLOR);
                borderBottomColorChanged = false;
            };
            if (borderLeftColorChanged)
            {
                updateBorderFill(BORDER_LEFT_COLOR);
                borderLeftColorChanged = false;
            };
        }

        override public function get borderMetrics():EdgeMetrics
        {
            if (borderMetricsChanged)
            {
                borderMetricsChanged = false;
            };
            return (_borderMetrics);
        }


    }
}//package com.degrafa.skins

