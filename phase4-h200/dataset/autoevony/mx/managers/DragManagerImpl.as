// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.DragManagerImpl

package mx.managers
{
    import flash.events.IEventDispatcher;
    import mx.managers.dragClasses.DragProxy;
    import mx.core.IUIComponent;
    import mx.events.InterDragManagerEvent;
    import flash.events.MouseEvent;
    import mx.events.InterManagerRequest;
    import flash.events.Event;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import flash.display.DisplayObject;
    import mx.core.UIComponentGlobals;
    import flash.geom.Point;
    import mx.core.DragSource;
    import mx.core.IFlexDisplayObject;
    import mx.events.DragEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DragManagerImpl implements IDragManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var sm:ISystemManager;
        private static var instance:IDragManager;

        private var bDoingDrag:Boolean = false;
        private var sandboxRoot:IEventDispatcher;
        public var dragProxy:DragProxy;
        private var dragInitiator:IUIComponent;
        private var mouseIsDown:Boolean = false;

        public function DragManagerImpl()
        {
            var _local_1:IEventDispatcher;
            super();
            if (instance)
            {
                throw (new Error("Instance already exists."));
            };
            if (!sm.isTopLevelRoot())
            {
                sandboxRoot = sm.getSandboxRoot();
                sandboxRoot.addEventListener(InterDragManagerEvent.DISPATCH_DRAG_EVENT, marshalDispatchEventHandler, false, 0, true);
            }
            else
            {
                _local_1 = sm;
                _local_1.addEventListener(MouseEvent.MOUSE_DOWN, sm_mouseDownHandler, false, 0, true);
                _local_1.addEventListener(MouseEvent.MOUSE_UP, sm_mouseUpHandler, false, 0, true);
                sandboxRoot = sm;
                sandboxRoot.addEventListener(InterDragManagerEvent.DISPATCH_DRAG_EVENT, marshalDispatchEventHandler, false, 0, true);
            };
            sandboxRoot.addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, marshalDragManagerHandler, false, 0, true);
            var _local_2:InterManagerRequest = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _local_2.name = "update";
            sandboxRoot.dispatchEvent(_local_2);
        }

        public static function getInstance():IDragManager
        {
            if (!instance)
            {
                sm = SystemManagerGlobals.topLevelSystemManagers[0];
                instance = new (DragManagerImpl)();
            };
            return (instance);
        }


        private function marshalDragManagerHandler(_arg_1:Event):void
        {
            var _local_3:InterManagerRequest;
            if ((_arg_1 is InterManagerRequest))
            {
                return;
            };
            var _local_2:Object = _arg_1;
            switch (_local_2.name)
            {
                case "isDragging":
                    bDoingDrag = _local_2.value;
                    return;
                case "acceptDragDrop":
                    if (dragProxy)
                    {
                        dragProxy.target = _local_2.value;
                    };
                    return;
                case "showFeedback":
                    if (dragProxy)
                    {
                        showFeedback(_local_2.value);
                    };
                    return;
                case "getFeedback":
                    if (dragProxy)
                    {
                        _local_2.value = getFeedback();
                    };
                    return;
                case "endDrag":
                    endDrag();
                    return;
                case "update":
                    if (((dragProxy) && (isDragging)))
                    {
                        _local_3 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                        _local_3.name = "isDragging";
                        _local_3.value = true;
                        sandboxRoot.dispatchEvent(_local_3);
                    };
            };
        }

        private function sm_mouseUpHandler(_arg_1:MouseEvent):void
        {
            mouseIsDown = false;
        }

        public function get isDragging():Boolean
        {
            return (bDoingDrag);
        }

        public function doDrag(_arg_1:IUIComponent, _arg_2:DragSource, _arg_3:MouseEvent, _arg_4:IFlexDisplayObject=null, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0.5, _arg_8:Boolean=true):void
        {
            var _local_9:Number;
            var _local_10:Number;
            var _local_18:CSSStyleDeclaration;
            var _local_19:Class;
            if (bDoingDrag)
            {
                return;
            };
            if (!((((_arg_3.type == MouseEvent.MOUSE_DOWN) || (_arg_3.type == MouseEvent.CLICK)) || (mouseIsDown)) || (_arg_3.buttonDown)))
            {
                return;
            };
            bDoingDrag = true;
            var _local_11:InterManagerRequest = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _local_11.name = "isDragging";
            _local_11.value = true;
            sandboxRoot.dispatchEvent(_local_11);
            _local_11 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _local_11.name = "mouseShield";
            _local_11.value = true;
            sandboxRoot.dispatchEvent(_local_11);
            this.dragInitiator = _arg_1;
            dragProxy = new DragProxy(_arg_1, _arg_2);
            sm.addChildToSandboxRoot("popUpChildren", dragProxy);
            if (!_arg_4)
            {
                _local_18 = StyleManager.getStyleDeclaration("DragManager");
                _local_19 = _local_18.getStyle("defaultDragImageSkin");
                _arg_4 = new (_local_19)();
                dragProxy.addChild(DisplayObject(_arg_4));
                _local_9 = _arg_1.width;
                _local_10 = _arg_1.height;
            }
            else
            {
                dragProxy.addChild(DisplayObject(_arg_4));
                if ((_arg_4 is ILayoutManagerClient))
                {
                    UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(_arg_4), true);
                };
                if ((_arg_4 is IUIComponent))
                {
                    _local_9 = (_arg_4 as IUIComponent).getExplicitOrMeasuredWidth();
                    _local_10 = (_arg_4 as IUIComponent).getExplicitOrMeasuredHeight();
                }
                else
                {
                    _local_9 = _arg_4.measuredWidth;
                    _local_10 = _arg_4.measuredHeight;
                };
            };
            _arg_4.setActualSize(_local_9, _local_10);
            dragProxy.setActualSize(_local_9, _local_10);
            dragProxy.alpha = _arg_7;
            dragProxy.allowMove = _arg_8;
            var _local_12:Object = _arg_3.target;
            if (_local_12 == null)
            {
                _local_12 = _arg_1;
            };
            var _local_13:Point = new Point(_arg_3.localX, _arg_3.localY);
            _local_13 = DisplayObject(_local_12).localToGlobal(_local_13);
            _local_13 = DisplayObject(sandboxRoot).globalToLocal(_local_13);
            var _local_14:Number = _local_13.x;
            var _local_15:Number = _local_13.y;
            var _local_16:Point = DisplayObject(_local_12).localToGlobal(new Point(_arg_3.localX, _arg_3.localY));
            _local_16 = DisplayObject(_arg_1).globalToLocal(_local_16);
            dragProxy.xOffset = (_local_16.x + _arg_5);
            dragProxy.yOffset = (_local_16.y + _arg_6);
            dragProxy.x = (_local_14 - dragProxy.xOffset);
            dragProxy.y = (_local_15 - dragProxy.yOffset);
            dragProxy.startX = dragProxy.x;
            dragProxy.startY = dragProxy.y;
            if ((_arg_4 is DisplayObject))
            {
                DisplayObject(_arg_4).cacheAsBitmap = true;
            };
            var _local_17:Object = dragProxy.automationDelegate;
            if (_local_17)
            {
                _local_17.recordAutomatableDragStart(_arg_1, _arg_3);
            };
        }

        private function sm_mouseDownHandler(_arg_1:MouseEvent):void
        {
            mouseIsDown = true;
        }

        public function showFeedback(_arg_1:String):void
        {
            var _local_2:InterManagerRequest;
            if (dragProxy)
            {
                if (((_arg_1 == DragManager.MOVE) && (!(dragProxy.allowMove))))
                {
                    _arg_1 = DragManager.COPY;
                };
                dragProxy.action = _arg_1;
            }
            else
            {
                if (isDragging)
                {
                    _local_2 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                    _local_2.name = "showFeedback";
                    _local_2.value = _arg_1;
                    sandboxRoot.dispatchEvent(_local_2);
                };
            };
        }

        public function acceptDragDrop(_arg_1:IUIComponent):void
        {
            var _local_2:InterManagerRequest;
            if (dragProxy)
            {
                dragProxy.target = (_arg_1 as DisplayObject);
            }
            else
            {
                if (isDragging)
                {
                    _local_2 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                    _local_2.name = "acceptDragDrop";
                    _local_2.value = _arg_1;
                    sandboxRoot.dispatchEvent(_local_2);
                };
            };
        }

        private function marshalDispatchEventHandler(_arg_1:Event):void
        {
            if ((_arg_1 is InterDragManagerEvent))
            {
                return;
            };
            var _local_2:Object = _arg_1;
            var _local_3:DisplayObject = SystemManager.getSWFRoot(_local_2.dropTarget);
            if (!_local_3)
            {
                return;
            };
            var _local_4:DragEvent = new DragEvent(_local_2.dragEventType, _local_2.bubbles, _local_2.cancelable);
            _local_4.localX = _local_2.localX;
            _local_4.localY = _local_2.localY;
            _local_4.action = _local_2.action;
            _local_4.ctrlKey = _local_2.ctrlKey;
            _local_4.altKey = _local_2.altKey;
            _local_4.shiftKey = _local_2.shiftKey;
            _local_4.draggedItem = _local_2.draggedItem;
            _local_4.dragSource = new DragSource();
            var _local_5:Array = _local_2.dragSource.formats;
            var _local_6:int = _local_5.length;
            var _local_7:int;
            while (_local_7 < _local_6)
            {
                _local_4.dragSource.addData(_local_2.dragSource.dataForFormat(_local_5[_local_7]), _local_5[_local_7]);
                _local_7++;
            };
            if (!_local_2.dropTarget.dispatchEvent(_local_4))
            {
                _arg_1.preventDefault();
            };
        }

        public function getFeedback():String
        {
            var _local_1:InterManagerRequest;
            if (((!(dragProxy)) && (isDragging)))
            {
                _local_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _local_1.name = "getFeedback";
                sandboxRoot.dispatchEvent(_local_1);
                return (_local_1.value as String);
            };
            return ((dragProxy) ? dragProxy.action : DragManager.NONE);
        }

        public function endDrag():void
        {
            var _local_1:InterManagerRequest;
            if (dragProxy)
            {
                sm.removeChildFromSandboxRoot("popUpChildren", dragProxy);
                dragProxy.removeChildAt(0);
                dragProxy = null;
            }
            else
            {
                if (isDragging)
                {
                    _local_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                    _local_1.name = "endDrag";
                    sandboxRoot.dispatchEvent(_local_1);
                };
            };
            _local_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _local_1.name = "mouseShield";
            _local_1.value = false;
            sandboxRoot.dispatchEvent(_local_1);
            dragInitiator = null;
            bDoingDrag = false;
            _local_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _local_1.name = "isDragging";
            _local_1.value = false;
            sandboxRoot.dispatchEvent(_local_1);
        }


    }
}//package mx.managers

