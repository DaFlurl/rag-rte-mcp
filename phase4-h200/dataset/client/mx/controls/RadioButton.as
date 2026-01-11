// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.RadioButton

package mx.controls
{
    import mx.managers.IFocusManagerGroup;
    import mx.core.IToggleButton;
    import mx.events.FlexEvent;
    import mx.managers.IFocusManager;
    import mx.events.ItemClickEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import mx.core.FlexVersion;
    import mx.core.IFlexDisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RadioButton extends Button implements IFocusManagerGroup, IToggleButton 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var createAccessibilityImplementation:Function;

        private var _group:RadioButtonGroup;
        mx_internal var _groupName:String;
        private var _value:Object;
        private var groupChanged:Boolean = false;
        mx_internal var indexNumber:int = 0;

        public function RadioButton()
        {
            _labelPlacement = "";
            _toggle = true;
            groupName = "radioGroup";
            addEventListener(FlexEvent.ADD, addHandler);
            centerContent = false;
            extraSpacing = 8;
        }

        private function addHandler(_arg_1:FlexEvent):void
        {
            if (((!(_group)) && (initialized)))
            {
                addToGroup();
            };
        }

        private function setNext(_arg_1:Boolean=true):void
        {
            var _local_5:RadioButton;
            var _local_2:RadioButtonGroup = group;
            var _local_3:IFocusManager = focusManager;
            if (_local_3)
            {
                _local_3.showFocusIndicator = true;
            };
            var _local_4:int = (indexNumber + 1);
            while (_local_4 < _local_2.numRadioButtons)
            {
                _local_5 = _local_2.getRadioButtonAt(_local_4);
                if (((_local_5) && (_local_5.enabled)))
                {
                    if (_arg_1)
                    {
                        _local_2.setSelection(_local_5);
                    };
                    _local_5.setFocus();
                    return;
                };
                _local_4++;
            };
            if (((_arg_1) && (!(_local_2.getRadioButtonAt(indexNumber) == _local_2.selection))))
            {
                _local_2.setSelection(this);
            };
            this.drawFocus(true);
        }

        private function addToGroup():Object
        {
            var _local_1:RadioButtonGroup = group;
            if (_local_1)
            {
                _local_1.addInstance(this);
            };
            return (_local_1);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (groupChanged)
            {
                addToGroup();
                groupChanged = false;
            };
        }

        override protected function clickHandler(_arg_1:MouseEvent):void
        {
            if (((!(enabled)) || (selected)))
            {
                return;
            };
            if (!_group)
            {
                addToGroup();
            };
            super.clickHandler(_arg_1);
            group.setSelection(this);
            var _local_2:ItemClickEvent = new ItemClickEvent(ItemClickEvent.ITEM_CLICK);
            _local_2.label = label;
            _local_2.index = indexNumber;
            _local_2.relatedObject = this;
            _local_2.item = value;
            group.dispatchEvent(_local_2);
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            super.keyUpHandler(_arg_1);
            if (((_arg_1.keyCode == Keyboard.SPACE) && (!(_toggle))))
            {
                _toggle = true;
            };
        }

        [Bindable("labelPlacementChanged")]
        override public function get labelPlacement():String
        {
            var _local_1:String = ButtonLabelPlacement.RIGHT;
            if (_labelPlacement != "")
            {
                _local_1 = _labelPlacement;
            }
            else
            {
                if (((_group) && (!(_group.labelPlacement == ""))))
                {
                    _local_1 = _group.labelPlacement;
                };
            };
            return (_local_1);
        }

        public function set groupName(_arg_1:String):void
        {
            if (((!(_arg_1)) || (_arg_1 == "")))
            {
                return;
            };
            deleteGroup();
            _groupName = _arg_1;
            groupChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("groupNameChanged"));
        }

        override protected function initializeAccessibility():void
        {
            if (RadioButton.createAccessibilityImplementation != null)
            {
                RadioButton.createAccessibilityImplementation(this);
            };
        }

        private function setThis():void
        {
            if (!_group)
            {
                addToGroup();
            };
            var _local_1:RadioButtonGroup = group;
            if (_local_1.selection != this)
            {
                _local_1.setSelection(this);
            };
        }

        override public function get emphasized():Boolean
        {
            return (false);
        }

        override public function get toggle():Boolean
        {
            return (super.toggle);
        }

        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            super.measure();
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_1 = measureText(label).height;
                _local_2 = ((currentIcon) ? currentIcon.height : 0);
                if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
                {
                    _local_3 = Math.max(_local_1, _local_2);
                }
                else
                {
                    _local_3 = (_local_1 + _local_2);
                    _local_4 = getStyle("verticalGap");
                    if (((!(_local_2 == 0)) && (!(isNaN(_local_4)))))
                    {
                        _local_3 = (_local_3 + _local_4);
                    };
                };
                measuredMinHeight = (measuredHeight = Math.max(_local_3, 18));
            };
        }

        override public function set toggle(_arg_1:Boolean):void
        {
        }

        mx_internal function deleteGroup():void
        {
            try
            {
                if (document[groupName])
                {
                    delete document[groupName];
                };
            }
            catch(e:Error)
            {
                try
                {
                    if (document.automaticRadioButtonGroups[groupName])
                    {
                        delete document.automaticRadioButtonGroups[groupName];
                    };
                }
                catch(e1:Error)
                {
                };
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            if (!enabled)
            {
                return;
            };
            switch (_arg_1.keyCode)
            {
                case Keyboard.DOWN:
                    setNext((!(_arg_1.ctrlKey)));
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.UP:
                    setPrev((!(_arg_1.ctrlKey)));
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.LEFT:
                    setPrev((!(_arg_1.ctrlKey)));
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.RIGHT:
                    setNext((!(_arg_1.ctrlKey)));
                    _arg_1.stopPropagation();
                    return;
                case Keyboard.SPACE:
                    setThis();
                    _toggle = false;
                default:
                    super.keyDownHandler(_arg_1);
            };
        }

        [Bindable("groupNameChanged")]
        public function get groupName():String
        {
            return (_groupName);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (groupChanged)
            {
                addToGroup();
                groupChanged = false;
            };
            if ((((_group) && (_selected)) && (!(_group.selection == this))))
            {
                group.setSelection(this, false);
            };
        }

        [Bindable("valueChanged")]
        public function get value():Object
        {
            return (_value);
        }

        public function set value(_arg_1:Object):void
        {
            _value = _arg_1;
            dispatchEvent(new Event("valueChanged"));
            if (((selected) && (group)))
            {
                group.dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            };
        }

        private function setPrev(_arg_1:Boolean=true):void
        {
            var _local_5:RadioButton;
            var _local_2:RadioButtonGroup = group;
            var _local_3:IFocusManager = focusManager;
            if (_local_3)
            {
                _local_3.showFocusIndicator = true;
            };
            var _local_4:int = 1;
            while (_local_4 <= indexNumber)
            {
                _local_5 = _local_2.getRadioButtonAt((indexNumber - _local_4));
                if (((_local_5) && (_local_5.enabled)))
                {
                    if (_arg_1)
                    {
                        _local_2.setSelection(_local_5);
                    };
                    _local_5.setFocus();
                    return;
                };
                _local_4++;
            };
            if (((_arg_1) && (!(_local_2.getRadioButtonAt(indexNumber) == _local_2.selection))))
            {
                _local_2.setSelection(this);
            };
            this.drawFocus(true);
        }

        public function set group(_arg_1:RadioButtonGroup):void
        {
            _group = _arg_1;
        }

        public function get group():RadioButtonGroup
        {
            var g:RadioButtonGroup;
            if (!document)
            {
                return (_group);
            };
            if (!_group)
            {
                if (((groupName) && (!(groupName == ""))))
                {
                    try
                    {
                        g = RadioButtonGroup(document[groupName]);
                    }
                    catch(e:Error)
                    {
                        if (((document.automaticRadioButtonGroups) && (document.automaticRadioButtonGroups[groupName])))
                        {
                            g = RadioButtonGroup(document.automaticRadioButtonGroups[groupName]);
                        };
                    };
                    if (!g)
                    {
                        g = new RadioButtonGroup(IFlexDisplayObject(document));
                        if (!document.automaticRadioButtonGroups)
                        {
                            document.automaticRadioButtonGroups = {};
                        };
                        document.automaticRadioButtonGroups[groupName] = g;
                    }
                    else
                    {
                        if (!(g is RadioButtonGroup))
                        {
                            return (null);
                        };
                    };
                    _group = g;
                };
            };
            return (_group);
        }


    }
}//package mx.controls

