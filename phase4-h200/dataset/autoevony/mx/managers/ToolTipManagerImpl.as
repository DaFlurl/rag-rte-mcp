// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ToolTipManagerImpl

package mx.managers
{
    import flash.events.EventDispatcher;
    import mx.effects.IAbstractEffect;
    import flash.utils.Timer;
    import mx.controls.ToolTip;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import mx.events.InterManagerRequest;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import mx.events.ToolTipEvent;
    import mx.core.IToolTip;
    import mx.core.ApplicationGlobals;
    import mx.core.IUIComponent;
    import mx.events.EffectEvent;
    import mx.effects.EffectManager;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import mx.styles.IStyleClient;
    import mx.validators.IValidatorListener;
    import mx.core.IInvalidating;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToolTipManagerImpl extends EventDispatcher implements IToolTipManager2 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var instance:IToolTipManager2;

        private var _enabled:Boolean = true;
        private var _showDelay:Number = 500;
        private var _hideEffect:IAbstractEffect;
        mx_internal var hideTimer:Timer;
        private var _scrubDelay:Number = 100;
        private var _toolTipClass:Class = ToolTip;
        mx_internal var showTimer:Timer;
        private var sandboxRoot:IEventDispatcher = null;
        mx_internal var currentText:String;
        private var _currentToolTip:DisplayObject;
        mx_internal var scrubTimer:Timer;
        mx_internal var previousTarget:DisplayObject;
        private var _currentTarget:DisplayObject;
        private var systemManager:ISystemManager = null;
        private var _showEffect:IAbstractEffect;
        private var _hideDelay:Number = 10000;
        mx_internal var initialized:Boolean = false;
        mx_internal var isError:Boolean;

        public function ToolTipManagerImpl()
        {
            if (instance)
            {
                throw (new Error("Instance already exists."));
            };
            this.systemManager = (SystemManagerGlobals.topLevelSystemManagers[0] as ISystemManager);
            sandboxRoot = this.systemManager.getSandboxRoot();
            sandboxRoot.addEventListener(InterManagerRequest.TOOLTIP_MANAGER_REQUEST, marshalToolTipManagerHandler, false, 0, true);
            var _local_1:InterManagerRequest = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
            _local_1.name = "update";
            sandboxRoot.dispatchEvent(_local_1);
        }

        public static function getInstance():IToolTipManager2
        {
            if (!instance)
            {
                instance = new (ToolTipManagerImpl)();
            };
            return (instance);
        }


        mx_internal function systemManager_mouseDownHandler(_arg_1:MouseEvent):void
        {
            reset();
        }

        public function set showDelay(_arg_1:Number):void
        {
            _showDelay = _arg_1;
        }

        mx_internal function showTimer_timerHandler(_arg_1:TimerEvent):void
        {
            if (currentTarget)
            {
                createTip();
                initializeTip();
                positionTip();
                showTip();
            };
        }

        mx_internal function hideEffectEnded():void
        {
            var _local_1:ToolTipEvent;
            reset();
            if (previousTarget)
            {
                _local_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_END);
                _local_1.toolTip = currentToolTip;
                previousTarget.dispatchEvent(_local_1);
            };
        }

        public function set scrubDelay(_arg_1:Number):void
        {
            _scrubDelay = _arg_1;
        }

        public function get currentToolTip():IToolTip
        {
            return (_currentToolTip as IToolTip);
        }

        private function mouseIsOver(_arg_1:DisplayObject):Boolean
        {
            if (((!(_arg_1)) || (!(_arg_1.stage))))
            {
                return (false);
            };
            if (((_arg_1.stage.mouseX == 0) && (_arg_1.stage.mouseY == 0)))
            {
                return (false);
            };
            return (_arg_1.hitTestPoint(_arg_1.stage.mouseX, _arg_1.stage.mouseY, true));
        }

        mx_internal function toolTipMouseOutHandler(_arg_1:MouseEvent):void
        {
            checkIfTargetChanged(_arg_1.relatedObject);
        }

        public function get enabled():Boolean
        {
            return (_enabled);
        }

        public function createToolTip(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:String=null, _arg_5:IUIComponent=null):IToolTip
        {
            var _local_6:ToolTip = new ToolTip();
            var _local_7:ISystemManager = ((_arg_5) ? (_arg_5.systemManager as ISystemManager) : (ApplicationGlobals.application.systemManager as ISystemManager));
            _local_7.topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", (_local_6 as DisplayObject));
            if (_arg_4)
            {
                _local_6.setStyle("styleName", "errorTip");
                _local_6.setStyle("borderStyle", _arg_4);
            };
            _local_6.text = _arg_1;
            sizeTip(_local_6);
            _local_6.move(_arg_2, _arg_3);
            return (_local_6 as IToolTip);
        }

        mx_internal function reset():void
        {
            var _local_1:ISystemManager;
            showTimer.reset();
            hideTimer.reset();
            if (currentToolTip)
            {
                if (((showEffect) || (hideEffect)))
                {
                    currentToolTip.removeEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                };
                EffectManager.endEffectsForTarget(currentToolTip);
                _local_1 = (currentToolTip.systemManager as ISystemManager);
                _local_1.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", (currentToolTip as DisplayObject));
                currentToolTip = null;
                scrubTimer.delay = scrubDelay;
                scrubTimer.reset();
                if (scrubDelay > 0)
                {
                    scrubTimer.delay = scrubDelay;
                    scrubTimer.start();
                };
            };
        }

        public function set currentToolTip(_arg_1:IToolTip):void
        {
            _currentToolTip = (_arg_1 as DisplayObject);
            var _local_2:InterManagerRequest = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
            _local_2.name = "currentToolTip";
            _local_2.value = _arg_1;
            sandboxRoot.dispatchEvent(_local_2);
        }

        public function get toolTipClass():Class
        {
            return (_toolTipClass);
        }

        private function hideImmediately(_arg_1:DisplayObject):void
        {
            checkIfTargetChanged(null);
        }

        mx_internal function showTip():void
        {
            var _local_2:ISystemManager;
            var _local_1:ToolTipEvent = new ToolTipEvent(ToolTipEvent.TOOL_TIP_SHOW);
            _local_1.toolTip = currentToolTip;
            currentTarget.dispatchEvent(_local_1);
            if (isError)
            {
                currentTarget.addEventListener("change", changeHandler);
            }
            else
            {
                _local_2 = getSystemManager(currentTarget);
                _local_2.addEventListener(MouseEvent.MOUSE_DOWN, systemManager_mouseDownHandler);
            };
            currentToolTip.visible = true;
            if (!showEffect)
            {
                showEffectEnded();
            };
        }

        mx_internal function effectEndHandler(_arg_1:EffectEvent):void
        {
            if (_arg_1.effectInstance.effect == showEffect)
            {
                showEffectEnded();
            }
            else
            {
                if (_arg_1.effectInstance.effect == hideEffect)
                {
                    hideEffectEnded();
                };
            };
        }

        public function get hideDelay():Number
        {
            return (_hideDelay);
        }

        public function get currentTarget():DisplayObject
        {
            return (_currentTarget);
        }

        mx_internal function showEffectEnded():void
        {
            var _local_1:ToolTipEvent;
            if (hideDelay == 0)
            {
                hideTip();
            }
            else
            {
                if (hideDelay < Infinity)
                {
                    hideTimer.delay = hideDelay;
                    hideTimer.start();
                };
            };
            if (currentTarget)
            {
                _local_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_SHOWN);
                _local_1.toolTip = currentToolTip;
                currentTarget.dispatchEvent(_local_1);
            };
        }

        public function get hideEffect():IAbstractEffect
        {
            return (_hideEffect);
        }

        mx_internal function changeHandler(_arg_1:Event):void
        {
            reset();
        }

        public function set enabled(_arg_1:Boolean):void
        {
            _enabled = _arg_1;
        }

        mx_internal function errorTipMouseOverHandler(_arg_1:MouseEvent):void
        {
            checkIfTargetChanged(DisplayObject(_arg_1.target));
        }

        public function get showDelay():Number
        {
            return (_showDelay);
        }

        public function get scrubDelay():Number
        {
            return (_scrubDelay);
        }

        public function registerErrorString(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void
        {
            if (((!(_arg_2)) && (_arg_3)))
            {
                _arg_1.addEventListener(MouseEvent.MOUSE_OVER, errorTipMouseOverHandler);
                _arg_1.addEventListener(MouseEvent.MOUSE_OUT, errorTipMouseOutHandler);
                if (mouseIsOver(_arg_1))
                {
                    showImmediately(_arg_1);
                };
            }
            else
            {
                if (((_arg_2) && (!(_arg_3))))
                {
                    _arg_1.removeEventListener(MouseEvent.MOUSE_OVER, errorTipMouseOverHandler);
                    _arg_1.removeEventListener(MouseEvent.MOUSE_OUT, errorTipMouseOutHandler);
                    if (mouseIsOver(_arg_1))
                    {
                        hideImmediately(_arg_1);
                    };
                };
            };
        }

        mx_internal function initialize():void
        {
            if (!showTimer)
            {
                showTimer = new Timer(0, 1);
                showTimer.addEventListener(TimerEvent.TIMER, showTimer_timerHandler);
            };
            if (!hideTimer)
            {
                hideTimer = new Timer(0, 1);
                hideTimer.addEventListener(TimerEvent.TIMER, hideTimer_timerHandler);
            };
            if (!scrubTimer)
            {
                scrubTimer = new Timer(0, 1);
            };
            initialized = true;
        }

        public function destroyToolTip(_arg_1:IToolTip):void
        {
            var _local_2:ISystemManager = (_arg_1.systemManager as ISystemManager);
            _local_2.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", DisplayObject(_arg_1));
        }

        mx_internal function checkIfTargetChanged(_arg_1:DisplayObject):void
        {
            if (!enabled)
            {
                return;
            };
            findTarget(_arg_1);
            if (currentTarget != previousTarget)
            {
                targetChanged();
                previousTarget = currentTarget;
            };
        }

        private function marshalToolTipManagerHandler(_arg_1:Event):void
        {
            var _local_2:InterManagerRequest;
            if ((_arg_1 is InterManagerRequest))
            {
                return;
            };
            var _local_3:Object = _arg_1;
            switch (_local_3.name)
            {
                case "currentToolTip":
                    _currentToolTip = _local_3.value;
                    return;
                case ToolTipEvent.TOOL_TIP_HIDE:
                    if ((_currentToolTip is IToolTip))
                    {
                        hideTip();
                    };
                    return;
                case "update":
                    _arg_1.stopImmediatePropagation();
                    _local_2 = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
                    _local_2.name = "currentToolTip";
                    _local_2.value = _currentToolTip;
                    sandboxRoot.dispatchEvent(_local_2);
            };
        }

        public function set toolTipClass(_arg_1:Class):void
        {
            _toolTipClass = _arg_1;
        }

        private function getGlobalBounds(_arg_1:DisplayObject, _arg_2:DisplayObject):Rectangle
        {
            var _local_3:Point = new Point(0, 0);
            _local_3 = _arg_1.localToGlobal(_local_3);
            _local_3 = _arg_2.globalToLocal(_local_3);
            return (new Rectangle(_local_3.x, _local_3.y, _arg_1.width, _arg_1.height));
        }

        mx_internal function positionTip():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_5:Rectangle;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:ISystemManager;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Point;
            var _local_3:Number = currentToolTip.screen.width;
            var _local_4:Number = currentToolTip.screen.height;
            if (isError)
            {
                _local_5 = getGlobalBounds(currentTarget, currentToolTip.root);
                _local_1 = (_local_5.right + 4);
                _local_2 = (_local_5.top - 1);
                if ((_local_1 + currentToolTip.width) > _local_3)
                {
                    _local_6 = NaN;
                    _local_7 = NaN;
                    _local_1 = (_local_5.left - 2);
                    if (((_local_1 + currentToolTip.width) + 4) > _local_3)
                    {
                        _local_6 = ((_local_3 - _local_1) - 4);
                        _local_7 = Object(toolTipClass).maxWidth;
                        Object(toolTipClass).maxWidth = _local_6;
                        if ((currentToolTip is IStyleClient))
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipAbove");
                        };
                        currentToolTip["text"] = currentToolTip["text"];
                    }
                    else
                    {
                        if ((currentToolTip is IStyleClient))
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipAbove");
                        };
                        currentToolTip["text"] = currentToolTip["text"];
                    };
                    if ((currentToolTip.height + 2) < _local_5.top)
                    {
                        _local_2 = (_local_5.top - (currentToolTip.height + 2));
                    }
                    else
                    {
                        _local_2 = (_local_5.bottom + 2);
                        if (!isNaN(_local_6))
                        {
                            Object(toolTipClass).maxWidth = _local_6;
                        };
                        if ((currentToolTip is IStyleClient))
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipBelow");
                        };
                        currentToolTip["text"] = currentToolTip["text"];
                    };
                };
                sizeTip(currentToolTip);
                if (!isNaN(_local_7))
                {
                    Object(toolTipClass).maxWidth = _local_7;
                };
            }
            else
            {
                _local_8 = getSystemManager(currentTarget);
                _local_1 = (DisplayObject(_local_8).mouseX + 11);
                _local_2 = (DisplayObject(_local_8).mouseY + 22);
                _local_9 = currentToolTip.width;
                if ((_local_1 + _local_9) > _local_3)
                {
                    _local_1 = (_local_3 - _local_9);
                };
                _local_10 = currentToolTip.height;
                if ((_local_2 + _local_10) > _local_4)
                {
                    _local_2 = (_local_4 - _local_10);
                };
                _local_11 = new Point(_local_1, _local_2);
                _local_11 = DisplayObject(_local_8).localToGlobal(_local_11);
                _local_11 = DisplayObject(sandboxRoot).globalToLocal(_local_11);
                _local_1 = _local_11.x;
                _local_2 = _local_11.y;
            };
            currentToolTip.move(_local_1, _local_2);
        }

        mx_internal function errorTipMouseOutHandler(_arg_1:MouseEvent):void
        {
            checkIfTargetChanged(_arg_1.relatedObject);
        }

        mx_internal function findTarget(_arg_1:DisplayObject):void
        {
            while (_arg_1)
            {
                if ((_arg_1 is IValidatorListener))
                {
                    currentText = IValidatorListener(_arg_1).errorString;
                    if (((!(currentText == null)) && (!(currentText == ""))))
                    {
                        currentTarget = _arg_1;
                        isError = true;
                        return;
                    };
                };
                if ((_arg_1 is IToolTipManagerClient))
                {
                    currentText = IToolTipManagerClient(_arg_1).toolTip;
                    if (currentText != null)
                    {
                        currentTarget = _arg_1;
                        isError = false;
                        return;
                    };
                };
                _arg_1 = _arg_1.parent;
            };
            currentText = null;
            currentTarget = null;
        }

        public function registerToolTip(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void
        {
            if (((!(_arg_2)) && (_arg_3)))
            {
                _arg_1.addEventListener(MouseEvent.MOUSE_OVER, toolTipMouseOverHandler);
                _arg_1.addEventListener(MouseEvent.MOUSE_OUT, toolTipMouseOutHandler);
                if (mouseIsOver(_arg_1))
                {
                    showImmediately(_arg_1);
                };
            }
            else
            {
                if (((_arg_2) && (!(_arg_3))))
                {
                    _arg_1.removeEventListener(MouseEvent.MOUSE_OVER, toolTipMouseOverHandler);
                    _arg_1.removeEventListener(MouseEvent.MOUSE_OUT, toolTipMouseOutHandler);
                    if (mouseIsOver(_arg_1))
                    {
                        hideImmediately(_arg_1);
                    };
                };
            };
        }

        private function showImmediately(_arg_1:DisplayObject):void
        {
            var _local_2:Number = ToolTipManager.showDelay;
            ToolTipManager.showDelay = 0;
            checkIfTargetChanged(_arg_1);
            ToolTipManager.showDelay = _local_2;
        }

        public function set hideDelay(_arg_1:Number):void
        {
            _hideDelay = _arg_1;
        }

        private function getSystemManager(_arg_1:DisplayObject):ISystemManager
        {
            return ((_arg_1 is IUIComponent) ? IUIComponent(_arg_1).systemManager : null);
        }

        public function set currentTarget(_arg_1:DisplayObject):void
        {
            _currentTarget = _arg_1;
        }

        public function sizeTip(_arg_1:IToolTip):void
        {
            if ((_arg_1 is IInvalidating))
            {
                IInvalidating(_arg_1).validateNow();
            };
            _arg_1.setActualSize(_arg_1.getExplicitOrMeasuredWidth(), _arg_1.getExplicitOrMeasuredHeight());
        }

        public function set showEffect(_arg_1:IAbstractEffect):void
        {
            _showEffect = (_arg_1 as IAbstractEffect);
        }

        mx_internal function targetChanged():void
        {
            var _local_1:ToolTipEvent;
            var _local_2:InterManagerRequest;
            if (!initialized)
            {
                initialize();
            };
            if (((previousTarget) && (currentToolTip)))
            {
                if ((currentToolTip is IToolTip))
                {
                    _local_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE);
                    _local_1.toolTip = currentToolTip;
                    previousTarget.dispatchEvent(_local_1);
                }
                else
                {
                    _local_2 = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
                    _local_2.name = ToolTipEvent.TOOL_TIP_HIDE;
                    sandboxRoot.dispatchEvent(_local_2);
                };
            };
            reset();
            if (currentTarget)
            {
                if (currentText == "")
                {
                    return;
                };
                _local_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_START);
                currentTarget.dispatchEvent(_local_1);
                if (((showDelay == 0) || (scrubTimer.running)))
                {
                    createTip();
                    initializeTip();
                    positionTip();
                    showTip();
                }
                else
                {
                    showTimer.delay = showDelay;
                    showTimer.start();
                };
            };
        }

        public function set hideEffect(_arg_1:IAbstractEffect):void
        {
            _hideEffect = (_arg_1 as IAbstractEffect);
        }

        mx_internal function hideTimer_timerHandler(_arg_1:TimerEvent):void
        {
            hideTip();
        }

        mx_internal function initializeTip():void
        {
            if ((currentToolTip is IToolTip))
            {
                IToolTip(currentToolTip).text = currentText;
            };
            if (((isError) && (currentToolTip is IStyleClient)))
            {
                IStyleClient(currentToolTip).setStyle("styleName", "errorTip");
            };
            sizeTip(currentToolTip);
            if ((currentToolTip is IStyleClient))
            {
                if (showEffect)
                {
                    IStyleClient(currentToolTip).setStyle("showEffect", showEffect);
                };
                if (hideEffect)
                {
                    IStyleClient(currentToolTip).setStyle("hideEffect", hideEffect);
                };
            };
            if (((showEffect) || (hideEffect)))
            {
                currentToolTip.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
            };
        }

        public function get showEffect():IAbstractEffect
        {
            return (_showEffect);
        }

        mx_internal function toolTipMouseOverHandler(_arg_1:MouseEvent):void
        {
            checkIfTargetChanged(DisplayObject(_arg_1.target));
        }

        mx_internal function hideTip():void
        {
            var _local_1:ToolTipEvent;
            var _local_2:ISystemManager;
            if (previousTarget)
            {
                _local_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE);
                _local_1.toolTip = currentToolTip;
                previousTarget.dispatchEvent(_local_1);
            };
            if (currentToolTip)
            {
                currentToolTip.visible = false;
            };
            if (isError)
            {
                if (currentTarget)
                {
                    currentTarget.removeEventListener("change", changeHandler);
                };
            }
            else
            {
                if (previousTarget)
                {
                    _local_2 = getSystemManager(previousTarget);
                    _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, systemManager_mouseDownHandler);
                };
            };
            if (!hideEffect)
            {
                hideEffectEnded();
            };
        }

        mx_internal function createTip():void
        {
            var _local_1:ToolTipEvent = new ToolTipEvent(ToolTipEvent.TOOL_TIP_CREATE);
            currentTarget.dispatchEvent(_local_1);
            if (_local_1.toolTip)
            {
                currentToolTip = _local_1.toolTip;
            }
            else
            {
                currentToolTip = new toolTipClass();
            };
            currentToolTip.visible = false;
            var _local_2:ISystemManager = (getSystemManager(currentTarget) as ISystemManager);
            _local_2.topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", (currentToolTip as DisplayObject));
        }


    }
}//package mx.managers

