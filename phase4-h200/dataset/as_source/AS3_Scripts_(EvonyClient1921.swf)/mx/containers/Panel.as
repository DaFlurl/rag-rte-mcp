// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Panel

package mx.containers
{
    import mx.core.Container;
    import mx.containers.utilityClasses.IConstraintLayout;
    import mx.core.IFontContextComponent;
    import mx.containers.utilityClasses.Layout;
    import mx.core.IFlexDisplayObject;
    import mx.controls.Button;
    import mx.core.IUITextField;
    import mx.core.IUIComponent;
    import mx.core.UIComponent;
    import mx.core.EdgeMetrics;
    import mx.effects.EffectManager;
    import mx.core.EventPriority;
    import mx.containers.utilityClasses.BoxLayout;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import mx.styles.IStyleClient;
    import mx.styles.ISimpleStyleClient;
    import mx.styles.StyleProxy;
    import mx.core.UIComponentCachePolicy;
    import flash.display.Graphics;
    import flash.utils.getQualifiedClassName;
    import mx.core.FlexVersion;
    import mx.core.UITextField;
    import mx.core.ContainerLayout;
    import mx.containers.utilityClasses.CanvasLayout;
    import flash.events.Event;
    import mx.core.IFlexModuleFactory;
    import flash.geom.Rectangle;
    import mx.core.UITextFormat;
    import flash.text.TextLineMetrics;
    import mx.events.CloseEvent;
    import mx.automation.IAutomationObject;
    import mx.containers.utilityClasses.ConstraintColumn;
    import mx.events.SandboxMouseEvent;
    import mx.containers.utilityClasses.ConstraintRow;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Panel extends Container implements IConstraintLayout, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const HEADER_PADDING:Number = 14;
        mx_internal static var createAccessibilityImplementation:Function;
        private static var _closeButtonStyleFilters:Object = {
            "closeButtonUpSkin":"closeButtonUpSkin",
            "closeButtonOverSkin":"closeButtonOverSkin",
            "closeButtonDownSkin":"closeButtonDownSkin",
            "closeButtonDisabledSkin":"closeButtonDisabledSkin",
            "closeButtonSkin":"closeButtonSkin",
            "repeatDelay":"repeatDelay",
            "repeatInterval":"repeatInterval"
        };

        private var layoutObject:Layout;
        private var _status:String = "";
        private var _titleChanged:Boolean = false;
        mx_internal var titleBarBackground:IFlexDisplayObject;
        private var regX:Number;
        private var regY:Number;
        private var _layout:String = "vertical";
        mx_internal var closeButton:Button;
        private var initializing:Boolean = true;
        private var _title:String = "";
        protected var titleTextField:IUITextField;
        private var _statusChanged:Boolean = false;
        private var autoSetRoundedCorners:Boolean;
        private var _titleIcon:Class;
        protected var controlBar:IUIComponent;
        mx_internal var titleIconObject:Object = null;
        protected var titleBar:UIComponent;
        private var panelViewMetrics:EdgeMetrics;
        mx_internal var _showCloseButton:Boolean = false;
        private var checkedForAutoSetRoundedCorners:Boolean;
        private var _titleIconChanged:Boolean = false;
        protected var statusTextField:IUITextField;

        private var _constraintColumns:Array = [];
        private var _constraintRows:Array = [];

        public function Panel()
        {
            addEventListener("resizeStart", EffectManager.eventHandler, false, EventPriority.EFFECT);
            addEventListener("resizeEnd", EffectManager.eventHandler, false, EventPriority.EFFECT);
            layoutObject = new BoxLayout();
            layoutObject.target = this;
            showInAutomationHierarchy = true;
        }

        private function systemManager_mouseUpHandler(_arg_1:MouseEvent):void
        {
            if (!isNaN(regX))
            {
                stopDragging();
            };
        }

        mx_internal function getHeaderHeightProxy():Number
        {
            return (getHeaderHeight());
        }

        override public function getChildIndex(_arg_1:DisplayObject):int
        {
            if (((controlBar) && (_arg_1 == controlBar)))
            {
                return (numChildren);
            };
            return (super.getChildIndex(_arg_1));
        }

        mx_internal function get _controlBar():IUIComponent
        {
            return (controlBar);
        }

        mx_internal function getTitleBar():UIComponent
        {
            return (titleBar);
        }

        [Bindable("layoutChanged")]
        public function get layout():String
        {
            return (_layout);
        }

        override protected function createChildren():void
        {
            var _local_1:Class;
            var _local_2:IStyleClient;
            var _local_3:ISimpleStyleClient;
            super.createChildren();
            if (!titleBar)
            {
                titleBar = new UIComponent();
                titleBar.visible = false;
                titleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
                rawChildren.addChild(titleBar);
            };
            if (!titleBarBackground)
            {
                _local_1 = getStyle("titleBackgroundSkin");
                if (_local_1)
                {
                    titleBarBackground = new (_local_1)();
                    _local_2 = (titleBarBackground as IStyleClient);
                    if (_local_2)
                    {
                        _local_2.setStyle("backgroundImage", undefined);
                    };
                    _local_3 = (titleBarBackground as ISimpleStyleClient);
                    if (_local_3)
                    {
                        _local_3.styleName = this;
                    };
                    titleBar.addChild(DisplayObject(titleBarBackground));
                };
            };
            createTitleTextField(-1);
            createStatusTextField(-1);
            if (!closeButton)
            {
                closeButton = new Button();
                closeButton.styleName = new StyleProxy(this, closeButtonStyleFilters);
                closeButton.upSkinName = "closeButtonUpSkin";
                closeButton.overSkinName = "closeButtonOverSkin";
                closeButton.downSkinName = "closeButtonDownSkin";
                closeButton.disabledSkinName = "closeButtonDisabledSkin";
                closeButton.skinName = "closeButtonSkin";
                closeButton.explicitWidth = (closeButton.explicitHeight = 16);
                closeButton.focusEnabled = false;
                closeButton.visible = false;
                closeButton.enabled = enabled;
                closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
                titleBar.addChild(closeButton);
                closeButton.owner = this;
            };
        }

        public function get constraintColumns():Array
        {
            return (_constraintColumns);
        }

        override public function set cacheAsBitmap(_arg_1:Boolean):void
        {
            super.cacheAsBitmap = _arg_1;
            if (((((cacheAsBitmap) && (!(contentPane))) && (!(cachePolicy == UIComponentCachePolicy.OFF))) && (getStyle("backgroundColor"))))
            {
                createContentPane();
                invalidateDisplayList();
            };
        }

        override public function createComponentsFromDescriptors(_arg_1:Boolean=true):void
        {
            var _local_3:Object;
            super.createComponentsFromDescriptors();
            if (numChildren == 0)
            {
                setControlBar(null);
                return;
            };
            var _local_2:IUIComponent = IUIComponent(getChildAt((numChildren - 1)));
            if ((_local_2 is ControlBar))
            {
                _local_3 = _local_2.document;
                if (contentPane)
                {
                    contentPane.removeChild(DisplayObject(_local_2));
                }
                else
                {
                    removeChild(DisplayObject(_local_2));
                };
                _local_2.document = _local_3;
                rawChildren.addChild(DisplayObject(_local_2));
                setControlBar(_local_2);
            }
            else
            {
                setControlBar(null);
            };
        }

        override protected function layoutChrome(_arg_1:Number, _arg_2:Number):void
        {
            var _local_9:Number;
            var _local_10:Graphics;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_21:Number;
            super.layoutChrome(_arg_1, _arg_2);
            var _local_3:EdgeMetrics = EdgeMetrics.EMPTY;
            var _local_4:Number = getStyle("borderThickness");
            if ((((getQualifiedClassName(border) == "mx.skins.halo::PanelSkin") && (!(getStyle("borderStyle") == "default"))) && (_local_4)))
            {
                _local_3 = new EdgeMetrics(_local_4, _local_4, _local_4, _local_4);
            };
            var _local_5:EdgeMetrics = ((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) ? borderMetrics : _local_3);
            var _local_6:Number = _local_5.left;
            var _local_7:Number = _local_5.top;
            var _local_8:Number = getHeaderHeight();
            if (((_local_8 > 0) && (height >= _local_8)))
            {
                _local_9 = ((_arg_1 - _local_5.left) - _local_5.right);
                showTitleBar(true);
                titleBar.mouseChildren = true;
                titleBar.mouseEnabled = true;
                _local_10 = titleBar.graphics;
                _local_10.clear();
                _local_10.beginFill(0xFFFFFF, 0);
                _local_10.drawRect(0, 0, _local_9, _local_8);
                _local_10.endFill();
                _local_10.lineStyle(0, 0, 0);
                _local_10.drawRect(0, 0, _local_9, _arg_2);
                titleBar.move(_local_6, _local_7);
                titleBar.setActualSize(_local_9, _local_8);
                titleBarBackground.move(0, 0);
                IFlexDisplayObject(titleBarBackground).setActualSize(_local_9, _local_8);
                closeButton.visible = _showCloseButton;
                if (_showCloseButton)
                {
                    closeButton.setActualSize(closeButton.getExplicitOrMeasuredWidth(), closeButton.getExplicitOrMeasuredHeight());
                    closeButton.move(((((_arg_1 - _local_6) - _local_5.right) - 10) - closeButton.getExplicitOrMeasuredWidth()), ((_local_8 - closeButton.getExplicitOrMeasuredHeight()) / 2));
                };
                _local_11 = 10;
                _local_12 = 10;
                if (titleIconObject)
                {
                    _local_13 = titleIconObject.height;
                    _local_14 = ((_local_8 - _local_13) / 2);
                    titleIconObject.move(_local_11, _local_14);
                    _local_11 = (_local_11 + (titleIconObject.width + 4));
                };
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _local_13 = titleTextField.nonZeroTextHeight;
                }
                else
                {
                    _local_13 = titleTextField.getUITextFormat().measureText(titleTextField.text).height;
                };
                _local_14 = ((_local_8 - _local_13) / 2);
                _local_15 = (_local_5.left + _local_5.right);
                titleTextField.move(_local_11, (_local_14 - 1));
                titleTextField.setActualSize(Math.max(0, (((_arg_1 - _local_11) - _local_12) - _local_15)), (_local_13 + UITextField.TEXT_HEIGHT_PADDING));
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _local_13 = statusTextField.textHeight;
                }
                else
                {
                    _local_13 = ((statusTextField.text != "") ? statusTextField.getUITextFormat().measureText(statusTextField.text).height : 0);
                };
                _local_14 = ((_local_8 - _local_13) / 2);
                _local_16 = ((((_arg_1 - _local_12) - 4) - _local_15) - statusTextField.textWidth);
                if (_showCloseButton)
                {
                    _local_16 = (_local_16 - (closeButton.getExplicitOrMeasuredWidth() + 4));
                };
                statusTextField.move(_local_16, (_local_14 - 1));
                statusTextField.setActualSize((statusTextField.textWidth + 8), (statusTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING));
                _local_17 = ((titleTextField.x + titleTextField.textWidth) + 8);
                if (statusTextField.x < _local_17)
                {
                    statusTextField.width = Math.max((statusTextField.width - (_local_17 - statusTextField.x)), 0);
                    statusTextField.x = _local_17;
                };
            }
            else
            {
                if (titleBar)
                {
                    showTitleBar(false);
                    titleBar.mouseChildren = false;
                    titleBar.mouseEnabled = false;
                };
            };
            if (controlBar)
            {
                _local_18 = controlBar.x;
                _local_19 = controlBar.y;
                _local_20 = controlBar.width;
                _local_21 = controlBar.height;
                controlBar.setActualSize((_arg_1 - (_local_5.left + _local_5.right)), controlBar.getExplicitOrMeasuredHeight());
                controlBar.move(_local_5.left, ((_arg_2 - _local_5.bottom) - controlBar.getExplicitOrMeasuredHeight()));
                if (controlBar.includeInLayout)
                {
                    controlBar.visible = (controlBar.y >= _local_5.top);
                };
                if (((((!(_local_18 == controlBar.x)) || (!(_local_19 == controlBar.y))) || (!(_local_20 == controlBar.width))) || (!(_local_21 == controlBar.height))))
                {
                    invalidateDisplayList();
                };
            };
        }

        public function set layout(_arg_1:String):void
        {
            if (_layout != _arg_1)
            {
                _layout = _arg_1;
                if (layoutObject)
                {
                    layoutObject.target = null;
                };
                if (_layout == ContainerLayout.ABSOLUTE)
                {
                    layoutObject = new CanvasLayout();
                }
                else
                {
                    layoutObject = new BoxLayout();
                    if (_layout == ContainerLayout.VERTICAL)
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.VERTICAL;
                    }
                    else
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.HORIZONTAL;
                    };
                };
                if (layoutObject)
                {
                    layoutObject.target = this;
                };
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("layoutChanged"));
            };
        }

        public function get constraintRows():Array
        {
            return (_constraintRows);
        }

        [Bindable("titleChanged")]
        public function get title():String
        {
            return (_title);
        }

        mx_internal function getTitleTextField():IUITextField
        {
            return (titleTextField);
        }

        mx_internal function createStatusTextField(_arg_1:int):void
        {
            var _local_2:String;
            if (((titleBar) && (!(statusTextField))))
            {
                statusTextField = IUITextField(createInFontContext(UITextField));
                statusTextField.selectable = false;
                if (_arg_1 == -1)
                {
                    titleBar.addChild(DisplayObject(statusTextField));
                }
                else
                {
                    titleBar.addChildAt(DisplayObject(statusTextField), _arg_1);
                };
                _local_2 = getStyle("statusStyleName");
                statusTextField.styleName = _local_2;
                statusTextField.text = status;
                statusTextField.enabled = enabled;
            };
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        override protected function measure():void
        {
            var _local_6:Number;
            super.measure();
            layoutObject.measure();
            var _local_1:Rectangle = measureHeaderText();
            var _local_2:Number = _local_1.width;
            var _local_3:Number = _local_1.height;
            var _local_4:EdgeMetrics = ((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) ? borderMetrics : EdgeMetrics.EMPTY);
            _local_2 = (_local_2 + (_local_4.left + _local_4.right));
            var _local_5:Number = 5;
            _local_2 = (_local_2 + (_local_5 * 2));
            if (titleIconObject)
            {
                _local_2 = (_local_2 + titleIconObject.width);
            };
            if (closeButton)
            {
                _local_2 = (_local_2 + (closeButton.getExplicitOrMeasuredWidth() + 6));
            };
            measuredMinWidth = Math.max(_local_2, measuredMinWidth);
            measuredWidth = Math.max(_local_2, measuredWidth);
            if (((controlBar) && (controlBar.includeInLayout)))
            {
                _local_6 = ((controlBar.getExplicitOrMeasuredWidth() + _local_4.left) + _local_4.right);
                measuredWidth = Math.max(measuredWidth, _local_6);
            };
        }

        mx_internal function getControlBar():IUIComponent
        {
            return (controlBar);
        }

        override public function get viewMetrics():EdgeMetrics
        {
            var _local_2:EdgeMetrics;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_1:EdgeMetrics = super.viewMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (!panelViewMetrics)
                {
                    panelViewMetrics = new EdgeMetrics(0, 0, 0, 0);
                };
                _local_1 = panelViewMetrics;
                _local_2 = super.viewMetrics;
                _local_3 = getStyle("borderThickness");
                _local_4 = getStyle("borderThicknessLeft");
                _local_5 = getStyle("borderThicknessTop");
                _local_6 = getStyle("borderThicknessRight");
                _local_7 = getStyle("borderThicknessBottom");
                _local_1.left = (_local_2.left + ((isNaN(_local_4)) ? _local_3 : _local_4));
                _local_1.top = (_local_2.top + ((isNaN(_local_5)) ? _local_3 : _local_5));
                _local_1.right = (_local_2.right + ((isNaN(_local_6)) ? _local_3 : _local_6));
                _local_1.bottom = (_local_2.bottom + ((isNaN(_local_7)) ? (((controlBar) && (!(isNaN(_local_5)))) ? _local_5 : ((isNaN(_local_4)) ? _local_3 : _local_4)) : _local_7));
                _local_8 = getHeaderHeight();
                if (!isNaN(_local_8))
                {
                    _local_1.top = (_local_1.top + _local_8);
                };
                if (((controlBar) && (controlBar.includeInLayout)))
                {
                    _local_1.bottom = (_local_1.bottom + controlBar.getExplicitOrMeasuredHeight());
                };
            };
            return (_local_1);
        }

        private function measureHeaderText():Rectangle
        {
            var _local_3:UITextFormat;
            var _local_4:TextLineMetrics;
            var _local_1:Number = 20;
            var _local_2:Number = 14;
            if (((titleTextField) && (titleTextField.text)))
            {
                titleTextField.validateNow();
                _local_3 = titleTextField.getUITextFormat();
                _local_4 = _local_3.measureText(titleTextField.text, false);
                _local_1 = _local_4.width;
                _local_2 = _local_4.height;
            };
            if (((statusTextField) && (statusTextField.text)))
            {
                statusTextField.validateNow();
                _local_3 = statusTextField.getUITextFormat();
                _local_4 = _local_3.measureText(statusTextField.text, false);
                _local_1 = Math.max(_local_1, _local_4.width);
                _local_2 = Math.max(_local_2, _local_4.height);
            };
            return (new Rectangle(0, 0, Math.round(_local_1), Math.round(_local_2)));
        }

        mx_internal function createTitleTextField(_arg_1:int):void
        {
            var _local_2:String;
            if (!titleTextField)
            {
                titleTextField = IUITextField(createInFontContext(UITextField));
                titleTextField.selectable = false;
                if (_arg_1 == -1)
                {
                    titleBar.addChild(DisplayObject(titleTextField));
                }
                else
                {
                    titleBar.addChildAt(DisplayObject(titleTextField), _arg_1);
                };
                _local_2 = getStyle("titleStyleName");
                titleTextField.styleName = _local_2;
                titleTextField.text = title;
                titleTextField.enabled = enabled;
            };
        }

        private function closeButton_clickHandler(_arg_1:MouseEvent):void
        {
            dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
        }

        private function setControlBar(_arg_1:IUIComponent):void
        {
            if (_arg_1 == controlBar)
            {
                return;
            };
            controlBar = _arg_1;
            if (!checkedForAutoSetRoundedCorners)
            {
                checkedForAutoSetRoundedCorners = true;
                autoSetRoundedCorners = ((styleDeclaration) ? (styleDeclaration.getStyle("roundedBottomCorners") === undefined) : true);
            };
            if (autoSetRoundedCorners)
            {
                setStyle("roundedBottomCorners", (!(controlBar == null)));
            };
            var _local_2:String = getStyle("controlBarStyleName");
            if (((_local_2) && (controlBar is ISimpleStyleClient)))
            {
                ISimpleStyleClient(controlBar).styleName = _local_2;
            };
            if (controlBar)
            {
                controlBar.enabled = enabled;
            };
            if ((controlBar is IAutomationObject))
            {
                IAutomationObject(controlBar).showInAutomationHierarchy = false;
            };
            invalidateViewMetricsAndPadding();
            invalidateSize();
            invalidateDisplayList();
        }

        protected function get closeButtonStyleFilters():Object
        {
            return (_closeButtonStyleFilters);
        }

        public function set constraintColumns(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1 != _constraintColumns)
            {
                _local_2 = _arg_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    ConstraintColumn(_arg_1[_local_3]).container = this;
                    _local_3++;
                };
                _constraintColumns = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (titleTextField)
            {
                titleTextField.enabled = _arg_1;
            };
            if (statusTextField)
            {
                statusTextField.enabled = _arg_1;
            };
            if (controlBar)
            {
                controlBar.enabled = _arg_1;
            };
            if (closeButton)
            {
                closeButton.enabled = _arg_1;
            };
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (super.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return ((titleBar.y + titleTextField.y) + titleTextField.baselinePosition);
        }

        protected function stopDragging():void
        {
            var _local_1:DisplayObject = systemManager.getSandboxRoot();
            _local_1.removeEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            _local_1.removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            _local_1.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            regX = NaN;
            regY = NaN;
            systemManager.deployMouseShields(false);
        }

        private function titleBar_mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.target == closeButton)
            {
                return;
            };
            if ((((enabled) && (isPopUp)) && (isNaN(regX))))
            {
                startDragging(_arg_1);
            };
        }

        override mx_internal function get usePadding():Boolean
        {
            return (!(layout == ContainerLayout.ABSOLUTE));
        }

        override protected function initializeAccessibility():void
        {
            if (Panel.createAccessibilityImplementation != null)
            {
                Panel.createAccessibilityImplementation(this);
            };
        }

        protected function getHeaderHeight():Number
        {
            var _local_1:Number = getStyle("headerHeight");
            if (isNaN(_local_1))
            {
                _local_1 = (measureHeaderText().height + HEADER_PADDING);
            };
            return (_local_1);
        }

        public function set constraintRows(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1 != _constraintRows)
            {
                _local_2 = _arg_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    ConstraintRow(_arg_1[_local_3]).container = this;
                    _local_3++;
                };
                _constraintRows = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }

        public function set title(_arg_1:String):void
        {
            _title = _arg_1;
            _titleChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            dispatchEvent(new Event("titleChanged"));
        }

        private function showTitleBar(_arg_1:Boolean):void
        {
            var _local_4:DisplayObject;
            titleBar.visible = _arg_1;
            var _local_2:int = titleBar.numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = titleBar.getChildAt(_local_3);
                _local_4.visible = _arg_1;
                _local_3++;
            };
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:Class;
            var _local_7:IStyleClient;
            var _local_8:ISimpleStyleClient;
            var _local_2:Boolean = ((!(_arg_1)) || (_arg_1 == "styleName"));
            super.styleChanged(_arg_1);
            if (((_local_2) || (_arg_1 == "titleStyleName")))
            {
                if (titleTextField)
                {
                    _local_3 = getStyle("titleStyleName");
                    titleTextField.styleName = _local_3;
                };
            };
            if (((_local_2) || (_arg_1 == "statusStyleName")))
            {
                if (statusTextField)
                {
                    _local_4 = getStyle("statusStyleName");
                    statusTextField.styleName = _local_4;
                };
            };
            if (((_local_2) || (_arg_1 == "controlBarStyleName")))
            {
                if (((controlBar) && (controlBar is ISimpleStyleClient)))
                {
                    _local_5 = getStyle("controlBarStyleName");
                    ISimpleStyleClient(controlBar).styleName = _local_5;
                };
            };
            if (((_local_2) || (_arg_1 == "titleBackgroundSkin")))
            {
                if (titleBar)
                {
                    _local_6 = getStyle("titleBackgroundSkin");
                    if (_local_6)
                    {
                        if (titleBarBackground)
                        {
                            titleBar.removeChild(DisplayObject(titleBarBackground));
                            titleBarBackground = null;
                        };
                        titleBarBackground = new (_local_6)();
                        _local_7 = (titleBarBackground as IStyleClient);
                        if (_local_7)
                        {
                            _local_7.setStyle("backgroundImage", undefined);
                        };
                        _local_8 = (titleBarBackground as ISimpleStyleClient);
                        if (_local_8)
                        {
                            _local_8.styleName = this;
                        };
                        titleBar.addChildAt(DisplayObject(titleBarBackground), 0);
                    };
                };
            };
        }

        mx_internal function getStatusTextField():IUITextField
        {
            return (statusTextField);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            super.commitProperties();
            if (hasFontContextChanged())
            {
                if (titleTextField)
                {
                    _local_1 = titleBar.getChildIndex(DisplayObject(titleTextField));
                    removeTitleTextField();
                    createTitleTextField(_local_1);
                    _titleChanged = true;
                };
                if (statusTextField)
                {
                    _local_1 = titleBar.getChildIndex(DisplayObject(statusTextField));
                    removeStatusTextField();
                    createStatusTextField(_local_1);
                    _statusChanged = true;
                };
            };
            if (_titleChanged)
            {
                _titleChanged = false;
                titleTextField.text = _title;
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                };
            };
            if (_titleIconChanged)
            {
                _titleIconChanged = false;
                if (titleIconObject)
                {
                    titleBar.removeChild(DisplayObject(titleIconObject));
                    titleIconObject = null;
                };
                if (_titleIcon)
                {
                    titleIconObject = new _titleIcon();
                    titleBar.addChild(DisplayObject(titleIconObject));
                };
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                };
            };
            if (_statusChanged)
            {
                _statusChanged = false;
                statusTextField.text = _status;
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                };
            };
        }

        protected function startDragging(_arg_1:MouseEvent):void
        {
            regX = (_arg_1.stageX - x);
            regY = (_arg_1.stageY - y);
            var _local_2:DisplayObject = systemManager.getSandboxRoot();
            _local_2.addEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            _local_2.addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            _local_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            systemManager.deployMouseShields(true);
        }

        mx_internal function removeStatusTextField():void
        {
            if (((titleBar) && (statusTextField)))
            {
                titleBar.removeChild(DisplayObject(statusTextField));
                statusTextField = null;
            };
        }

        private function stage_mouseLeaveHandler(_arg_1:Event):void
        {
            if (!isNaN(regX))
            {
                stopDragging();
            };
        }

        public function set status(_arg_1:String):void
        {
            _status = _arg_1;
            _statusChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("statusChanged"));
        }

        [Bindable("titleIconChanged")]
        public function get titleIcon():Class
        {
            return (_titleIcon);
        }

        [Bindable("statusChanged")]
        public function get status():String
        {
            return (_status);
        }

        private function systemManager_mouseMoveHandler(_arg_1:MouseEvent):void
        {
            _arg_1.stopImmediatePropagation();
            if (((isNaN(regX)) || (isNaN(regY))))
            {
                return;
            };
            move((_arg_1.stageX - regX), (_arg_1.stageY - regY));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            layoutObject.updateDisplayList(_arg_1, _arg_2);
            if (border)
            {
                border.visible = true;
            };
            titleBar.visible = true;
        }

        mx_internal function removeTitleTextField():void
        {
            if (((titleBar) && (titleTextField)))
            {
                titleBar.removeChild(DisplayObject(titleTextField));
                titleTextField = null;
            };
        }

        public function set titleIcon(_arg_1:Class):void
        {
            _titleIcon = _arg_1;
            _titleIconChanged = true;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("titleIconChanged"));
        }


    }
}//package mx.containers

