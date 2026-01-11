// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.dragClasses.DragProxy

package mx.managers.dragClasses
{
    import mx.core.UIComponent;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import mx.core.IUIComponent;
    import mx.core.DragSource;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import mx.managers.ISystemManager;
    import flash.display.DisplayObjectContainer;
    import flash.display.InteractiveObject;
    import flash.geom.Point;
    import mx.events.DragEvent;
    import mx.effects.Move;
    import mx.effects.Zoom;
    import mx.events.SandboxMouseEvent;
    import mx.managers.DragManager;
    import mx.events.EffectEvent;
    import mx.managers.CursorManager;
    import mx.managers.SystemManager;
    import mx.events.InterManagerRequest;
    import mx.styles.StyleManager;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.Event;
    import mx.events.InterDragManagerEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DragProxy extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var allowMove:Boolean = true;
        private var cursorClass:Class = null;
        public var action:String;
        private var sandboxRoot:IEventDispatcher;
        public var target:DisplayObject = null;
        public var dragInitiator:IUIComponent;
        public var xOffset:Number;
        public var yOffset:Number;
        public var dragSource:DragSource;
        private var cursorID:int = 0;
        private var lastMouseEvent:MouseEvent;
        public var startX:Number;
        public var startY:Number;
        private var lastKeyEvent:KeyboardEvent;

        public function DragProxy(_arg_1:IUIComponent, _arg_2:DragSource)
        {
            this.dragInitiator = _arg_1;
            this.dragSource = _arg_2;
            var _local_3:ISystemManager = (_arg_1.systemManager.topLevelSystemManager as ISystemManager);
            var _local_4:IEventDispatcher = (sandboxRoot = _local_3.getSandboxRoot());
            _local_4.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            _local_4.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _local_4.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _local_4.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }

        private static function getObjectsUnderPoint(obj:DisplayObject, pt:Point, arr:Array):void
        {
            var doc:DisplayObjectContainer;
            var rc:Object;
            var n:int;
            var i:int;
            var child:DisplayObject;
            if (!obj.visible)
            {
                return;
            };
            if (((obj is UIComponent) && (!(UIComponent(obj).$visible))))
            {
                return;
            };
            if (obj.hitTestPoint(pt.x, pt.y, true))
            {
                if (((obj is InteractiveObject) && (InteractiveObject(obj).mouseEnabled)))
                {
                    arr.push(obj);
                };
                if ((obj is DisplayObjectContainer))
                {
                    doc = (obj as DisplayObjectContainer);
                    if (doc.mouseChildren)
                    {
                        if (("rawChildren" in doc))
                        {
                            rc = doc["rawChildren"];
                            n = rc.numChildren;
                            i = 0;
                            while (i < n)
                            {
                                try
                                {
                                    getObjectsUnderPoint(rc.getChildAt(i), pt, arr);
                                }
                                catch(e:Error)
                                {
                                };
                                i = (i + 1);
                            };
                        }
                        else
                        {
                            if (doc.numChildren)
                            {
                                n = doc.numChildren;
                                i = 0;
                                while (i < n)
                                {
                                    try
                                    {
                                        child = doc.getChildAt(i);
                                        getObjectsUnderPoint(child, pt, arr);
                                    }
                                    catch(e:Error)
                                    {
                                    };
                                    i = (i + 1);
                                };
                            };
                        };
                    };
                };
            };
        }


        public function mouseUpHandler(_arg_1:MouseEvent):void
        {
            var _local_2:DragEvent;
            var _local_6:Point;
            var _local_7:Move;
            var _local_8:Zoom;
            var _local_9:Move;
            var _local_3:ISystemManager = (dragInitiator.systemManager.topLevelSystemManager as ISystemManager);
            var _local_4:IEventDispatcher = sandboxRoot;
            _local_4.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            _local_4.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _local_4.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _local_4.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler);
            _local_4.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            var _local_5:Object = automationDelegate;
            if (((target) && (!(action == DragManager.NONE))))
            {
                _local_2 = new DragEvent(DragEvent.DRAG_DROP);
                _local_2.dragInitiator = dragInitiator;
                _local_2.dragSource = dragSource;
                _local_2.action = action;
                _local_2.ctrlKey = _arg_1.ctrlKey;
                _local_2.altKey = _arg_1.altKey;
                _local_2.shiftKey = _arg_1.shiftKey;
                _local_6 = new Point();
                _local_6.x = lastMouseEvent.localX;
                _local_6.y = lastMouseEvent.localY;
                _local_6 = DisplayObject(lastMouseEvent.target).localToGlobal(_local_6);
                _local_6 = DisplayObject(target).globalToLocal(_local_6);
                _local_2.localX = _local_6.x;
                _local_2.localY = _local_6.y;
                if (_local_5)
                {
                    _local_5.recordAutomatableDragDrop(target, _local_2);
                };
                _dispatchDragEvent(target, _local_2);
            }
            else
            {
                action = DragManager.NONE;
            };
            if (action == DragManager.NONE)
            {
                _local_7 = new Move(this);
                _local_7.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _local_7.xFrom = x;
                _local_7.yFrom = y;
                _local_7.xTo = startX;
                _local_7.yTo = startY;
                _local_7.duration = 200;
                _local_7.play();
            }
            else
            {
                _local_8 = new Zoom(this);
                _local_8.zoomWidthFrom = (_local_8.zoomHeightFrom = 1);
                _local_8.zoomWidthTo = (_local_8.zoomHeightTo = 0);
                _local_8.duration = 200;
                _local_8.play();
                _local_9 = new Move(this);
                _local_9.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _local_9.xFrom = x;
                _local_9.yFrom = this.y;
                _local_9.xTo = parent.mouseX;
                _local_9.yTo = parent.mouseY;
                _local_9.duration = 200;
                _local_9.play();
            };
            _local_2 = new DragEvent(DragEvent.DRAG_COMPLETE);
            _local_2.dragInitiator = dragInitiator;
            _local_2.dragSource = dragSource;
            _local_2.relatedObject = InteractiveObject(target);
            _local_2.action = action;
            _local_2.ctrlKey = _arg_1.ctrlKey;
            _local_2.altKey = _arg_1.altKey;
            _local_2.shiftKey = _arg_1.shiftKey;
            dragInitiator.dispatchEvent(_local_2);
            if (((_local_5) && (action == DragManager.NONE)))
            {
                _local_5.recordAutomatableDragCancel(dragInitiator, _local_2);
            };
            cursorManager.removeCursor(cursorID);
            cursorID = CursorManager.NO_CURSOR;
            this.lastMouseEvent = null;
        }

        private function isSameOrChildApplicationDomain(_arg_1:Object):Boolean
        {
            var _local_2:DisplayObject = SystemManager.getSWFRoot(_arg_1);
            if (_local_2)
            {
                return (true);
            };
            var _local_3:InterManagerRequest = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _local_3.name = "hasSWFBridges";
            sandboxRoot.dispatchEvent(_local_3);
            if (!_local_3.value)
            {
                return (true);
            };
            return (false);
        }

        public function showFeedback():void
        {
            var _local_1:Class = cursorClass;
            var _local_2:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DragManager");
            if (action == DragManager.COPY)
            {
                _local_1 = _local_2.getStyle("copyCursor");
            }
            else
            {
                if (action == DragManager.LINK)
                {
                    _local_1 = _local_2.getStyle("linkCursor");
                }
                else
                {
                    if (action == DragManager.NONE)
                    {
                        _local_1 = _local_2.getStyle("rejectCursor");
                    }
                    else
                    {
                        _local_1 = _local_2.getStyle("moveCursor");
                    };
                };
            };
            if (_local_1 != cursorClass)
            {
                cursorClass = _local_1;
                if (cursorID != CursorManager.NO_CURSOR)
                {
                    cursorManager.removeCursor(cursorID);
                };
                cursorID = cursorManager.setCursor(cursorClass, 2, 0, 0);
            };
        }

        override public function initialize():void
        {
            super.initialize();
            dragInitiator.systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler);
            if (!getFocus())
            {
                setFocus();
            };
        }

        public function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            var _local_2:DragEvent;
            var _local_3:DisplayObject;
            var _local_4:int;
            var _local_10:Array;
            var _local_14:Boolean;
            var _local_15:DisplayObject;
            lastMouseEvent = _arg_1;
            var _local_5:Point = new Point();
            var _local_6:Point = new Point(_arg_1.localX, _arg_1.localY);
            var _local_7:Point = DisplayObject(_arg_1.target).localToGlobal(_local_6);
            _local_6 = DisplayObject(sandboxRoot).globalToLocal(_local_7);
            var _local_8:Number = _local_6.x;
            var _local_9:Number = _local_6.y;
            x = (_local_8 - xOffset);
            y = (_local_9 - yOffset);
            if (!_arg_1)
            {
                return;
            };
            var _local_11:IEventDispatcher = systemManager.getTopLevelRoot();
            _local_10 = [];
            DragProxy.getObjectsUnderPoint(DisplayObject(sandboxRoot), _local_7, _local_10);
            var _local_12:DisplayObject;
            var _local_13:int = (_local_10.length - 1);
            while (_local_13 >= 0)
            {
                _local_12 = _local_10[_local_13];
                if (((!(_local_12 == this)) && (!(contains(_local_12))))) break;
                _local_13--;
            };
            if (target)
            {
                _local_14 = false;
                _local_15 = target;
                _local_3 = _local_12;
                while (_local_3)
                {
                    if (_local_3 == target)
                    {
                        dispatchDragEvent(DragEvent.DRAG_OVER, _arg_1, _local_3);
                        _local_14 = true;
                        break;
                    };
                    dispatchDragEvent(DragEvent.DRAG_ENTER, _arg_1, _local_3);
                    if (target == _local_3)
                    {
                        _local_14 = false;
                        break;
                    };
                    _local_3 = _local_3.parent;
                };
                if (!_local_14)
                {
                    dispatchDragEvent(DragEvent.DRAG_EXIT, _arg_1, _local_15);
                    if (target == _local_15)
                    {
                        target = null;
                    };
                };
            };
            if (!target)
            {
                action = DragManager.MOVE;
                _local_3 = _local_12;
                while (_local_3)
                {
                    if (_local_3 != this)
                    {
                        dispatchDragEvent(DragEvent.DRAG_ENTER, _arg_1, _local_3);
                        if (target) break;
                    };
                    _local_3 = _local_3.parent;
                };
                if (!target)
                {
                    action = DragManager.NONE;
                };
            };
            showFeedback();
        }

        private function dispatchDragEvent(_arg_1:String, _arg_2:MouseEvent, _arg_3:Object):void
        {
            var _local_4:DragEvent = new DragEvent(_arg_1);
            var _local_5:Point = new Point();
            _local_4.dragInitiator = dragInitiator;
            _local_4.dragSource = dragSource;
            _local_4.action = action;
            _local_4.ctrlKey = _arg_2.ctrlKey;
            _local_4.altKey = _arg_2.altKey;
            _local_4.shiftKey = _arg_2.shiftKey;
            _local_5.x = lastMouseEvent.localX;
            _local_5.y = lastMouseEvent.localY;
            _local_5 = DisplayObject(lastMouseEvent.target).localToGlobal(_local_5);
            _local_5 = DisplayObject(_arg_3).globalToLocal(_local_5);
            _local_4.localX = _local_5.x;
            _local_4.localY = _local_5.y;
            _dispatchDragEvent(DisplayObject(_arg_3), _local_4);
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            checkKeyEvent(_arg_1);
        }

        private function effectEndHandler(_arg_1:EffectEvent):void
        {
            DragManager.endDrag();
        }

        public function checkKeyEvent(_arg_1:KeyboardEvent):void
        {
            var _local_2:DragEvent;
            var _local_3:Point;
            if (target)
            {
                if ((((lastKeyEvent) && (_arg_1.type == lastKeyEvent.type)) && (_arg_1.keyCode == lastKeyEvent.keyCode)))
                {
                    return;
                };
                lastKeyEvent = _arg_1;
                _local_2 = new DragEvent(DragEvent.DRAG_OVER);
                _local_2.dragInitiator = dragInitiator;
                _local_2.dragSource = dragSource;
                _local_2.action = action;
                _local_2.ctrlKey = _arg_1.ctrlKey;
                _local_2.altKey = _arg_1.altKey;
                _local_2.shiftKey = _arg_1.shiftKey;
                _local_3 = new Point();
                _local_3.x = lastMouseEvent.localX;
                _local_3.y = lastMouseEvent.localY;
                _local_3 = DisplayObject(lastMouseEvent.target).localToGlobal(_local_3);
                _local_3 = DisplayObject(target).globalToLocal(_local_3);
                _local_2.localX = _local_3.x;
                _local_2.localY = _local_3.y;
                _dispatchDragEvent(target, _local_2);
                showFeedback();
            };
        }

        public function mouseLeaveHandler(_arg_1:Event):void
        {
            mouseUpHandler(lastMouseEvent);
        }

        private function _dispatchDragEvent(_arg_1:DisplayObject, _arg_2:DragEvent):void
        {
            var _local_3:InterManagerRequest;
            var _local_4:InterDragManagerEvent;
            if (isSameOrChildApplicationDomain(_arg_1))
            {
                _arg_1.dispatchEvent(_arg_2);
            }
            else
            {
                _local_3 = new InterManagerRequest(InterManagerRequest.INIT_MANAGER_REQUEST);
                _local_3.name = "mx.managers::IDragManager";
                sandboxRoot.dispatchEvent(_local_3);
                _local_4 = new InterDragManagerEvent(InterDragManagerEvent.DISPATCH_DRAG_EVENT, false, false, _arg_2.localX, _arg_2.localY, _arg_2.relatedObject, _arg_2.ctrlKey, _arg_2.altKey, _arg_2.shiftKey, _arg_2.buttonDown, _arg_2.delta, _arg_1, _arg_2.type, _arg_2.dragInitiator, _arg_2.dragSource, _arg_2.action, _arg_2.draggedItem);
                sandboxRoot.dispatchEvent(_local_4);
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            checkKeyEvent(_arg_1);
        }

        public function stage_mouseMoveHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.target != stage)
            {
                return;
            };
            mouseMoveHandler(_arg_1);
        }


    }
}//package mx.managers.dragClasses

