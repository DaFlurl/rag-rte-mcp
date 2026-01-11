// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.UIComponent

package mx.core
{
    import mx.automation.IAutomationObject;
    import mx.managers.ILayoutManagerClient;
    import mx.styles.ISimpleStyleClient;
    import mx.styles.IStyleClient;
    import mx.managers.IToolTipManagerClient;
    import mx.validators.IValidatorListener;
    import mx.managers.ISystemManager;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.IFocusManager;
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import mx.effects.IEffect;
    import mx.controls.IFlexContextMenu;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.managers.IFocusManagerComponent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import mx.core.UIComponentGlobals;
    import mx.managers.SystemManagerGlobals;
    import mx.events.EffectEvent;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import mx.events.DynamicEvent;
    import mx.styles.StyleManager;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Matrix;
    import mx.events.FlexEvent;
    import mx.states.State;
    import flash.geom.Rectangle;
    import flash.display.Stage;
    import mx.utils.StringUtil;
    import mx.events.ResizeEvent;
    import mx.events.ChildExistenceChangedEvent;
    import mx.graphics.RoundedRectangle;
    import mx.managers.ToolTipManager;
    import mx.validators.ValidationResult;
    import mx.events.ValidationResultEvent;
    import mx.effects.EffectManager;
    import flash.display.Loader;
    import mx.utils.ColorUtil;
    import mx.binding.BindingManager;
    import mx.effects.IEffectInstance;
    import flash.display.Graphics;
    import mx.managers.SystemManager;
    import mx.events.StateChangeEvent;
    import mx.managers.SystemManagerProxy;
    import mx.states.Transition;
    import mx.events.PropertyChangeEvent;
    import mx.events.MoveEvent;
    import flash.display.InteractiveObject;
    import mx.styles.StyleProtoChain;
    import flash.text.TextLineMetrics;
    import flash.events.EventPhase;
    import flash.system.ApplicationDomain;
    import mx.modules.ModuleManager;
    import flash.utils.getQualifiedSuperclassName;
    import mx.managers.ICursorManager;
    import mx.managers.CursorManager;
    import mx.managers.IFocusManagerContainer;
    import flash.display.GradientType;
    import mx.utils.GraphicsUtil;
    import flash.events.IEventDispatcher;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UIComponent extends FlexSprite implements IAutomationObject, IChildList, IDeferredInstantiationUIComponent, IFlexDisplayObject, IFlexModule, IInvalidating, ILayoutManagerClient, IPropertyChangeNotifier, IRepeaterClient, ISimpleStyleClient, IStyleClient, IToolTipManagerClient, IUIComponent, IValidatorListener, IStateClient, IConstraintClient 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const DEFAULT_MEASURED_WIDTH:Number = 160;
        public static const DEFAULT_MEASURED_MIN_WIDTH:Number = 40;
        public static const DEFAULT_MEASURED_HEIGHT:Number = 22;
        public static const DEFAULT_MEASURED_MIN_HEIGHT:Number = 22;
        public static const DEFAULT_MAX_WIDTH:Number = 10000;
        public static const DEFAULT_MAX_HEIGHT:Number = 10000;
        mx_internal static var STYLE_UNINITIALIZED:Object = {};
        mx_internal static var createAccessibilityImplementation:Function;
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
        mx_internal static var dispatchEventHook:Function;
        private static var fakeMouseX:QName = new QName(mx_internal, "_mouseX");
        private static var fakeMouseY:QName = new QName(mx_internal, "_mouseY");

        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var errorStringChanged:Boolean = false;
        mx_internal var overlay:UIComponent;
        mx_internal var automaticRadioButtonGroups:Object;
        private var _currentState:String;
        private var _isPopUp:Boolean;
        private var _repeaters:Array;
        private var _systemManager:ISystemManager;
        private var _measuredWidth:Number = 0;
        mx_internal var _width:Number;
        private var _tweeningProperties:Array;
        private var _validationSubField:String;
        mx_internal var saveBorderColor:Boolean = true;
        mx_internal var overlayColor:uint;
        mx_internal var overlayReferenceCount:int = 0;
        private var hasFontContextBeenSaved:Boolean = false;
        private var _repeaterIndices:Array;
        private var oldExplicitWidth:Number;
        mx_internal var _descriptor:UIComponentDescriptor;
        private var _initialized:Boolean = false;
        private var _focusEnabled:Boolean = true;
        private var cacheAsBitmapCount:int = 0;
        private var errorArray:Array;
        private var requestedCurrentState:String;
        private var listeningForRender:Boolean = false;
        mx_internal var invalidateDisplayListFlag:Boolean = false;
        private var oldScaleX:Number = 1;
        private var oldScaleY:Number = 1;
        mx_internal var _explicitMaxHeight:Number;
        mx_internal var invalidatePropertiesFlag:Boolean = false;
        private var hasFocusRect:Boolean = false;
        mx_internal var invalidateSizeFlag:Boolean = false;
        private var _scaleX:Number = 1;
        private var _scaleY:Number = 1;
        private var _styleDeclaration:CSSStyleDeclaration;
        mx_internal var _documentDescriptor:UIComponentDescriptor;
        private var _processedDescriptors:Boolean = false;
        mx_internal var origBorderColor:Number;
        private var _focusManager:IFocusManager;
        private var _cachePolicy:String = "auto";
        private var _measuredHeight:Number = 0;
        private var _id:String;
        private var _owner:DisplayObjectContainer;
        mx_internal var _parent:DisplayObjectContainer;
        private var _measuredMinWidth:Number = 0;
        private var oldMinWidth:Number;
        private var _explicitWidth:Number;
        private var _enabled:Boolean = false;
        private var _mouseFocusEnabled:Boolean = true;
        private var oldHeight:Number = 0;
        private var _currentStateChanged:Boolean;
        private var cachedTextFormat:UITextFormat;
        mx_internal var _height:Number;
        private var _automationDelegate:IAutomationObject;
        private var _percentWidth:Number;
        private var _automationName:String = null;
        private var _isEffectStarted:Boolean = false;
        private var _styleName:Object;
        private var lastUnscaledWidth:Number;
        mx_internal var _document:Object;
        mx_internal var _errorString:String = "";
        private var oldExplicitHeight:Number;
        private var _nestLevel:int = 0;
        private var _systemManagerDirty:Boolean = false;
        private var _explicitHeight:Number;
        mx_internal var _toolTip:String;
        private var _filters:Array;
        private var _focusPane:Sprite;
        private var playStateTransition:Boolean = true;
        private var _showInAutomationHierarchy:Boolean = true;
        private var _moduleFactory:IFlexModuleFactory;
        private var preventDrawFocus:Boolean = false;
        private var oldX:Number = 0;
        private var oldY:Number = 0;
        private var _instanceIndices:Array;
        private var errorObjectArray:Array;
        private var _visible:Boolean = true;
        private var _includeInLayout:Boolean = true;
        mx_internal var _explicitMinWidth:Number;
        private var lastUnscaledHeight:Number;
        mx_internal var _explicitMaxWidth:Number;
        private var _measuredMinHeight:Number = 0;
        private var _uid:String;
        private var _currentTransitionEffect:IEffect;
        private var _updateCompletePendingFlag:Boolean = false;
        private var oldMinHeight:Number;
        private var _flexContextMenu:IFlexContextMenu;
        mx_internal var _explicitMinHeight:Number;
        private var _percentHeight:Number;
        private var oldEmbeddedFontContext:IFlexModuleFactory = null;
        private var oldWidth:Number = 0;

        private var methodQueue:Array = [];
        private var _resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _inheritingStyles:Object = UIComponent.mx_internal::STYLE_UNINITIALIZED;
        private var _nonInheritingStyles:Object = UIComponent.mx_internal::STYLE_UNINITIALIZED;
        public var states:Array = [];
        public var transitions:Array = [];
        mx_internal var _effectsStarted:Array = [];
        mx_internal var _affectedProperties:Object = {};
        private var _endingEffectInstances:Array = [];

        public function UIComponent()
        {
            focusRect = false;
            tabEnabled = (this is IFocusManagerComponent);
            tabChildren = false;
            enabled = true;
            $visible = false;
            addEventListener(Event.ADDED, addedHandler);
            addEventListener(Event.REMOVED, removedHandler);
            if ((this is IFocusManagerComponent))
            {
                addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
                addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
                addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            };
            resourcesChanged();
            resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler, false, 0, true);
            _width = super.width;
            _height = super.height;
        }

        private static function get embeddedFontRegistry():IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            };
            return (_embeddedFontRegistry);
        }

        public static function resumeBackgroundProcessing():void
        {
            var _local_1:ISystemManager;
            if (UIComponentGlobals.callLaterSuspendCount > 0)
            {
                UIComponentGlobals.callLaterSuspendCount--;
                if (UIComponentGlobals.callLaterSuspendCount == 0)
                {
                    _local_1 = SystemManagerGlobals.topLevelSystemManagers[0];
                    if (((_local_1) && (_local_1.stage)))
                    {
                        _local_1.stage.invalidate();
                    };
                };
            };
        }

        public static function suspendBackgroundProcessing():void
        {
            UIComponentGlobals.callLaterSuspendCount++;
        }


        override public function get filters():Array
        {
            return ((_filters) ? _filters : super.filters);
        }

        [Bindable("toolTipChanged")]
        public function get toolTip():String
        {
            return (_toolTip);
        }

        private function transition_effectEndHandler(_arg_1:EffectEvent):void
        {
            _currentTransitionEffect = null;
        }

        public function get nestLevel():int
        {
            return (_nestLevel);
        }

        protected function adjustFocusRect(_arg_1:DisplayObject=null):void
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Point;
            var _local_7:Number;
            if (!_arg_1)
            {
                _arg_1 = this;
            };
            if (((isNaN(_arg_1.width)) || (isNaN(_arg_1.height))))
            {
                return;
            };
            var _local_2:IFocusManager = focusManager;
            if (!_local_2)
            {
                return;
            };
            var _local_3:IFlexDisplayObject = IFlexDisplayObject(getFocusObject());
            if (_local_3)
            {
                if (((errorString) && (!(errorString == ""))))
                {
                    _local_4 = getStyle("errorColor");
                }
                else
                {
                    _local_4 = getStyle("themeColor");
                };
                _local_5 = getStyle("focusThickness");
                if ((_local_3 is IStyleClient))
                {
                    IStyleClient(_local_3).setStyle("focusColor", _local_4);
                };
                _local_3.setActualSize((_arg_1.width + (2 * _local_5)), (_arg_1.height + (2 * _local_5)));
                if (rotation)
                {
                    _local_7 = ((rotation * Math.PI) / 180);
                    _local_6 = new Point((_arg_1.x - (_local_5 * (Math.cos(_local_7) - Math.sin(_local_7)))), (_arg_1.y - (_local_5 * (Math.cos(_local_7) + Math.sin(_local_7)))));
                    DisplayObject(_local_3).rotation = rotation;
                }
                else
                {
                    _local_6 = new Point((_arg_1.x - _local_5), (_arg_1.y - _local_5));
                };
                if (_arg_1.parent == this)
                {
                    _local_6.x = (_local_6.x + x);
                    _local_6.y = (_local_6.y + y);
                };
                _local_6 = parent.localToGlobal(_local_6);
                _local_6 = parent.globalToLocal(_local_6);
                _local_3.move(_local_6.x, _local_6.y);
                if ((_local_3 is IInvalidating))
                {
                    IInvalidating(_local_3).validateNow();
                }
                else
                {
                    if ((_local_3 is IProgrammaticSkin))
                    {
                        IProgrammaticSkin(_local_3).validateNow();
                    };
                };
            };
        }

        mx_internal function setUnscaledWidth(_arg_1:Number):void
        {
            var _local_2:Number = (_arg_1 * Math.abs(oldScaleX));
            if (_explicitWidth == _local_2)
            {
                return;
            };
            if (!isNaN(_local_2))
            {
                _percentWidth = NaN;
            };
            _explicitWidth = _local_2;
            invalidateSize();
            var _local_3:IInvalidating = (parent as IInvalidating);
            if (((_local_3) && (includeInLayout)))
            {
                _local_3.invalidateSize();
                _local_3.invalidateDisplayList();
            };
        }

        private function isOnDisplayList():Boolean
        {
            var p:DisplayObjectContainer;
            try
            {
                p = ((_parent) ? _parent : super.parent);
            }
            catch(e:SecurityError)
            {
                return (true);
            };
            return ((p) ? true : false);
        }

        public function set nestLevel(_arg_1:int):void
        {
            var _local_2:IChildList;
            var _local_3:int;
            var _local_4:int;
            var _local_5:ILayoutManagerClient;
            var _local_6:IUITextField;
            if (((_arg_1 > 1) && (!(_nestLevel == _arg_1))))
            {
                _nestLevel = _arg_1;
                updateCallbacks();
                _local_2 = ((this is IRawChildrenContainer) ? IRawChildrenContainer(this).rawChildren : IChildList(this));
                _local_3 = _local_2.numChildren;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_5 = (_local_2.getChildAt(_local_4) as ILayoutManagerClient);
                    if (_local_5)
                    {
                        _local_5.nestLevel = (_arg_1 + 1);
                    }
                    else
                    {
                        _local_6 = (_local_2.getChildAt(_local_4) as IUITextField);
                        if (_local_6)
                        {
                            _local_6.nestLevel = (_arg_1 + 1);
                        };
                    };
                    _local_4++;
                };
            };
        }

        public function getExplicitOrMeasuredHeight():Number
        {
            return ((isNaN(explicitHeight)) ? measuredHeight : explicitHeight);
        }

        private function callLaterDispatcher(event:Event):void
        {
            var callLaterErrorEvent:DynamicEvent;
            UIComponentGlobals.callLaterDispatcherCount++;
            if (!UIComponentGlobals.catchCallLaterExceptions)
            {
                callLaterDispatcher2(event);
            }
            else
            {
                try
                {
                    callLaterDispatcher2(event);
                }
                catch(e:Error)
                {
                    callLaterErrorEvent = new DynamicEvent("callLaterError");
                    callLaterErrorEvent.error = e;
                    systemManager.dispatchEvent(callLaterErrorEvent);
                };
            };
            UIComponentGlobals.callLaterDispatcherCount--;
        }

        public function getStyle(_arg_1:String):*
        {
            return ((StyleManager.inheritingStyles[_arg_1]) ? _inheritingStyles[_arg_1] : _nonInheritingStyles[_arg_1]);
        }

        final mx_internal function get $width():Number
        {
            return (super.width);
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

        public function verticalGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Matrix
        {
            UIComponentGlobals.tempMatrix.createGradientBox(_arg_3, _arg_4, (Math.PI / 2), _arg_1, _arg_2);
            return (UIComponentGlobals.tempMatrix);
        }

        public function setCurrentState(_arg_1:String, _arg_2:Boolean=true):void
        {
            if (((!(_arg_1 == currentState)) && (!((isBaseState(_arg_1)) && (isBaseState(currentState))))))
            {
                requestedCurrentState = _arg_1;
                playStateTransition = _arg_2;
                if (initialized)
                {
                    commitCurrentState();
                }
                else
                {
                    _currentStateChanged = true;
                    addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
                };
            };
        }

        private function getBaseStates(_arg_1:State):Array
        {
            var _local_2:Array = [];
            while (((_arg_1) && (_arg_1.basedOn)))
            {
                _local_2.push(_arg_1.basedOn);
                _arg_1 = getState(_arg_1.basedOn);
            };
            return (_local_2);
        }

        public function set minHeight(_arg_1:Number):void
        {
            if (explicitMinHeight == _arg_1)
            {
                return;
            };
            explicitMinHeight = _arg_1;
        }

        protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return (_arg_1 == this);
        }

        [Bindable("errorStringChanged")]
        public function get errorString():String
        {
            return (_errorString);
        }

        mx_internal function setUnscaledHeight(_arg_1:Number):void
        {
            var _local_2:Number = (_arg_1 * Math.abs(oldScaleY));
            if (_explicitHeight == _local_2)
            {
                return;
            };
            if (!isNaN(_local_2))
            {
                _percentHeight = NaN;
            };
            _explicitHeight = _local_2;
            invalidateSize();
            var _local_3:IInvalidating = (parent as IInvalidating);
            if (((_local_3) && (includeInLayout)))
            {
                _local_3.invalidateSize();
                _local_3.invalidateDisplayList();
            };
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

        final mx_internal function set $width(_arg_1:Number):void
        {
            super.width = _arg_1;
        }

        public function getVisibleRect(_arg_1:DisplayObject=null):Rectangle
        {
            if (!_arg_1)
            {
                _arg_1 = DisplayObject(systemManager);
            };
            var _local_2:DisplayObject = (($parent) ? $parent : parent);
            if (!_local_2)
            {
                return (new Rectangle());
            };
            var _local_3:Point = new Point(x, y);
            _local_3 = _local_2.localToGlobal(_local_3);
            var _local_4:Rectangle = new Rectangle(_local_3.x, _local_3.y, width, height);
            var _local_5:DisplayObject = this;
            var _local_6:Rectangle = new Rectangle();
            do 
            {
                if ((_local_5 is UIComponent))
                {
                    if (UIComponent(_local_5).$parent)
                    {
                        _local_5 = UIComponent(_local_5).$parent;
                    }
                    else
                    {
                        _local_5 = UIComponent(_local_5).parent;
                    };
                }
                else
                {
                    _local_5 = _local_5.parent;
                };
                if (((_local_5) && (_local_5.scrollRect)))
                {
                    _local_6 = _local_5.scrollRect.clone();
                    _local_3 = _local_5.localToGlobal(_local_6.topLeft);
                    _local_6.x = _local_3.x;
                    _local_6.y = _local_3.y;
                    _local_4 = _local_4.intersection(_local_6);
                };
            } while (((_local_5) && (!(_local_5 == _arg_1))));
            return (_local_4);
        }

        public function invalidateDisplayList():void
        {
            if (!invalidateDisplayListFlag)
            {
                invalidateDisplayListFlag = true;
                if (((isOnDisplayList()) && (UIComponentGlobals.layoutManager)))
                {
                    UIComponentGlobals.layoutManager.invalidateDisplayList(this);
                };
            };
        }

        mx_internal function initThemeColor():Boolean
        {
            var _local_2:Object;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Object;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:CSSStyleDeclaration;
            var _local_1:Object = _styleName;
            if (_styleDeclaration)
            {
                _local_2 = _styleDeclaration.getStyle("themeColor");
                _local_3 = _styleDeclaration.getStyle("rollOverColor");
                _local_4 = _styleDeclaration.getStyle("selectionColor");
            };
            if ((((_local_2 === null) || (!(StyleManager.isValidStyleValue(_local_2)))) && ((_local_1) && (!(_local_1 is ISimpleStyleClient)))))
            {
                _local_5 = ((_local_1 is String) ? StyleManager.getStyleDeclaration(("." + _local_1)) : _local_1);
                if (_local_5)
                {
                    _local_2 = _local_5.getStyle("themeColor");
                    _local_3 = _local_5.getStyle("rollOverColor");
                    _local_4 = _local_5.getStyle("selectionColor");
                };
            };
            if (((_local_2 === null) || (!(StyleManager.isValidStyleValue(_local_2)))))
            {
                _local_6 = getClassStyleDeclarations();
                _local_7 = 0;
                while (_local_7 < _local_6.length)
                {
                    _local_8 = _local_6[_local_7];
                    if (_local_8)
                    {
                        _local_2 = _local_8.getStyle("themeColor");
                        _local_3 = _local_8.getStyle("rollOverColor");
                        _local_4 = _local_8.getStyle("selectionColor");
                    };
                    if (((!(_local_2 === null)) && (StyleManager.isValidStyleValue(_local_2)))) break;
                    _local_7++;
                };
            };
            if (((((!(_local_2 === null)) && (StyleManager.isValidStyleValue(_local_2))) && (isNaN(_local_3))) && (isNaN(_local_4))))
            {
                setThemeColor(_local_2);
                return (true);
            };
            return ((((!(_local_2 === null)) && (StyleManager.isValidStyleValue(_local_2))) && (!(isNaN(_local_3)))) && (!(isNaN(_local_4))));
        }

        [Bindable("scaleXChanged")]
        override public function get scaleX():Number
        {
            return (_scaleX);
        }

        public function get uid():String
        {
            if (!_uid)
            {
                _uid = toString();
            };
            return (_uid);
        }

        override public function get mouseX():Number
        {
            if ((((!(root)) || (root is Stage)) || (root[fakeMouseX] === undefined)))
            {
                return (super.mouseX);
            };
            return (globalToLocal(new Point(root[fakeMouseX], 0)).x);
        }

        override public function stopDrag():void
        {
            super.stopDrag();
            invalidateProperties();
            dispatchEvent(new Event("xChanged"));
            dispatchEvent(new Event("yChanged"));
        }

        public function get focusPane():Sprite
        {
            return (_focusPane);
        }

        public function set tweeningProperties(_arg_1:Array):void
        {
            _tweeningProperties = _arg_1;
        }

        public function horizontalGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Matrix
        {
            UIComponentGlobals.tempMatrix.createGradientBox(_arg_3, _arg_4, 0, _arg_1, _arg_2);
            return (UIComponentGlobals.tempMatrix);
        }

        public function get isDocument():Boolean
        {
            return (document == this);
        }

        public function set validationSubField(_arg_1:String):void
        {
            _validationSubField = _arg_1;
        }

        [Bindable("scaleYChanged")]
        override public function get scaleY():Number
        {
            return (_scaleY);
        }

        protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
        }

        protected function createInFontContext(_arg_1:Class):Object
        {
            hasFontContextBeenSaved = true;
            var _local_2:String = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _local_3:String = getStyle("fontWeight");
            var _local_4:String = getStyle("fontStyle");
            var _local_5:* = (_local_3 == "bold");
            var _local_6:* = (_local_4 == "italic");
            oldEmbeddedFontContext = getFontContext(_local_2, _local_5, _local_6);
            var _local_7:Object = createInModuleContext(((oldEmbeddedFontContext) ? oldEmbeddedFontContext : moduleFactory), getQualifiedClassName(_arg_1));
            if (_local_7 == null)
            {
                _local_7 = new (_arg_1)();
            };
            return (_local_7);
        }

        public function get screen():Rectangle
        {
            var _local_1:ISystemManager = systemManager;
            return ((_local_1) ? _local_1.screen : null);
        }

        protected function focusInHandler(_arg_1:FocusEvent):void
        {
            var _local_2:IFocusManager;
            if (isOurFocus(DisplayObject(_arg_1.target)))
            {
                _local_2 = focusManager;
                if (((_local_2) && (_local_2.showFocusIndicator)))
                {
                    drawFocus(true);
                };
                ContainerGlobals.checkFocus(_arg_1.relatedObject, this);
            };
        }

        public function hasFontContextChanged():Boolean
        {
            if (!hasFontContextBeenSaved)
            {
                return (false);
            };
            var _local_1:String = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _local_2:String = getStyle("fontWeight");
            var _local_3:String = getStyle("fontStyle");
            var _local_4:* = (_local_2 == "bold");
            var _local_5:* = (_local_3 == "italic");
            var _local_6:EmbeddedFont = getEmbeddedFont(_local_1, _local_4, _local_5);
            var _local_7:IFlexModuleFactory = embeddedFontRegistry.getAssociatedModuleFactory(_local_6, moduleFactory);
            return (!(_local_7 == oldEmbeddedFontContext));
        }

        [Bindable("explicitHeightChanged")]
        public function get explicitHeight():Number
        {
            return (_explicitHeight);
        }

        [Bindable("xChanged")]
        override public function get x():Number
        {
            return (super.x);
        }

        [Bindable("yChanged")]
        override public function get y():Number
        {
            return (super.y);
        }

        [Bindable("hide")]
        [Bindable("show")]
        override public function get visible():Boolean
        {
            return (_visible);
        }

        mx_internal function addOverlay(_arg_1:uint, _arg_2:RoundedRectangle=null):void
        {
            if (!overlay)
            {
                overlayColor = _arg_1;
                overlay = new UIComponent();
                overlay.name = "overlay";
                overlay.$visible = true;
                fillOverlay(overlay, _arg_1, _arg_2);
                attachOverlay();
                if (!_arg_2)
                {
                    addEventListener(ResizeEvent.RESIZE, overlay_resizeHandler);
                };
                overlay.x = 0;
                overlay.y = 0;
                invalidateDisplayList();
                overlayReferenceCount = 1;
            }
            else
            {
                overlayReferenceCount++;
            };
            dispatchEvent(new ChildExistenceChangedEvent(ChildExistenceChangedEvent.OVERLAY_CREATED, true, false, overlay));
        }

        [Bindable("resize")]
        public function get percentWidth():Number
        {
            return (_percentWidth);
        }

        public function set explicitMinHeight(_arg_1:Number):void
        {
            if (_explicitMinHeight == _arg_1)
            {
                return;
            };
            _explicitMinHeight = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitMinHeightChanged"));
        }

        public function set automationName(_arg_1:String):void
        {
            _automationName = _arg_1;
        }

        public function get mouseFocusEnabled():Boolean
        {
            return (_mouseFocusEnabled);
        }

        mx_internal function getEmbeddedFont(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):EmbeddedFont
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

        public function stylesInitialized():void
        {
        }

        public function set errorString(_arg_1:String):void
        {
            var _local_2:String = _errorString;
            _errorString = _arg_1;
            ToolTipManager.registerErrorString(this, _local_2, _arg_1);
            errorStringChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("errorStringChanged"));
        }

        public function getExplicitOrMeasuredWidth():Number
        {
            return ((isNaN(explicitWidth)) ? measuredWidth : explicitWidth);
        }

        final mx_internal function set $height(_arg_1:Number):void
        {
            super.height = _arg_1;
        }

        protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
        }

        final mx_internal function $removeChild(_arg_1:DisplayObject):DisplayObject
        {
            return (super.removeChild(_arg_1));
        }

        override public function set scaleX(_arg_1:Number):void
        {
            if (_scaleX == _arg_1)
            {
                return;
            };
            _scaleX = _arg_1;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("scaleXChanged"));
        }

        override public function set scaleY(_arg_1:Number):void
        {
            if (_scaleY == _arg_1)
            {
                return;
            };
            _scaleY = _arg_1;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("scaleYChanged"));
        }

        public function set uid(_arg_1:String):void
        {
            this._uid = _arg_1;
        }

        public function createAutomationIDPart(_arg_1:IAutomationObject):Object
        {
            if (automationDelegate)
            {
                return (automationDelegate.createAutomationIDPart(_arg_1));
            };
            return (null);
        }

        public function getAutomationChildAt(_arg_1:int):IAutomationObject
        {
            if (automationDelegate)
            {
                return (automationDelegate.getAutomationChildAt(_arg_1));
            };
            return (null);
        }

        mx_internal function get isEffectStarted():Boolean
        {
            return (_isEffectStarted);
        }

        override public function get parent():DisplayObjectContainer
        {
            try
            {
                return ((_parent) ? _parent : super.parent);
            }
            catch(e:SecurityError)
            {
            };
            return (null);
        }

        override public function get mouseY():Number
        {
            if ((((!(root)) || (root is Stage)) || (root[fakeMouseY] === undefined)))
            {
                return (super.mouseY);
            };
            return (globalToLocal(new Point(0, root[fakeMouseY])).y);
        }

        public function setActualSize(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Boolean;
            if (_width != _arg_1)
            {
                _width = _arg_1;
                dispatchEvent(new Event("widthChanged"));
                _local_3 = true;
            };
            if (_height != _arg_2)
            {
                _height = _arg_2;
                dispatchEvent(new Event("heightChanged"));
                _local_3 = true;
            };
            if (_local_3)
            {
                invalidateDisplayList();
                dispatchResizeEvent();
            };
        }

        private function focusObj_resizeHandler(_arg_1:ResizeEvent):void
        {
            adjustFocusRect();
        }

        mx_internal function adjustSizesForScaleChanges():void
        {
            var _local_3:Number;
            var _local_1:Number = scaleX;
            var _local_2:Number = scaleY;
            if (_local_1 != oldScaleX)
            {
                _local_3 = Math.abs((_local_1 / oldScaleX));
                if (explicitMinWidth)
                {
                    explicitMinWidth = (explicitMinWidth * _local_3);
                };
                if (!isNaN(explicitWidth))
                {
                    explicitWidth = (explicitWidth * _local_3);
                };
                if (explicitMaxWidth)
                {
                    explicitMaxWidth = (explicitMaxWidth * _local_3);
                };
                oldScaleX = _local_1;
            };
            if (_local_2 != oldScaleY)
            {
                _local_3 = Math.abs((_local_2 / oldScaleY));
                if (explicitMinHeight)
                {
                    explicitMinHeight = (explicitMinHeight * _local_3);
                };
                if (explicitHeight)
                {
                    explicitHeight = (explicitHeight * _local_3);
                };
                if (explicitMaxHeight)
                {
                    explicitMaxHeight = (explicitMaxHeight * _local_3);
                };
                oldScaleY = _local_2;
            };
        }

        public function set focusPane(_arg_1:Sprite):void
        {
            if (_arg_1)
            {
                addChild(_arg_1);
                _arg_1.x = 0;
                _arg_1.y = 0;
                _arg_1.scrollRect = null;
                _focusPane = _arg_1;
            }
            else
            {
                removeChild(_focusPane);
                _focusPane.mask = null;
                _focusPane = null;
            };
        }

        public function determineTextFormatFromStyles():UITextFormat
        {
            var _local_2:String;
            var _local_1:UITextFormat = cachedTextFormat;
            if (!_local_1)
            {
                _local_2 = StringUtil.trimArrayElements(_inheritingStyles.fontFamily, ",");
                _local_1 = new UITextFormat(getNonNullSystemManager(), _local_2);
                _local_1.moduleFactory = moduleFactory;
                _local_1.align = _inheritingStyles.textAlign;
                _local_1.bold = (_inheritingStyles.fontWeight == "bold");
                _local_1.color = ((enabled) ? _inheritingStyles.color : _inheritingStyles.disabledColor);
                _local_1.font = _local_2;
                _local_1.indent = _inheritingStyles.textIndent;
                _local_1.italic = (_inheritingStyles.fontStyle == "italic");
                _local_1.kerning = _inheritingStyles.kerning;
                _local_1.leading = _nonInheritingStyles.leading;
                _local_1.leftMargin = _nonInheritingStyles.paddingLeft;
                _local_1.letterSpacing = _inheritingStyles.letterSpacing;
                _local_1.rightMargin = _nonInheritingStyles.paddingRight;
                _local_1.size = _inheritingStyles.fontSize;
                _local_1.underline = (_nonInheritingStyles.textDecoration == "underline");
                _local_1.antiAliasType = _inheritingStyles.fontAntiAliasType;
                _local_1.gridFitType = _inheritingStyles.fontGridFitType;
                _local_1.sharpness = _inheritingStyles.fontSharpness;
                _local_1.thickness = _inheritingStyles.fontThickness;
                cachedTextFormat = _local_1;
            };
            return (_local_1);
        }

        public function validationResultHandler(_arg_1:ValidationResultEvent):void
        {
            var _local_3:String;
            var _local_4:ValidationResult;
            var _local_5:int;
            if (errorObjectArray === null)
            {
                errorObjectArray = new Array();
                errorArray = new Array();
            };
            var _local_2:int = errorObjectArray.indexOf(_arg_1.target);
            if (_arg_1.type == ValidationResultEvent.VALID)
            {
                if (_local_2 != -1)
                {
                    errorObjectArray.splice(_local_2, 1);
                    errorArray.splice(_local_2, 1);
                    errorString = errorArray.join("\n");
                    if (errorArray.length == 0)
                    {
                        dispatchEvent(new FlexEvent(FlexEvent.VALID));
                    };
                };
            }
            else
            {
                if ((((!(validationSubField == null)) && (!(validationSubField == ""))) && (_arg_1.results)))
                {
                    _local_5 = 0;
                    while (_local_5 < _arg_1.results.length)
                    {
                        _local_4 = _arg_1.results[_local_5];
                        if (_local_4.subField == validationSubField)
                        {
                            if (_local_4.isError)
                            {
                                _local_3 = _local_4.errorMessage;
                            }
                            else
                            {
                                if (_local_2 != -1)
                                {
                                    errorObjectArray.splice(_local_2, 1);
                                    errorArray.splice(_local_2, 1);
                                    errorString = errorArray.join("\n");
                                    if (errorArray.length == 0)
                                    {
                                        dispatchEvent(new FlexEvent(FlexEvent.VALID));
                                    };
                                };
                            };
                            break;
                        };
                        _local_5++;
                    };
                }
                else
                {
                    if (((_arg_1.results) && (_arg_1.results.length > 0)))
                    {
                        _local_3 = _arg_1.results[0].errorMessage;
                    };
                };
                if ((((_local_3) && (!(_local_2 == -1))) && (!(errorArray[_local_2] == _local_3))))
                {
                    errorArray[_local_2] = _local_3;
                    errorString = errorArray.join("\n");
                    dispatchEvent(new FlexEvent(FlexEvent.INVALID));
                }
                else
                {
                    if (((_local_3) && (_local_2 == -1)))
                    {
                        errorObjectArray.push(_arg_1.target);
                        errorArray.push(_local_3);
                        errorString = errorArray.join("\n");
                        dispatchEvent(new FlexEvent(FlexEvent.INVALID));
                    };
                };
            };
        }

        public function invalidateProperties():void
        {
            if (!invalidatePropertiesFlag)
            {
                invalidatePropertiesFlag = true;
                if (((parent) && (UIComponentGlobals.layoutManager)))
                {
                    UIComponentGlobals.layoutManager.invalidateProperties(this);
                };
            };
        }

        public function get inheritingStyles():Object
        {
            return (_inheritingStyles);
        }

        private function focusObj_scrollHandler(_arg_1:Event):void
        {
            adjustFocusRect();
        }

        final mx_internal function get $x():Number
        {
            return (super.x);
        }

        final mx_internal function get $y():Number
        {
            return (super.y);
        }

        public function setConstraintValue(_arg_1:String, _arg_2:*):void
        {
            setStyle(_arg_1, _arg_2);
        }

        protected function resourcesChanged():void
        {
        }

        public function registerEffects(_arg_1:Array):void
        {
            var _local_4:String;
            var _local_2:int = _arg_1.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = EffectManager.getEventForEffectTrigger(_arg_1[_local_3]);
                if (((!(_local_4 == null)) && (!(_local_4 == ""))))
                {
                    addEventListener(_local_4, EffectManager.eventHandler, false, EventPriority.EFFECT);
                };
                _local_3++;
            };
        }

        [Bindable("explicitMinWidthChanged")]
        public function get explicitMinWidth():Number
        {
            return (_explicitMinWidth);
        }

        private function filterChangeHandler(_arg_1:Event):void
        {
            super.filters = _filters;
        }

        override public function set visible(_arg_1:Boolean):void
        {
            setVisible(_arg_1);
        }

        public function set explicitHeight(_arg_1:Number):void
        {
            if (_explicitHeight == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _percentHeight = NaN;
            };
            _explicitHeight = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (((_local_2) && (includeInLayout)))
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitHeightChanged"));
        }

        override public function set x(_arg_1:Number):void
        {
            if (super.x == _arg_1)
            {
                return;
            };
            super.x = _arg_1;
            invalidateProperties();
            dispatchEvent(new Event("xChanged"));
        }

        public function set showInAutomationHierarchy(_arg_1:Boolean):void
        {
            _showInAutomationHierarchy = _arg_1;
        }

        override public function set y(_arg_1:Number):void
        {
            if (super.y == _arg_1)
            {
                return;
            };
            super.y = _arg_1;
            invalidateProperties();
            dispatchEvent(new Event("yChanged"));
        }

        private function resourceManager_changeHandler(_arg_1:Event):void
        {
            resourcesChanged();
        }

        public function set systemManager(_arg_1:ISystemManager):void
        {
            _systemManager = _arg_1;
            _systemManagerDirty = false;
        }

        mx_internal function getFocusObject():DisplayObject
        {
            var _local_1:IFocusManager = focusManager;
            if (((!(_local_1)) || (!(_local_1.focusPane))))
            {
                return (null);
            };
            return ((_local_1.focusPane.numChildren == 0) ? null : _local_1.focusPane.getChildAt(0));
        }

        public function set percentWidth(_arg_1:Number):void
        {
            if (_percentWidth == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _explicitWidth = NaN;
            };
            _percentWidth = _arg_1;
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
        }

        public function get moduleFactory():IFlexModuleFactory
        {
            return (_moduleFactory);
        }

        override public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:DisplayObjectContainer = _arg_1.parent;
            if (((_local_2) && (!(_local_2 is Loader))))
            {
                _local_2.removeChild(_arg_1);
            };
            var _local_3:int = (((overlayReferenceCount) && (!(_arg_1 == overlay))) ? Math.max(0, (super.numChildren - 1)) : super.numChildren);
            addingChild(_arg_1);
            $addChildAt(_arg_1, _local_3);
            childAdded(_arg_1);
            return (_arg_1);
        }

        public function get document():Object
        {
            return (_document);
        }

        public function set mouseFocusEnabled(_arg_1:Boolean):void
        {
            _mouseFocusEnabled = _arg_1;
        }

        final mx_internal function $addChild(_arg_1:DisplayObject):DisplayObject
        {
            return (super.addChild(_arg_1));
        }

        mx_internal function setThemeColor(_arg_1:Object):void
        {
            var _local_2:Number;
            if ((_local_2 is String))
            {
                _local_2 = parseInt(String(_arg_1));
            }
            else
            {
                _local_2 = Number(_arg_1);
            };
            if (isNaN(_local_2))
            {
                _local_2 = StyleManager.getColorName(_arg_1);
            };
            var _local_3:Number = ColorUtil.adjustBrightness2(_local_2, 50);
            var _local_4:Number = ColorUtil.adjustBrightness2(_local_2, 70);
            setStyle("selectionColor", _local_3);
            setStyle("rollOverColor", _local_4);
        }

        [Bindable("explicitMaxWidthChanged")]
        public function get explicitMaxWidth():Number
        {
            return (_explicitMaxWidth);
        }

        public function get id():String
        {
            return (_id);
        }

        [Bindable("heightChanged")]
        override public function get height():Number
        {
            return (_height);
        }

        public function set minWidth(_arg_1:Number):void
        {
            if (explicitMinWidth == _arg_1)
            {
                return;
            };
            explicitMinWidth = _arg_1;
        }

        public function set currentState(_arg_1:String):void
        {
            setCurrentState(_arg_1, true);
        }

        public function executeBindings(_arg_1:Boolean=false):void
        {
            var _local_2:Object = (((descriptor) && (descriptor.document)) ? descriptor.document : parentDocument);
            BindingManager.executeBindings(_local_2, id, this);
        }

        public function replayAutomatableEvent(_arg_1:Event):Boolean
        {
            if (automationDelegate)
            {
                return (automationDelegate.replayAutomatableEvent(_arg_1));
            };
            return (false);
        }

        mx_internal function getFontContext(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):IFlexModuleFactory
        {
            return (embeddedFontRegistry.getAssociatedModuleFactory(getEmbeddedFont(_arg_1, _arg_2, _arg_3), moduleFactory));
        }

        public function get instanceIndex():int
        {
            return ((_instanceIndices) ? _instanceIndices[(_instanceIndices.length - 1)] : -1);
        }

        public function set measuredWidth(_arg_1:Number):void
        {
            _measuredWidth = _arg_1;
        }

        public function effectFinished(_arg_1:IEffectInstance):void
        {
            _endingEffectInstances.push(_arg_1);
            invalidateProperties();
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler, false, 0, true);
        }

        public function getRepeaterItem(_arg_1:int=-1):Object
        {
            var _local_2:Array = repeaters;
            if (_local_2.length == 0)
            {
                return (null);
            };
            if (_arg_1 == -1)
            {
                _arg_1 = (_local_2.length - 1);
            };
            return (_local_2[_arg_1].getItemAt(repeaterIndices[_arg_1]));
        }

        mx_internal function set isEffectStarted(_arg_1:Boolean):void
        {
            _isEffectStarted = _arg_1;
        }

        mx_internal function fillOverlay(_arg_1:UIComponent, _arg_2:uint, _arg_3:RoundedRectangle=null):void
        {
            if (!_arg_3)
            {
                _arg_3 = new RoundedRectangle(0, 0, unscaledWidth, unscaledHeight, 0);
            };
            var _local_4:Graphics = _arg_1.graphics;
            _local_4.clear();
            _local_4.beginFill(_arg_2);
            _local_4.drawRoundRect(_arg_3.x, _arg_3.y, _arg_3.width, _arg_3.height, (_arg_3.cornerRadius * 2), (_arg_3.cornerRadius * 2));
            _local_4.endFill();
        }

        public function get instanceIndices():Array
        {
            return ((_instanceIndices) ? _instanceIndices.slice(0) : null);
        }

        mx_internal function childAdded(_arg_1:DisplayObject):void
        {
            if ((_arg_1 is UIComponent))
            {
                if (!UIComponent(_arg_1).initialized)
                {
                    UIComponent(_arg_1).initialize();
                };
            }
            else
            {
                if ((_arg_1 is IUIComponent))
                {
                    IUIComponent(_arg_1).initialize();
                };
            };
        }

        public function globalToContent(_arg_1:Point):Point
        {
            return (globalToLocal(_arg_1));
        }

        mx_internal function removingChild(_arg_1:DisplayObject):void
        {
        }

        mx_internal function getEffectsForProperty(_arg_1:String):Array
        {
            return ((_affectedProperties[_arg_1] != undefined) ? _affectedProperties[_arg_1] : []);
        }

        override public function removeChildAt(_arg_1:int):DisplayObject
        {
            var _local_2:DisplayObject = getChildAt(_arg_1);
            removingChild(_local_2);
            $removeChild(_local_2);
            childRemoved(_local_2);
            return (_local_2);
        }

        protected function measure():void
        {
            measuredMinWidth = 0;
            measuredMinHeight = 0;
            measuredWidth = 0;
            measuredHeight = 0;
        }

        public function set owner(_arg_1:DisplayObjectContainer):void
        {
            _owner = _arg_1;
        }

        mx_internal function getNonNullSystemManager():ISystemManager
        {
            var _local_1:ISystemManager = systemManager;
            if (!_local_1)
            {
                _local_1 = ISystemManager(SystemManager.getSWFRoot(this));
            };
            if (!_local_1)
            {
                return (SystemManagerGlobals.topLevelSystemManagers[0]);
            };
            return (_local_1);
        }

        protected function get unscaledWidth():Number
        {
            return (width / Math.abs(scaleX));
        }

        public function set processedDescriptors(_arg_1:Boolean):void
        {
            _processedDescriptors = _arg_1;
            if (_arg_1)
            {
                dispatchEvent(new FlexEvent(FlexEvent.INITIALIZE));
            };
        }

        private function processEffectFinished(_arg_1:Array):void
        {
            var _local_3:int;
            var _local_4:IEffectInstance;
            var _local_5:IEffectInstance;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:String;
            var _local_9:int;
            var _local_2:int = (_effectsStarted.length - 1);
            while (_local_2 >= 0)
            {
                _local_3 = 0;
                while (_local_3 < _arg_1.length)
                {
                    _local_4 = _arg_1[_local_3];
                    if (_local_4 == _effectsStarted[_local_2])
                    {
                        _local_5 = _effectsStarted[_local_2];
                        _effectsStarted.splice(_local_2, 1);
                        _local_6 = _local_5.effect.getAffectedProperties();
                        _local_7 = 0;
                        while (_local_7 < _local_6.length)
                        {
                            _local_8 = _local_6[_local_7];
                            if (_affectedProperties[_local_8] != undefined)
                            {
                                _local_9 = 0;
                                while (_local_9 < _affectedProperties[_local_8].length)
                                {
                                    if (_affectedProperties[_local_8][_local_9] == _local_4)
                                    {
                                        _affectedProperties[_local_8].splice(_local_9, 1);
                                        break;
                                    };
                                    _local_9++;
                                };
                                if (_affectedProperties[_local_8].length == 0)
                                {
                                    delete _affectedProperties[_local_8];
                                };
                            };
                            _local_7++;
                        };
                        break;
                    };
                    _local_3++;
                };
                _local_2--;
            };
            isEffectStarted = ((_effectsStarted.length > 0) ? true : false);
            if (((_local_4) && (_local_4.hideFocusRing)))
            {
                preventDrawFocus = false;
            };
        }

        private function commitCurrentState():void
        {
            var _local_3:StateChangeEvent;
            var _local_1:IEffect = ((playStateTransition) ? getTransition(_currentState, requestedCurrentState) : null);
            var _local_2:String = findCommonBaseState(_currentState, requestedCurrentState);
            var _local_4:String = ((_currentState) ? _currentState : "");
            var _local_5:State = getState(requestedCurrentState);
            if (_currentTransitionEffect)
            {
                _currentTransitionEffect.end();
            };
            initializeState(requestedCurrentState);
            if (_local_1)
            {
                _local_1.captureStartValues();
            };
            _local_3 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGING);
            _local_3.oldState = _local_4;
            _local_3.newState = ((requestedCurrentState) ? requestedCurrentState : "");
            dispatchEvent(_local_3);
            if (isBaseState(_currentState))
            {
                dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
            };
            removeState(_currentState, _local_2);
            _currentState = requestedCurrentState;
            if (isBaseState(currentState))
            {
                dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
            }
            else
            {
                applyState(_currentState, _local_2);
            };
            _local_3 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE);
            _local_3.oldState = _local_4;
            _local_3.newState = ((_currentState) ? _currentState : "");
            dispatchEvent(_local_3);
            if (_local_1)
            {
                UIComponentGlobals.layoutManager.validateNow();
                _currentTransitionEffect = _local_1;
                _local_1.addEventListener(EffectEvent.EFFECT_END, transition_effectEndHandler);
                _local_1.play();
            };
        }

        [Bindable("includeInLayoutChanged")]
        public function get includeInLayout():Boolean
        {
            return (_includeInLayout);
        }

        private function dispatchResizeEvent():void
        {
            var _local_1:ResizeEvent = new ResizeEvent(ResizeEvent.RESIZE);
            _local_1.oldWidth = oldWidth;
            _local_1.oldHeight = oldHeight;
            dispatchEvent(_local_1);
            oldWidth = width;
            oldHeight = height;
        }

        public function set maxWidth(_arg_1:Number):void
        {
            if (explicitMaxWidth == _arg_1)
            {
                return;
            };
            explicitMaxWidth = _arg_1;
        }

        public function validateDisplayList():void
        {
            var _local_1:ISystemManager;
            var _local_2:Number;
            var _local_3:Number;
            if (invalidateDisplayListFlag)
            {
                _local_1 = (parent as ISystemManager);
                if (_local_1)
                {
                    if (((_local_1 is SystemManagerProxy) || ((_local_1 == systemManager.topLevelSystemManager) && (!(_local_1.document == this)))))
                    {
                        setActualSize(getExplicitOrMeasuredWidth(), getExplicitOrMeasuredHeight());
                    };
                };
                _local_2 = ((scaleX == 0) ? 0 : (width / scaleX));
                _local_3 = ((scaleY == 0) ? 0 : (height / scaleY));
                if (Math.abs((_local_2 - lastUnscaledWidth)) < 1E-5)
                {
                    _local_2 = lastUnscaledWidth;
                };
                if (Math.abs((_local_3 - lastUnscaledHeight)) < 1E-5)
                {
                    _local_3 = lastUnscaledHeight;
                };
                updateDisplayList(_local_2, _local_3);
                lastUnscaledWidth = _local_2;
                lastUnscaledHeight = _local_3;
                invalidateDisplayListFlag = false;
            };
        }

        public function contentToGlobal(_arg_1:Point):Point
        {
            return (localToGlobal(_arg_1));
        }

        public function resolveAutomationIDPart(_arg_1:Object):Array
        {
            if (automationDelegate)
            {
                return (automationDelegate.resolveAutomationIDPart(_arg_1));
            };
            return ([]);
        }

        public function set inheritingStyles(_arg_1:Object):void
        {
            _inheritingStyles = _arg_1;
        }

        public function setFocus():void
        {
            var _local_1:ISystemManager = systemManager;
            if (((_local_1) && ((_local_1.stage) || (_local_1.useSWFBridge()))))
            {
                if (UIComponentGlobals.callLaterDispatcherCount == 0)
                {
                    _local_1.stage.focus = this;
                    UIComponentGlobals.nextFocusObject = null;
                }
                else
                {
                    UIComponentGlobals.nextFocusObject = this;
                    _local_1.addEventListener(FlexEvent.ENTER_FRAME, setFocusLater);
                };
            }
            else
            {
                UIComponentGlobals.nextFocusObject = this;
                callLater(setFocusLater);
            };
        }

        private function getTransition(_arg_1:String, _arg_2:String):IEffect
        {
            var _local_6:Transition;
            var _local_3:IEffect;
            var _local_4:int;
            if (!transitions)
            {
                return (null);
            };
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            if (!_arg_2)
            {
                _arg_2 = "";
            };
            var _local_5:int;
            while (_local_5 < transitions.length)
            {
                _local_6 = transitions[_local_5];
                if ((((_local_6.fromState == "*") && (_local_6.toState == "*")) && (_local_4 < 1)))
                {
                    _local_3 = _local_6.effect;
                    _local_4 = 1;
                }
                else
                {
                    if ((((_local_6.fromState == _arg_1) && (_local_6.toState == "*")) && (_local_4 < 2)))
                    {
                        _local_3 = _local_6.effect;
                        _local_4 = 2;
                    }
                    else
                    {
                        if ((((_local_6.fromState == "*") && (_local_6.toState == _arg_2)) && (_local_4 < 3)))
                        {
                            _local_3 = _local_6.effect;
                            _local_4 = 3;
                        }
                        else
                        {
                            if ((((_local_6.fromState == _arg_1) && (_local_6.toState == _arg_2)) && (_local_4 < 4)))
                            {
                                _local_3 = _local_6.effect;
                                _local_4 = 4;
                                break;
                            };
                        };
                    };
                };
                _local_5++;
            };
            return (_local_3);
        }

        public function set initialized(_arg_1:Boolean):void
        {
            _initialized = _arg_1;
            if (_arg_1)
            {
                setVisible(_visible, true);
                dispatchEvent(new FlexEvent(FlexEvent.CREATION_COMPLETE));
            };
        }

        final mx_internal function set $y(_arg_1:Number):void
        {
            super.y = _arg_1;
        }

        public function owns(child:DisplayObject):Boolean
        {
            var childList:IChildList = ((this is IRawChildrenContainer) ? IRawChildrenContainer(this).rawChildren : IChildList(this));
            if (childList.contains(child))
            {
                return (true);
            };
            try
            {
                while (((child) && (!(child == this))))
                {
                    if ((child is IUIComponent))
                    {
                        child = IUIComponent(child).owner;
                    }
                    else
                    {
                        child = child.parent;
                    };
                };
            }
            catch(e:SecurityError)
            {
                return (false);
            };
            return (child == this);
        }

        public function setVisible(_arg_1:Boolean, _arg_2:Boolean=false):void
        {
            _visible = _arg_1;
            if (!initialized)
            {
                return;
            };
            if ($visible == _arg_1)
            {
                return;
            };
            $visible = _arg_1;
            if (!_arg_2)
            {
                dispatchEvent(new FlexEvent(((_arg_1) ? FlexEvent.SHOW : FlexEvent.HIDE)));
            };
        }

        final mx_internal function $addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            return (super.addChildAt(_arg_1, _arg_2));
        }

        public function deleteReferenceOnParentDocument(_arg_1:IFlexDisplayObject):void
        {
            var _local_2:Array;
            var _local_3:Object;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Object;
            var _local_9:PropertyChangeEvent;
            if (((id) && (!(id == ""))))
            {
                _local_2 = _instanceIndices;
                if (!_local_2)
                {
                    _arg_1[id] = null;
                }
                else
                {
                    _local_3 = _arg_1[id];
                    if (!_local_3)
                    {
                        return;
                    };
                    _local_4 = [];
                    _local_4.push(_local_3);
                    _local_5 = _local_2.length;
                    _local_6 = 0;
                    while (_local_6 < (_local_5 - 1))
                    {
                        _local_8 = _local_3[_local_2[_local_6]];
                        if (!_local_8)
                        {
                            return;
                        };
                        _local_3 = _local_8;
                        _local_4.push(_local_3);
                        _local_6++;
                    };
                    _local_3.splice(_local_2[(_local_5 - 1)], 1);
                    _local_7 = (_local_4.length - 1);
                    while (_local_7 > 0)
                    {
                        if (_local_4[_local_7].length == 0)
                        {
                            _local_4[(_local_7 - 1)].splice(_local_2[_local_7], 1);
                        };
                        _local_7--;
                    };
                    if (((_local_4.length > 0) && (_local_4[0].length == 0)))
                    {
                        _arg_1[id] = null;
                    }
                    else
                    {
                        _local_9 = PropertyChangeEvent.createUpdateEvent(_arg_1, id, _arg_1[id], _arg_1[id]);
                        _arg_1.dispatchEvent(_local_9);
                    };
                };
            };
        }

        public function get nonInheritingStyles():Object
        {
            return (_nonInheritingStyles);
        }

        public function effectStarted(_arg_1:IEffectInstance):void
        {
            var _local_4:String;
            _effectsStarted.push(_arg_1);
            var _local_2:Array = _arg_1.effect.getAffectedProperties();
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                _local_4 = _local_2[_local_3];
                if (_affectedProperties[_local_4] == undefined)
                {
                    _affectedProperties[_local_4] = [];
                };
                _affectedProperties[_local_4].push(_arg_1);
                _local_3++;
            };
            isEffectStarted = true;
            if (_arg_1.hideFocusRing)
            {
                preventDrawFocus = true;
                drawFocus(false);
            };
        }

        final mx_internal function set $x(_arg_1:Number):void
        {
            super.x = _arg_1;
        }

        private function applyState(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:State = getState(_arg_1);
            if (_arg_1 == _arg_2)
            {
                return;
            };
            if (_local_3)
            {
                if (_local_3.basedOn != _arg_2)
                {
                    applyState(_local_3.basedOn, _arg_2);
                };
                _local_4 = _local_3.overrides;
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    _local_4[_local_5].apply(this);
                    _local_5++;
                };
                _local_3.dispatchEnterState();
            };
        }

        protected function commitProperties():void
        {
            var _local_1:Number;
            var _local_2:Number;
            if (_scaleX != oldScaleX)
            {
                _local_1 = Math.abs((_scaleX / oldScaleX));
                if (!isNaN(explicitMinWidth))
                {
                    explicitMinWidth = (explicitMinWidth * _local_1);
                };
                if (!isNaN(explicitWidth))
                {
                    explicitWidth = (explicitWidth * _local_1);
                };
                if (!isNaN(explicitMaxWidth))
                {
                    explicitMaxWidth = (explicitMaxWidth * _local_1);
                };
                _width = (_width * _local_1);
                super.scaleX = (oldScaleX = _scaleX);
            };
            if (_scaleY != oldScaleY)
            {
                _local_2 = Math.abs((_scaleY / oldScaleY));
                if (!isNaN(explicitMinHeight))
                {
                    explicitMinHeight = (explicitMinHeight * _local_2);
                };
                if (!isNaN(explicitHeight))
                {
                    explicitHeight = (explicitHeight * _local_2);
                };
                if (!isNaN(explicitMaxHeight))
                {
                    explicitMaxHeight = (explicitMaxHeight * _local_2);
                };
                _height = (_height * _local_2);
                super.scaleY = (oldScaleY = _scaleY);
            };
            if (((!(x == oldX)) || (!(y == oldY))))
            {
                dispatchMoveEvent();
            };
            if (((!(width == oldWidth)) || (!(height == oldHeight))))
            {
                dispatchResizeEvent();
            };
            if (errorStringChanged)
            {
                errorStringChanged = false;
                setBorderColorForErrorString();
            };
        }

        [Bindable("resize")]
        public function get percentHeight():Number
        {
            return (_percentHeight);
        }

        [Bindable("widthChanged")]
        override public function get width():Number
        {
            return (_width);
        }

        final mx_internal function get $parent():DisplayObjectContainer
        {
            return (super.parent);
        }

        public function set explicitMinWidth(_arg_1:Number):void
        {
            if (_explicitMinWidth == _arg_1)
            {
                return;
            };
            _explicitMinWidth = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitMinWidthChanged"));
        }

        public function get isPopUp():Boolean
        {
            return (_isPopUp);
        }

        private function measureSizes():Boolean
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_1:Boolean;
            if (!invalidateSizeFlag)
            {
                return (_local_1);
            };
            if (((isNaN(explicitWidth)) || (isNaN(explicitHeight))))
            {
                _local_4 = Math.abs(scaleX);
                _local_5 = Math.abs(scaleY);
                if (_local_4 != 1)
                {
                    _measuredMinWidth = (_measuredMinWidth / _local_4);
                    _measuredWidth = (_measuredWidth / _local_4);
                };
                if (_local_5 != 1)
                {
                    _measuredMinHeight = (_measuredMinHeight / _local_5);
                    _measuredHeight = (_measuredHeight / _local_5);
                };
                measure();
                invalidateSizeFlag = false;
                if (((!(isNaN(explicitMinWidth))) && (measuredWidth < explicitMinWidth)))
                {
                    measuredWidth = explicitMinWidth;
                };
                if (((!(isNaN(explicitMaxWidth))) && (measuredWidth > explicitMaxWidth)))
                {
                    measuredWidth = explicitMaxWidth;
                };
                if (((!(isNaN(explicitMinHeight))) && (measuredHeight < explicitMinHeight)))
                {
                    measuredHeight = explicitMinHeight;
                };
                if (((!(isNaN(explicitMaxHeight))) && (measuredHeight > explicitMaxHeight)))
                {
                    measuredHeight = explicitMaxHeight;
                };
                if (_local_4 != 1)
                {
                    _measuredMinWidth = (_measuredMinWidth * _local_4);
                    _measuredWidth = (_measuredWidth * _local_4);
                };
                if (_local_5 != 1)
                {
                    _measuredMinHeight = (_measuredMinHeight * _local_5);
                    _measuredHeight = (_measuredHeight * _local_5);
                };
            }
            else
            {
                invalidateSizeFlag = false;
                _measuredMinWidth = 0;
                _measuredMinHeight = 0;
            };
            adjustSizesForScaleChanges();
            if (isNaN(oldMinWidth))
            {
                oldMinWidth = ((isNaN(explicitMinWidth)) ? measuredMinWidth : explicitMinWidth);
                oldMinHeight = ((isNaN(explicitMinHeight)) ? measuredMinHeight : explicitMinHeight);
                oldExplicitWidth = ((isNaN(explicitWidth)) ? measuredWidth : explicitWidth);
                oldExplicitHeight = ((isNaN(explicitHeight)) ? measuredHeight : explicitHeight);
                _local_1 = true;
            }
            else
            {
                _local_3 = ((isNaN(explicitMinWidth)) ? measuredMinWidth : explicitMinWidth);
                if (_local_3 != oldMinWidth)
                {
                    oldMinWidth = _local_3;
                    _local_1 = true;
                };
                _local_3 = ((isNaN(explicitMinHeight)) ? measuredMinHeight : explicitMinHeight);
                if (_local_3 != oldMinHeight)
                {
                    oldMinHeight = _local_3;
                    _local_1 = true;
                };
                _local_3 = ((isNaN(explicitWidth)) ? measuredWidth : explicitWidth);
                if (_local_3 != oldExplicitWidth)
                {
                    oldExplicitWidth = _local_3;
                    _local_1 = true;
                };
                _local_3 = ((isNaN(explicitHeight)) ? measuredHeight : explicitHeight);
                if (_local_3 != oldExplicitHeight)
                {
                    oldExplicitHeight = _local_3;
                    _local_1 = true;
                };
            };
            return (_local_1);
        }

        public function get automationTabularData():Object
        {
            if (automationDelegate)
            {
                return (automationDelegate.automationTabularData);
            };
            return (null);
        }

        public function validateNow():void
        {
            UIComponentGlobals.layoutManager.validateClient(this);
        }

        public function finishPrint(_arg_1:Object, _arg_2:IFlexDisplayObject):void
        {
        }

        public function get repeaters():Array
        {
            return ((_repeaters) ? _repeaters.slice(0) : []);
        }

        private function dispatchMoveEvent():void
        {
            var _local_1:MoveEvent = new MoveEvent(MoveEvent.MOVE);
            _local_1.oldX = oldX;
            _local_1.oldY = oldY;
            dispatchEvent(_local_1);
            oldX = x;
            oldY = y;
        }

        public function drawFocus(_arg_1:Boolean):void
        {
            var _local_4:DisplayObjectContainer;
            var _local_5:Class;
            if (!parent)
            {
                return;
            };
            var _local_2:DisplayObject = getFocusObject();
            var _local_3:Sprite = ((focusManager) ? focusManager.focusPane : null);
            if (((_arg_1) && (!(preventDrawFocus))))
            {
                _local_4 = _local_3.parent;
                if (_local_4 != parent)
                {
                    if (_local_4)
                    {
                        if ((_local_4 is ISystemManager))
                        {
                            ISystemManager(_local_4).focusPane = null;
                        }
                        else
                        {
                            IUIComponent(_local_4).focusPane = null;
                        };
                    };
                    if ((parent is ISystemManager))
                    {
                        ISystemManager(parent).focusPane = _local_3;
                    }
                    else
                    {
                        IUIComponent(parent).focusPane = _local_3;
                    };
                };
                _local_5 = getStyle("focusSkin");
                if (((_local_2) && (!(_local_2 is _local_5))))
                {
                    _local_3.removeChild(_local_2);
                    _local_2 = null;
                };
                if (!_local_2)
                {
                    _local_2 = new (_local_5)();
                    _local_2.name = "focus";
                    _local_3.addChild(_local_2);
                };
                if ((_local_2 is ILayoutManagerClient))
                {
                    ILayoutManagerClient(_local_2).nestLevel = nestLevel;
                };
                if ((_local_2 is ISimpleStyleClient))
                {
                    ISimpleStyleClient(_local_2).styleName = this;
                };
                addEventListener(MoveEvent.MOVE, focusObj_moveHandler, true);
                addEventListener(MoveEvent.MOVE, focusObj_moveHandler);
                addEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler, true);
                addEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler);
                addEventListener(Event.REMOVED, focusObj_removedHandler, true);
                _local_2.visible = true;
                hasFocusRect = true;
                adjustFocusRect();
            }
            else
            {
                if (hasFocusRect)
                {
                    hasFocusRect = false;
                    if (_local_2)
                    {
                        _local_2.visible = false;
                        if ((_local_2 is ISimpleStyleClient))
                        {
                            ISimpleStyleClient(_local_2).styleName = null;
                        };
                    };
                    removeEventListener(MoveEvent.MOVE, focusObj_moveHandler);
                    removeEventListener(MoveEvent.MOVE, focusObj_moveHandler, true);
                    removeEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler, true);
                    removeEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler);
                    removeEventListener(Event.REMOVED, focusObj_removedHandler, true);
                };
            };
        }

        public function get flexContextMenu():IFlexContextMenu
        {
            return (_flexContextMenu);
        }

        private function get indexedID():String
        {
            var _local_1:String = id;
            var _local_2:Array = instanceIndices;
            if (_local_2)
            {
                _local_1 = (_local_1 + (("[" + _local_2.join("][")) + "]"));
            };
            return (_local_1);
        }

        public function get measuredMinHeight():Number
        {
            return (_measuredMinHeight);
        }

        mx_internal function addingChild(_arg_1:DisplayObject):void
        {
            if (((_arg_1 is IUIComponent) && (!(IUIComponent(_arg_1).document))))
            {
                IUIComponent(_arg_1).document = ((document) ? document : ApplicationGlobals.application);
            };
            if (((_arg_1 is UIComponent) && (UIComponent(_arg_1).moduleFactory == null)))
            {
                if (moduleFactory != null)
                {
                    UIComponent(_arg_1).moduleFactory = moduleFactory;
                }
                else
                {
                    if (((document is IFlexModule) && (!(document.moduleFactory == null))))
                    {
                        UIComponent(_arg_1).moduleFactory = document.moduleFactory;
                    }
                    else
                    {
                        if (((parent is UIComponent) && (!(UIComponent(parent).moduleFactory == null))))
                        {
                            UIComponent(_arg_1).moduleFactory = UIComponent(parent).moduleFactory;
                        };
                    };
                };
            };
            if ((((_arg_1 is IFontContextComponent) && ((!(_arg_1)) is UIComponent)) && (IFontContextComponent(_arg_1).fontContext == null)))
            {
                IFontContextComponent(_arg_1).fontContext = moduleFactory;
            };
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).parentChanged(this);
            };
            if ((_arg_1 is ILayoutManagerClient))
            {
                ILayoutManagerClient(_arg_1).nestLevel = (nestLevel + 1);
            }
            else
            {
                if ((_arg_1 is IUITextField))
                {
                    IUITextField(_arg_1).nestLevel = (nestLevel + 1);
                };
            };
            if ((_arg_1 is InteractiveObject))
            {
                if (doubleClickEnabled)
                {
                    InteractiveObject(_arg_1).doubleClickEnabled = true;
                };
            };
            if ((_arg_1 is IStyleClient))
            {
                IStyleClient(_arg_1).regenerateStyleCache(true);
            }
            else
            {
                if (((_arg_1 is IUITextField) && (IUITextField(_arg_1).inheritingStyles)))
                {
                    StyleProtoChain.initTextField(IUITextField(_arg_1));
                };
            };
            if ((_arg_1 is ISimpleStyleClient))
            {
                ISimpleStyleClient(_arg_1).styleChanged(null);
            };
            if ((_arg_1 is IStyleClient))
            {
                IStyleClient(_arg_1).notifyStyleChangeInChildren(null, true);
            };
            if ((_arg_1 is UIComponent))
            {
                UIComponent(_arg_1).initThemeColor();
            };
            if ((_arg_1 is UIComponent))
            {
                UIComponent(_arg_1).stylesInitialized();
            };
        }

        public function set repeaterIndices(_arg_1:Array):void
        {
            _repeaterIndices = _arg_1;
        }

        protected function initializationComplete():void
        {
            processedDescriptors = true;
        }

        public function set moduleFactory(_arg_1:IFlexModuleFactory):void
        {
            var _local_4:UIComponent;
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = (getChildAt(_local_3) as UIComponent);
                if (_local_4)
                {
                    if (((_local_4.moduleFactory == null) || (_local_4.moduleFactory == _moduleFactory)))
                    {
                        _local_4.moduleFactory = _arg_1;
                    };
                };
                _local_3++;
            };
            _moduleFactory = _arg_1;
        }

        private function focusObj_removedHandler(_arg_1:Event):void
        {
            if (_arg_1.target != this)
            {
                return;
            };
            var _local_2:DisplayObject = getFocusObject();
            if (_local_2)
            {
                _local_2.visible = false;
            };
        }

        mx_internal function updateCallbacks():void
        {
            if (invalidateDisplayListFlag)
            {
                UIComponentGlobals.layoutManager.invalidateDisplayList(this);
            };
            if (invalidateSizeFlag)
            {
                UIComponentGlobals.layoutManager.invalidateSize(this);
            };
            if (invalidatePropertiesFlag)
            {
                UIComponentGlobals.layoutManager.invalidateProperties(this);
            };
            if (((systemManager) && ((_systemManager.stage) || (_systemManager.useSWFBridge()))))
            {
                if (((methodQueue.length > 0) && (!(listeningForRender))))
                {
                    _systemManager.addEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _systemManager.addEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = true;
                };
                if (_systemManager.stage)
                {
                    _systemManager.stage.invalidate();
                };
            };
        }

        public function set styleDeclaration(_arg_1:CSSStyleDeclaration):void
        {
            _styleDeclaration = _arg_1;
        }

        override public function set doubleClickEnabled(_arg_1:Boolean):void
        {
            var _local_2:IChildList;
            var _local_4:InteractiveObject;
            super.doubleClickEnabled = _arg_1;
            if ((this is IRawChildrenContainer))
            {
                _local_2 = IRawChildrenContainer(this).rawChildren;
            }
            else
            {
                _local_2 = IChildList(this);
            };
            var _local_3:int;
            while (_local_3 < _local_2.numChildren)
            {
                _local_4 = (_local_2.getChildAt(_local_3) as InteractiveObject);
                if (_local_4)
                {
                    _local_4.doubleClickEnabled = _arg_1;
                };
                _local_3++;
            };
        }

        public function prepareToPrint(_arg_1:IFlexDisplayObject):Object
        {
            return (null);
        }

        [Bindable("explicitMinHeightChanged")]
        public function get minHeight():Number
        {
            if (!isNaN(explicitMinHeight))
            {
                return (explicitMinHeight);
            };
            return (measuredMinHeight);
        }

        public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_5:ISimpleStyleClient;
            cachedTextFormat = null;
            var _local_3:int = numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = (getChildAt(_local_4) as ISimpleStyleClient);
                if (_local_5)
                {
                    _local_5.styleChanged(_arg_1);
                    if ((_local_5 is IStyleClient))
                    {
                        IStyleClient(_local_5).notifyStyleChangeInChildren(_arg_1, _arg_2);
                    };
                };
                _local_4++;
            };
        }

        public function get contentMouseX():Number
        {
            return (mouseX);
        }

        public function get contentMouseY():Number
        {
            return (mouseY);
        }

        public function get tweeningProperties():Array
        {
            return (_tweeningProperties);
        }

        public function set explicitMaxWidth(_arg_1:Number):void
        {
            if (_explicitMaxWidth == _arg_1)
            {
                return;
            };
            _explicitMaxWidth = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitMaxWidthChanged"));
        }

        public function set document(_arg_1:Object):void
        {
            var _local_4:IUIComponent;
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = (getChildAt(_local_3) as IUIComponent);
                if (_local_4)
                {
                    if (((_local_4.document == _document) || (_local_4.document == ApplicationGlobals.application)))
                    {
                        _local_4.document = _arg_1;
                    };
                };
                _local_3++;
            };
            _document = _arg_1;
        }

        public function validateSize(_arg_1:Boolean=false):void
        {
            var _local_2:int;
            var _local_3:DisplayObject;
            var _local_4:Boolean;
            var _local_5:IInvalidating;
            if (_arg_1)
            {
                _local_2 = 0;
                while (_local_2 < numChildren)
                {
                    _local_3 = getChildAt(_local_2);
                    if ((_local_3 is ILayoutManagerClient))
                    {
                        (_local_3 as ILayoutManagerClient).validateSize(true);
                    };
                    _local_2++;
                };
            };
            if (invalidateSizeFlag)
            {
                _local_4 = measureSizes();
                if (((_local_4) && (includeInLayout)))
                {
                    invalidateDisplayList();
                    _local_5 = (parent as IInvalidating);
                    if (_local_5)
                    {
                        _local_5.invalidateSize();
                        _local_5.invalidateDisplayList();
                    };
                };
            };
        }

        public function get validationSubField():String
        {
            return (_validationSubField);
        }

        override public function dispatchEvent(_arg_1:Event):Boolean
        {
            if (dispatchEventHook != null)
            {
                dispatchEventHook(_arg_1, this);
            };
            return (super.dispatchEvent(_arg_1));
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        private function overlay_resizeHandler(_arg_1:Event):void
        {
            fillOverlay(overlay, overlayColor, null);
        }

        public function set updateCompletePendingFlag(_arg_1:Boolean):void
        {
            _updateCompletePendingFlag = _arg_1;
        }

        final mx_internal function get $height():Number
        {
            return (super.height);
        }

        protected function attachOverlay():void
        {
            addChild(overlay);
        }

        [Bindable("explictMinHeightChanged")]
        public function get explicitMinHeight():Number
        {
            return (_explicitMinHeight);
        }

        override public function set height(_arg_1:Number):void
        {
            var _local_2:IInvalidating;
            if (explicitHeight != _arg_1)
            {
                explicitHeight = _arg_1;
                invalidateSize();
            };
            if (_height != _arg_1)
            {
                invalidateProperties();
                invalidateDisplayList();
                _local_2 = (parent as IInvalidating);
                if (((_local_2) && (includeInLayout)))
                {
                    _local_2.invalidateSize();
                    _local_2.invalidateDisplayList();
                };
                _height = _arg_1;
                dispatchEvent(new Event("heightChanged"));
            };
        }

        public function get numAutomationChildren():int
        {
            if (automationDelegate)
            {
                return (automationDelegate.numAutomationChildren);
            };
            return (0);
        }

        [Bindable("initialize")]
        public function get parentApplication():Object
        {
            var _local_2:UIComponent;
            var _local_1:Object = systemManager.document;
            if (_local_1 == this)
            {
                _local_2 = (_local_1.systemManager.parent as UIComponent);
                _local_1 = ((_local_2) ? _local_2.systemManager.document : null);
            };
            return (_local_1);
        }

        public function get repeaterIndex():int
        {
            return ((_repeaterIndices) ? _repeaterIndices[(_repeaterIndices.length - 1)] : -1);
        }

        private function removeState(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:State = getState(_arg_1);
            if (_arg_1 == _arg_2)
            {
                return;
            };
            if (_local_3)
            {
                _local_3.dispatchExitState();
                _local_4 = _local_3.overrides;
                _local_5 = _local_4.length;
                while (_local_5)
                {
                    _local_4[(_local_5 - 1)].remove(this);
                    _local_5--;
                };
                if (_local_3.basedOn != _arg_2)
                {
                    removeState(_local_3.basedOn, _arg_2);
                };
            };
        }

        public function setStyle(_arg_1:String, _arg_2:*):void
        {
            if (_arg_1 == "styleName")
            {
                styleName = _arg_2;
                return;
            };
            if (EffectManager.getEventForEffectTrigger(_arg_1) != "")
            {
                EffectManager.mx_internal::setStyle(_arg_1, this);
            };
            var _local_3:Boolean = StyleManager.isInheritingStyle(_arg_1);
            var _local_4:* = (!(inheritingStyles == UIComponent.STYLE_UNINITIALIZED));
            var _local_5:* = (!(getStyle(_arg_1) == _arg_2));
            if (!_styleDeclaration)
            {
                _styleDeclaration = new CSSStyleDeclaration();
                _styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
                if (_local_4)
                {
                    regenerateStyleCache(_local_3);
                };
            }
            else
            {
                _styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
            };
            if (((_local_4) && (_local_5)))
            {
                styleChanged(_arg_1);
                notifyStyleChangeInChildren(_arg_1, _local_3);
            };
        }

        public function get showInAutomationHierarchy():Boolean
        {
            return (_showInAutomationHierarchy);
        }

        public function get systemManager():ISystemManager
        {
            var _local_1:DisplayObject;
            var _local_2:DisplayObjectContainer;
            var _local_3:IUIComponent;
            if (((!(_systemManager)) || (_systemManagerDirty)))
            {
                _local_1 = root;
                if (!(_systemManager is SystemManagerProxy))
                {
                    if (((_local_1) && (!(_local_1 is Stage))))
                    {
                        _systemManager = (_local_1 as ISystemManager);
                    }
                    else
                    {
                        if (_local_1)
                        {
                            _systemManager = (Stage(_local_1).getChildAt(0) as ISystemManager);
                        }
                        else
                        {
                            _local_2 = parent;
                            while (_local_2)
                            {
                                _local_3 = (_local_2 as IUIComponent);
                                if (_local_3)
                                {
                                    _systemManager = _local_3.systemManager;
                                    break;
                                };
                                if ((_local_2 is ISystemManager))
                                {
                                    _systemManager = (_local_2 as ISystemManager);
                                    break;
                                };
                                _local_2 = _local_2.parent;
                            };
                        };
                    };
                };
                _systemManagerDirty = false;
            };
            return (_systemManager);
        }

        public function localToContent(_arg_1:Point):Point
        {
            return (_arg_1);
        }

        private function isBaseState(_arg_1:String):Boolean
        {
            return ((!(_arg_1)) || (_arg_1 == ""));
        }

        public function set enabled(_arg_1:Boolean):void
        {
            _enabled = _arg_1;
            cachedTextFormat = null;
            invalidateDisplayList();
            dispatchEvent(new Event("enabledChanged"));
        }

        public function set focusEnabled(_arg_1:Boolean):void
        {
            _focusEnabled = _arg_1;
        }

        [Bindable("explicitMinWidthChanged")]
        public function get minWidth():Number
        {
            if (!isNaN(explicitMinWidth))
            {
                return (explicitMinWidth);
            };
            return (measuredMinWidth);
        }

        private function setFocusLater(_arg_1:Event=null):void
        {
            var _local_2:ISystemManager = systemManager;
            if (((_local_2) && (_local_2.stage)))
            {
                _local_2.stage.removeEventListener(Event.ENTER_FRAME, setFocusLater);
                if (UIComponentGlobals.nextFocusObject)
                {
                    _local_2.stage.focus = UIComponentGlobals.nextFocusObject;
                };
                UIComponentGlobals.nextFocusObject = null;
            };
        }

        [Bindable("currentStateChange")]
        public function get currentState():String
        {
            return ((_currentStateChanged) ? requestedCurrentState : _currentState);
        }

        public function initializeRepeaterArrays(_arg_1:IRepeaterClient):void
        {
            if (((((_arg_1) && (_arg_1.instanceIndices)) && ((!(_arg_1.isDocument)) || (!(_arg_1 == descriptor.document)))) && (!(_instanceIndices))))
            {
                _instanceIndices = _arg_1.instanceIndices;
                _repeaters = _arg_1.repeaters;
                _repeaterIndices = _arg_1.repeaterIndices;
            };
        }

        public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return (NaN);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            var _local_1:TextLineMetrics = measureText("Wj");
            if (height < ((2 + _local_1.ascent) + 2))
            {
                return (int((height + ((_local_1.ascent - height) / 2))));
            };
            return (2 + _local_1.ascent);
        }

        public function get measuredWidth():Number
        {
            return (_measuredWidth);
        }

        public function set instanceIndices(_arg_1:Array):void
        {
            _instanceIndices = _arg_1;
        }

        public function set cachePolicy(_arg_1:String):void
        {
            if (_cachePolicy != _arg_1)
            {
                _cachePolicy = _arg_1;
                if (_arg_1 == UIComponentCachePolicy.OFF)
                {
                    cacheAsBitmap = false;
                }
                else
                {
                    if (_arg_1 == UIComponentCachePolicy.ON)
                    {
                        cacheAsBitmap = true;
                    }
                    else
                    {
                        cacheAsBitmap = (cacheAsBitmapCount > 0);
                    };
                };
            };
        }

        public function get automationValue():Array
        {
            if (automationDelegate)
            {
                return (automationDelegate.automationValue);
            };
            return ([]);
        }

        private function addedHandler(event:Event):void
        {
            if (event.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            };
            try
            {
                if (((parent is IContainer) && (IContainer(parent).creatingContentPane)))
                {
                    event.stopImmediatePropagation();
                    return;
                };
            }
            catch(error:SecurityError)
            {
            };
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
                    if ((_arg_1 is ISystemManager))
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

        public function get owner():DisplayObjectContainer
        {
            return ((_owner) ? _owner : parent);
        }

        public function get processedDescriptors():Boolean
        {
            return (_processedDescriptors);
        }

        override public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            var _local_3:DisplayObjectContainer = _arg_1.parent;
            if (((_local_3) && (!(_local_3 is Loader))))
            {
                _local_3.removeChild(_arg_1);
            };
            if (((overlayReferenceCount) && (!(_arg_1 == overlay))))
            {
                _arg_2 = Math.min(_arg_2, Math.max(0, (super.numChildren - 1)));
            };
            addingChild(_arg_1);
            $addChildAt(_arg_1, _arg_2);
            childAdded(_arg_1);
            return (_arg_1);
        }

        [Bindable("explicitMaxWidthChanged")]
        public function get maxWidth():Number
        {
            return ((isNaN(explicitMaxWidth)) ? DEFAULT_MAX_WIDTH : explicitMaxWidth);
        }

        [Bindable("alphaChanged")]
        override public function set alpha(_arg_1:Number):void
        {
            super.alpha = _arg_1;
            dispatchEvent(new Event("alphaChanged"));
        }

        private function removedHandler(event:Event):void
        {
            if (event.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            };
            try
            {
                if (((parent is IContainer) && (IContainer(parent).creatingContentPane)))
                {
                    event.stopImmediatePropagation();
                    return;
                };
            }
            catch(error:SecurityError)
            {
            };
            _systemManagerDirty = true;
        }

        public function callLater(_arg_1:Function, _arg_2:Array=null):void
        {
            methodQueue.push(new MethodQueueElement(_arg_1, _arg_2));
            var _local_3:ISystemManager = systemManager;
            if (((_local_3) && ((_local_3.stage) || (_local_3.useSWFBridge()))))
            {
                if (!listeningForRender)
                {
                    _local_3.addEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _local_3.addEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = true;
                };
                if (_local_3.stage)
                {
                    _local_3.stage.invalidate();
                };
            };
        }

        public function get initialized():Boolean
        {
            return (_initialized);
        }

        private function callLaterDispatcher2(_arg_1:Event):void
        {
            var _local_6:MethodQueueElement;
            if (UIComponentGlobals.callLaterSuspendCount > 0)
            {
                return;
            };
            var _local_2:ISystemManager = systemManager;
            if ((((_local_2) && ((_local_2.stage) || (_local_2.useSWFBridge()))) && (listeningForRender)))
            {
                _local_2.removeEventListener(FlexEvent.RENDER, callLaterDispatcher);
                _local_2.removeEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                listeningForRender = false;
            };
            var _local_3:Array = methodQueue;
            methodQueue = [];
            var _local_4:int = _local_3.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = MethodQueueElement(_local_3[_local_5]);
                _local_6.method.apply(null, _local_6.args);
                _local_5++;
            };
        }

        public function measureHTMLText(_arg_1:String):TextLineMetrics
        {
            return (determineTextFormatFromStyles().measureHTMLText(_arg_1));
        }

        public function set descriptor(_arg_1:UIComponentDescriptor):void
        {
            _descriptor = _arg_1;
        }

        private function getState(_arg_1:String):State
        {
            if (((!(states)) || (isBaseState(_arg_1))))
            {
                return (null);
            };
            var _local_2:int;
            while (_local_2 < states.length)
            {
                if (states[_local_2].name == _arg_1)
                {
                    return (states[_local_2]);
                };
                _local_2++;
            };
            var _local_3:String = resourceManager.getString("core", "stateUndefined", [_arg_1]);
            throw (new ArgumentError(_local_3));
        }

        public function validateProperties():void
        {
            if (invalidatePropertiesFlag)
            {
                commitProperties();
                invalidatePropertiesFlag = false;
            };
        }

        mx_internal function get documentDescriptor():UIComponentDescriptor
        {
            return (_documentDescriptor);
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
                dispatchEvent(new Event("includeInLayoutChanged"));
            };
        }

        public function getClassStyleDeclarations():Array
        {
            var myApplicationDomain:ApplicationDomain;
            var cache:Array;
            var myRoot:DisplayObject;
            var s:CSSStyleDeclaration;
            var factory:IFlexModuleFactory = ModuleManager.getAssociatedFactory(this);
            if (factory != null)
            {
                myApplicationDomain = ApplicationDomain(factory.info()["currentDomain"]);
            }
            else
            {
                myRoot = SystemManager.getSWFRoot(this);
                if (!myRoot)
                {
                    return ([]);
                };
                myApplicationDomain = myRoot.loaderInfo.applicationDomain;
            };
            var className:String = getQualifiedClassName(this);
            className = className.replace("::", ".");
            cache = StyleManager.typeSelectorCache[className];
            if (cache)
            {
                return (cache);
            };
            var decls:Array = [];
            var classNames:Array = [];
            var caches:Array = [];
            var declcache:Array = [];
            while ((((!(className == null)) && (!(className == "mx.core.UIComponent"))) && (!(className == "mx.core.UITextField"))))
            {
                cache = StyleManager.typeSelectorCache[className];
                if (cache)
                {
                    decls = decls.concat(cache);
                    break;
                };
                s = StyleManager.getStyleDeclaration(className);
                if (s)
                {
                    decls.unshift(s);
                    classNames.push(className);
                    caches.push(classNames);
                    declcache.push(decls);
                    decls = [];
                    classNames = [];
                }
                else
                {
                    classNames.push(className);
                };
                try
                {
                    className = getQualifiedSuperclassName(myApplicationDomain.getDefinition(className));
                    className = className.replace("::", ".");
                }
                catch(e:ReferenceError)
                {
                    className = null;
                };
            };
            caches.push(classNames);
            declcache.push(decls);
            decls = [];
            while (caches.length)
            {
                classNames = caches.pop();
                decls = decls.concat(declcache.pop());
                while (classNames.length)
                {
                    StyleManager.typeSelectorCache[classNames.pop()] = decls;
                };
            };
            return (decls);
        }

        public function set measuredMinWidth(_arg_1:Number):void
        {
            _measuredMinWidth = _arg_1;
        }

        private function initializeState(_arg_1:String):void
        {
            var _local_2:State = getState(_arg_1);
            while (_local_2)
            {
                _local_2.initialize();
                _local_2 = getState(_local_2.basedOn);
            };
        }

        mx_internal function initProtoChain():void
        {
            var _local_1:CSSStyleDeclaration;
            var _local_7:Object;
            var _local_8:CSSStyleDeclaration;
            if (styleName)
            {
                if ((styleName is CSSStyleDeclaration))
                {
                    _local_1 = CSSStyleDeclaration(styleName);
                }
                else
                {
                    if (((styleName is IFlexDisplayObject) || (styleName is IStyleClient)))
                    {
                        StyleProtoChain.initProtoChainForUIComponentStyleName(this);
                        return;
                    };
                    if ((styleName is String))
                    {
                        _local_1 = StyleManager.getStyleDeclaration(("." + styleName));
                    };
                };
            };
            var _local_2:Object = StyleManager.stylesRoot;
            if (((_local_2) && (_local_2.effects)))
            {
                registerEffects(_local_2.effects);
            };
            var _local_3:IStyleClient = (parent as IStyleClient);
            if (_local_3)
            {
                _local_7 = _local_3.inheritingStyles;
                if (_local_7 == UIComponent.STYLE_UNINITIALIZED)
                {
                    _local_7 = _local_2;
                };
            }
            else
            {
                if (isPopUp)
                {
                    if ((((FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0) && (_owner)) && (_owner is IStyleClient)))
                    {
                        _local_7 = IStyleClient(_owner).inheritingStyles;
                    }
                    else
                    {
                        _local_7 = ApplicationGlobals.application.inheritingStyles;
                    };
                }
                else
                {
                    _local_7 = StyleManager.stylesRoot;
                };
            };
            var _local_4:Array = getClassStyleDeclarations();
            var _local_5:int = _local_4.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_8 = _local_4[_local_6];
                _local_7 = _local_8.addStyleToProtoChain(_local_7, this);
                _local_2 = _local_8.addStyleToProtoChain(_local_2, this);
                if (_local_8.effects)
                {
                    registerEffects(_local_8.effects);
                };
                _local_6++;
            };
            if (_local_1)
            {
                _local_7 = _local_1.addStyleToProtoChain(_local_7, this);
                _local_2 = _local_1.addStyleToProtoChain(_local_2, this);
                if (_local_1.effects)
                {
                    registerEffects(_local_1.effects);
                };
            };
            inheritingStyles = ((_styleDeclaration) ? _styleDeclaration.addStyleToProtoChain(_local_7, this) : _local_7);
            nonInheritingStyles = ((_styleDeclaration) ? _styleDeclaration.addStyleToProtoChain(_local_2, this) : _local_2);
        }

        public function get repeaterIndices():Array
        {
            return ((_repeaterIndices) ? _repeaterIndices.slice() : []);
        }

        override public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            removingChild(_arg_1);
            $removeChild(_arg_1);
            childRemoved(_arg_1);
            return (_arg_1);
        }

        private function focusObj_moveHandler(_arg_1:MoveEvent):void
        {
            adjustFocusRect();
        }

        public function get styleDeclaration():CSSStyleDeclaration
        {
            return (_styleDeclaration);
        }

        override public function get doubleClickEnabled():Boolean
        {
            return (super.doubleClickEnabled);
        }

        public function contentToLocal(_arg_1:Point):Point
        {
            return (_arg_1);
        }

        private function creationCompleteHandler(_arg_1:FlexEvent):void
        {
            if (_currentStateChanged)
            {
                _currentStateChanged = false;
                commitCurrentState();
                validateNow();
            };
            removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        public function set measuredHeight(_arg_1:Number):void
        {
            _measuredHeight = _arg_1;
        }

        protected function createChildren():void
        {
        }

        public function get activeEffects():Array
        {
            return (_effectsStarted);
        }

        override public function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void
        {
            if (((overlayReferenceCount) && (!(_arg_1 == overlay))))
            {
                _arg_2 = Math.min(_arg_2, Math.max(0, (super.numChildren - 2)));
            };
            super.setChildIndex(_arg_1, _arg_2);
        }

        public function regenerateStyleCache(_arg_1:Boolean):void
        {
            var _local_5:DisplayObject;
            initProtoChain();
            var _local_2:IChildList = ((this is IRawChildrenContainer) ? IRawChildrenContainer(this).rawChildren : IChildList(this));
            var _local_3:int = _local_2.numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _local_2.getChildAt(_local_4);
                if ((_local_5 is IStyleClient))
                {
                    if (IStyleClient(_local_5).inheritingStyles != UIComponent.STYLE_UNINITIALIZED)
                    {
                        IStyleClient(_local_5).regenerateStyleCache(_arg_1);
                    };
                }
                else
                {
                    if ((_local_5 is IUITextField))
                    {
                        if (IUITextField(_local_5).inheritingStyles)
                        {
                            StyleProtoChain.initTextField(IUITextField(_local_5));
                        };
                    };
                };
                _local_4++;
            };
        }

        public function get updateCompletePendingFlag():Boolean
        {
            return (_updateCompletePendingFlag);
        }

        protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            if (isOurFocus(DisplayObject(_arg_1.target)))
            {
                drawFocus(false);
            };
        }

        public function getFocus():InteractiveObject
        {
            var _local_1:ISystemManager = systemManager;
            if (!_local_1)
            {
                return (null);
            };
            if (UIComponentGlobals.nextFocusObject)
            {
                return (UIComponentGlobals.nextFocusObject);
            };
            return (_local_1.stage.focus);
        }

        public function endEffectsStarted():void
        {
            var _local_1:int = _effectsStarted.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _effectsStarted[_local_2].end();
                _local_2++;
            };
        }

        protected function get unscaledHeight():Number
        {
            return (height / Math.abs(scaleY));
        }

        [Bindable("enabledChanged")]
        public function get enabled():Boolean
        {
            return (_enabled);
        }

        public function get focusEnabled():Boolean
        {
            return (_focusEnabled);
        }

        override public function set cacheAsBitmap(_arg_1:Boolean):void
        {
            super.cacheAsBitmap = _arg_1;
            cacheAsBitmapCount = ((_arg_1) ? 1 : 0);
        }

        mx_internal function removeOverlay():void
        {
            if ((((overlayReferenceCount > 0) && (--overlayReferenceCount == 0)) && (overlay)))
            {
                removeEventListener("resize", overlay_resizeHandler);
                if (super.getChildByName("overlay"))
                {
                    $removeChild(overlay);
                };
                overlay = null;
            };
        }

        public function set cacheHeuristic(_arg_1:Boolean):void
        {
            if (_cachePolicy == UIComponentCachePolicy.AUTO)
            {
                if (_arg_1)
                {
                    cacheAsBitmapCount++;
                }
                else
                {
                    if (cacheAsBitmapCount != 0)
                    {
                        cacheAsBitmapCount--;
                    };
                };
                super.cacheAsBitmap = (!(cacheAsBitmapCount == 0));
            };
        }

        public function get cachePolicy():String
        {
            return (_cachePolicy);
        }

        public function set maxHeight(_arg_1:Number):void
        {
            if (explicitMaxHeight == _arg_1)
            {
                return;
            };
            explicitMaxHeight = _arg_1;
        }

        public function getConstraintValue(_arg_1:String):*
        {
            return (getStyle(_arg_1));
        }

        public function set focusManager(_arg_1:IFocusManager):void
        {
            _focusManager = _arg_1;
        }

        public function clearStyle(_arg_1:String):void
        {
            setStyle(_arg_1, undefined);
        }

        public function get descriptor():UIComponentDescriptor
        {
            return (_descriptor);
        }

        public function set nonInheritingStyles(_arg_1:Object):void
        {
            _nonInheritingStyles = _arg_1;
        }

        public function get cursorManager():ICursorManager
        {
            var _local_2:ICursorManager;
            var _local_1:DisplayObject = parent;
            while (_local_1)
            {
                if (((_local_1 is IUIComponent) && ("cursorManager" in _local_1)))
                {
                    return (_local_1["cursorManager"]);
                };
                _local_1 = _local_1.parent;
            };
            return (CursorManager.getInstance());
        }

        public function set automationDelegate(_arg_1:Object):void
        {
            _automationDelegate = (_arg_1 as IAutomationObject);
        }

        public function get measuredMinWidth():Number
        {
            return (_measuredMinWidth);
        }

        public function createReferenceOnParentDocument(_arg_1:IFlexDisplayObject):void
        {
            var _local_2:Array;
            var _local_3:Object;
            var _local_4:int;
            var _local_5:int;
            var _local_6:PropertyChangeEvent;
            var _local_7:Object;
            if (((id) && (!(id == ""))))
            {
                _local_2 = _instanceIndices;
                if (!_local_2)
                {
                    _arg_1[id] = this;
                }
                else
                {
                    _local_3 = _arg_1[id];
                    if (!(_local_3 is Array))
                    {
                        _local_3 = (_arg_1[id] = []);
                    };
                    _local_4 = _local_2.length;
                    _local_5 = 0;
                    while (_local_5 < (_local_4 - 1))
                    {
                        _local_7 = _local_3[_local_2[_local_5]];
                        if (!(_local_7 is Array))
                        {
                            _local_7 = (_local_3[_local_2[_local_5]] = []);
                        };
                        _local_3 = _local_7;
                        _local_5++;
                    };
                    _local_3[_local_2[(_local_4 - 1)]] = this;
                    _local_6 = PropertyChangeEvent.createUpdateEvent(_arg_1, id, _arg_1[id], _arg_1[id]);
                    _arg_1.dispatchEvent(_local_6);
                };
            };
        }

        public function get repeater():IRepeater
        {
            return ((_repeaters) ? _repeaters[(_repeaters.length - 1)] : null);
        }

        public function set isPopUp(_arg_1:Boolean):void
        {
            _isPopUp = _arg_1;
        }

        public function get measuredHeight():Number
        {
            return (_measuredHeight);
        }

        public function initialize():void
        {
            if (initialized)
            {
                return;
            };
            dispatchEvent(new FlexEvent(FlexEvent.PREINITIALIZE));
            createChildren();
            childrenCreated();
            initializeAccessibility();
            initializationComplete();
        }

        override public function set width(_arg_1:Number):void
        {
            var _local_2:IInvalidating;
            if (explicitWidth != _arg_1)
            {
                explicitWidth = _arg_1;
                invalidateSize();
            };
            if (_width != _arg_1)
            {
                invalidateProperties();
                invalidateDisplayList();
                _local_2 = (parent as IInvalidating);
                if (((_local_2) && (includeInLayout)))
                {
                    _local_2.invalidateSize();
                    _local_2.invalidateDisplayList();
                };
                _width = _arg_1;
                dispatchEvent(new Event("widthChanged"));
            };
        }

        public function set percentHeight(_arg_1:Number):void
        {
            if (_percentHeight == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _explicitHeight = NaN;
            };
            _percentHeight = _arg_1;
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
        }

        final mx_internal function set $visible(_arg_1:Boolean):void
        {
            super.visible = _arg_1;
        }

        private function findCommonBaseState(_arg_1:String, _arg_2:String):String
        {
            var _local_3:State = getState(_arg_1);
            var _local_4:State = getState(_arg_2);
            if (((!(_local_3)) || (!(_local_4))))
            {
                return ("");
            };
            if (((isBaseState(_local_3.basedOn)) && (isBaseState(_local_4.basedOn))))
            {
                return ("");
            };
            var _local_5:Array = getBaseStates(_local_3);
            var _local_6:Array = getBaseStates(_local_4);
            var _local_7:* = "";
            while (_local_5[(_local_5.length - 1)] == _local_6[(_local_6.length - 1)])
            {
                _local_7 = _local_5.pop();
                _local_6.pop();
                if (((!(_local_5.length)) || (!(_local_6.length)))) break;
            };
            if (((_local_5.length) && (_local_5[(_local_5.length - 1)] == _local_4.name)))
            {
                _local_7 = _local_4.name;
            }
            else
            {
                if (((_local_6.length) && (_local_6[(_local_6.length - 1)] == _local_3.name)))
                {
                    _local_7 = _local_3.name;
                };
            };
            return (_local_7);
        }

        mx_internal function childRemoved(_arg_1:DisplayObject):void
        {
            if ((_arg_1 is IUIComponent))
            {
                if (IUIComponent(_arg_1).document != _arg_1)
                {
                    IUIComponent(_arg_1).document = null;
                };
                IUIComponent(_arg_1).parentChanged(null);
            };
        }

        final mx_internal function $removeChildAt(_arg_1:int):DisplayObject
        {
            return (super.removeChildAt(_arg_1));
        }

        [Bindable("explicitMaxHeightChanged")]
        public function get maxHeight():Number
        {
            return ((isNaN(explicitMaxHeight)) ? DEFAULT_MAX_HEIGHT : explicitMaxHeight);
        }

        protected function initializeAccessibility():void
        {
            if (UIComponent.createAccessibilityImplementation != null)
            {
                UIComponent.createAccessibilityImplementation(this);
            };
        }

        public function set explicitMaxHeight(_arg_1:Number):void
        {
            if (_explicitMaxHeight == _arg_1)
            {
                return;
            };
            _explicitMaxHeight = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (_local_2)
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitMaxHeightChanged"));
        }

        public function get focusManager():IFocusManager
        {
            if (_focusManager)
            {
                return (_focusManager);
            };
            var _local_1:DisplayObject = parent;
            while (_local_1)
            {
                if ((_local_1 is IFocusManagerContainer))
                {
                    return (IFocusManagerContainer(_local_1).focusManager);
                };
                _local_1 = _local_1.parent;
            };
            return (null);
        }

        public function set styleName(_arg_1:Object):void
        {
            if (_styleName === _arg_1)
            {
                return;
            };
            _styleName = _arg_1;
            if (inheritingStyles == UIComponent.STYLE_UNINITIALIZED)
            {
                return;
            };
            regenerateStyleCache(true);
            initThemeColor();
            styleChanged("styleName");
            notifyStyleChangeInChildren("styleName", true);
        }

        public function get automationDelegate():Object
        {
            return (_automationDelegate);
        }

        [Bindable("unused")]
        protected function get resourceManager():IResourceManager
        {
            return (_resourceManager);
        }

        mx_internal function validateBaselinePosition():Boolean
        {
            var _local_1:Number;
            var _local_2:Number;
            if (!parent)
            {
                return (false);
            };
            if (((width == 0) && (height == 0)))
            {
                validateNow();
                _local_1 = getExplicitOrMeasuredWidth();
                _local_2 = getExplicitOrMeasuredHeight();
                setActualSize(_local_1, _local_2);
            };
            validateNow();
            return (true);
        }

        mx_internal function cancelAllCallLaters():void
        {
            var _local_1:ISystemManager = systemManager;
            if (((_local_1) && ((_local_1.stage) || (_local_1.useSWFBridge()))))
            {
                if (listeningForRender)
                {
                    _local_1.removeEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _local_1.removeEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = false;
                };
            };
            methodQueue.splice(0);
        }

        private function updateCompleteHandler(_arg_1:FlexEvent):void
        {
            UIComponentGlobals.layoutManager.removeEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
            processEffectFinished(_endingEffectInstances);
            _endingEffectInstances = [];
        }

        public function styleChanged(_arg_1:String):void
        {
            if (((this is IFontContextComponent) && (hasFontContextChanged())))
            {
                invalidateProperties();
            };
            if ((((!(_arg_1)) || (_arg_1 == "styleName")) || (StyleManager.isSizeInvalidatingStyle(_arg_1))))
            {
                invalidateSize();
            };
            if ((((!(_arg_1)) || (_arg_1 == "styleName")) || (_arg_1 == "themeColor")))
            {
                initThemeColor();
            };
            invalidateDisplayList();
            if ((parent is IInvalidating))
            {
                if (StyleManager.isParentSizeInvalidatingStyle(_arg_1))
                {
                    IInvalidating(parent).invalidateSize();
                };
                if (StyleManager.isParentDisplayListInvalidatingStyle(_arg_1))
                {
                    IInvalidating(parent).invalidateDisplayList();
                };
            };
        }

        final mx_internal function get $visible():Boolean
        {
            return (super.visible);
        }

        public function drawRoundRect(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Object=null, _arg_6:Object=null, _arg_7:Object=null, _arg_8:Object=null, _arg_9:String=null, _arg_10:Array=null, _arg_11:Object=null):void
        {
            var _local_13:Number;
            var _local_14:Array;
            var _local_15:Matrix;
            var _local_16:Object;
            var _local_12:Graphics = graphics;
            if (((!(_arg_3)) || (!(_arg_4))))
            {
                return;
            };
            if (_arg_6 !== null)
            {
                if ((_arg_6 is Array))
                {
                    if ((_arg_7 is Array))
                    {
                        _local_14 = (_arg_7 as Array);
                    }
                    else
                    {
                        _local_14 = [_arg_7, _arg_7];
                    };
                    if (!_arg_10)
                    {
                        _arg_10 = [0, 0xFF];
                    };
                    _local_15 = null;
                    if (_arg_8)
                    {
                        if ((_arg_8 is Matrix))
                        {
                            _local_15 = Matrix(_arg_8);
                        }
                        else
                        {
                            _local_15 = new Matrix();
                            if ((_arg_8 is Number))
                            {
                                _local_15.createGradientBox(_arg_3, _arg_4, ((Number(_arg_8) * Math.PI) / 180), _arg_1, _arg_2);
                            }
                            else
                            {
                                _local_15.createGradientBox(_arg_8.w, _arg_8.h, _arg_8.r, _arg_8.x, _arg_8.y);
                            };
                        };
                    };
                    if (_arg_9 == GradientType.RADIAL)
                    {
                        _local_12.beginGradientFill(GradientType.RADIAL, (_arg_6 as Array), _local_14, _arg_10, _local_15);
                    }
                    else
                    {
                        _local_12.beginGradientFill(GradientType.LINEAR, (_arg_6 as Array), _local_14, _arg_10, _local_15);
                    };
                }
                else
                {
                    _local_12.beginFill(Number(_arg_6), Number(_arg_7));
                };
            };
            if (!_arg_5)
            {
                _local_12.drawRect(_arg_1, _arg_2, _arg_3, _arg_4);
            }
            else
            {
                if ((_arg_5 is Number))
                {
                    _local_13 = (Number(_arg_5) * 2);
                    _local_12.drawRoundRect(_arg_1, _arg_2, _arg_3, _arg_4, _local_13, _local_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_local_12, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5.tl, _arg_5.tr, _arg_5.bl, _arg_5.br);
                };
            };
            if (_arg_11)
            {
                _local_16 = _arg_11.r;
                if ((_local_16 is Number))
                {
                    _local_13 = (Number(_local_16) * 2);
                    _local_12.drawRoundRect(_arg_11.x, _arg_11.y, _arg_11.w, _arg_11.h, _local_13, _local_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_local_12, _arg_11.x, _arg_11.y, _arg_11.w, _arg_11.h, _local_16.tl, _local_16.tr, _local_16.bl, _local_16.br);
                };
            };
            if (_arg_6 !== null)
            {
                _local_12.endFill();
            };
        }

        public function move(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Boolean;
            if (_arg_1 != super.x)
            {
                super.x = _arg_1;
                dispatchEvent(new Event("xChanged"));
                _local_3 = true;
            };
            if (_arg_2 != super.y)
            {
                super.y = _arg_2;
                dispatchEvent(new Event("yChanged"));
                _local_3 = true;
            };
            if (_local_3)
            {
                dispatchMoveEvent();
            };
        }

        public function set toolTip(_arg_1:String):void
        {
            var _local_2:String = _toolTip;
            _toolTip = _arg_1;
            ToolTipManager.registerToolTip(this, _local_2, _arg_1);
            dispatchEvent(new Event("toolTipChanged"));
        }

        public function set repeaters(_arg_1:Array):void
        {
            _repeaters = _arg_1;
        }

        [Bindable("explicitMaxHeightChanged")]
        public function get explicitMaxHeight():Number
        {
            return (_explicitMaxHeight);
        }

        public function measureText(_arg_1:String):TextLineMetrics
        {
            return (determineTextFormatFromStyles().measureText(_arg_1));
        }

        public function get styleName():Object
        {
            return (_styleName);
        }

        protected function createInModuleContext(_arg_1:IFlexModuleFactory, _arg_2:String):Object
        {
            var _local_3:Object;
            if (_arg_1)
            {
                _local_3 = _arg_1.create(_arg_2);
            };
            return (_local_3);
        }

        [Bindable("initialize")]
        public function get parentDocument():Object
        {
            var _local_1:IUIComponent;
            var _local_2:ISystemManager;
            if (document == this)
            {
                _local_1 = (parent as IUIComponent);
                if (_local_1)
                {
                    return (_local_1.document);
                };
                _local_2 = (parent as ISystemManager);
                if (_local_2)
                {
                    return (_local_2.document);
                };
                return (null);
            };
            return (document);
        }

        protected function childrenCreated():void
        {
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
        }

        public function set flexContextMenu(_arg_1:IFlexContextMenu):void
        {
            if (_flexContextMenu)
            {
                _flexContextMenu.unsetContextMenu(this);
            };
            _flexContextMenu = _arg_1;
            if (_arg_1 != null)
            {
                _flexContextMenu.setContextMenu(this);
            };
        }

        public function set explicitWidth(_arg_1:Number):void
        {
            if (_explicitWidth == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _percentWidth = NaN;
            };
            _explicitWidth = _arg_1;
            invalidateSize();
            var _local_2:IInvalidating = (parent as IInvalidating);
            if (((_local_2) && (includeInLayout)))
            {
                _local_2.invalidateSize();
                _local_2.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitWidthChanged"));
        }

        private function setBorderColorForErrorString():void
        {
            if (((!(_errorString)) || (_errorString.length == 0)))
            {
                if (!isNaN(origBorderColor))
                {
                    setStyle("borderColor", origBorderColor);
                    saveBorderColor = true;
                };
            }
            else
            {
                if (saveBorderColor)
                {
                    saveBorderColor = false;
                    origBorderColor = getStyle("borderColor");
                };
                setStyle("borderColor", getStyle("errorColor"));
            };
            styleChanged("themeColor");
            var _local_1:IFocusManager = focusManager;
            var _local_2:DisplayObject = ((_local_1) ? DisplayObject(_local_1.getFocus()) : null);
            if ((((_local_1) && (_local_1.showFocusIndicator)) && (_local_2 == this)))
            {
                drawFocus(true);
            };
        }

        [Bindable("explicitWidthChanged")]
        public function get explicitWidth():Number
        {
            return (_explicitWidth);
        }

        public function invalidateSize():void
        {
            if (!invalidateSizeFlag)
            {
                invalidateSizeFlag = true;
                if (((parent) && (UIComponentGlobals.layoutManager)))
                {
                    UIComponentGlobals.layoutManager.invalidateSize(this);
                };
            };
        }

        public function set measuredMinHeight(_arg_1:Number):void
        {
            _measuredMinHeight = _arg_1;
        }

        protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
        }

        override public function set filters(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:IEventDispatcher;
            if (_filters)
            {
                _local_2 = _filters.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (_filters[_local_3] as IEventDispatcher);
                    if (_local_4)
                    {
                        _local_4.removeEventListener("change", filterChangeHandler);
                    };
                    _local_3++;
                };
            };
            _filters = _arg_1;
            if (_filters)
            {
                _local_2 = _filters.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (_filters[_local_3] as IEventDispatcher);
                    if (_local_4)
                    {
                        _local_4.addEventListener("change", filterChangeHandler);
                    };
                    _local_3++;
                };
            };
            super.filters = _filters;
        }


    }
}//package mx.core

class MethodQueueElement 
{

    public var method:Function;
    public var args:Array;

    public function MethodQueueElement(_arg_1:Function, _arg_2:Array=null)
    {
        this.method = _arg_1;
        this.args = _arg_2;
    }

}


