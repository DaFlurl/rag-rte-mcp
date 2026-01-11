// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ToggleButtonBar

package mx.controls
{
    import mx.core.IFlexDisplayObject;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import mx.events.FlexEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToggleButtonBar extends ButtonBar 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        mx_internal var selectedButtonTextStyleNameProp:String = "selectedButtonTextStyleName";
        private var initializeSelectedButton:Boolean = true;
        private var _toggleOnClick:Boolean = false;
        private var _selectedIndex:int = -2;
        private var selectedIndexChanged:Boolean = false;


        override protected function createNavItem(_arg_1:String, _arg_2:Class=null):IFlexDisplayObject
        {
            var _local_3:Button = Button(super.createNavItem(_arg_1, _arg_2));
            _local_3.toggle = true;
            return (_local_3);
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_3:Button;
            var _local_4:String;
            var _local_2:Boolean = ((_arg_1 == null) || (_arg_1 == "styleName"));
            super.styleChanged(_arg_1);
            if (((_local_2) || (_arg_1 == selectedButtonTextStyleNameProp)))
            {
                if (((!(selectedIndex == -1)) && (selectedIndex < numChildren)))
                {
                    _local_3 = Button(getChildAt(selectedIndex));
                    if (_local_3)
                    {
                        _local_4 = getStyle(selectedButtonTextStyleNameProp);
                        _local_3.getTextField().styleName = ((_local_4) ? _local_4 : "activeButtonStyle");
                    };
                };
            };
        }

        override protected function resetNavItems():void
        {
            var _local_4:Button;
            var _local_1:String = getStyle(selectedButtonTextStyleNameProp);
            var _local_2:int = numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = Button(getChildAt(_local_3));
                if (_local_3 == selectedIndex)
                {
                    _local_4.selected = true;
                    _local_4.getTextField().styleName = ((_local_1) ? _local_1 : "activeButtonStyle");
                }
                else
                {
                    _local_4.selected = false;
                    _local_4.getTextField().styleName = _local_4;
                };
                _local_3++;
            };
            super.resetNavItems();
        }

        mx_internal function selectButton(_arg_1:int, _arg_2:Boolean=false, _arg_3:Event=null):void
        {
            _selectedIndex = _arg_1;
            if (_arg_2)
            {
                drawButtonFocus(focusedIndex, false);
                focusedIndex = _arg_1;
                drawButtonFocus(focusedIndex, false);
            };
            var _local_4:Button = Button(getChildAt(_arg_1));
            simulatedClickTriggerEvent = _arg_3;
            _local_4.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            simulatedClickTriggerEvent = null;
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (selectedIndexChanged)
            {
                hiliteSelectedNavItem(_selectedIndex);
                super.selectedIndex = _selectedIndex;
                selectedIndexChanged = false;
            };
        }

        override protected function hiliteSelectedNavItem(_arg_1:int):void
        {
            var _local_2:Button;
            var _local_3:String;
            if (((!(selectedIndex == -1)) && (selectedIndex < numChildren)))
            {
                _local_2 = Button(getChildAt(selectedIndex));
                _local_2.selected = false;
                _local_2.getTextField().styleName = _local_2;
                _local_2.invalidateDisplayList();
                _local_2.invalidateSize();
            };
            super.selectedIndex = _arg_1;
            _selectedIndex = _arg_1;
            if (_arg_1 > -1)
            {
                _local_2 = Button(getChildAt(selectedIndex));
                _local_2.selected = true;
                _local_3 = getStyle(selectedButtonTextStyleNameProp);
                _local_2.getTextField().styleName = ((_local_3) ? _local_3 : "activeButtonStyle");
                _local_2.invalidateDisplayList();
            };
        }

        override protected function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int = getChildIndex(Button(_arg_1.currentTarget));
            _selectedIndex = _local_2;
            if (((_toggleOnClick) && (_local_2 == selectedIndex)))
            {
                selectedIndex = -1;
                hiliteSelectedNavItem(-1);
            }
            else
            {
                hiliteSelectedNavItem(_local_2);
            };
            super.clickHandler(_arg_1);
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:int = -1;
            var _local_3:Boolean = true;
            var _local_4:int = numChildren;
            switch (_arg_1.keyCode)
            {
                case Keyboard.PAGE_DOWN:
                    _local_2 = nextIndex(selectedIndex);
                    break;
                case Keyboard.PAGE_UP:
                    if (selectedIndex != -1)
                    {
                        _local_2 = prevIndex(selectedIndex);
                    }
                    else
                    {
                        if (_local_4 > 0)
                        {
                            _local_2 = 0;
                        };
                    };
                    break;
                case Keyboard.HOME:
                    if (_local_4 > 0)
                    {
                        _local_2 = 0;
                    };
                    break;
                case Keyboard.END:
                    if (_local_4 > 0)
                    {
                        _local_2 = (_local_4 - 1);
                    };
                    break;
                case Keyboard.SPACE:
                case Keyboard.ENTER:
                    if (focusedIndex != -1)
                    {
                        _local_2 = focusedIndex;
                        _local_3 = false;
                    };
                    break;
                default:
                    super.keyDownHandler(_arg_1);
            };
            if (_local_2 != -1)
            {
                selectButton(_local_2, _local_3, _arg_1);
            };
            _arg_1.stopPropagation();
        }

        public function set toggleOnClick(_arg_1:Boolean):void
        {
            _toggleOnClick = _arg_1;
        }

        override public function set selectedIndex(_arg_1:int):void
        {
            if (((_arg_1 == selectedIndex) && (!(_arg_1 == -1))))
            {
                return;
            };
            if (numChildren == 0)
            {
                _selectedIndex = _arg_1;
                selectedIndexChanged = true;
            };
            if (_arg_1 < numChildren)
            {
                _selectedIndex = _arg_1;
                selectedIndexChanged = true;
                invalidateProperties();
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            };
        }

        public function get toggleOnClick():Boolean
        {
            return (_toggleOnClick);
        }

        [Bindable("click")]
        [Bindable("valueCommit")]
        override public function get selectedIndex():int
        {
            return (super.selectedIndex);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:int;
            super.updateDisplayList(_arg_1, _arg_2);
            if (initializeSelectedButton)
            {
                initializeSelectedButton = false;
                _local_3 = _selectedIndex;
                if (_local_3 == -2)
                {
                    if (numChildren > 0)
                    {
                        _local_3 = 0;
                    }
                    else
                    {
                        _local_3 = -1;
                    };
                };
                hiliteSelectedNavItem(_local_3);
            };
        }


    }
}//package mx.controls

