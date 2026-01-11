// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.CursorManagerImpl

package mx.managers
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;
    import mx.events.InterManagerRequest;
    import flash.events.MouseEvent;
    import flash.display.InteractiveObject;
    import flash.events.ContextMenuEvent;
    import mx.events.SWFBridgeRequest;
    import flash.ui.Mouse;
    import flash.events.Event;
    import mx.styles.StyleManager;
    import mx.styles.CSSStyleDeclaration;
    import flash.geom.Point;
    import mx.core.FlexSprite;
    import flash.display.DisplayObjectContainer;
    import mx.core.EventPriority;
    import mx.events.SandboxMouseEvent;
    import mx.core.ApplicationGlobals;
    import flash.events.ProgressEvent;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.text.TextFieldType;
    import flash.text.TextField;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CursorManagerImpl implements ICursorManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var instance:ICursorManager;

        private var showSystemCursor:Boolean = false;
        private var nextCursorID:int = 1;
        private var systemManager:ISystemManager = null;
        private var cursorList:Array = [];
        private var _currentCursorYOffset:Number = 0;
        private var cursorHolder:Sprite;
        private var currentCursor:DisplayObject;
        private var sandboxRoot:IEventDispatcher = null;
        private var showCustomCursor:Boolean = false;
        private var listenForContextMenu:Boolean = false;
        private var customCursorLeftStage:Boolean = false;
        private var _currentCursorID:int = 0;
        private var initialized:Boolean = false;
        private var overTextField:Boolean = false;
        private var _currentCursorXOffset:Number = 0;
        private var busyCursorList:Array = [];
        private var overLink:Boolean = false;
        private var sourceArray:Array = [];

        public function CursorManagerImpl(_arg_1:ISystemManager=null)
        {
            if (((instance) && (!(_arg_1))))
            {
                throw (new Error("Instance already exists."));
            };
            if (_arg_1)
            {
                this.systemManager = (_arg_1 as ISystemManager);
            }
            else
            {
                this.systemManager = (SystemManagerGlobals.topLevelSystemManagers[0] as ISystemManager);
            };
            sandboxRoot = this.systemManager.getSandboxRoot();
            sandboxRoot.addEventListener(InterManagerRequest.CURSOR_MANAGER_REQUEST, marshalCursorManagerHandler, false, 0, true);
            var _local_2:InterManagerRequest = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
            _local_2.name = "update";
            sandboxRoot.dispatchEvent(_local_2);
        }

        public static function getInstance():ICursorManager
        {
            if (!instance)
            {
                instance = new (CursorManagerImpl)();
            };
            return (instance);
        }


        private function mouseOverHandler(_arg_1:MouseEvent):void
        {
            sandboxRoot.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            mouseMoveHandler(_arg_1);
        }

        public function set currentCursorYOffset(_arg_1:Number):void
        {
            var _local_2:InterManagerRequest;
            _currentCursorYOffset = _arg_1;
            if (!cursorHolder)
            {
                _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_2.name = "currentCursorYOffset";
                _local_2.value = currentCursorYOffset;
                sandboxRoot.dispatchEvent(_local_2);
            };
        }

        public function get currentCursorXOffset():Number
        {
            return (_currentCursorXOffset);
        }

        public function removeCursor(_arg_1:int):void
        {
            var _local_2:Object;
            var _local_3:InterManagerRequest;
            var _local_4:CursorQueueItem;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_3.name = "removeCursor";
                _local_3.value = _arg_1;
                sandboxRoot.dispatchEvent(_local_3);
                return;
            };
            for (_local_2 in cursorList)
            {
                _local_4 = cursorList[_local_2];
                if (_local_4.cursorID == _arg_1)
                {
                    cursorList.splice(_local_2, 1);
                    showCurrentCursor();
                    break;
                };
            };
        }

        public function get currentCursorID():int
        {
            return (_currentCursorID);
        }

        private function removeContextMenuHandlers():void
        {
            var _local_1:InteractiveObject;
            var _local_2:InteractiveObject;
            if (listenForContextMenu)
            {
                _local_1 = (systemManager.document as InteractiveObject);
                _local_2 = (systemManager as InteractiveObject);
                if (((_local_1) && (_local_1.contextMenu)))
                {
                    _local_1.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler, true);
                };
                if (((_local_2) && (_local_2.contextMenu)))
                {
                    _local_2.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler, true);
                };
                listenForContextMenu = false;
            };
        }

        private function marshalMouseMoveHandler(_arg_1:Event):void
        {
            var _local_2:SWFBridgeRequest;
            var _local_3:IEventDispatcher;
            if (cursorHolder.visible)
            {
                cursorHolder.visible = false;
                _local_2 = new SWFBridgeRequest(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST);
                if (systemManager.useSWFBridge())
                {
                    _local_3 = systemManager.swfBridgeGroup.parentBridge;
                }
                else
                {
                    _local_3 = systemManager;
                };
                _local_2.requestor = _local_3;
                _local_3.dispatchEvent(_local_2);
                if (_local_2.data)
                {
                    Mouse.show();
                };
            };
        }

        public function set currentCursorID(_arg_1:int):void
        {
            var _local_2:InterManagerRequest;
            _currentCursorID = _arg_1;
            if (!cursorHolder)
            {
                _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_2.name = "currentCursorID";
                _local_2.value = currentCursorID;
                sandboxRoot.dispatchEvent(_local_2);
            };
        }

        private function priorityCompare(_arg_1:CursorQueueItem, _arg_2:CursorQueueItem):int
        {
            if (_arg_1.priority < _arg_2.priority)
            {
                return (-1);
            };
            if (_arg_1.priority == _arg_2.priority)
            {
                return (0);
            };
            return (1);
        }

        private function mouseOutHandler(_arg_1:MouseEvent):void
        {
            if (((_arg_1.relatedObject == null) && (cursorList.length > 0)))
            {
                customCursorLeftStage = true;
                hideCursor();
                Mouse.show();
            };
        }

        public function setBusyCursor():void
        {
            var _local_3:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_3.name = "setBusyCursor";
                sandboxRoot.dispatchEvent(_local_3);
                return;
            };
            var _local_1:CSSStyleDeclaration = StyleManager.getStyleDeclaration("CursorManager");
            var _local_2:Class = _local_1.getStyle("busyCursor");
            busyCursorList.push(setCursor(_local_2, CursorManagerPriority.LOW));
        }

        private function findSource(_arg_1:Object):int
        {
            var _local_2:int = sourceArray.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (sourceArray[_local_3] === _arg_1)
                {
                    return (_local_3);
                };
                _local_3++;
            };
            return (-1);
        }

        private function showCurrentCursor():void
        {
            var _local_1:CursorQueueItem;
            var _local_2:InterManagerRequest;
            var _local_3:Point;
            if (cursorList.length > 0)
            {
                if (!initialized)
                {
                    cursorHolder = new FlexSprite();
                    cursorHolder.name = "cursorHolder";
                    cursorHolder.mouseEnabled = false;
                    cursorHolder.mouseChildren = false;
                    systemManager.addChildToSandboxRoot("cursorChildren", cursorHolder);
                    initialized = true;
                    _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                    _local_2.name = "initialized";
                    sandboxRoot.dispatchEvent(_local_2);
                };
                _local_1 = cursorList[0];
                if (currentCursorID == CursorManager.NO_CURSOR)
                {
                    Mouse.hide();
                };
                if (_local_1.cursorID != currentCursorID)
                {
                    if (cursorHolder.numChildren > 0)
                    {
                        cursorHolder.removeChildAt(0);
                    };
                    currentCursor = new _local_1.cursorClass();
                    if (currentCursor)
                    {
                        if ((currentCursor is InteractiveObject))
                        {
                            InteractiveObject(currentCursor).mouseEnabled = false;
                        };
                        if ((currentCursor is DisplayObjectContainer))
                        {
                            DisplayObjectContainer(currentCursor).mouseChildren = false;
                        };
                        cursorHolder.addChild(currentCursor);
                        addContextMenuHandlers();
                        if ((systemManager is SystemManager))
                        {
                            _local_3 = new Point((SystemManager(systemManager).mouseX + _local_1.x), (SystemManager(systemManager).mouseY + _local_1.y));
                            _local_3 = SystemManager(systemManager).localToGlobal(_local_3);
                            _local_3 = cursorHolder.parent.globalToLocal(_local_3);
                            cursorHolder.x = _local_3.x;
                            cursorHolder.y = _local_3.y;
                        }
                        else
                        {
                            if ((systemManager is DisplayObject))
                            {
                                _local_3 = new Point((DisplayObject(systemManager).mouseX + _local_1.x), (DisplayObject(systemManager).mouseY + _local_1.y));
                                _local_3 = DisplayObject(systemManager).localToGlobal(_local_3);
                                _local_3 = cursorHolder.parent.globalToLocal(_local_3);
                                cursorHolder.x = (DisplayObject(systemManager).mouseX + _local_1.x);
                                cursorHolder.y = (DisplayObject(systemManager).mouseY + _local_1.y);
                            }
                            else
                            {
                                cursorHolder.x = _local_1.x;
                                cursorHolder.y = _local_1.y;
                            };
                        };
                        if (systemManager.useSWFBridge())
                        {
                            sandboxRoot.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        }
                        else
                        {
                            systemManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        };
                        sandboxRoot.addEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, marshalMouseMoveHandler, false, EventPriority.CURSOR_MANAGEMENT);
                        if (systemManager.useSWFBridge())
                        {
                            sandboxRoot.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        }
                        else
                        {
                            systemManager.stage.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        };
                    };
                    currentCursorID = _local_1.cursorID;
                    currentCursorXOffset = _local_1.x;
                    currentCursorYOffset = _local_1.y;
                };
            }
            else
            {
                showCustomCursor = false;
                if (currentCursorID != CursorManager.NO_CURSOR)
                {
                    currentCursorID = CursorManager.NO_CURSOR;
                    currentCursorXOffset = 0;
                    currentCursorYOffset = 0;
                    cursorHolder.removeChild(currentCursor);
                    removeSystemManagerHandlers();
                    removeContextMenuHandlers();
                };
                Mouse.show();
            };
        }

        public function get currentCursorYOffset():Number
        {
            return (_currentCursorYOffset);
        }

        private function contextMenu_menuSelectHandler(_arg_1:ContextMenuEvent):void
        {
            showCustomCursor = true;
            sandboxRoot.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
        }

        public function hideCursor():void
        {
            var _local_1:InterManagerRequest;
            if (cursorHolder)
            {
                cursorHolder.visible = false;
            }
            else
            {
                _local_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_1.name = "hideCursor";
                sandboxRoot.dispatchEvent(_local_1);
            };
        }

        public function showCursor():void
        {
            var _local_1:InterManagerRequest;
            if (cursorHolder)
            {
                cursorHolder.visible = true;
            }
            else
            {
                _local_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_1.name = "showCursor";
                sandboxRoot.dispatchEvent(_local_1);
            };
        }

        private function marshalCursorManagerHandler(_arg_1:Event):void
        {
            var _local_3:InterManagerRequest;
            if ((_arg_1 is InterManagerRequest))
            {
                return;
            };
            var _local_2:Object = _arg_1;
            switch (_local_2.name)
            {
                case "initialized":
                    initialized = _local_2.value;
                    return;
                case "currentCursorID":
                    _currentCursorID = _local_2.value;
                    return;
                case "currentCursorXOffset":
                    _currentCursorXOffset = _local_2.value;
                    return;
                case "currentCursorYOffset":
                    _currentCursorYOffset = _local_2.value;
                    return;
                case "showCursor":
                    if (cursorHolder)
                    {
                        cursorHolder.visible = true;
                    };
                    return;
                case "hideCursor":
                    if (cursorHolder)
                    {
                        cursorHolder.visible = false;
                    };
                    return;
                case "setCursor":
                    if (cursorHolder)
                    {
                        _local_2.value = setCursor.apply(this, _local_2.value);
                    };
                    return;
                case "removeCursor":
                    if (cursorHolder)
                    {
                        removeCursor.apply(this, [_local_2.value]);
                    };
                    return;
                case "removeAllCursors":
                    if (cursorHolder)
                    {
                        removeAllCursors();
                    };
                    return;
                case "setBusyCursor":
                    if (cursorHolder)
                    {
                        setBusyCursor();
                    };
                    return;
                case "removeBusyCursor":
                    if (cursorHolder)
                    {
                        removeBusyCursor();
                    };
                    return;
                case "registerToUseBusyCursor":
                    if (cursorHolder)
                    {
                        registerToUseBusyCursor.apply(this, _local_2.value);
                    };
                    return;
                case "unRegisterToUseBusyCursor":
                    if (cursorHolder)
                    {
                        unRegisterToUseBusyCursor.apply(this, _local_2.value);
                    };
                    return;
                case "update":
                    if (cursorHolder)
                    {
                        _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _local_3.name = "initialized";
                        _local_3.value = true;
                        sandboxRoot.dispatchEvent(_local_3);
                        _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _local_3.name = "currentCursorID";
                        _local_3.value = currentCursorID;
                        sandboxRoot.dispatchEvent(_local_3);
                        _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _local_3.name = "currentCursorXOffset";
                        _local_3.value = currentCursorXOffset;
                        sandboxRoot.dispatchEvent(_local_3);
                        _local_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _local_3.name = "currentCursorYOffset";
                        _local_3.value = currentCursorYOffset;
                        sandboxRoot.dispatchEvent(_local_3);
                    };
            };
        }

        public function removeAllCursors():void
        {
            var _local_1:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_1.name = "removeAllCursors";
                sandboxRoot.dispatchEvent(_local_1);
                return;
            };
            cursorList.splice(0);
            showCurrentCursor();
        }

        private function completeHandler(_arg_1:Event):void
        {
            var _local_2:int = findSource(_arg_1.target);
            if (_local_2 != -1)
            {
                sourceArray.splice(_local_2, 1);
                removeBusyCursor();
            };
        }

        public function removeBusyCursor():void
        {
            var _local_1:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_1.name = "removeBusyCursor";
                sandboxRoot.dispatchEvent(_local_1);
                return;
            };
            if (busyCursorList.length > 0)
            {
                removeCursor(int(busyCursorList.pop()));
            };
        }

        private function addContextMenuHandlers():void
        {
            var _local_1:InteractiveObject;
            var _local_2:InteractiveObject;
            if (!listenForContextMenu)
            {
                _local_1 = (systemManager.document as InteractiveObject);
                _local_2 = (systemManager as InteractiveObject);
                if (((_local_1) && (_local_1.contextMenu)))
                {
                    _local_1.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler, true, EventPriority.CURSOR_MANAGEMENT);
                    listenForContextMenu = true;
                };
                if (((_local_2) && (_local_2.contextMenu)))
                {
                    _local_2.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler, true, EventPriority.CURSOR_MANAGEMENT);
                    listenForContextMenu = true;
                };
            };
        }

        public function setCursor(_arg_1:Class, _arg_2:int=2, _arg_3:Number=0, _arg_4:Number=0):int
        {
            var _local_7:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_7 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_7.name = "setCursor";
                _local_7.value = [_arg_1, _arg_2, _arg_3, _arg_4];
                sandboxRoot.dispatchEvent(_local_7);
                return (_local_7.value as int);
            };
            var _local_5:int = nextCursorID++;
            var _local_6:CursorQueueItem = new CursorQueueItem();
            _local_6.cursorID = _local_5;
            _local_6.cursorClass = _arg_1;
            _local_6.priority = _arg_2;
            _local_6.x = _arg_3;
            _local_6.y = _arg_4;
            if (systemManager)
            {
                _local_6.systemManager = systemManager;
            }
            else
            {
                _local_6.systemManager = ApplicationGlobals.application.systemManager;
            };
            cursorList.push(_local_6);
            cursorList.sort(priorityCompare);
            showCurrentCursor();
            return (_local_5);
        }

        private function progressHandler(_arg_1:ProgressEvent):void
        {
            var _local_2:int = findSource(_arg_1.target);
            if (_local_2 == -1)
            {
                sourceArray.push(_arg_1.target);
                setBusyCursor();
            };
        }

        private function removeSystemManagerHandlers():void
        {
            if (systemManager.useSWFBridge())
            {
                sandboxRoot.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            }
            else
            {
                systemManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            };
            sandboxRoot.removeEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, marshalMouseMoveHandler, false);
            if (systemManager.useSWFBridge())
            {
                sandboxRoot.removeEventListener(MouseEvent.MOUSE_OUT, mouseMoveHandler, true);
            }
            else
            {
                systemManager.stage.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, true);
            };
        }

        public function registerToUseBusyCursor(_arg_1:Object):void
        {
            var _local_2:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_2.name = "registerToUseBusyCursor";
                _local_2.value = _arg_1;
                sandboxRoot.dispatchEvent(_local_2);
                return;
            };
            if (((_arg_1) && (_arg_1 is EventDispatcher)))
            {
                _arg_1.addEventListener(ProgressEvent.PROGRESS, progressHandler);
                _arg_1.addEventListener(Event.COMPLETE, completeHandler);
                _arg_1.addEventListener(IOErrorEvent.IO_ERROR, completeHandler);
            };
        }

        private function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            var _local_4:SWFBridgeRequest;
            var _local_5:IEventDispatcher;
            var _local_2:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            _local_2 = cursorHolder.parent.globalToLocal(_local_2);
            _local_2.x = (_local_2.x + currentCursorXOffset);
            _local_2.y = (_local_2.y + currentCursorYOffset);
            cursorHolder.x = _local_2.x;
            cursorHolder.y = _local_2.y;
            var _local_3:Object = _arg_1.target;
            if ((((!(overTextField)) && (_local_3 is TextField)) && (_local_3.type == TextFieldType.INPUT)))
            {
                overTextField = true;
                showSystemCursor = true;
            }
            else
            {
                if (((overTextField) && (!((_local_3 is TextField) && (_local_3.type == TextFieldType.INPUT)))))
                {
                    overTextField = false;
                    showCustomCursor = true;
                }
                else
                {
                    showCustomCursor = true;
                };
            };
            if (showSystemCursor)
            {
                showSystemCursor = false;
                cursorHolder.visible = false;
                Mouse.show();
            };
            if (showCustomCursor)
            {
                showCustomCursor = false;
                cursorHolder.visible = true;
                Mouse.hide();
                _local_4 = new SWFBridgeRequest(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST);
                if (systemManager.useSWFBridge())
                {
                    _local_5 = systemManager.swfBridgeGroup.parentBridge;
                }
                else
                {
                    _local_5 = systemManager;
                };
                _local_4.requestor = _local_5;
                _local_5.dispatchEvent(_local_4);
            };
        }

        public function unRegisterToUseBusyCursor(_arg_1:Object):void
        {
            var _local_2:InterManagerRequest;
            if (((initialized) && (!(cursorHolder))))
            {
                _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_2.name = "unRegisterToUseBusyCursor";
                _local_2.value = _arg_1;
                sandboxRoot.dispatchEvent(_local_2);
                return;
            };
            if (((_arg_1) && (_arg_1 is EventDispatcher)))
            {
                _arg_1.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
                _arg_1.removeEventListener(Event.COMPLETE, completeHandler);
                _arg_1.removeEventListener(IOErrorEvent.IO_ERROR, completeHandler);
            };
        }

        public function set currentCursorXOffset(_arg_1:Number):void
        {
            var _local_2:InterManagerRequest;
            _currentCursorXOffset = _arg_1;
            if (!cursorHolder)
            {
                _local_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _local_2.name = "currentCursorXOffset";
                _local_2.value = currentCursorXOffset;
                sandboxRoot.dispatchEvent(_local_2);
            };
        }


    }
}//package mx.managers

import mx.managers.ISystemManager;
import mx.core.mx_internal; 

use namespace mx_internal;

class CursorQueueItem 
{

    mx_internal static const VERSION:String = "3.6.0.21751";

    public var priority:int = 2;
    public var cursorClass:Class = null;
    public var cursorID:int = 0;
    public var x:Number;
    public var y:Number;
    public var systemManager:ISystemManager;


}


