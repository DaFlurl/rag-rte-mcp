// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.Text

package mx.controls
{
    import mx.events.FlexEvent;
    import mx.core.UITextField;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Text extends Label 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var widthChanged:Boolean = true;
        private var lastUnscaledWidth:Number = NaN;

        public function Text()
        {
            selectable = true;
            truncateToFit = false;
            addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
        }

        private function measureUsingWidth(_arg_1:Number):void
        {
            var _local_6:Boolean;
            var _local_2:Number = getStyle("paddingLeft");
            var _local_3:Number = getStyle("paddingTop");
            var _local_4:Number = getStyle("paddingRight");
            var _local_5:Number = getStyle("paddingBottom");
            textField.validateNow();
            textField.autoSize = "left";
            if (!isNaN(_arg_1))
            {
                textField.width = ((_arg_1 - _local_2) - _local_4);
                measuredWidth = (Math.ceil(textField.textWidth) + UITextField.TEXT_WIDTH_PADDING);
                measuredHeight = (Math.ceil(textField.textHeight) + UITextField.TEXT_HEIGHT_PADDING);
            }
            else
            {
                _local_6 = textField.wordWrap;
                textField.wordWrap = false;
                measuredWidth = (Math.ceil(textField.textWidth) + UITextField.TEXT_WIDTH_PADDING);
                measuredHeight = (Math.ceil(textField.textHeight) + UITextField.TEXT_HEIGHT_PADDING);
                textField.wordWrap = _local_6;
            };
            textField.autoSize = "none";
            measuredWidth = (measuredWidth + (_local_2 + _local_4));
            measuredHeight = (measuredHeight + (_local_3 + _local_5));
            if (isNaN(explicitWidth))
            {
                measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
                measuredMinHeight = DEFAULT_MEASURED_MIN_HEIGHT;
            }
            else
            {
                measuredMinWidth = measuredWidth;
                measuredMinHeight = measuredHeight;
            };
        }

        override public function set percentWidth(_arg_1:Number):void
        {
            if (_arg_1 != percentWidth)
            {
                widthChanged = true;
                invalidateProperties();
                invalidateSize();
            };
            super.percentWidth = _arg_1;
        }

        override public function set explicitWidth(_arg_1:Number):void
        {
            if (_arg_1 != explicitWidth)
            {
                widthChanged = true;
                invalidateProperties();
                invalidateSize();
            };
            super.explicitWidth = _arg_1;
        }

        private function updateCompleteHandler(_arg_1:FlexEvent):void
        {
            lastUnscaledWidth = NaN;
        }

        override protected function childrenCreated():void
        {
            super.childrenCreated();
            textField.wordWrap = true;
            textField.multiline = true;
            textField.mouseWheelEnabled = false;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            if (widthChanged)
            {
                textField.wordWrap = (((!(isNaN(explicitWidth))) || (!(isNaN(explicitMaxWidth)))) || (!(isNaN(percentWidth))));
                widthChanged = false;
            };
        }

        override public function set maxWidth(_arg_1:Number):void
        {
            if (_arg_1 != maxWidth)
            {
                widthChanged = true;
                invalidateProperties();
                invalidateSize();
            };
            super.maxWidth = _arg_1;
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_7:Boolean;
            if (isSpecialCase())
            {
                _local_7 = ((isNaN(lastUnscaledWidth)) || (!(lastUnscaledWidth == _arg_1)));
                lastUnscaledWidth = _arg_1;
                if (_local_7)
                {
                    invalidateSize();
                    return;
                };
            };
            var _local_3:Number = getStyle("paddingLeft");
            var _local_4:Number = getStyle("paddingTop");
            var _local_5:Number = getStyle("paddingRight");
            var _local_6:Number = getStyle("paddingBottom");
            textField.setActualSize(((_arg_1 - _local_3) - _local_5), ((_arg_2 - _local_4) - _local_6));
            textField.x = _local_3;
            textField.y = _local_4;
            if (Math.floor(width) < Math.floor(measuredWidth))
            {
                textField.wordWrap = true;
            };
        }

        override protected function measure():void
        {
            var _local_1:Number;
            if (isSpecialCase())
            {
                if (!isNaN(lastUnscaledWidth))
                {
                    measureUsingWidth(lastUnscaledWidth);
                }
                else
                {
                    measuredWidth = 0;
                    measuredHeight = 0;
                };
                return;
            };
            if (!isNaN(explicitWidth))
            {
                _local_1 = explicitWidth;
            }
            else
            {
                if (!isNaN(explicitMaxWidth))
                {
                    _local_1 = explicitMaxWidth;
                };
            };
            measureUsingWidth(_local_1);
        }

        private function isSpecialCase():Boolean
        {
            var _local_1:Number = getStyle("left");
            var _local_2:Number = getStyle("right");
            return ((((!(isNaN(percentWidth))) || ((!(isNaN(_local_1))) && (!(isNaN(_local_2))))) && (isNaN(explicitHeight))) && (isNaN(percentHeight)));
        }


    }
}//package mx.controls

