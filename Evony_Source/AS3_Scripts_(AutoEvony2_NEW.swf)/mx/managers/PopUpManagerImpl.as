// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.PopUpManagerImpl

package mx.managers
{
    import mx.events.SWFBridgeRequest;
    import mx.core.IUIComponent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import mx.events.FlexMouseEvent;
    import flash.geom.Point;
    import flash.display.InteractiveObject;
    import flash.geom.Rectangle;
    import mx.core.ISWFLoader;
    import flash.display.Sprite;
    import mx.styles.IStyleClient;
    import mx.events.FlexEvent;
    import mx.events.InterManagerRequest;
    import mx.core.IFlexDisplayObject;
    import mx.core.IInvalidating;
    import mx.core.UIComponent;
    import mx.core.ApplicationGlobals;
    import flash.events.Event;
    import mx.events.EffectEvent;
    import mx.events.SandboxMouseEvent;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import mx.effects.Fade;
    import mx.effects.Blur;
    import flash.events.IEventDispatcher;
    import mx.events.MoveEvent;
    import mx.effects.IEffect;
    import mx.core.FlexSprite;
    import mx.automation.IAutomationObject;
    import flash.display.Graphics;
    import mx.core.IChildList;
    import mx.utils.NameUtil;
    import mx.core.IFlexModule;
    import mx.core.UIComponentGlobals;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PopUpManagerImpl implements IPopUpManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var instance:IPopUpManager;

        private var popupInfo:Array;
        mx_internal var modalWindowClass:Class;

        public function PopUpManagerImpl()
        {
            var _local_1:ISystemManager = ISystemManager(SystemManagerGlobals.topLevelSystemManagers[0]);
            _local_1.addEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, createModalWindowRequestHandler, false, 0, true);
            _local_1.addEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, showModalWindowRequest, false, 0, true);
            _local_1.addEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, hideModalWindowRequest, false, 0, true);
        }

        private static function nonmodalMouseWheelOutsideHandler(_arg_1:DisplayObject, _arg_2:MouseEvent):void
        {
            if (!_arg_1.hitTestPoint(_arg_2.stageX, _arg_2.stageY, true))
            {
                if ((_arg_1 is IUIComponent))
                {
                    if (IUIComponent(_arg_1).owns(DisplayObject(_arg_2.target)))
                    {
                        return;
                    };
                };
                dispatchMouseWheelOutsideEvent(_arg_1, _arg_2);
            };
        }

        private static function dispatchMouseWheelOutsideEvent(_arg_1:DisplayObject, _arg_2:MouseEvent):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_3:MouseEvent = new FlexMouseEvent(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE);
            var _local_4:Point = _arg_1.globalToLocal(new Point(_arg_2.stageX, _arg_2.stageY));
            _local_3.localX = _local_4.x;
            _local_3.localY = _local_4.y;
            _local_3.buttonDown = _arg_2.buttonDown;
            _local_3.shiftKey = _arg_2.shiftKey;
            _local_3.altKey = _arg_2.altKey;
            _local_3.ctrlKey = _arg_2.ctrlKey;
            _local_3.delta = _arg_2.delta;
            _local_3.relatedObject = InteractiveObject(_arg_2.target);
            _arg_1.dispatchEvent(_local_3);
        }

        mx_internal static function updateModalMask(_arg_1:ISystemManager, _arg_2:DisplayObject, _arg_3:IUIComponent, _arg_4:Rectangle, _arg_5:Sprite):void
        {
            var _local_7:Rectangle;
            var _local_8:Point;
            var _local_9:Rectangle;
            var _local_6:Rectangle = _arg_2.getBounds(DisplayObject(_arg_1));
            if ((_arg_3 is ISWFLoader))
            {
                _local_7 = ISWFLoader(_arg_3).getVisibleApplicationRect();
                _local_8 = new Point(_local_7.x, _local_7.y);
                _local_8 = DisplayObject(_arg_1).globalToLocal(_local_8);
                _local_7.x = _local_8.x;
                _local_7.y = _local_8.y;
            }
            else
            {
                if (!_arg_3)
                {
                    _local_7 = _local_6.clone();
                }
                else
                {
                    _local_7 = DisplayObject(_arg_3).getBounds(DisplayObject(_arg_1));
                };
            };
            if (_arg_4)
            {
                _local_8 = new Point(_arg_4.x, _arg_4.y);
                _local_8 = DisplayObject(_arg_1).globalToLocal(_local_8);
                _local_9 = new Rectangle(_local_8.x, _local_8.y, _arg_4.width, _arg_4.height);
                _local_7 = _local_7.intersection(_local_9);
            };
            _arg_5.graphics.clear();
            _arg_5.graphics.beginFill(0);
            if (_local_7.y > _local_6.y)
            {
                _arg_5.graphics.drawRect(_local_6.x, _local_6.y, _local_6.width, (_local_7.y - _local_6.y));
            };
            if (_local_6.x < _local_7.x)
            {
                _arg_5.graphics.drawRect(_local_6.x, _local_7.y, (_local_7.x - _local_6.x), _local_7.height);
            };
            if ((_local_6.x + _local_6.width) > (_local_7.x + _local_7.width))
            {
                _arg_5.graphics.drawRect((_local_7.x + _local_7.width), _local_7.y, (((_local_6.x + _local_6.width) - _local_7.x) - _local_7.width), _local_7.height);
            };
            if ((_local_7.y + _local_7.height) < (_local_6.y + _local_6.height))
            {
                _arg_5.graphics.drawRect(_local_6.x, (_local_7.y + _local_7.height), _local_6.width, (((_local_6.y + _local_6.height) - _local_7.y) - _local_7.height));
            };
            _arg_5.graphics.endFill();
        }

        private static function dispatchMouseDownOutsideEvent(_arg_1:DisplayObject, _arg_2:MouseEvent):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_3:MouseEvent = new FlexMouseEvent(FlexMouseEvent.MOUSE_DOWN_OUTSIDE);
            var _local_4:Point = _arg_1.globalToLocal(new Point(_arg_2.stageX, _arg_2.stageY));
            _local_3.localX = _local_4.x;
            _local_3.localY = _local_4.y;
            _local_3.buttonDown = _arg_2.buttonDown;
            _local_3.shiftKey = _arg_2.shiftKey;
            _local_3.altKey = _arg_2.altKey;
            _local_3.ctrlKey = _arg_2.ctrlKey;
            _local_3.delta = _arg_2.delta;
            _local_3.relatedObject = InteractiveObject(_arg_2.target);
            _arg_1.dispatchEvent(_local_3);
        }

        public static function getInstance():IPopUpManager
        {
            if (!instance)
            {
                instance = new (PopUpManagerImpl)();
            };
            return (instance);
        }

        private static function nonmodalMouseDownOutsideHandler(_arg_1:DisplayObject, _arg_2:MouseEvent):void
        {
            if (!_arg_1.hitTestPoint(_arg_2.stageX, _arg_2.stageY, true))
            {
                if ((_arg_1 is IUIComponent))
                {
                    if (IUIComponent(_arg_1).owns(DisplayObject(_arg_2.target)))
                    {
                        return;
                    };
                };
                dispatchMouseDownOutsideEvent(_arg_1, _arg_2);
            };
        }


        private function showModalWindow(_arg_1:PopUpData, _arg_2:ISystemManager, _arg_3:Boolean=true):void
        {
            var _local_4:IStyleClient = (_arg_1.owner as IStyleClient);
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            if (!isNaN(_arg_1.modalTransparencyDuration))
            {
                _local_5 = _arg_1.modalTransparencyDuration;
            }
            else
            {
                if (_local_4)
                {
                    _local_5 = _local_4.getStyle("modalTransparencyDuration");
                    _arg_1.modalTransparencyDuration = _local_5;
                };
            };
            if (!isNaN(_arg_1.modalTransparency))
            {
                _local_6 = _arg_1.modalTransparency;
            }
            else
            {
                if (_local_4)
                {
                    _local_6 = _local_4.getStyle("modalTransparency");
                    _arg_1.modalTransparency = _local_6;
                };
            };
            _arg_1.modalWindow.alpha = _local_6;
            var _local_7:Number = 0;
            if (!isNaN(_arg_1.modalTransparencyBlur))
            {
                _local_7 = _arg_1.modalTransparencyBlur;
            }
            else
            {
                if (_local_4)
                {
                    _local_7 = _local_4.getStyle("modalTransparencyBlur");
                    _arg_1.modalTransparencyBlur = _local_7;
                };
            };
            var _local_8:Number = 0xFFFFFF;
            if (!isNaN(_arg_1.modalTransparencyColor))
            {
                _local_8 = _arg_1.modalTransparencyColor;
            }
            else
            {
                if (_local_4)
                {
                    _local_8 = _local_4.getStyle("modalTransparencyColor");
                    _arg_1.modalTransparencyColor = _local_8;
                };
            };
            if ((_arg_2 is SystemManagerProxy))
            {
                _arg_2 = SystemManagerProxy(_arg_2).systemManager;
            };
            var _local_9:DisplayObject = _arg_2.getSandboxRoot();
            showModalWindowInternal(_arg_1, _local_5, _local_6, _local_8, _local_7, _arg_2, _local_9);
            if (((_arg_3) && (_arg_2.useSWFBridge())))
            {
                dispatchModalWindowRequest(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, _arg_2, _local_9, _arg_1, true);
            };
        }

        private function popupShowHandler(_arg_1:FlexEvent):void
        {
            var _local_2:PopUpData = findPopupInfoByOwner(_arg_1.target);
            if (_local_2)
            {
                showModalWindow(_local_2, getTopLevelSystemManager(_local_2.parent));
            };
        }

        public function bringToFront(_arg_1:IFlexDisplayObject):void
        {
            var _local_2:PopUpData;
            var _local_3:ISystemManager;
            var _local_4:InterManagerRequest;
            if (((_arg_1) && (_arg_1.parent)))
            {
                _local_2 = findPopupInfoByOwner(_arg_1);
                if (_local_2)
                {
                    _local_3 = ISystemManager(_arg_1.parent);
                    if ((_local_3 is SystemManagerProxy))
                    {
                        _local_4 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "bringToFront", {
                            "topMost":_local_2.topMost,
                            "popUp":_local_3
                        });
                        _local_3.getSandboxRoot().dispatchEvent(_local_4);
                    }
                    else
                    {
                        if (_local_2.topMost)
                        {
                            _local_3.popUpChildren.setChildIndex(DisplayObject(_arg_1), (_local_3.popUpChildren.numChildren - 1));
                        }
                        else
                        {
                            _local_3.setChildIndex(DisplayObject(_arg_1), (_local_3.numChildren - 1));
                        };
                    };
                };
            };
        }

        public function centerPopUp(_arg_1:IFlexDisplayObject):void
        {
            var _local_4:ISystemManager;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Rectangle;
            var _local_12:Rectangle;
            var _local_13:Point;
            var _local_14:Point;
            var _local_15:Boolean;
            var _local_16:DisplayObject;
            var _local_17:InterManagerRequest;
            var _local_18:Point;
            if ((_arg_1 is IInvalidating))
            {
                IInvalidating(_arg_1).validateNow();
            };
            var _local_2:PopUpData = findPopupInfoByOwner(_arg_1);
            var _local_3:DisplayObject = ((((_local_2) && (_local_2.parent)) && (_local_2.parent.stage)) ? _local_2.parent : _arg_1.parent);
            if (_local_3)
            {
                _local_4 = _local_2.systemManager;
                _local_13 = new Point();
                _local_16 = _local_4.getSandboxRoot();
                if (_local_4 != _local_16)
                {
                    _local_17 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                    _local_16.dispatchEvent(_local_17);
                    _local_15 = Boolean(_local_17.value);
                }
                else
                {
                    _local_15 = _local_4.isTopLevelRoot();
                };
                if (_local_15)
                {
                    _local_11 = _local_4.screen;
                    _local_7 = _local_11.width;
                    _local_8 = _local_11.height;
                }
                else
                {
                    if (_local_4 != _local_16)
                    {
                        _local_17 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                        _local_16.dispatchEvent(_local_17);
                        _local_12 = Rectangle(_local_17.value);
                    }
                    else
                    {
                        _local_12 = _local_4.getVisibleApplicationRect();
                    };
                    _local_13 = new Point(_local_12.x, _local_12.y);
                    _local_13 = DisplayObject(_local_4).globalToLocal(_local_13);
                    _local_7 = _local_12.width;
                    _local_8 = _local_12.height;
                };
                if ((_local_3 is UIComponent))
                {
                    _local_12 = UIComponent(_local_3).getVisibleRect();
                    _local_18 = _local_3.globalToLocal(_local_12.topLeft);
                    _local_13.x = (_local_13.x + _local_18.x);
                    _local_13.y = (_local_13.y + _local_18.y);
                    _local_9 = _local_12.width;
                    _local_10 = _local_12.height;
                }
                else
                {
                    _local_9 = _local_3.width;
                    _local_10 = _local_3.height;
                };
                _local_5 = Math.max(0, ((Math.min(_local_7, _local_9) - _arg_1.width) / 2));
                _local_6 = Math.max(0, ((Math.min(_local_8, _local_10) - _arg_1.height) / 2));
                _local_14 = new Point(_local_13.x, _local_13.y);
                _local_14 = _local_3.localToGlobal(_local_14);
                _local_14 = _arg_1.parent.globalToLocal(_local_14);
                _arg_1.move((Math.round(_local_5) + _local_14.x), (Math.round(_local_6) + _local_14.y));
            };
        }

        private function showModalWindowRequest(_arg_1:Event):void
        {
            var _local_2:SWFBridgeRequest = SWFBridgeRequest.marshal(_arg_1);
            if ((_arg_1 is SWFBridgeRequest))
            {
                _local_2 = SWFBridgeRequest(_arg_1);
            }
            else
            {
                _local_2 = SWFBridgeRequest.marshal(_arg_1);
            };
            var _local_3:ISystemManager = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _local_4:DisplayObject = _local_3.getSandboxRoot();
            var _local_5:PopUpData = findHighestRemoteModalPopupInfo();
            _local_5.excludeRect = Rectangle(_local_2.data);
            _local_5.modalTransparency = _local_2.data.transparency;
            _local_5.modalTransparencyBlur = 0;
            _local_5.modalTransparencyColor = _local_2.data.transparencyColor;
            _local_5.modalTransparencyDuration = _local_2.data.transparencyDuration;
            if (((_local_5.owner) || (_local_5.parent)))
            {
                throw (new Error());
            };
            showModalWindow(_local_5, _local_3);
        }

        private function hideOwnerHandler(_arg_1:FlexEvent):void
        {
            var _local_2:PopUpData = findPopupInfoByOwner(_arg_1.target);
            if (_local_2)
            {
                removeMouseOutEventListeners(_local_2);
            };
        }

        private function fadeOutDestroyEffectEndHandler(_arg_1:EffectEvent):void
        {
            var _local_4:ISystemManager;
            effectEndHandler(_arg_1);
            var _local_2:DisplayObject = DisplayObject(_arg_1.effectInstance.target);
            var _local_3:DisplayObject = _local_2.mask;
            if (_local_3)
            {
                _local_2.mask = null;
                _local_4.popUpChildren.removeChild(_local_3);
            };
            if ((_local_2.parent is ISystemManager))
            {
                _local_4 = ISystemManager(_local_2.parent);
                if (_local_4.popUpChildren.contains(_local_2))
                {
                    _local_4.popUpChildren.removeChild(_local_2);
                }
                else
                {
                    _local_4.removeChild(_local_2);
                };
            }
            else
            {
                if (_local_2.parent)
                {
                    _local_2.parent.removeChild(_local_2);
                };
            };
        }

        private function createModalWindowRequestHandler(_arg_1:Event):void
        {
            var _local_2:SWFBridgeRequest;
            if ((_arg_1 is SWFBridgeRequest))
            {
                _local_2 = SWFBridgeRequest(_arg_1);
            }
            else
            {
                _local_2 = SWFBridgeRequest.marshal(_arg_1);
            };
            var _local_3:ISystemManager = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _local_4:DisplayObject = _local_3.getSandboxRoot();
            var _local_5:PopUpData = new PopUpData();
            _local_5.isRemoteModalWindow = true;
            _local_5.systemManager = _local_3;
            _local_5.modalTransparency = _local_2.data.transparency;
            _local_5.modalTransparencyBlur = 0;
            _local_5.modalTransparencyColor = _local_2.data.transparencyColor;
            _local_5.modalTransparencyDuration = _local_2.data.transparencyDuration;
            _local_5.exclude = (_local_3.swfBridgeGroup.getChildBridgeProvider(_local_2.requestor) as IUIComponent);
            _local_5.useExclude = _local_2.data.useExclude;
            _local_5.excludeRect = Rectangle(_local_2.data.excludeRect);
            if (!popupInfo)
            {
                popupInfo = [];
            };
            popupInfo.push(_local_5);
            createModalWindow(null, _local_5, _local_3.popUpChildren, _local_2.data.show, _local_3, _local_4);
        }

        private function showOwnerHandler(_arg_1:FlexEvent):void
        {
            var _local_2:PopUpData = findPopupInfoByOwner(_arg_1.target);
            if (_local_2)
            {
                addMouseOutEventListeners(_local_2);
            };
        }

        private function addMouseOutEventListeners(_arg_1:PopUpData):void
        {
            var _local_2:DisplayObject = _arg_1.systemManager.getSandboxRoot();
            if (_arg_1.modalWindow)
            {
                _arg_1.modalWindow.addEventListener(MouseEvent.MOUSE_DOWN, _arg_1.mouseDownOutsideHandler);
                _arg_1.modalWindow.addEventListener(MouseEvent.MOUSE_WHEEL, _arg_1.mouseWheelOutsideHandler, true);
            }
            else
            {
                _local_2.addEventListener(MouseEvent.MOUSE_DOWN, _arg_1.mouseDownOutsideHandler);
                _local_2.addEventListener(MouseEvent.MOUSE_WHEEL, _arg_1.mouseWheelOutsideHandler, true);
            };
            _local_2.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, _arg_1.marshalMouseOutsideHandler);
            _local_2.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, _arg_1.marshalMouseOutsideHandler, true);
        }

        private function fadeInEffectEndHandler(_arg_1:EffectEvent):void
        {
            var _local_4:PopUpData;
            effectEndHandler(_arg_1);
            var _local_2:int = popupInfo.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = popupInfo[_local_3];
                if (((_local_4.owner) && (_local_4.modalWindow == _arg_1.effectInstance.target)))
                {
                    IUIComponent(_local_4.owner).setVisible(true, true);
                    return;
                };
                _local_3++;
            };
        }

        private function hideModalWindowRequest(_arg_1:Event):void
        {
            var _local_2:SWFBridgeRequest;
            if ((_arg_1 is SWFBridgeRequest))
            {
                _local_2 = SWFBridgeRequest(_arg_1);
            }
            else
            {
                _local_2 = SWFBridgeRequest.marshal(_arg_1);
            };
            var _local_3:ISystemManager = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _local_4:DisplayObject = _local_3.getSandboxRoot();
            var _local_5:PopUpData = findHighestRemoteModalPopupInfo();
            if ((((!(_local_5)) || (_local_5.owner)) || (_local_5.parent)))
            {
                throw (new Error());
            };
            hideModalWindow(_local_5, _local_2.data.remove);
            if (_local_2.data.remove)
            {
                popupInfo.splice(popupInfo.indexOf(_local_5), 1);
                _local_3.numModalWindows--;
            };
        }

        private function getTopLevelSystemManager(_arg_1:DisplayObject):ISystemManager
        {
            var _local_2:DisplayObjectContainer;
            var _local_3:ISystemManager;
            if ((_arg_1.parent is SystemManagerProxy))
            {
                _local_2 = DisplayObjectContainer(SystemManagerProxy(_arg_1.parent).systemManager);
            }
            else
            {
                if (((_arg_1 is IUIComponent) && (IUIComponent(_arg_1).systemManager is SystemManagerProxy)))
                {
                    _local_2 = DisplayObjectContainer(SystemManagerProxy(IUIComponent(_arg_1).systemManager).systemManager);
                }
                else
                {
                    _local_2 = DisplayObjectContainer(_arg_1.root);
                };
            };
            if ((((!(_local_2)) || (_local_2 is Stage)) && (_arg_1 is IUIComponent)))
            {
                _local_2 = DisplayObjectContainer(IUIComponent(_arg_1).systemManager);
            };
            if ((_local_2 is ISystemManager))
            {
                _local_3 = ISystemManager(_local_2);
                if (!_local_3.isTopLevel())
                {
                    _local_3 = _local_3.topLevelSystemManager;
                };
            };
            return (_local_3);
        }

        private function hideModalWindow(_arg_1:PopUpData, _arg_2:Boolean=false):void
        {
            var _local_6:Fade;
            var _local_7:Number;
            var _local_8:Blur;
            var _local_9:DisplayObject;
            var _local_10:SWFBridgeRequest;
            var _local_11:IEventDispatcher;
            var _local_12:IEventDispatcher;
            var _local_13:InterManagerRequest;
            if (((_arg_2) && (_arg_1.exclude)))
            {
                _arg_1.exclude.removeEventListener(Event.RESIZE, _arg_1.resizeHandler);
                _arg_1.exclude.removeEventListener(MoveEvent.MOVE, _arg_1.resizeHandler);
            };
            var _local_3:IStyleClient = (_arg_1.owner as IStyleClient);
            var _local_4:Number = 0;
            if (_local_3)
            {
                _local_4 = _local_3.getStyle("modalTransparencyDuration");
            };
            endEffects(_arg_1);
            if (_local_4)
            {
                _local_6 = new Fade(_arg_1.modalWindow);
                _local_6.alphaFrom = _arg_1.modalWindow.alpha;
                _local_6.alphaTo = 0;
                _local_6.duration = _local_4;
                _local_6.addEventListener(EffectEvent.EFFECT_END, ((_arg_2) ? fadeOutDestroyEffectEndHandler : fadeOutCloseEffectEndHandler));
                _arg_1.modalWindow.visible = true;
                _arg_1.fade = _local_6;
                _local_6.play();
                _local_7 = _local_3.getStyle("modalTransparencyBlur");
                if (_local_7)
                {
                    _local_8 = new Blur(_arg_1.blurTarget);
                    _local_8.blurXFrom = (_local_8.blurYFrom = _local_7);
                    _local_8.blurXTo = (_local_8.blurYTo = 0);
                    _local_8.duration = _local_4;
                    _local_8.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                    _arg_1.blur = _local_8;
                    _local_8.play();
                };
            }
            else
            {
                _arg_1.modalWindow.visible = false;
            };
            var _local_5:ISystemManager = ISystemManager(ApplicationGlobals.application.systemManager);
            if (_local_5.useSWFBridge())
            {
                _local_9 = _local_5.getSandboxRoot();
                if (((!(_arg_1.isRemoteModalWindow)) && (!(_local_5 == _local_9))))
                {
                    _local_13 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                    _local_9.dispatchEvent(_local_13);
                    if (Boolean(_local_13.value))
                    {
                        return;
                    };
                };
                _local_10 = new SWFBridgeRequest(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, false, false, null, {
                    "skip":((!(_arg_1.isRemoteModalWindow)) && (!(_local_5 == _local_9))),
                    "show":false,
                    "remove":_arg_2
                });
                _local_11 = _local_5.swfBridgeGroup.parentBridge;
                _local_10.requestor = _local_11;
                _local_11.dispatchEvent(_local_10);
            };
        }

        private function popupHideHandler(_arg_1:FlexEvent):void
        {
            var _local_2:PopUpData = findPopupInfoByOwner(_arg_1.target);
            if (_local_2)
            {
                hideModalWindow(_local_2);
            };
        }

        private function showModalWindowInternal(_arg_1:PopUpData, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:ISystemManager, _arg_7:DisplayObject):void
        {
            var _local_8:Fade;
            var _local_9:Number;
            var _local_10:Blur;
            var _local_11:Object;
            var _local_12:InterManagerRequest;
            endEffects(_arg_1);
            if (_arg_2)
            {
                _local_8 = new Fade(_arg_1.modalWindow);
                _local_8.alphaFrom = 0;
                _local_8.alphaTo = _arg_3;
                _local_8.duration = _arg_2;
                _local_8.addEventListener(EffectEvent.EFFECT_END, fadeInEffectEndHandler);
                _arg_1.modalWindow.alpha = 0;
                _arg_1.modalWindow.visible = true;
                _arg_1.fade = _local_8;
                if (_arg_1.owner)
                {
                    IUIComponent(_arg_1.owner).setVisible(false, true);
                };
                _local_8.play();
                _local_9 = _arg_5;
                if (_local_9)
                {
                    if ((DisplayObject(_arg_6).parent is Stage))
                    {
                        _arg_1.blurTarget = _arg_6.document;
                    }
                    else
                    {
                        if (_arg_6 != _arg_7)
                        {
                            _local_12 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "application", _local_11);
                            _arg_7.dispatchEvent(_local_12);
                            _arg_1.blurTarget = _local_12.value;
                        }
                        else
                        {
                            _arg_1.blurTarget = ApplicationGlobals.application;
                        };
                    };
                    _local_10 = new Blur(_arg_1.blurTarget);
                    _local_10.blurXFrom = (_local_10.blurYFrom = 0);
                    _local_10.blurXTo = (_local_10.blurYTo = _local_9);
                    _local_10.duration = _arg_2;
                    _local_10.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                    _arg_1.blur = _local_10;
                    _local_10.play();
                };
            }
            else
            {
                if (_arg_1.owner)
                {
                    IUIComponent(_arg_1.owner).setVisible(true, true);
                };
                _arg_1.modalWindow.visible = true;
            };
        }

        private function effectEndHandler(_arg_1:EffectEvent):void
        {
            var _local_4:PopUpData;
            var _local_5:IEffect;
            var _local_2:int = popupInfo.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = popupInfo[_local_3];
                _local_5 = _arg_1.effectInstance.effect;
                if (_local_5 == _local_4.fade)
                {
                    _local_4.fade = null;
                }
                else
                {
                    if (_local_5 == _local_4.blur)
                    {
                        _local_4.blur = null;
                    };
                };
                _local_3++;
            };
        }

        private function createModalWindow(_arg_1:DisplayObject, _arg_2:PopUpData, _arg_3:IChildList, _arg_4:Boolean, _arg_5:ISystemManager, _arg_6:DisplayObject):void
        {
            var _local_7:IFlexDisplayObject;
            var _local_10:Sprite;
            var _local_11:SystemManagerProxy;
            var _local_12:ISystemManager;
            _local_7 = IFlexDisplayObject(_arg_2.owner);
            var _local_8:IStyleClient = (_local_7 as IStyleClient);
            var _local_9:Number = 0;
            if (modalWindowClass)
            {
                _local_10 = new modalWindowClass();
            }
            else
            {
                _local_10 = new FlexSprite();
                _local_10.name = "modalWindow";
            };
            if (((!(_arg_5)) && (_arg_1)))
            {
                _arg_5 = IUIComponent(_arg_1).systemManager;
            };
            if ((_arg_5 is SystemManagerProxy))
            {
                _local_11 = SystemManagerProxy(_arg_5);
                _local_12 = _local_11.systemManager;
            }
            else
            {
                _local_12 = _arg_5;
            };
            _local_12.numModalWindows++;
            if (_local_7)
            {
                _arg_3.addChildAt(_local_10, _arg_3.getChildIndex(DisplayObject(_local_7)));
            }
            else
            {
                _arg_3.addChild(_local_10);
            };
            if ((_local_7 is IAutomationObject))
            {
                IAutomationObject(_local_7).showInAutomationHierarchy = true;
            };
            if (!isNaN(_arg_2.modalTransparency))
            {
                _local_10.alpha = _arg_2.modalTransparency;
            }
            else
            {
                if (_local_8)
                {
                    _local_10.alpha = _local_8.getStyle("modalTransparency");
                }
                else
                {
                    _local_10.alpha = 0;
                };
            };
            _arg_2.modalTransparency = _local_10.alpha;
            _local_10.tabEnabled = false;
            var _local_13:Rectangle = _local_12.screen;
            var _local_14:Graphics = _local_10.graphics;
            var _local_15:Number = 0xFFFFFF;
            if (!isNaN(_arg_2.modalTransparencyColor))
            {
                _local_15 = _arg_2.modalTransparencyColor;
            }
            else
            {
                if (_local_8)
                {
                    _local_15 = _local_8.getStyle("modalTransparencyColor");
                    _arg_2.modalTransparencyColor = _local_15;
                };
            };
            _local_14.clear();
            _local_14.beginFill(_local_15, 100);
            _local_14.drawRect(_local_13.x, _local_13.y, _local_13.width, _local_13.height);
            _local_14.endFill();
            _arg_2.modalWindow = _local_10;
            if (_arg_2.exclude)
            {
                _arg_2.modalMask = new Sprite();
                updateModalMask(_local_12, _local_10, ((_arg_2.useExclude) ? _arg_2.exclude : null), _arg_2.excludeRect, _arg_2.modalMask);
                _local_10.mask = _arg_2.modalMask;
                _arg_3.addChild(_arg_2.modalMask);
                _arg_2.exclude.addEventListener(Event.RESIZE, _arg_2.resizeHandler);
                _arg_2.exclude.addEventListener(MoveEvent.MOVE, _arg_2.resizeHandler);
            };
            _arg_2._mouseDownOutsideHandler = dispatchMouseDownOutsideEvent;
            _arg_2._mouseWheelOutsideHandler = dispatchMouseWheelOutsideEvent;
            _local_12.addEventListener(Event.RESIZE, _arg_2.resizeHandler);
            if (_local_7)
            {
                _local_7.addEventListener(FlexEvent.SHOW, popupShowHandler);
                _local_7.addEventListener(FlexEvent.HIDE, popupHideHandler);
            };
            if (_arg_4)
            {
                showModalWindow(_arg_2, _arg_5, false);
            }
            else
            {
                _local_7.visible = _arg_4;
            };
            if (_local_12.useSWFBridge())
            {
                if (_local_8)
                {
                    _arg_2.modalTransparencyDuration = _local_8.getStyle("modalTransparencyDuration");
                    _arg_2.modalTransparencyBlur = _local_8.getStyle("modalTransparencyBlur");
                };
                dispatchModalWindowRequest(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, _local_12, _arg_6, _arg_2, _arg_4);
            };
        }

        private function findPopupInfoByOwner(_arg_1:Object):PopUpData
        {
            var _local_4:PopUpData;
            var _local_2:int = popupInfo.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = popupInfo[_local_3];
                if (_local_4.owner == _arg_1)
                {
                    return (_local_4);
                };
                _local_3++;
            };
            return (null);
        }

        private function popupRemovedHandler(_arg_1:Event):void
        {
            var _local_4:PopUpData;
            var _local_5:DisplayObject;
            var _local_6:DisplayObject;
            var _local_7:DisplayObject;
            var _local_8:ISystemManager;
            var _local_9:ISystemManager;
            var _local_10:IEventDispatcher;
            var _local_11:SWFBridgeRequest;
            var _local_2:int = popupInfo.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = popupInfo[_local_3];
                _local_5 = _local_4.owner;
                if (_local_5 == _arg_1.target)
                {
                    _local_6 = _local_4.parent;
                    _local_7 = _local_4.modalWindow;
                    _local_8 = _local_4.systemManager;
                    if ((_local_8 is SystemManagerProxy))
                    {
                        _local_9 = SystemManagerProxy(_local_8).systemManager;
                    }
                    else
                    {
                        _local_9 = _local_8;
                    };
                    if (!_local_8.isTopLevel())
                    {
                        _local_8 = _local_8.topLevelSystemManager;
                    };
                    if ((_local_5 is IUIComponent))
                    {
                        IUIComponent(_local_5).isPopUp = false;
                    };
                    if ((_local_5 is IFocusManagerContainer))
                    {
                        _local_8.removeFocusManager(IFocusManagerContainer(_local_5));
                    };
                    _local_5.removeEventListener(Event.REMOVED, popupRemovedHandler);
                    if ((_local_8 is SystemManagerProxy))
                    {
                        _local_10 = _local_9.swfBridgeGroup.parentBridge;
                        _local_11 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, false, false, _local_10, {
                            "window":DisplayObject(_local_8),
                            "parent":_local_4.parent,
                            "modal":(!(_local_4.modalWindow == null))
                        });
                        _local_9.getSandboxRoot().dispatchEvent(_local_11);
                    }
                    else
                    {
                        if (_local_8.useSWFBridge())
                        {
                            _local_11 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, false, false, null, {"window":DisplayObject(_local_5)});
                            _local_11.requestor = _local_8.swfBridgeGroup.parentBridge;
                            _local_11.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(_local_5));
                            _local_8.dispatchEvent(_local_11);
                        };
                    };
                    if (_local_4.owner)
                    {
                        _local_4.owner.removeEventListener(FlexEvent.SHOW, showOwnerHandler);
                        _local_4.owner.removeEventListener(FlexEvent.HIDE, hideOwnerHandler);
                    };
                    removeMouseOutEventListeners(_local_4);
                    if (_local_7)
                    {
                        _local_9.removeEventListener(Event.RESIZE, _local_4.resizeHandler);
                        _local_5.removeEventListener(FlexEvent.SHOW, popupShowHandler);
                        _local_5.removeEventListener(FlexEvent.HIDE, popupHideHandler);
                        hideModalWindow(_local_4, true);
                        _local_9.numModalWindows--;
                    };
                    popupInfo.splice(_local_3, 1);
                    return;
                };
                _local_3++;
            };
        }

        private function fadeOutCloseEffectEndHandler(_arg_1:EffectEvent):void
        {
            effectEndHandler(_arg_1);
            DisplayObject(_arg_1.effectInstance.target).visible = false;
        }

        private function endEffects(_arg_1:PopUpData):void
        {
            if (_arg_1.fade)
            {
                _arg_1.fade.end();
                _arg_1.fade = null;
            };
            if (_arg_1.blur)
            {
                _arg_1.blur.end();
                _arg_1.blur = null;
            };
        }

        public function removePopUp(_arg_1:IFlexDisplayObject):void
        {
            var _local_2:PopUpData;
            var _local_3:ISystemManager;
            var _local_4:IUIComponent;
            if (((_arg_1) && (_arg_1.parent)))
            {
                _local_2 = findPopupInfoByOwner(_arg_1);
                if (_local_2)
                {
                    _local_3 = _local_2.systemManager;
                    if (!_local_3)
                    {
                        _local_4 = (_arg_1 as IUIComponent);
                        if (_local_4)
                        {
                            _local_3 = ISystemManager(_local_4.systemManager);
                        }
                        else
                        {
                            return;
                        };
                    };
                    if (_local_2.topMost)
                    {
                        _local_3.popUpChildren.removeChild(DisplayObject(_arg_1));
                    }
                    else
                    {
                        _local_3.removeChild(DisplayObject(_arg_1));
                    };
                };
            };
        }

        public function addPopUp(_arg_1:IFlexDisplayObject, _arg_2:DisplayObject, _arg_3:Boolean=false, _arg_4:String=null):void
        {
            var _local_7:IChildList;
            var _local_8:Boolean;
            var _local_5:Boolean = _arg_1.visible;
            if ((((_arg_2 is IUIComponent) && (_arg_1 is IUIComponent)) && (IUIComponent(_arg_1).document == null)))
            {
                IUIComponent(_arg_1).document = IUIComponent(_arg_2).document;
            };
            if (((((_arg_2 is IUIComponent) && (IUIComponent(_arg_2).document is IFlexModule)) && (_arg_1 is UIComponent)) && (UIComponent(_arg_1).moduleFactory == null)))
            {
                UIComponent(_arg_1).moduleFactory = IFlexModule(IUIComponent(_arg_2).document).moduleFactory;
            };
            var _local_6:ISystemManager = getTopLevelSystemManager(_arg_2);
            if (!_local_6)
            {
                _local_6 = ISystemManager(SystemManagerGlobals.topLevelSystemManagers[0]);
                if (_local_6.getSandboxRoot() != _arg_2)
                {
                    return;
                };
            };
            var _local_9:ISystemManager = _local_6;
            var _local_10:DisplayObject = _local_6.getSandboxRoot();
            var _local_11:SWFBridgeRequest;
            if (_local_6.useSWFBridge())
            {
                if (_local_10 != _local_6)
                {
                    _local_9 = new SystemManagerProxy(_local_6);
                    _local_11 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_REQUEST, false, false, _local_6.swfBridgeGroup.parentBridge, {
                        "window":DisplayObject(_local_9),
                        "parent":_arg_2,
                        "modal":_arg_3,
                        "childList":_arg_4
                    });
                    _local_10.dispatchEvent(_local_11);
                }
                else
                {
                    _local_9 = _local_6;
                };
            };
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).isPopUp = true;
            };
            if (((!(_arg_4)) || (_arg_4 == PopUpManagerChildList.PARENT)))
            {
                _local_8 = _local_9.popUpChildren.contains(_arg_2);
            }
            else
            {
                _local_8 = (_arg_4 == PopUpManagerChildList.POPUP);
            };
            _local_7 = ((_local_8) ? _local_9.popUpChildren : _local_9);
            _local_7.addChild(DisplayObject(_arg_1));
            _arg_1.visible = false;
            if (!popupInfo)
            {
                popupInfo = [];
            };
            var _local_12:PopUpData = new PopUpData();
            _local_12.owner = DisplayObject(_arg_1);
            _local_12.topMost = _local_8;
            _local_12.systemManager = _local_9;
            popupInfo.push(_local_12);
            if ((_arg_1 is IFocusManagerContainer))
            {
                if (IFocusManagerContainer(_arg_1).focusManager)
                {
                    _local_9.addFocusManager(IFocusManagerContainer(_arg_1));
                }
                else
                {
                    IFocusManagerContainer(_arg_1).focusManager = new FocusManager(IFocusManagerContainer(_arg_1), true);
                };
            };
            if ((((!(_local_6.isTopLevelRoot())) && (_local_10)) && (_local_6 == _local_10)))
            {
                _local_11 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, false, false, null, {"window":DisplayObject(_arg_1)});
                _local_11.requestor = _local_6.swfBridgeGroup.parentBridge;
                _local_11.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(_arg_1));
                _local_6.dispatchEvent(_local_11);
            };
            if ((_arg_1 is IAutomationObject))
            {
                IAutomationObject(_arg_1).showInAutomationHierarchy = true;
            };
            if ((_arg_1 is ILayoutManagerClient))
            {
                UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(_arg_1), true);
            };
            _local_12.parent = _arg_2;
            if ((_arg_1 is IUIComponent))
            {
                IUIComponent(_arg_1).setActualSize(IUIComponent(_arg_1).getExplicitOrMeasuredWidth(), IUIComponent(_arg_1).getExplicitOrMeasuredHeight());
            };
            if (_arg_3)
            {
                createModalWindow(_arg_2, _local_12, _local_7, _local_5, _local_9, _local_10);
            }
            else
            {
                _local_12._mouseDownOutsideHandler = nonmodalMouseDownOutsideHandler;
                _local_12._mouseWheelOutsideHandler = nonmodalMouseWheelOutsideHandler;
                _arg_1.visible = _local_5;
            };
            _local_12.owner.addEventListener(FlexEvent.SHOW, showOwnerHandler);
            _local_12.owner.addEventListener(FlexEvent.HIDE, hideOwnerHandler);
            addMouseOutEventListeners(_local_12);
            _arg_1.addEventListener(Event.REMOVED, popupRemovedHandler);
            if (((_arg_1 is IFocusManagerContainer) && (_local_5)))
            {
                if (((!(_local_9 is SystemManagerProxy)) && (_local_9.useSWFBridge())))
                {
                    SystemManager(_local_9).dispatchActivatedWindowEvent(DisplayObject(_arg_1));
                }
                else
                {
                    _local_9.activate(IFocusManagerContainer(_arg_1));
                };
            };
        }

        private function dispatchModalWindowRequest(_arg_1:String, _arg_2:ISystemManager, _arg_3:DisplayObject, _arg_4:PopUpData, _arg_5:Boolean):void
        {
            var _local_8:InterManagerRequest;
            if (((!(_arg_4.isRemoteModalWindow)) && (!(_arg_2 == _arg_3))))
            {
                _local_8 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                _arg_3.dispatchEvent(_local_8);
                if (Boolean(_local_8.value))
                {
                    return;
                };
            };
            var _local_6:SWFBridgeRequest = new SWFBridgeRequest(_arg_1, false, false, null, {
                "skip":((!(_arg_4.isRemoteModalWindow)) && (!(_arg_2 == _arg_3))),
                "useExclude":_arg_4.useExclude,
                "show":_arg_5,
                "remove":false,
                "transparencyDuration":_arg_4.modalTransparencyDuration,
                "transparency":_arg_4.modalTransparency,
                "transparencyColor":_arg_4.modalTransparencyColor,
                "transparencyBlur":_arg_4.modalTransparencyBlur
            });
            var _local_7:IEventDispatcher = _arg_2.swfBridgeGroup.parentBridge;
            _local_6.requestor = _local_7;
            _local_7.dispatchEvent(_local_6);
        }

        public function createPopUp(_arg_1:DisplayObject, _arg_2:Class, _arg_3:Boolean=false, _arg_4:String=null):IFlexDisplayObject
        {
            var _local_5:IUIComponent = new (_arg_2)();
            addPopUp(_local_5, _arg_1, _arg_3, _arg_4);
            return (_local_5);
        }

        private function removeMouseOutEventListeners(_arg_1:PopUpData):void
        {
            var _local_2:DisplayObject = _arg_1.systemManager.getSandboxRoot();
            if (_arg_1.modalWindow)
            {
                _arg_1.modalWindow.removeEventListener(MouseEvent.MOUSE_DOWN, _arg_1.mouseDownOutsideHandler);
                _arg_1.modalWindow.removeEventListener(MouseEvent.MOUSE_WHEEL, _arg_1.mouseWheelOutsideHandler, true);
            }
            else
            {
                _local_2.removeEventListener(MouseEvent.MOUSE_DOWN, _arg_1.mouseDownOutsideHandler);
                _local_2.removeEventListener(MouseEvent.MOUSE_WHEEL, _arg_1.mouseWheelOutsideHandler, true);
            };
            _local_2.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, _arg_1.marshalMouseOutsideHandler);
            _local_2.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, _arg_1.marshalMouseOutsideHandler, true);
        }

        private function findHighestRemoteModalPopupInfo():PopUpData
        {
            var _local_3:PopUpData;
            var _local_1:int = (popupInfo.length - 1);
            var _local_2:int = _local_1;
            while (_local_2 >= 0)
            {
                _local_3 = popupInfo[_local_2];
                if (_local_3.isRemoteModalWindow)
                {
                    return (_local_3);
                };
                _local_2--;
            };
            return (null);
        }


    }
}//package mx.managers

