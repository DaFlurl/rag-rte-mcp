// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ColorLabel

package view.ui
{
    import mx.controls.Label;
    import mx.formatters.NumberFormatter;

    public class ColorLabel extends Label 
    {

        private var _color:String;
        private var oldColor:*;


        override public function initialize():void
        {
            super.initialize();
        }

        public function set myText(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            var _local_2:NumberFormatter = new NumberFormatter();
            _local_2.useThousandsSeparator = true;
            this.text = _local_2.format(_arg_1);
        }

        public function set color(_arg_1:String):void
        {
            this._color = _arg_1;
            if (oldColor == null)
            {
                this.oldColor = this.getStyle("color");
            };
            if (_color != null)
            {
                this.setStyle("color", _color);
            }
            else
            {
                this.setStyle("color", this.oldColor);
            };
        }

        public function get color():String
        {
            return (this._color);
        }


    }
}//package view.ui

