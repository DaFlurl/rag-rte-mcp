// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.RadioButtonGroup

package mx.controls
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.core.IFlexDisplayObject;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.core.Application;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RadioButtonGroup extends EventDispatcher implements IMXMLObject 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var radioButtons:Array = [];
        private var _selection:RadioButton;
        private var _selectedValue:Object;
        private var document:IFlexDisplayObject;
        private var _labelPlacement:String = "right";
        private var indexNumber:int = 0;

        public function RadioButtonGroup(_arg_1:IFlexDisplayObject=null)
        {
        }

        [Bindable("enabledChanged")]
        public function get enabled():Boolean
        {
            var _local_1:Number = 0;
            var _local_2:int = numRadioButtons;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_1 = (_local_1 + getRadioButtonAt(_local_3).enabled);
                _local_3++;
            };
            if (_local_1 == 0)
            {
                return (false);
            };
            if (_local_1 == _local_2)
            {
                return (true);
            };
            return (false);
        }

        public function set enabled(_arg_1:Boolean):void
        {
            var _local_2:int = numRadioButtons;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                getRadioButtonAt(_local_3).enabled = _arg_1;
                _local_3++;
            };
            dispatchEvent(new Event("enabledChanged"));
        }

        private function radioButton_removedHandler(_arg_1:Event):void
        {
            var _local_2:RadioButton = (_arg_1.target as RadioButton);
            if (_local_2)
            {
                _local_2.removeEventListener(Event.REMOVED, radioButton_removedHandler);
                removeInstance(RadioButton(_arg_1.target));
            };
        }

        public function set selectedValue(_arg_1:Object):void
        {
            var _local_4:RadioButton;
            _selectedValue = _arg_1;
            var _local_2:int = numRadioButtons;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = getRadioButtonAt(_local_3);
                if (((_local_4.value == _arg_1) || (_local_4.label == _arg_1)))
                {
                    changeSelection(_local_3, false);
                    break;
                };
                _local_3++;
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        private function getValue():String
        {
            if (selection)
            {
                return ((((selection.value) && (selection.value is String)) && (!(String(selection.value).length == 0))) ? String(selection.value) : selection.label);
            };
            return (null);
        }

        [Bindable("labelPlacementChanged")]
        public function get labelPlacement():String
        {
            return (_labelPlacement);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selection():RadioButton
        {
            return (_selection);
        }

        [Bindable("change")]
        [Bindable("valueCommit")]
        public function get selectedValue():Object
        {
            if (selection)
            {
                return ((selection.value != null) ? selection.value : selection.label);
            };
            return (null);
        }

        public function set selection(_arg_1:RadioButton):void
        {
            setSelection(_arg_1, false);
        }

        mx_internal function setSelection(_arg_1:RadioButton, _arg_2:Boolean=true):void
        {
            var _local_3:int;
            var _local_4:int;
            if (((_arg_1 == null) && (!(_selection == null))))
            {
                _selection.selected = false;
                _selection = null;
                if (_arg_2)
                {
                    dispatchEvent(new Event(Event.CHANGE));
                };
            }
            else
            {
                _local_3 = numRadioButtons;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    if (_arg_1 == getRadioButtonAt(_local_4))
                    {
                        changeSelection(_local_4, _arg_2);
                        break;
                    };
                    _local_4++;
                };
            };
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.document = ((_arg_1) ? IFlexDisplayObject(_arg_1) : IFlexDisplayObject(Application.application));
        }

        mx_internal function addInstance(_arg_1:RadioButton):void
        {
            _arg_1.indexNumber = indexNumber++;
            _arg_1.addEventListener(Event.REMOVED, radioButton_removedHandler);
            radioButtons.push(_arg_1);
            if (_selectedValue != null)
            {
                selectedValue = _selectedValue;
            };
            dispatchEvent(new Event("numRadioButtonsChanged"));
        }

        public function set labelPlacement(_arg_1:String):void
        {
            _labelPlacement = _arg_1;
            var _local_2:int = numRadioButtons;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                getRadioButtonAt(_local_3).labelPlacement = _arg_1;
                _local_3++;
            };
        }

        [Bindable("numRadioButtonsChanged")]
        public function get numRadioButtons():int
        {
            return (radioButtons.length);
        }

        public function getRadioButtonAt(_arg_1:int):RadioButton
        {
            return (RadioButton(radioButtons[_arg_1]));
        }

        mx_internal function removeInstance(_arg_1:RadioButton):void
        {
            var _local_2:Boolean;
            var _local_3:int;
            var _local_4:RadioButton;
            if (_arg_1)
            {
                _local_2 = false;
                _local_3 = 0;
                while (_local_3 < numRadioButtons)
                {
                    _local_4 = getRadioButtonAt(_local_3);
                    if (_local_2)
                    {
                        _local_4.indexNumber--;
                    }
                    else
                    {
                        if (_local_4 == _arg_1)
                        {
                            _local_4.group = null;
                            if (_arg_1 == _selection)
                            {
                                _selection = null;
                            };
                            radioButtons.splice(_local_3, 1);
                            _local_2 = true;
                            indexNumber--;
                            _local_3--;
                        };
                    };
                    _local_3++;
                };
                if (_local_2)
                {
                    dispatchEvent(new Event("numRadioButtonsChanged"));
                };
            };
        }

        private function changeSelection(_arg_1:int, _arg_2:Boolean=true):void
        {
            if (getRadioButtonAt(_arg_1))
            {
                if (selection)
                {
                    selection.selected = false;
                };
                _selection = getRadioButtonAt(_arg_1);
                _selection.selected = true;
                if (_arg_2)
                {
                    dispatchEvent(new Event(Event.CHANGE));
                };
            };
        }


    }
}//package mx.controls

