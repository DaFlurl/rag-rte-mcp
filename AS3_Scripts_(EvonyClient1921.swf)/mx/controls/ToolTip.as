// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.ToolTip

package mx.controls
{
    import mx.core.UIComponent;
    import mx.core.IToolTip;
    import mx.core.IFontContextComponent;
    import mx.core.IUITextField;
    import mx.core.IFlexDisplayObject;
    import mx.core.IFlexModuleFactory;
    import flash.text.TextFormat;
    import flash.display.DisplayObject;
    import mx.styles.ISimpleStyleClient;
    import mx.core.EdgeMetrics;
    import mx.core.UITextField;
    import flash.text.TextFieldAutoSize;
    import mx.core.IRectangularBorder;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToolTip extends UIComponent implements IToolTip, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static var maxWidth:Number = 300;

        private var textChanged:Boolean;
        private var _text:String;
        protected var textField:IUITextField;
        mx_internal var border:IFlexDisplayObject;

        public function ToolTip()
        {
            mouseEnabled = false;
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        override public function styleChanged(_arg_1:String):void
        {
            super.styleChanged(_arg_1);
            if ((((_arg_1 == "borderStyle") || (_arg_1 == "styleName")) || (_arg_1 == null)))
            {
                invalidateDisplayList();
            };
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            var _local_2:TextFormat;
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(textField == null))))
            {
                _local_1 = getChildIndex(DisplayObject(textField));
                removeTextField();
                createTextField(_local_1);
                invalidateSize();
                textChanged = true;
            };
            if (textChanged)
            {
                _local_2 = textField.getTextFormat();
                _local_2.leftMargin = 0;
                _local_2.rightMargin = 0;
                textField.defaultTextFormat = _local_2;
                textField.text = _text;
                textChanged = false;
            };
        }

        mx_internal function getTextField():IUITextField
        {
            return (textField);
        }

        override protected function createChildren():void
        {
            var _local_1:Class;
            super.createChildren();
            if (!border)
            {
                _local_1 = getStyle("borderSkin");
                border = new (_local_1)();
                if ((border is ISimpleStyleClient))
                {
                    ISimpleStyleClient(border).styleName = this;
                };
                addChild(DisplayObject(border));
            };
            createTextField(-1);
        }

        override protected function measure():void
        {
            var _local_7:Number;
            super.measure();
            var _local_1:EdgeMetrics = borderMetrics;
            var _local_2:Number = (_local_1.left + getStyle("paddingLeft"));
            var _local_3:Number = (_local_1.top + getStyle("paddingTop"));
            var _local_4:Number = (_local_1.right + getStyle("paddingRight"));
            var _local_5:Number = (_local_1.bottom + getStyle("paddingBottom"));
            var _local_6:Number = (_local_2 + _local_4);
            _local_7 = (_local_3 + _local_5);
            textField.wordWrap = false;
            if ((textField.textWidth + _local_6) > ToolTip.maxWidth)
            {
                textField.width = (ToolTip.maxWidth - _local_6);
                textField.wordWrap = true;
            };
            measuredWidth = (textField.width + _local_6);
            measuredHeight = (textField.height + _local_7);
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
            textChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
        }

        public function get text():String
        {
            return (_text);
        }

        mx_internal function removeTextField():void
        {
            if (textField)
            {
                removeChild(DisplayObject(textField));
                textField = null;
            };
        }

        mx_internal function createTextField(_arg_1:int):void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.autoSize = TextFieldAutoSize.LEFT;
                textField.mouseEnabled = false;
                textField.multiline = true;
                textField.selectable = false;
                textField.wordWrap = false;
                textField.styleName = this;
                if (_arg_1 == -1)
                {
                    addChild(DisplayObject(textField));
                }
                else
                {
                    addChildAt(DisplayObject(textField), _arg_1);
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:EdgeMetrics = borderMetrics;
            var _local_4:Number = (_local_3.left + getStyle("paddingLeft"));
            var _local_5:Number = (_local_3.top + getStyle("paddingTop"));
            var _local_6:Number = (_local_3.right + getStyle("paddingRight"));
            var _local_7:Number = (_local_3.bottom + getStyle("paddingBottom"));
            var _local_8:Number = (_local_4 + _local_6);
            var _local_9:Number = (_local_5 + _local_7);
            border.setActualSize(_arg_1, _arg_2);
            textField.move(_local_4, _local_5);
            textField.setActualSize((_arg_1 - _local_8), (_arg_2 - _local_9));
        }

        private function get borderMetrics():EdgeMetrics
        {
            if ((border is IRectangularBorder))
            {
                return (IRectangularBorder(border).borderMetrics);
            };
            return (EdgeMetrics.EMPTY);
        }


    }
}//package mx.controls