import mx.effects.Effect;
import mx.core.IUIComponent;
import flash.geom.Rectangle;
import flash.display.DisplayObject;
import flash.display.Sprite;
import mx.managers.ISystemManager;
import mx.events.SandboxMouseEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import mx.managers.PopUpManagerImpl;
import mx.core.mx_internal; 

use namespace mx_internal;

class PopUpData 
{

    public var fade:Effect;
    public var modalTransparencyColor:Number;
    public var exclude:IUIComponent;
    public var isRemoteModalWindow:Boolean;
    public var useExclude:Boolean;
    public var blurTarget:Object;
    public var modalTransparencyDuration:Number;
    public var _mouseWheelOutsideHandler:Function;
    public var excludeRect:Rectangle;
    public var modalTransparency:Number;
    public var blur:Effect;
    public var parent:DisplayObject;
    public var modalTransparencyBlur:Number;
    public var _mouseDownOutsideHandler:Function;
    public var owner:DisplayObject;
    public var topMost:Boolean;
    public var modalMask:Sprite;
    public var modalWindow:DisplayObject;
    public var systemManager:ISystemManager;

    public function PopUpData()
    {
        useExclude = true;
    }

    public function marshalMouseOutsideHandler(_arg_1:Event):void
    {
        if (!(_arg_1 is SandboxMouseEvent))
        {
            _arg_1 = SandboxMouseEvent.marshal(_arg_1);
        };
        if (owner)
        {
            owner.dispatchEvent(_arg_1);
        };
    }

    public function mouseDownOutsideHandler(_arg_1:MouseEvent):void
    {
        _mouseDownOutsideHandler(owner, _arg_1);
    }

    public function mouseWheelOutsideHandler(_arg_1:MouseEvent):void
    {
        _mouseWheelOutsideHandler(owner, _arg_1);
    }

    public function resizeHandler(_arg_1:Event):void
    {
        var _local_2:Rectangle;
        if ((((owner) && (owner.stage == DisplayObject(_arg_1.target).stage)) || ((modalWindow) && (modalWindow.stage == DisplayObject(_arg_1.target).stage))))
        {
            _local_2 = systemManager.screen;
            modalWindow.width = _local_2.width;
            modalWindow.height = _local_2.height;
            modalWindow.x = _local_2.x;
            modalWindow.y = _local_2.y;
            if (modalMask)
            {
                PopUpManagerImpl.updateModalMask(systemManager, modalWindow, exclude, excludeRect, modalMask);
            };
        };
    }


}


