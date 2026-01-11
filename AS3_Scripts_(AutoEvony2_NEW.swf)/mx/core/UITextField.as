// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.UITextField

package mx.core
{
    import mx.automation.IAutomationObject;
    import mx.styles.ISimpleStyleClient;
    import mx.managers.IToolTipManagerClient;
    import flash.text.TextFormat;
    import flash.display.DisplayObjectContainer;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.Event;
    import mx.styles.StyleProtoChain;
    import mx.styles.StyleManager;
    import mx.styles.IStyleClient;
    import flash.utils.getQualifiedClassName;
    import mx.managers.ISystemManager;
    import flash.display.Sprite;
    import mx.utils.StringUtil;
    import flash.display.DisplayObject;
    import flash.text.TextLineMetrics;
    import mx.managers.SystemManager;
    import mx.managers.ToolTipManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UITextField extends FlexTextField implements IAutomationObject, IIMESupport, IFlexModule, IInvalidating, ISimpleStyleClient, IToolTipManagerClient, IUITextField 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static const TEXT_WIDTH_PADDING:int = 5;
        mx_internal static const TEXT_HEIGHT_PADDING:int = 4;
        private static var truncationIndicatorResource:String;
        mx_internal static var debuggingBorders:Boolean = false;
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;

        private var _enabled:Boolean = true;
        private var untruncatedText:String;
        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var cachedTextFormat:TextFormat;
        private var _automationDelegate:IAutomationObject;
        private var _automationName:String;
        private var _styleName:Object;
        private var _document:Object;
        mx_internal var _toolTip:String;
        private var _nestLevel:int = 0;
        private var _explicitHeight:Number;
        private var _moduleFactory:IFlexModuleFactory;
        private var _initialized:Boolean = false;
        private var _includeInLayout:Boolean = true;
        private var invalidateDisplayListFlag:Boolean = true;
        mx_internal var explicitColor:uint = 0xFFFFFFFF;
        private var _processedDescriptors:Boolean = true;
        private var _updateCompletePendingFlag:Boolean = false;
        private var explicitHTMLText:String = null;
        mx_internal var _parent:DisplayObjectContainer;
        private var _imeMode:String = null;
        mx_internal var styleChangedFlag:Boolean = true;
        private var _ignorePadding:Boolean = true;
        private var _owner:DisplayObjectContainer;
        private var _explicitWidth:Number;

        private var resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _inheritingStyles:Object = UIComponent.STYLE_UNINITIALIZED;
        private var _nonInheritingStyles:Object = UIComponent.STYLE_UNINITIALIZED;

        public function UITextField()
        {
            super.text = "";
            focusRect = false;
            selectable = false;
            tabEnabled = false;
            if (debuggingBorders)
            {
                border = true;
            };
            if (!truncationIndicatorResource)
            {
                truncationIndicatorResource = resourceManager.getString("core", "truncationIndicator");
            };
            addEventListener(Event.CHANGE, changeHandler);
            addEventListener("textFieldStyleChange", textFieldStyleChangeHandler);
            resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler, false, 0, true);
        }

        private static function get embeddedFontRegistry():IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            };
            return (_embeddedFontRegistry);
        }


        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        public function get nestLevel():int
        {
            return (_nestLevel);
        }

        private function textFieldStyleChangeHandler(_arg_1:Event):void
        {
            if (explicitHTMLText != null)
            {
                super.htmlText = explicitHTMLText;
            };
        }

        public function truncateToFit(_arg_1:String=null):Boolean
        {
            var _local_4:String;
            if (!_arg_1)
            {
                _arg_1 = truncationIndicatorResource;
            };
            validateNow();
            var _local_2:String = super.text;
            untruncatedText = _local_2;
            var _local_3:Number = width;
            if (((!(_local_2 == "")) && ((textWidth + TEXT_WIDTH_PADDING) > (_local_3 + 1E-14))))
            {
                var _local_5:* = _local_2;
                super.text = _local_5;
                _local_4 = _local_5;
                _local_2.slice(0, Math.floor(((_local_3 / (textWidth + TEXT_WIDTH_PADDING)) * _local_2.length)));
                while (((_local_4.length > 1) && ((textWidth + TEXT_WIDTH_PADDING) > _local_3)))
                {
                    _local_4 = _local_4.slice(0, -1);
                    super.text = (_local_4 + _arg_1);
                };
                return (true);
            };
            return (false);
        }

        public function set nestLevel(_arg_1:int):void
        {
            if (((_arg_1 > 1) && (!(_nestLevel == _arg_1))))
            {
                _nestLevel = _arg_1;
                StyleProtoChain.initTextField(this);
                styleChangedFlag = true;
                validateNow();
            };
        }

        public function get minHeight():Number
        {
            return (0);
        }

        public function getExplicitOrMeasuredHeight():Number
        {
            return ((isNaN(explicitHeight)) ? measuredHeight : explicitHeight);
        }

        public function getStyle(_arg_1:String):*
        {
            if (StyleManager.inheritingStyles[_arg_1])
            {
                return ((inheritingStyles) ? inheritingStyles[_arg_1] : IStyleClient(parent).getStyle(_arg_1));
            };
            return ((nonInheritingStyles) ? nonInheritingStyles[_arg_1] : IStyleClient(parent).getStyle(_arg_1));
        }

        public function get className():String
        {
            var _local_1:String = getQualifiedClassName(this);
            var _local_2:int = _local_1.indexOf("::");
            if (_local_2 != -1)
            {
                _local_1 = _local_1.substr((_local_2 + 2));
            };
            return (_local_1);
        }

        public function setColor(_arg_1:uint):void
        {
            explicitColor = _arg_1;
            styleChangedFlag = true;
            invalidateDisplayListFlag = true;
            validateNow();
        }

        override public function replaceText(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            super.replaceText(_arg_1, _arg_2, _arg_3);
            dispatchEvent(new Event("textReplace"));
        }

        private function creatingSystemManager():ISystemManager
        {
            return (((!(moduleFactory == null)) && (moduleFactory is ISystemManager)) ? ISystemManager(moduleFactory) : systemManager);
        }

        public function set document(_arg_1:Object):void
        {
            _document = _arg_1;
        }

        public function get automationName():String
        {
            if (_automationName)
            {
                return (_automationName);
            };
            if (automationDelegate)
            {
                return (automationDelegate.automationName);
            };
            return ("");
        }

        public function get explicitMinHeight():Number
        {
            return (NaN);
        }

        public function get focusPane():Sprite
        {
            return (null);
        }

        public function getTextStyles():TextFormat
        {
            var _local_1:TextFormat = new TextFormat();
            _local_1.align = getStyle("textAlign");
            _local_1.bold = (getStyle("fontWeight") == "bold");
            if (enabled)
            {
                if (explicitColor == StyleManager.NOT_A_COLOR)
                {
                    _local_1.color = getStyle("color");
                }
                else
                {
                    _local_1.color = explicitColor;
                };
            }
            else
            {
                _local_1.color = getStyle("disabledColor");
            };
            _local_1.font = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            _local_1.indent = getStyle("textIndent");
            _local_1.italic = (getStyle("fontStyle") == "italic");
            _local_1.kerning = getStyle("kerning");
            _local_1.leading = getStyle("leading");
            _local_1.leftMargin = ((ignorePadding) ? 0 : getStyle("paddingLeft"));
            _local_1.letterSpacing = getStyle("letterSpacing");
            _local_1.rightMargin = ((ignorePadding) ? 0 : getStyle("paddingRight"));
            _local_1.size = getStyle("fontSize");
            _local_1.underline = (getStyle("textDecoration") == "underline");
            cachedTextFormat = _local_1;
            return (_local_1);
        }

        override public function set text(_arg_1:String):void
        {
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            if (((!(isHTML)) && (super.text == _arg_1)))
            {
                return;
            };
            super.text = _arg_1;
            explicitHTMLText = null;
            if (invalidateDisplayListFlag)
            {
                validateNow();
            };
        }

        public function getExplicitOrMeasuredWidth():Number
        {
            return ((isNaN(explicitWidth)) ? measuredWidth : explicitWidth);
        }

        public function get showInAutomationHierarchy():Boolean
        {
            return (true);
        }

        public function set automationName(_arg_1:String):void
        {
            _automationName = _arg_1;
        }

        public function get systemManager():ISystemManager
        {
            var _local_2:IUIComponent;
            var _local_1:DisplayObject = parent;
            while (_local_1)
            {
                _local_2 = (_local_1 as IUIComponent);
                if (_local_2)
                {
                    return (_local_2.systemManager);
                };
                _local_1 = _local_1.parent;
            };
            return (null);
        }

        public function setStyle(_arg_1:String, _arg_2:*):void
        {
        }

        public function get percentWidth():Number
        {
            return (NaN);
        }

        public function get explicitHeight():Number
        {
            return (_explicitHeight);
        }

        public function get baselinePosition():Number
        {
            var _local_1:TextLineMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_1 = getLineMetrics(0);
                return ((height - 4) - _local_1.descent);
            };
            if (!parent)
            {
                return (NaN);
            };
            var _local_2:* = (text == "");
            if (_local_2)
            {
                super.text = "Wj";
            };
            _local_1 = getLineMetrics(0);
            if (_local_2)
            {
                super.text = "";
            };
            return (2 + _local_1.ascent);
        }

        public function set enabled(_arg_1:Boolean):void
        {
            mouseEnabled = _arg_1;
            _enabled = _arg_1;
            styleChanged("color");
        }

        public function get minWidth():Number
        {
            return (0);
        }

        public function get automationValue():Array
        {
            if (automationDelegate)
            {
                return (automationDelegate.automationValue);
            };
            return ([""]);
        }

        public function get tweeningProperties():Array
        {
            return (null);
        }

        public function get measuredWidth():Number
        {
            validateNow();
            if (!stage)
            {
                return (textWidth + TEXT_WIDTH_PADDING);
            };
            return ((textWidth * transform.concatenatedMatrix.d) + TEXT_WIDTH_PADDING);
        }

        public function set tweeningProperties(_arg_1:Array):void
        {
        }

        public function createAutomationIDPart(_arg_1:IAutomationObject):Object
        {
            return (null);
        }

        override public function get parent():DisplayObjectContainer
        {
            return ((_parent) ? _parent : super.parent);
        }

        public function set updateCompletePendingFlag(_arg_1:Boolean):void
        {
            _updateCompletePendingFlag = _arg_1;
        }

        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            if (width != _arg_1)
            {
                width = _arg_1;
            };
            if (height != _arg_2)
            {
                height = _arg_2;
            };
        }

        public function get numAutomationChildren():int
        {
            return (0);
        }

        public function set focusPane(_arg_1:Sprite):void
        {
        }

        public function getAutomationChildAt(_arg_1:int):IAutomationObject
        {
            return (null);
        }

        public function get inheritingStyles():Object
        {
            return (_inheritingStyles);
        }

        public function get owner():DisplayObjectContainer
        {
            return ((_owner) ? _owner : parent);
        }

        public function parentChanged(_arg_1:DisplayObjectContainer):void
        {
            if (!_arg_1)
            {
                _parent = null;
                _nestLevel = 0;
            }
            else
            {
                if ((_arg_1 is IStyleClient))
                {
                    _parent = _arg_1;
                }
                else
                {
                    if ((_arg_1 is SystemManager))
                    {
                        _parent = _arg_1;
                    }
                    else
                    {
                        _parent = _arg_1.parent;
                    };
                };
            };
        }

        public function get processedDescriptors():Boolean
        {
            return (_processedDescriptors);
        }

        public function get maxWidth():Number
        {
            return (UIComponent.DEFAULT_MAX_WIDTH);
        }

        private function getEmbeddedFont(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):EmbeddedFont
        {
            if (cachedEmbeddedFont)
            {
                if (((cachedEmbeddedFont.fontName == _arg_1) && (cachedEmbeddedFont.fontStyle == EmbeddedFontRegistry.getFontStyle(_arg_2, _arg_3))))
                {
                    return (cachedEmbeddedFont);
                };
            };
            cachedEmbeddedFont = new EmbeddedFont(_arg_1, _arg_2, _arg_3);
            return (cachedEmbeddedFont);
        }

        public function get initialized():Boolean
        {
            return (_initialized);
        }

        public function invalidateDisplayList():void
        {
            invalidateDisplayListFlag = true;
        }

        public function invalidateProperties():void
        {
        }

        override public function insertXMLText(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean=false):void
        {
            super.insertXMLText(_arg_1, _arg_2, _arg_3, _arg_4);
            dispatchEvent(new Event("textInsert"));
        }

        public function set includeInLayout(_arg_1:Boolean):void
        {
            var _local_2:IInvalidating;
            if (_includeInLayout != _arg_1)
            {
                _includeInLayout = _arg_1;
                _local_2 = (parent as IInvalidating);
                if (_local_2)
                {
                    _local_2.invalidateSize();
                    _local_2.invalidateDisplayList();
                };
            };
        }

        override public function set htmlText(_arg_1:String):void
        {
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            if (((isHTML) && (super.htmlText == _arg_1)))
            {
                return;
            };
            if (((cachedTextFormat) && (styleSheet == null)))
            {
                defaultTextFormat = cachedTextFormat;
            };
            super.htmlText = _arg_1;
            explicitHTMLText = _arg_1;
            if (invalidateDisplayListFlag)
            {
                validateNow();
            };
        }

        public function set showInAutomationHierarchy(_arg_1:Boolean):void
        {
        }

        private function resourceManager_changeHandler(_arg_1:Event):void
        {
            truncationIndicatorResource = resourceManager.getString("core", "truncationIndicator");
            if (untruncatedText != null)
            {
                super.text = untruncatedText;
                truncateToFit();
            };
        }

        public function set measuredMinWidth(_arg_1:Number):void
        {
        }

        public function set explicitHeight(_arg_1:Number):void
        {
            _explicitHeight = _arg_1;
        }

        public function get explicitMinWidth():Number
        {
            return (NaN);
        }

        public function set percentWidth(_arg_1:Number):void
        {
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function get moduleFactory():IFlexModuleFactory
        {
            return (_moduleFactory);
        }

        public function set systemManager(_arg_1:ISystemManager):void
        {
        }

        public function get explicitMaxWidth():Number
        {
            return (NaN);
        }

        public function get document():Object
        {
            return (_document);
        }

        public function get updateCompletePendingFlag():Boolean
        {
            return (_updateCompletePendingFlag);
        }

        public function replayAutomatableEvent(_arg_1:Event):Boolean
        {
            if (automationDelegate)
            {
                return (automationDelegate.replayAutomatableEvent(_arg_1));
            };
            return (false);
        }

        public function get enabled():Boolean
        {
            return (_enabled);
        }

        public function set owner(_arg_1:DisplayObjectContainer):void
        {
            _owner = _arg_1;
        }

        public function get automationTabularData():Object
        {
            return (null);
        }

        public function set nonInheritingStyles(_arg_1:Object):void
        {
            _nonInheritingStyles = _arg_1;
        }

        public function get includeInLayout():Boolean
        {
            return (_includeInLayout);
        }

        public function get measuredMinWidth():Number
        {
            return (0);
        }

        public function set isPopUp(_arg_1:Boolean):void
        {
        }

        public function set automationDelegate(_arg_1:Object):void
        {
            _automationDelegate = (_arg_1 as IAutomationObject);
        }

        public function get measuredHeight():Number
        {
            validateNow();
            if (!stage)
            {
                return (textHeight + TEXT_HEIGHT_PADDING);
            };
            return ((textHeight * transform.concatenatedMatrix.a) + TEXT_HEIGHT_PADDING);
        }

        public function set processedDescriptors(_arg_1:Boolean):void
        {
            _processedDescriptors = _arg_1;
        }

        public function setFocus():void
        {
            systemManager.stage.focus = this;
        }

        public function initialize():void
        {
        }

        public function set percentHeight(_arg_1:Number):void
        {
        }

        public function resolveAutomationIDPart(_arg_1:Object):Array
        {
            return ([]);
        }

        public function set inheritingStyles(_arg_1:Object):void
        {
            _inheritingStyles = _arg_1;
        }

        public function getUITextFormat():UITextFormat
        {
            validateNow();
            var _local_1:UITextFormat = new UITextFormat(creatingSystemManager());
            _local_1.moduleFactory = moduleFactory;
            _local_1.copyFrom(getTextFormat());
            _local_1.antiAliasType = antiAliasType;
            _local_1.gridFitType = gridFitType;
            _local_1.sharpness = sharpness;
            _local_1.thickness = thickness;
            return (_local_1);
        }

        private function changeHandler(_arg_1:Event):void
        {
            explicitHTMLText = null;
        }

        public function set initialized(_arg_1:Boolean):void
        {
            _initialized = _arg_1;
        }

        public function get nonZeroTextHeight():Number
        {
            var _local_1:Number;
            if (super.text == "")
            {
                super.text = "Wj";
                _local_1 = textHeight;
                super.text = "";
                return (_local_1);
            };
            return (textHeight);
        }

        public function owns(_arg_1:DisplayObject):Boolean
        {
            return (_arg_1 == this);
        }

        override public function setTextFormat(_arg_1:TextFormat, _arg_2:int=-1, _arg_3:int=-1):void
        {
            if (styleSheet)
            {
                return;
            };
            super.setTextFormat(_arg_1, _arg_2, _arg_3);
            dispatchEvent(new Event("textFormatChange"));
        }

        public function get nonInheritingStyles():Object
        {
            return (_nonInheritingStyles);
        }

        public function setVisible(_arg_1:Boolean, _arg_2:Boolean=false):void
        {
            this.visible = _arg_1;
        }

        public function get maxHeight():Number
        {
            return (UIComponent.DEFAULT_MAX_HEIGHT);
        }

        public function get automationDelegate():Object
        {
            return (_automationDelegate);
        }

        public function get isPopUp():Boolean
        {
            return (false);
        }

        public function set ignorePadding(_arg_1:Boolean):void
        {
            _ignorePadding = _arg_1;
            styleChanged(null);
        }

        public function set styleName(_arg_1:Object):void
        {
            if (_styleName === _arg_1)
            {
                return;
            };
            _styleName = _arg_1;
            if (parent)
            {
                StyleProtoChain.initTextField(this);
                styleChanged("styleName");
            };
        }

        public function styleChanged(_arg_1:String):void
        {
            styleChangedFlag = true;
            if (!invalidateDisplayListFlag)
            {
                invalidateDisplayListFlag = true;
                if (("callLater" in parent))
                {
                    Object(parent).callLater(validateNow);
                };
            };
        }

        public function get percentHeight():Number
        {
            return (NaN);
        }

        private function get isHTML():Boolean
        {
            return (!(explicitHTMLText == null));
        }

        public function get explicitMaxHeight():Number
        {
            return (NaN);
        }

        public function get styleName():Object
        {
            return (_styleName);
        }

        public function set explicitWidth(_arg_1:Number):void
        {
            _explicitWidth = _arg_1;
        }

        public function validateNow():void
        {
            var _local_1:TextFormat;
            var _local_2:EmbeddedFont;
            var _local_3:IFlexModuleFactory;
            var _local_4:ISystemManager;
            if (!parent)
            {
                return;
            };
            if (((!(isNaN(explicitWidth))) && (!(super.width == explicitWidth))))
            {
                super.width = ((explicitWidth > 4) ? explicitWidth : 4);
            };
            if (((!(isNaN(explicitHeight))) && (!(super.height == explicitHeight))))
            {
                super.height = explicitHeight;
            };
            if (styleChangedFlag)
            {
                _local_1 = getTextStyles();
                if (_local_1.font)
                {
                    _local_2 = getEmbeddedFont(_local_1.font, _local_1.bold, _local_1.italic);
                    _local_3 = embeddedFontRegistry.getAssociatedModuleFactory(_local_2, moduleFactory);
                    if (_local_3 != null)
                    {
                        embedFonts = true;
                    }
                    else
                    {
                        _local_4 = creatingSystemManager();
                        embedFonts = ((!(_local_4 == null)) && (_local_4.isFontFaceEmbedded(_local_1)));
                    };
                }
                else
                {
                    embedFonts = getStyle("embedFonts");
                };
                if (getStyle("fontAntiAliasType") != undefined)
                {
                    antiAliasType = getStyle("fontAntiAliasType");
                    gridFitType = getStyle("fontGridFitType");
                    sharpness = getStyle("fontSharpness");
                    thickness = getStyle("fontThickness");
                };
                if (!styleSheet)
                {
                    super.setTextFormat(_local_1);
                    defaultTextFormat = _local_1;
                };
                dispatchEvent(new Event("textFieldStyleChange"));
            };
            styleChangedFlag = false;
            invalidateDisplayListFlag = false;
        }

        public function set toolTip(_arg_1:String):void
        {
            var _local_2:String = _toolTip;
            _toolTip = _arg_1;
            ToolTipManager.registerToolTip(this, _local_2, _arg_1);
        }

        public function move(_arg_1:Number, _arg_2:Number):void
        {
            if (this.x != _arg_1)
            {
                this.x = _arg_1;
            };
            if (this.y != _arg_2)
            {
                this.y = _arg_2;
            };
        }

        public function get toolTip():String
        {
            return (_toolTip);
        }

        public function get ignorePadding():Boolean
        {
            return (_ignorePadding);
        }

        public function get explicitWidth():Number
        {
            return (_explicitWidth);
        }

        public function invalidateSize():void
        {
            invalidateDisplayListFlag = true;
        }

        public function set measuredMinHeight(_arg_1:Number):void
        {
        }

        public function get measuredMinHeight():Number
        {
            return (0);
        }

        public function set moduleFactory(_arg_1:IFlexModuleFactory):void
        {
            _moduleFactory = _arg_1;
        }


    }
}//package mx.core

