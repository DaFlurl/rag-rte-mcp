// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.dividedBoxClasses.BoxDivider

package mx.containers.dividedBoxClasses
{
    import mx.core.UIComponent;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import mx.containers.DividedBox;
    import mx.containers.DividerState;
    import mx.events.SandboxMouseEvent;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BoxDivider extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var isMouseOver:Boolean = false;
        private var _state:String = "up";
        private var knob:DisplayObject;

        public function BoxDivider()
        {
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }

        mx_internal function set state(_arg_1:String):void
        {
            _state = _arg_1;
            invalidateDisplayList();
        }

        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            if ((((!(_arg_1)) || (_arg_1 == "dividerSkin")) || (_arg_1 == "styleName")))
            {
                if (knob)
                {
                    removeChild(knob);
                    knob = null;
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Number;
            var _local_7:Class;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            if (((isNaN(width)) || (isNaN(height))))
            {
                return;
            };
            if (!parent)
            {
                return;
            };
            super.updateDisplayList(_arg_1, _arg_2);
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
            var _local_4:Number = 1;
            var _local_5:Number = getStyle("dividerThickness");
            var _local_6:Number = ((DividedBox(owner).isVertical()) ? DividedBox(owner).getStyle("verticalGap") : DividedBox(owner).getStyle("horizontalGap"));
            if (state != DividerState.DOWN)
            {
                if (_local_6 >= 6)
                {
                    if (!knob)
                    {
                        _local_7 = Class(getStyle("dividerSkin"));
                        if (_local_7)
                        {
                            knob = new (_local_7)();
                        };
                        if (knob)
                        {
                            addChild(knob);
                        };
                    };
                    if (knob)
                    {
                        if (DividedBox(owner).isVertical())
                        {
                            knob.scaleX = 1;
                            knob.rotation = 0;
                        }
                        else
                        {
                            knob.scaleX = -1;
                            knob.rotation = -90;
                        };
                        knob.x = Math.round(((width - knob.width) / 2));
                        knob.y = Math.round(((height - knob.height) / 2));
                    };
                };
                return;
            };
            _local_3 = getStyle("dividerColor");
            _local_4 = getStyle("dividerAlpha");
            graphics.beginFill(_local_3, _local_4);
            if (DividedBox(owner).isVertical())
            {
                _local_8 = _local_5;
                if (_local_8 > _local_6)
                {
                    _local_8 = _local_6;
                };
                _local_9 = ((height - _local_8) / 2);
                graphics.drawRect(0, _local_9, width, _local_8);
            }
            else
            {
                _local_10 = _local_5;
                if (_local_10 > _local_6)
                {
                    _local_10 = _local_6;
                };
                _local_11 = ((width - _local_10) / 2);
                graphics.drawRect(_local_11, 0, _local_10, height);
            };
            graphics.endFill();
        }

        private function mouseOutHandler(_arg_1:MouseEvent):void
        {
            isMouseOver = false;
            if (!DividedBox(owner).activeDivider)
            {
                state = DividerState.UP;
                if (parent)
                {
                    DividedBox(owner).restoreCursor();
                };
            };
        }

        private function mouseUpHandler(_arg_1:Event):void
        {
            if (!isMouseOver)
            {
                DividedBox(owner).restoreCursor();
            };
            state = DividerState.OVER;
            DividedBox(owner).stopDividerDrag(this, (_arg_1 as MouseEvent));
            var _local_2:DisplayObject = systemManager.getSandboxRoot();
            _local_2.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _local_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler);
        }

        override public function set x(_arg_1:Number):void
        {
            var _local_2:Number = x;
            super.x = _arg_1;
            if (!DividedBox(owner).isVertical())
            {
                DividedBox(owner).moveDivider(DividedBox(owner).getDividerIndex(this), (_arg_1 - _local_2));
            };
        }

        mx_internal function get state():String
        {
            return (_state);
        }

        private function mouseOverHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.buttonDown)
            {
                return;
            };
            isMouseOver = true;
            if (!DividedBox(owner).activeDivider)
            {
                state = DividerState.OVER;
                DividedBox(owner).changeCursor(this);
            };
        }

        override public function set y(_arg_1:Number):void
        {
            var _local_2:Number = y;
            super.y = _arg_1;
            if (DividedBox(owner).isVertical())
            {
                DividedBox(owner).moveDivider(DividedBox(owner).getDividerIndex(this), (_arg_1 - _local_2));
            };
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            DividedBox(owner).changeCursor(this);
            DividedBox(owner).startDividerDrag(this, _arg_1);
            var _local_2:DisplayObject = systemManager.getSandboxRoot();
            _local_2.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _local_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseUpHandler);
        }


    }
}//package mx.containers.dividedBoxClasses

