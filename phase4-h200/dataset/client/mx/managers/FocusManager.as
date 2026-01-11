// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.FocusManager

package mx.managers
{
    import flash.display.InteractiveObject;
    import mx.core.SWFBridgeGroup;
    import mx.core.IButton;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.IEventDispatcher;
    import flash.system.Capabilities;
    import mx.core.FlexSprite;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.events.SWFBridgeEvent;
    import mx.events.SWFBridgeRequest;
    import flash.display.DisplayObjectContainer;
    import mx.core.IChildList;
    import mx.core.IRawChildrenContainer;
    import flash.text.TextField;
    import flash.events.FocusEvent;
    import mx.core.ISWFBridgeProvider;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import mx.core.IUIComponent;
    import mx.core.ISWFLoader;
    import mx.events.FocusRequestDirection;
    import mx.core.IToggleButton;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FocusManager implements IFocusManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const FROM_INDEX_UNSPECIFIED:int = -2;

        private var lastActiveFocusManager:FocusManager;
        private var _showFocusIndicator:Boolean = false;
        private var focusableCandidates:Array;
        private var LARGE_TAB_INDEX:int = 99999;
        private var browserFocusComponent:InteractiveObject;
        private var calculateCandidates:Boolean = true;
        private var _lastFocus:IFocusManagerComponent;
        private var lastAction:String;
        private var focusSetLocally:Boolean;
        private var focusableObjects:Array;
        private var swfBridgeGroup:SWFBridgeGroup;
        private var defButton:IButton;
        private var _form:IFocusManagerContainer;
        private var popup:Boolean;
        private var focusChanged:Boolean;
        private var _defaultButtonEnabled:Boolean = true;
        private var activated:Boolean = false;
        private var _defaultButton:IButton;
        private var fauxFocus:DisplayObject;
        private var _focusPane:Sprite;
        private var skipBridge:IEventDispatcher;
        public var browserMode:Boolean;

        public function FocusManager(container:IFocusManagerContainer, popup:Boolean=false)
        {
            var sm:ISystemManager;
            var bridge:IEventDispatcher;
            super();
            this.popup = popup;
            browserMode = ((Capabilities.playerType == "ActiveX") && (!(popup)));
            container.focusManager = this;
            _form = container;
            focusableObjects = [];
            focusPane = new FlexSprite();
            focusPane.name = "focusPane";
            addFocusables(DisplayObject(container));
            container.addEventListener(Event.ADDED, addedHandler);
            container.addEventListener(Event.REMOVED, removedHandler);
            container.addEventListener(FlexEvent.SHOW, showHandler);
            container.addEventListener(FlexEvent.HIDE, hideHandler);
            if ((container.systemManager is SystemManager))
            {
                if (container != SystemManager(container.systemManager).application)
                {
                    container.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
                };
            };
            try
            {
                container.systemManager.addFocusManager(container);
                sm = form.systemManager;
                swfBridgeGroup = new SWFBridgeGroup(sm);
                if (!popup)
                {
                    swfBridgeGroup.parentBridge = sm.swfBridgeGroup.parentBridge;
                };
                if (sm.useSWFBridge())
                {
                    sm.addEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, removeFromParentBridge);
                    bridge = swfBridgeGroup.parentBridge;
                    if (bridge)
                    {
                        bridge.addEventListener(SWFBridgeRequest.MOVE_FOCUS_REQUEST, focusRequestMoveHandler);
                        bridge.addEventListener(SWFBridgeRequest.SET_SHOW_FOCUS_INDICATOR_REQUEST, setShowFocusIndicatorRequestHandler);
                    };
                    if (((bridge) && (!(form.systemManager is SystemManagerProxy))))
                    {
                        bridge.addEventListener(SWFBridgeRequest.ACTIVATE_FOCUS_REQUEST, focusRequestActivateHandler);
                        bridge.addEventListener(SWFBridgeRequest.DEACTIVATE_FOCUS_REQUEST, focusRequestDeactivateHandler);
                        bridge.addEventListener(SWFBridgeEvent.BRIDGE_FOCUS_MANAGER_ACTIVATE, bridgeEventActivateHandler);
                    };
                    container.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
                };
            }
            catch(e:Error)
            {
            };
        }

        private function dispatchSetShowFocusIndicatorRequest(_arg_1:Boolean, _arg_2:IEventDispatcher):void
        {
            var _local_3:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.SET_SHOW_FOCUS_INDICATOR_REQUEST, false, false, null, _arg_1);
            dispatchEventFromSWFBridges(_local_3, _arg_2);
        }

        private function creationCompleteHandler(_arg_1:FlexEvent):void
        {
            var _local_2:DisplayObject = DisplayObject(form);
            if ((((_local_2.parent) && (_local_2.visible)) && (!(activated))))
            {
                form.systemManager.activate(form);
            };
        }

        private function addFocusables(o:DisplayObject, skipTopLevel:Boolean=false):void
        {
            var addToFocusables:Boolean;
            var focusable:IFocusManagerComponent;
            var doc:DisplayObjectContainer;
            var rawChildren:IChildList;
            var i:int;
            if (((o is IFocusManagerComponent) && (!(skipTopLevel))))
            {
                addToFocusables = false;
                if ((o is IFocusManagerComponent))
                {
                    focusable = IFocusManagerComponent(o);
                    if (focusable.focusEnabled)
                    {
                        if (((focusable.tabEnabled) && (isTabVisible(o))))
                        {
                            addToFocusables = true;
                        };
                    };
                };
                if (addToFocusables)
                {
                    if (focusableObjects.indexOf(o) == -1)
                    {
                        focusableObjects.push(o);
                        calculateCandidates = true;
                    };
                    o.addEventListener("tabEnabledChange", tabEnabledChangeHandler);
                    o.addEventListener("tabIndexChange", tabIndexChangeHandler);
                };
            };
            if ((o is DisplayObjectContainer))
            {
                doc = DisplayObjectContainer(o);
                o.addEventListener("tabChildrenChange", tabChildrenChangeHandler);
                if (doc.tabChildren)
                {
                    if ((o is IRawChildrenContainer))
                    {
                        rawChildren = IRawChildrenContainer(o).rawChildren;
                        i = 0;
                        while (i < rawChildren.numChildren)
                        {
                            try
                            {
                                addFocusables(rawChildren.getChildAt(i));
                            }
                            catch(error:SecurityError)
                            {
                            };
                            i = (i + 1);
                        };
                    }
                    else
                    {
                        i = 0;
                        while (i < doc.numChildren)
                        {
                            try
                            {
                                addFocusables(doc.getChildAt(i));
                            }
                            catch(error:SecurityError)
                            {
                            };
                            i = (i + 1);
                        };
                    };
                };
            };
        }

        private function tabEnabledChangeHandler(_arg_1:Event):void
        {
            calculateCandidates = true;
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
            var _local_3:int = focusableObjects.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (focusableObjects[_local_4] == _local_2) break;
                _local_4++;
            };
            if (_local_2.tabEnabled)
            {
                if (((_local_4 == _local_3) && (isTabVisible(_local_2))))
                {
                    if (focusableObjects.indexOf(_local_2) == -1)
                    {
                        focusableObjects.push(_local_2);
                    };
                };
            }
            else
            {
                if (_local_4 < _local_3)
                {
                    focusableObjects.splice(_local_4, 1);
                };
            };
        }

        private function mouseFocusChangeHandler(_arg_1:FocusEvent):void
        {
            var _local_2:TextField;
            if ((((_arg_1.relatedObject == null) && ("isRelatedObjectInaccessible" in _arg_1)) && (_arg_1["isRelatedObjectInaccessible"] == true)))
            {
                return;
            };
            if ((_arg_1.relatedObject is TextField))
            {
                _local_2 = (_arg_1.relatedObject as TextField);
                if (((_local_2.type == "input") || (_local_2.selectable)))
                {
                    return;
                };
            };
            _arg_1.preventDefault();
        }

        public function addSWFBridge(_arg_1:IEventDispatcher, _arg_2:DisplayObject):void
        {
            if (!_arg_2)
            {
                return;
            };
            var _local_3:ISystemManager = _form.systemManager;
            if (focusableObjects.indexOf(_arg_2) == -1)
            {
                focusableObjects.push(_arg_2);
                calculateCandidates = true;
            };
            swfBridgeGroup.addChildBridge(_arg_1, ISWFBridgeProvider(_arg_2));
            _arg_1.addEventListener(SWFBridgeRequest.MOVE_FOCUS_REQUEST, focusRequestMoveHandler);
            _arg_1.addEventListener(SWFBridgeRequest.SET_SHOW_FOCUS_INDICATOR_REQUEST, setShowFocusIndicatorRequestHandler);
            _arg_1.addEventListener(SWFBridgeEvent.BRIDGE_FOCUS_MANAGER_ACTIVATE, bridgeEventActivateHandler);
        }

        private function getChildIndex(parent:DisplayObjectContainer, child:DisplayObject):int
        {
            try
            {
                return (parent.getChildIndex(child));
            }
            catch(e:Error)
            {
                if ((parent is IRawChildrenContainer))
                {
                    return (IRawChildrenContainer(parent).rawChildren.getChildIndex(child));
                };
                throw (e);
            };
            throw (new Error("FocusManager.getChildIndex failed"));
        }

        private function bridgeEventActivateHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeEvent))
            {
                return;
            };
            lastActiveFocusManager = null;
            _lastFocus = null;
            dispatchActivatedFocusManagerEvent(IEventDispatcher(_arg_1.target));
        }

        private function focusOutHandler(_arg_1:FocusEvent):void
        {
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
        }

        private function isValidFocusCandidate(_arg_1:DisplayObject, _arg_2:String):Boolean
        {
            var _local_3:IFocusManagerGroup;
            if (!isEnabledAndVisible(_arg_1))
            {
                return (false);
            };
            if ((_arg_1 is IFocusManagerGroup))
            {
                _local_3 = IFocusManagerGroup(_arg_1);
                if (_arg_2 == _local_3.groupName)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function defaultButtonKeyHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:ISystemManager = form.systemManager;
            if (_local_2.isDisplayObjectInABridgedApplication(DisplayObject(_arg_1.target)))
            {
                return;
            };
            if (((((defaultButtonEnabled) && (_arg_1.keyCode == Keyboard.ENTER)) && (defaultButton)) && (defButton.enabled)))
            {
                sendDefaultButtonEvent();
            };
        }

        private function removeFocusables(_arg_1:DisplayObject, _arg_2:Boolean):void
        {
            var _local_3:int;
            if ((_arg_1 is DisplayObjectContainer))
            {
                if (!_arg_2)
                {
                    _arg_1.removeEventListener("tabChildrenChange", tabChildrenChangeHandler);
                };
                _local_3 = 0;
                while (_local_3 < focusableObjects.length)
                {
                    if (isParent(DisplayObjectContainer(_arg_1), focusableObjects[_local_3]))
                    {
                        if (focusableObjects[_local_3] == _lastFocus)
                        {
                            _lastFocus.drawFocus(false);
                            _lastFocus = null;
                        };
                        focusableObjects[_local_3].removeEventListener("tabEnabledChange", tabEnabledChangeHandler);
                        focusableObjects[_local_3].removeEventListener("tabIndexChange", tabIndexChangeHandler);
                        focusableObjects.splice(_local_3, 1);
                        _local_3--;
                        focusableCandidates = [];
                        calculateCandidates = true;
                    };
                    _local_3++;
                };
            };
        }

        private function addedHandler(_arg_1:Event):void
        {
            var _local_2:DisplayObject = DisplayObject(_arg_1.target);
            if (_local_2.stage)
            {
                addFocusables(DisplayObject(_arg_1.target));
            };
        }

        private function tabChildrenChangeHandler(_arg_1:Event):void
        {
            if (_arg_1.target != _arg_1.currentTarget)
            {
                return;
            };
            calculateCandidates = true;
            var _local_2:DisplayObjectContainer = DisplayObjectContainer(_arg_1.target);
            if (_local_2.tabChildren)
            {
                addFocusables(_local_2, true);
            }
            else
            {
                removeFocusables(_local_2, true);
            };
        }

        private function sortByDepth(_arg_1:DisplayObject, _arg_2:DisplayObject):Number
        {
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_3:* = "";
            var _local_4:* = "";
            var _local_8:* = "0000";
            var _local_9:DisplayObject = DisplayObject(_arg_1);
            var _local_10:DisplayObject = DisplayObject(_arg_2);
            while (((!(_local_9 == DisplayObject(form))) && (_local_9.parent)))
            {
                _local_5 = getChildIndex(_local_9.parent, _local_9);
                _local_6 = _local_5.toString(16);
                if (_local_6.length < 4)
                {
                    _local_7 = (_local_8.substring(0, (4 - _local_6.length)) + _local_6);
                };
                _local_3 = (_local_7 + _local_3);
                _local_9 = _local_9.parent;
            };
            while (((!(_local_10 == DisplayObject(form))) && (_local_10.parent)))
            {
                _local_5 = getChildIndex(_local_10.parent, _local_10);
                _local_6 = _local_5.toString(16);
                if (_local_6.length < 4)
                {
                    _local_7 = (_local_8.substring(0, (4 - _local_6.length)) + _local_6);
                };
                _local_4 = (_local_7 + _local_4);
                _local_10 = _local_10.parent;
            };
            return ((_local_3 > _local_4) ? 1 : ((_local_3 < _local_4) ? -1 : 0));
        }

        mx_internal function sendDefaultButtonEvent():void
        {
            defButton.dispatchEvent(new MouseEvent("click"));
        }

        public function getFocus():IFocusManagerComponent
        {
            var _local_1:InteractiveObject = form.systemManager.stage.focus;
            return (findFocusManagerComponent(_local_1));
        }

        private function deactivateHandler(_arg_1:Event):void
        {
        }

        private function setFocusToBottom():void
        {
            setFocusToNextIndex(focusableObjects.length, true);
        }

        private function tabIndexChangeHandler(_arg_1:Event):void
        {
            calculateCandidates = true;
        }

        private function sortFocusableObjects():void
        {
            var _local_3:InteractiveObject;
            focusableCandidates = [];
            var _local_1:int = focusableObjects.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = focusableObjects[_local_2];
                if ((((_local_3.tabIndex) && (!(isNaN(Number(_local_3.tabIndex))))) && (_local_3.tabIndex > 0)))
                {
                    sortFocusableObjectsTabIndex();
                    return;
                };
                focusableCandidates.push(_local_3);
                _local_2++;
            };
            focusableCandidates.sort(sortByDepth);
        }

        private function keyFocusChangeHandler(_arg_1:FocusEvent):void
        {
            var _local_2:ISystemManager = form.systemManager;
            if (_local_2.isDisplayObjectInABridgedApplication(DisplayObject(_arg_1.target)))
            {
                return;
            };
            showFocusIndicator = true;
            focusChanged = false;
            if (((_arg_1.keyCode == Keyboard.TAB) && (!(_arg_1.isDefaultPrevented()))))
            {
                if (browserFocusComponent)
                {
                    if (browserFocusComponent.tabIndex == LARGE_TAB_INDEX)
                    {
                        browserFocusComponent.tabIndex = -1;
                    };
                    browserFocusComponent = null;
                    if (SystemManager(form.systemManager).useSWFBridge())
                    {
                        moveFocusToParent(_arg_1.shiftKey);
                        if (focusChanged)
                        {
                            _arg_1.preventDefault();
                        };
                    };
                    return;
                };
                setFocusToNextObject(_arg_1);
                if (focusChanged)
                {
                    _arg_1.preventDefault();
                };
            };
        }

        private function getNextFocusManagerComponent2(_arg_1:Boolean=false, _arg_2:DisplayObject=null, _arg_3:int=-2):FocusInfo
        {
            var _local_10:DisplayObject;
            var _local_11:String;
            var _local_12:IFocusManagerGroup;
            if (focusableObjects.length == 0)
            {
                return (null);
            };
            if (calculateCandidates)
            {
                sortFocusableObjects();
                calculateCandidates = false;
            };
            var _local_4:int = _arg_3;
            if (_arg_3 == FROM_INDEX_UNSPECIFIED)
            {
                _local_10 = _arg_2;
                if (!_local_10)
                {
                    _local_10 = form.systemManager.stage.focus;
                };
                _local_10 = DisplayObject(findFocusManagerComponent2(InteractiveObject(_local_10)));
                _local_11 = "";
                if ((_local_10 is IFocusManagerGroup))
                {
                    _local_12 = IFocusManagerGroup(_local_10);
                    _local_11 = _local_12.groupName;
                };
                _local_4 = getIndexOfFocusedObject(_local_10);
            };
            var _local_5:Boolean;
            var _local_6:int = _local_4;
            if (_local_4 == -1)
            {
                if (_arg_1)
                {
                    _local_4 = focusableCandidates.length;
                };
                _local_5 = true;
            };
            var _local_7:int = getIndexOfNextObject(_local_4, _arg_1, _local_5, _local_11);
            var _local_8:Boolean;
            if (_arg_1)
            {
                if (_local_7 >= _local_4)
                {
                    _local_8 = true;
                };
            }
            else
            {
                if (_local_7 <= _local_4)
                {
                    _local_8 = true;
                };
            };
            var _local_9:FocusInfo = new FocusInfo();
            _local_9.displayObject = findFocusManagerComponent2(focusableCandidates[_local_7]);
            _local_9.wrapped = _local_8;
            return (_local_9);
        }

        private function getIndexOfFocusedObject(_arg_1:DisplayObject):int
        {
            var _local_4:IUIComponent;
            if (!_arg_1)
            {
                return (-1);
            };
            var _local_2:int = focusableCandidates.length;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                if (focusableCandidates[_local_3] == _arg_1)
                {
                    return (_local_3);
                };
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = (focusableCandidates[_local_3] as IUIComponent);
                if (((_local_4) && (_local_4.owns(_arg_1))))
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        private function focusRequestActivateHandler(_arg_1:Event):void
        {
            skipBridge = IEventDispatcher(_arg_1.target);
            activate();
            skipBridge = null;
        }

        private function removeFromParentBridge(_arg_1:Event):void
        {
            var _local_3:IEventDispatcher;
            var _local_2:ISystemManager = form.systemManager;
            if (_local_2.useSWFBridge())
            {
                _local_2.removeEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, removeFromParentBridge);
                _local_3 = swfBridgeGroup.parentBridge;
                if (_local_3)
                {
                    _local_3.removeEventListener(SWFBridgeRequest.MOVE_FOCUS_REQUEST, focusRequestMoveHandler);
                    _local_3.removeEventListener(SWFBridgeRequest.SET_SHOW_FOCUS_INDICATOR_REQUEST, setShowFocusIndicatorRequestHandler);
                };
                if (((_local_3) && (!(form.systemManager is SystemManagerProxy))))
                {
                    _local_3.removeEventListener(SWFBridgeRequest.ACTIVATE_FOCUS_REQUEST, focusRequestActivateHandler);
                    _local_3.removeEventListener(SWFBridgeRequest.DEACTIVATE_FOCUS_REQUEST, focusRequestDeactivateHandler);
                    _local_3.removeEventListener(SWFBridgeEvent.BRIDGE_FOCUS_MANAGER_ACTIVATE, bridgeEventActivateHandler);
                };
            };
        }

        private function getParentBridge():IEventDispatcher
        {
            if (swfBridgeGroup)
            {
                return (swfBridgeGroup.parentBridge);
            };
            return (null);
        }

        private function setFocusToComponent(_arg_1:Object, _arg_2:Boolean):void
        {
            var _local_3:SWFBridgeRequest;
            var _local_4:IEventDispatcher;
            focusChanged = false;
            if (_arg_1)
            {
                if (((_arg_1 is ISWFLoader) && (ISWFLoader(_arg_1).swfBridge)))
                {
                    _local_3 = new SWFBridgeRequest(SWFBridgeRequest.MOVE_FOCUS_REQUEST, false, true, null, ((_arg_2) ? FocusRequestDirection.BOTTOM : FocusRequestDirection.TOP));
                    _local_4 = ISWFLoader(_arg_1).swfBridge;
                    if (_local_4)
                    {
                        _local_4.dispatchEvent(_local_3);
                        focusChanged = _local_3.data;
                    };
                }
                else
                {
                    if ((_arg_1 is IFocusManagerComplexComponent))
                    {
                        IFocusManagerComplexComponent(_arg_1).assignFocus(((_arg_2) ? "bottom" : "top"));
                        focusChanged = true;
                    }
                    else
                    {
                        if ((_arg_1 is IFocusManagerComponent))
                        {
                            setFocus(IFocusManagerComponent(_arg_1));
                            focusChanged = true;
                        };
                    };
                };
            };
        }

        private function focusRequestMoveHandler(_arg_1:Event):void
        {
            var _local_3:DisplayObject;
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            focusSetLocally = false;
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if (((_local_2.data == FocusRequestDirection.TOP) || (_local_2.data == FocusRequestDirection.BOTTOM)))
            {
                if (focusableObjects.length == 0)
                {
                    moveFocusToParent(((_local_2.data == FocusRequestDirection.TOP) ? false : true));
                    _arg_1["data"] = focusChanged;
                    return;
                };
                if (_local_2.data == FocusRequestDirection.TOP)
                {
                    setFocusToTop();
                }
                else
                {
                    setFocusToBottom();
                };
                _arg_1["data"] = focusChanged;
            }
            else
            {
                _local_3 = DisplayObject(_form.systemManager.swfBridgeGroup.getChildBridgeProvider(IEventDispatcher(_arg_1.target)));
                moveFocus((_local_2.data as String), _local_3);
                _arg_1["data"] = focusChanged;
            };
            if (focusSetLocally)
            {
                dispatchActivatedFocusManagerEvent(null);
                lastActiveFocusManager = this;
            };
        }

        public function get nextTabIndex():int
        {
            return (getMaxTabIndex() + 1);
        }

        private function dispatchActivatedFocusManagerEvent(_arg_1:IEventDispatcher=null):void
        {
            if (lastActiveFocusManager == this)
            {
                return;
            };
            var _local_2:SWFBridgeEvent = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_FOCUS_MANAGER_ACTIVATE);
            dispatchEventFromSWFBridges(_local_2, _arg_1);
        }

        private function focusRequestDeactivateHandler(_arg_1:Event):void
        {
            skipBridge = IEventDispatcher(_arg_1.target);
            deactivate();
            skipBridge = null;
        }

        public function get focusPane():Sprite
        {
            return (_focusPane);
        }

        private function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_3:DisplayObject;
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_7:IFocusManagerGroup;
            var _local_2:ISystemManager = form.systemManager;
            if (_local_2.isDisplayObjectInABridgedApplication(DisplayObject(_arg_1.target)))
            {
                return;
            };
            if ((_local_2 is SystemManager))
            {
                SystemManager(_local_2).idleCounter = 0;
            };
            if (_arg_1.keyCode == Keyboard.TAB)
            {
                lastAction = "KEY";
                if (calculateCandidates)
                {
                    sortFocusableObjects();
                    calculateCandidates = false;
                };
            };
            if (browserMode)
            {
                if (((_arg_1.keyCode == Keyboard.TAB) && (focusableCandidates.length > 0)))
                {
                    _local_3 = fauxFocus;
                    if (!_local_3)
                    {
                        _local_3 = form.systemManager.stage.focus;
                    };
                    _local_3 = DisplayObject(findFocusManagerComponent2(InteractiveObject(_local_3)));
                    _local_4 = "";
                    if ((_local_3 is IFocusManagerGroup))
                    {
                        _local_7 = IFocusManagerGroup(_local_3);
                        _local_4 = _local_7.groupName;
                    };
                    _local_5 = getIndexOfFocusedObject(_local_3);
                    _local_6 = getIndexOfNextObject(_local_5, _arg_1.shiftKey, false, _local_4);
                    if (_arg_1.shiftKey)
                    {
                        if (_local_6 >= _local_5)
                        {
                            browserFocusComponent = getBrowserFocusComponent(_arg_1.shiftKey);
                            if (browserFocusComponent.tabIndex == -1)
                            {
                                browserFocusComponent.tabIndex = 0;
                            };
                        };
                    }
                    else
                    {
                        if (_local_6 <= _local_5)
                        {
                            browserFocusComponent = getBrowserFocusComponent(_arg_1.shiftKey);
                            if (browserFocusComponent.tabIndex == -1)
                            {
                                browserFocusComponent.tabIndex = LARGE_TAB_INDEX;
                            };
                        };
                    };
                };
            };
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.isDefaultPrevented())
            {
                return;
            };
            var _local_2:ISystemManager = form.systemManager;
            var _local_3:DisplayObject = getTopLevelFocusTarget(InteractiveObject(_arg_1.target));
            if (!_local_3)
            {
                return;
            };
            showFocusIndicator = false;
            if ((((!(_local_3 == _lastFocus)) || (lastAction == "ACTIVATE")) && (!(_local_3 is TextField))))
            {
                setFocus(IFocusManagerComponent(_local_3));
            }
            else
            {
                if (_lastFocus)
                {
                    if ((((!(_lastFocus)) && (_local_3 is IEventDispatcher)) && (SystemManager(form.systemManager).useSWFBridge())))
                    {
                        IEventDispatcher(_local_3).dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
                    };
                };
            };
            lastAction = "MOUSEDOWN";
            dispatchActivatedFocusManagerEvent(null);
            lastActiveFocusManager = this;
        }

        private function focusInHandler(_arg_1:FocusEvent):void
        {
            var _local_4:IButton;
            var _local_2:InteractiveObject = InteractiveObject(_arg_1.target);
            var _local_3:ISystemManager = form.systemManager;
            if (_local_3.isDisplayObjectInABridgedApplication(DisplayObject(_arg_1.target)))
            {
                return;
            };
            if (isParent(DisplayObjectContainer(form), _local_2))
            {
                _lastFocus = findFocusManagerComponent(InteractiveObject(_local_2));
                if (((_lastFocus is IButton) && (!(_lastFocus is IToggleButton))))
                {
                    _local_4 = (_lastFocus as IButton);
                    if (defButton)
                    {
                        defButton.emphasized = false;
                        defButton = _local_4;
                        _local_4.emphasized = true;
                    };
                }
                else
                {
                    if (((defButton) && (!(defButton == _defaultButton))))
                    {
                        defButton.emphasized = false;
                        defButton = _defaultButton;
                        if (_defaultButton)
                        {
                            _defaultButton.emphasized = true;
                        };
                    };
                };
            };
        }

        public function toString():String
        {
            return (Object(form).toString() + ".focusManager");
        }

        public function deactivate():void
        {
            var _local_1:ISystemManager = form.systemManager;
            if (_local_1)
            {
                if (_local_1.isTopLevelRoot())
                {
                    _local_1.stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler);
                    _local_1.stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                    _local_1.stage.removeEventListener(Event.ACTIVATE, activateHandler);
                    _local_1.stage.removeEventListener(Event.DEACTIVATE, deactivateHandler);
                }
                else
                {
                    _local_1.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler);
                    _local_1.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
                    _local_1.removeEventListener(Event.ACTIVATE, activateHandler);
                    _local_1.removeEventListener(Event.DEACTIVATE, deactivateHandler);
                };
            };
            form.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler, true);
            form.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true);
            form.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            form.removeEventListener(KeyboardEvent.KEY_DOWN, defaultButtonKeyHandler);
            form.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
            activated = false;
            dispatchEventFromSWFBridges(new SWFBridgeRequest(SWFBridgeRequest.DEACTIVATE_FOCUS_REQUEST), skipBridge);
        }

        private function findFocusManagerComponent2(o:InteractiveObject):DisplayObject
        {
            try
            {
                while (o)
                {
                    if ((((o is IFocusManagerComponent) && (IFocusManagerComponent(o).focusEnabled)) || (o is ISWFLoader)))
                    {
                        return (o);
                    };
                    o = o.parent;
                };
            }
            catch(error:SecurityError)
            {
            };
            return (null);
        }

        private function getIndexOfNextObject(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:String):int
        {
            var _local_7:DisplayObject;
            var _local_8:IFocusManagerGroup;
            var _local_9:int;
            var _local_10:DisplayObject;
            var _local_11:IFocusManagerGroup;
            var _local_5:int = focusableCandidates.length;
            var _local_6:int = _arg_1;
            while (true)
            {
                if (_arg_2)
                {
                    _arg_1--;
                }
                else
                {
                    _arg_1++;
                };
                if (_arg_3)
                {
                    if (((_arg_2) && (_arg_1 < 0))) break;
                    if (((!(_arg_2)) && (_arg_1 == _local_5))) break;
                }
                else
                {
                    _arg_1 = ((_arg_1 + _local_5) % _local_5);
                    if (_local_6 == _arg_1) break;
                    if (_local_6 == -1)
                    {
                        _local_6 = _arg_1;
                    };
                };
                if (isValidFocusCandidate(focusableCandidates[_arg_1], _arg_4))
                {
                    _local_7 = DisplayObject(findFocusManagerComponent2(focusableCandidates[_arg_1]));
                    if ((_local_7 is IFocusManagerGroup))
                    {
                        _local_8 = IFocusManagerGroup(_local_7);
                        _local_9 = 0;
                        while (_local_9 < focusableCandidates.length)
                        {
                            _local_10 = focusableCandidates[_local_9];
                            if ((_local_10 is IFocusManagerGroup))
                            {
                                _local_11 = IFocusManagerGroup(_local_10);
                                if (((_local_11.groupName == _local_8.groupName) && (_local_11.selected)))
                                {
                                    if (((!(InteractiveObject(_local_10).tabIndex == InteractiveObject(_local_7).tabIndex)) && (!(_local_8.selected))))
                                    {
                                        return (getIndexOfNextObject(_arg_1, _arg_2, _arg_3, _arg_4));
                                    };
                                    _arg_1 = _local_9;
                                    break;
                                };
                            };
                            _local_9++;
                        };
                    };
                    return (_arg_1);
                };
            };
            return (_arg_1);
        }

        public function moveFocus(_arg_1:String, _arg_2:DisplayObject=null):void
        {
            if (_arg_1 == FocusRequestDirection.TOP)
            {
                setFocusToTop();
                return;
            };
            if (_arg_1 == FocusRequestDirection.BOTTOM)
            {
                setFocusToBottom();
                return;
            };
            var _local_3:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
            _local_3.keyCode = Keyboard.TAB;
            _local_3.shiftKey = ((_arg_1 == FocusRequestDirection.FORWARD) ? false : true);
            fauxFocus = _arg_2;
            keyDownHandler(_local_3);
            var _local_4:FocusEvent = new FocusEvent(FocusEvent.KEY_FOCUS_CHANGE);
            _local_4.keyCode = Keyboard.TAB;
            _local_4.shiftKey = ((_arg_1 == FocusRequestDirection.FORWARD) ? false : true);
            keyFocusChangeHandler(_local_4);
            fauxFocus = null;
        }

        private function getMaxTabIndex():int
        {
            var _local_4:Number;
            var _local_1:Number = 0;
            var _local_2:int = focusableObjects.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = focusableObjects[_local_3].tabIndex;
                if (!isNaN(_local_4))
                {
                    _local_1 = Math.max(_local_1, _local_4);
                };
                _local_3++;
            };
            return (_local_1);
        }

        private function isParent(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):Boolean
        {
            if ((_arg_1 is IRawChildrenContainer))
            {
                return (IRawChildrenContainer(_arg_1).rawChildren.contains(_arg_2));
            };
            return (_arg_1.contains(_arg_2));
        }

        private function showHandler(_arg_1:Event):void
        {
            form.systemManager.activate(form);
        }

        mx_internal function set form(_arg_1:IFocusManagerContainer):void
        {
            _form = _arg_1;
        }

        public function setFocus(_arg_1:IFocusManagerComponent):void
        {
            _arg_1.setFocus();
            focusSetLocally = true;
        }

        public function findFocusManagerComponent(_arg_1:InteractiveObject):IFocusManagerComponent
        {
            return (findFocusManagerComponent2(_arg_1) as IFocusManagerComponent);
        }

        public function removeSWFBridge(_arg_1:IEventDispatcher):void
        {
            var _local_4:int;
            var _local_2:ISystemManager = _form.systemManager;
            var _local_3:DisplayObject = DisplayObject(swfBridgeGroup.getChildBridgeProvider(_arg_1));
            if (_local_3)
            {
                _local_4 = focusableObjects.indexOf(_local_3);
                if (_local_4 != -1)
                {
                    focusableObjects.splice(_local_4, 1);
                    calculateCandidates = true;
                };
            }
            else
            {
                throw (new Error());
            };
            _arg_1.removeEventListener(SWFBridgeRequest.MOVE_FOCUS_REQUEST, focusRequestMoveHandler);
            _arg_1.removeEventListener(SWFBridgeRequest.SET_SHOW_FOCUS_INDICATOR_REQUEST, setShowFocusIndicatorRequestHandler);
            _arg_1.removeEventListener(SWFBridgeEvent.BRIDGE_FOCUS_MANAGER_ACTIVATE, bridgeEventActivateHandler);
            swfBridgeGroup.removeChildBridge(_arg_1);
        }

        private function sortFocusableObjectsTabIndex():void
        {
            var _local_3:IFocusManagerComponent;
            focusableCandidates = [];
            var _local_1:int = focusableObjects.length;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = (focusableObjects[_local_2] as IFocusManagerComponent);
                if (((((_local_3) && (_local_3.tabIndex)) && (!(isNaN(Number(_local_3.tabIndex))))) || (focusableObjects[_local_2] is ISWFLoader)))
                {
                    focusableCandidates.push(focusableObjects[_local_2]);
                };
                _local_2++;
            };
            focusableCandidates.sort(sortByTabIndex);
        }

        public function set defaultButton(_arg_1:IButton):void
        {
            var _local_2:IButton = ((_arg_1) ? IButton(_arg_1) : null);
            if (_local_2 != _defaultButton)
            {
                if (_defaultButton)
                {
                    _defaultButton.emphasized = false;
                };
                if (defButton)
                {
                    defButton.emphasized = false;
                };
                _defaultButton = _local_2;
                if ((((_lastFocus) && (_lastFocus is IButton)) && (!(_lastFocus is IToggleButton))))
                {
                    defButton = (_lastFocus as IButton);
                    defButton.emphasized = true;
                }
                else
                {
                    defButton = _local_2;
                    if (_local_2)
                    {
                        _local_2.emphasized = true;
                    };
                };
            };
        }

        private function setFocusToNextObject(_arg_1:FocusEvent):void
        {
            focusChanged = false;
            if (focusableObjects.length == 0)
            {
                return;
            };
            var _local_2:FocusInfo = getNextFocusManagerComponent2(_arg_1.shiftKey, fauxFocus);
            if (((!(popup)) && ((_local_2.wrapped) || (!(_local_2.displayObject)))))
            {
                if (getParentBridge())
                {
                    moveFocusToParent(_arg_1.shiftKey);
                    return;
                };
            };
            if (!_local_2.displayObject)
            {
                _arg_1.preventDefault();
                return;
            };
            setFocusToComponent(_local_2.displayObject, _arg_1.shiftKey);
        }

        private function getTopLevelFocusTarget(_arg_1:InteractiveObject):InteractiveObject
        {
            while (_arg_1 != InteractiveObject(form))
            {
                if (((((_arg_1 is IFocusManagerComponent) && (IFocusManagerComponent(_arg_1).focusEnabled)) && (IFocusManagerComponent(_arg_1).mouseFocusEnabled)) && ((_arg_1 is IUIComponent) ? IUIComponent(_arg_1).enabled : true)))
                {
                    return (_arg_1);
                };
                if ((_arg_1.parent is ISWFLoader))
                {
                    if (ISWFLoader(_arg_1.parent).swfBridge)
                    {
                        return (null);
                    };
                };
                _arg_1 = _arg_1.parent;
                if (_arg_1 == null) break;
            };
            return (null);
        }

        private function addedToStageHandler(_arg_1:Event):void
        {
            _form.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            if (focusableObjects.length == 0)
            {
                addFocusables(DisplayObject(_form));
                calculateCandidates = true;
            };
        }

        private function hideHandler(_arg_1:Event):void
        {
            form.systemManager.deactivate(form);
        }

        private function isEnabledAndVisible(_arg_1:DisplayObject):Boolean
        {
            var _local_2:DisplayObjectContainer = DisplayObject(form).parent;
            while (_arg_1 != _local_2)
            {
                if ((_arg_1 is IUIComponent))
                {
                    if (!IUIComponent(_arg_1).enabled)
                    {
                        return (false);
                    };
                };
                if (!_arg_1.visible)
                {
                    return (false);
                };
                _arg_1 = _arg_1.parent;
            };
            return (true);
        }

        public function hideFocus():void
        {
            if (showFocusIndicator)
            {
                showFocusIndicator = false;
                if (_lastFocus)
                {
                    _lastFocus.drawFocus(false);
                };
            };
        }

        private function getBrowserFocusComponent(_arg_1:Boolean):InteractiveObject
        {
            var _local_3:int;
            var _local_2:InteractiveObject = form.systemManager.stage.focus;
            if (!_local_2)
            {
                _local_3 = ((_arg_1) ? 0 : (focusableCandidates.length - 1));
                _local_2 = focusableCandidates[_local_3];
            };
            return (_local_2);
        }

        public function get showFocusIndicator():Boolean
        {
            return (_showFocusIndicator);
        }

        private function moveFocusToParent(_arg_1:Boolean):Boolean
        {
            var _local_2:SWFBridgeRequest = new SWFBridgeRequest(SWFBridgeRequest.MOVE_FOCUS_REQUEST, false, true, null, ((_arg_1) ? FocusRequestDirection.BACKWARD : FocusRequestDirection.FORWARD));
            var _local_3:IEventDispatcher = _form.systemManager.swfBridgeGroup.parentBridge;
            _local_3.dispatchEvent(_local_2);
            focusChanged = _local_2.data;
            return (focusChanged);
        }

        public function set focusPane(_arg_1:Sprite):void
        {
            _focusPane = _arg_1;
        }

        mx_internal function get form():IFocusManagerContainer
        {
            return (_form);
        }

        private function removedHandler(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:DisplayObject = DisplayObject(_arg_1.target);
            if ((_local_3 is IFocusManagerComponent))
            {
                _local_2 = 0;
                while (_local_2 < focusableObjects.length)
                {
                    if (_local_3 == focusableObjects[_local_2])
                    {
                        if (_local_3 == _lastFocus)
                        {
                            _lastFocus.drawFocus(false);
                            _lastFocus = null;
                        };
                        _local_3.removeEventListener("tabEnabledChange", tabEnabledChangeHandler);
                        _local_3.removeEventListener("tabIndexChange", tabIndexChangeHandler);
                        focusableObjects.splice(_local_2, 1);
                        focusableCandidates = [];
                        calculateCandidates = true;
                        break;
                    };
                    _local_2++;
                };
            };
            removeFocusables(_local_3, false);
        }

        private function dispatchEventFromSWFBridges(_arg_1:Event, _arg_2:IEventDispatcher=null):void
        {
            var _local_3:Event;
            var _local_7:IEventDispatcher;
            var _local_4:ISystemManager = form.systemManager;
            if (!popup)
            {
                _local_7 = swfBridgeGroup.parentBridge;
                if (((_local_7) && (!(_local_7 == _arg_2))))
                {
                    _local_3 = _arg_1.clone();
                    if ((_local_3 is SWFBridgeRequest))
                    {
                        SWFBridgeRequest(_local_3).requestor = _local_7;
                    };
                    _local_7.dispatchEvent(_local_3);
                };
            };
            var _local_5:Array = swfBridgeGroup.getChildBridges();
            var _local_6:int;
            while (_local_6 < _local_5.length)
            {
                if (_local_5[_local_6] != _arg_2)
                {
                    _local_3 = _arg_1.clone();
                    if ((_local_3 is SWFBridgeRequest))
                    {
                        SWFBridgeRequest(_local_3).requestor = IEventDispatcher(_local_5[_local_6]);
                    };
                    IEventDispatcher(_local_5[_local_6]).dispatchEvent(_local_3);
                };
                _local_6++;
            };
        }

        public function get defaultButton():IButton
        {
            return (_defaultButton);
        }

        private function activateHandler(_arg_1:Event):void
        {
            if (((_lastFocus) && (!(browserMode))))
            {
                _lastFocus.setFocus();
            };
            lastAction = "ACTIVATE";
        }

        public function showFocus():void
        {
            if (!showFocusIndicator)
            {
                showFocusIndicator = true;
                if (_lastFocus)
                {
                    _lastFocus.drawFocus(true);
                };
            };
        }

        public function getNextFocusManagerComponent(_arg_1:Boolean=false):IFocusManagerComponent
        {
            return (getNextFocusManagerComponent2(_arg_1, fauxFocus).displayObject as IFocusManagerComponent);
        }

        private function setShowFocusIndicatorRequestHandler(_arg_1:Event):void
        {
            if ((_arg_1 is SWFBridgeRequest))
            {
                return;
            };
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            _showFocusIndicator = _local_2.data;
            dispatchSetShowFocusIndicatorRequest(_showFocusIndicator, IEventDispatcher(_arg_1.target));
        }

        private function setFocusToTop():void
        {
            setFocusToNextIndex(-1, false);
        }

        private function isTabVisible(_arg_1:DisplayObject):Boolean
        {
            var _local_2:DisplayObject = DisplayObject(form.systemManager);
            if (!_local_2)
            {
                return (false);
            };
            var _local_3:DisplayObjectContainer = _arg_1.parent;
            while (((_local_3) && (!(_local_3 == _local_2))))
            {
                if (!_local_3.tabChildren)
                {
                    return (false);
                };
                _local_3 = _local_3.parent;
            };
            return (true);
        }

        mx_internal function get lastFocus():IFocusManagerComponent
        {
            return (_lastFocus);
        }

        public function set defaultButtonEnabled(_arg_1:Boolean):void
        {
            _defaultButtonEnabled = _arg_1;
        }

        public function get defaultButtonEnabled():Boolean
        {
            return (_defaultButtonEnabled);
        }

        public function set showFocusIndicator(_arg_1:Boolean):void
        {
            var _local_2:* = (!(_showFocusIndicator == _arg_1));
            _showFocusIndicator = _arg_1;
            if ((((_local_2) && (!(popup))) && (form.systemManager.swfBridgeGroup)))
            {
                dispatchSetShowFocusIndicatorRequest(_arg_1, null);
            };
        }

        private function sortByTabIndex(_arg_1:InteractiveObject, _arg_2:InteractiveObject):int
        {
            var _local_3:int = _arg_1.tabIndex;
            var _local_4:int = _arg_2.tabIndex;
            if (_local_3 == -1)
            {
                _local_3 = int.MAX_VALUE;
            };
            if (_local_4 == -1)
            {
                _local_4 = int.MAX_VALUE;
            };
            return ((_local_3 > _local_4) ? 1 : ((_local_3 < _local_4) ? -1 : sortByDepth(DisplayObject(_arg_1), DisplayObject(_arg_2))));
        }

        public function activate():void
        {
            if (activated)
            {
                return;
            };
            var _local_1:ISystemManager = form.systemManager;
            if (_local_1)
            {
                if (_local_1.isTopLevelRoot())
                {
                    _local_1.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                    _local_1.stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                    _local_1.stage.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                    _local_1.stage.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
                }
                else
                {
                    _local_1.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, mouseFocusChangeHandler, false, 0, true);
                    _local_1.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler, false, 0, true);
                    _local_1.addEventListener(Event.ACTIVATE, activateHandler, false, 0, true);
                    _local_1.addEventListener(Event.DEACTIVATE, deactivateHandler, false, 0, true);
                };
            };
            form.addEventListener(FocusEvent.FOCUS_IN, focusInHandler, true);
            form.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler, true);
            form.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            form.addEventListener(KeyboardEvent.KEY_DOWN, defaultButtonKeyHandler);
            form.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, true);
            activated = true;
            if (_lastFocus)
            {
                setFocus(_lastFocus);
            };
            dispatchEventFromSWFBridges(new SWFBridgeRequest(SWFBridgeRequest.ACTIVATE_FOCUS_REQUEST), skipBridge);
        }

        private function setFocusToNextIndex(_arg_1:int, _arg_2:Boolean):void
        {
            if (focusableObjects.length == 0)
            {
                return;
            };
            if (calculateCandidates)
            {
                sortFocusableObjects();
                calculateCandidates = false;
            };
            var _local_3:FocusInfo = getNextFocusManagerComponent2(_arg_2, null, _arg_1);
            if (((!(popup)) && (_local_3.wrapped)))
            {
                if (getParentBridge())
                {
                    moveFocusToParent(_arg_2);
                    return;
                };
            };
            setFocusToComponent(_local_3.displayObject, _arg_2);
        }


    }
}//package mx.managers

import flash.display.DisplayObject;

class FocusInfo 
{

    public var displayObject:DisplayObject;
    public var wrapped:Boolean;


}


