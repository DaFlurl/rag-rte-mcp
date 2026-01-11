// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.NumberInput

package view.ui
{
    import mx.controls.TextInput;
    import flash.events.TextEvent;
    import flash.events.Event;

    public class NumberInput extends TextInput 
    {

        private var num:Number;
        private var hasMaxValue:Boolean = false;
        public var onDataChange:Function;
        public var allowFloat:Boolean = false;
        private var _maxValue:Number;
        public var allowNegative:Boolean = false;

        public function NumberInput()
        {
            this.addEventListener("change", ___NumberInput_TextInput1_change);
            this.addEventListener("textInput", ___NumberInput_TextInput1_textInput);
        }

        public function set maxValue(_arg_1:Number):void
        {
            this.hasMaxValue = true;
            this._maxValue = _arg_1;
        }

        private function isNumber(_arg_1:Number):Boolean
        {
            return ((((_arg_1 >= 48) && (_arg_1 <= 57)) || ((this.allowNegative) && (_arg_1 == 45))) || ((this.allowFloat) && (_arg_1 == 46)));
        }

        private function onTextInput(_arg_1:TextEvent):void
        {
            var _local_4:Number;
            var _local_2:Boolean = true;
            var _local_3:int;
            while (_local_3 < _arg_1.text.length)
            {
                _local_2 = this.isNumber(_arg_1.text.charCodeAt(_local_3));
                _local_3++;
            };
            if (!_local_2)
            {
                _arg_1.preventDefault();
            }
            else
            {
                if (this.hasMaxValue)
                {
                    _local_4 = Number((this.text + _arg_1.text));
                    if (_local_4 > this._maxValue)
                    {
                        _arg_1.preventDefault();
                    };
                };
            };
        }

        private function onChange(_arg_1:Event):void
        {
            var _local_2:Number = Number(this.text);
            if (this.onDataChange != null)
            {
                this.onDataChange.apply(this, [_local_2]);
            };
        }

        override public function initialize():void
        {
            super.initialize();
        }

        public function ___NumberInput_TextInput1_textInput(_arg_1:TextEvent):void
        {
            onTextInput(_arg_1);
        }

        public function ___NumberInput_TextInput1_change(_arg_1:Event):void
        {
            onChange(_arg_1);
        }


    }
}//package view.ui

