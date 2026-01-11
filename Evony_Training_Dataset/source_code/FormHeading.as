// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.FormHeading

package mx.containers
{
    import mx.core.UIComponent;
    import mx.controls.Label;
    import mx.core.EdgeMetrics;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class FormHeading extends UIComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var labelObj:Label;
        private var _label:String = "";


        private function getLabelWidth():Number
        {
            var _local_1:Number = getStyle("labelWidth");
            if (_local_1 == 0)
            {
                _local_1 = NaN;
            };
            if (((isNaN(_local_1)) && (parent is Form)))
            {
                _local_1 = Form(parent).calculateLabelWidth();
            };
            if (isNaN(_local_1))
            {
                _local_1 = 0;
            };
            return (_local_1);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();
            createLabel();
        }

        [Bindable("labelChanged")]
        public function get label():String
        {
            return (_label);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:EdgeMetrics;
            super.updateDisplayList(_arg_1, _arg_2);
            if (labelObj)
            {
                _local_3 = getStyle("indicatorGap");
                _local_4 = getStyle("paddingTop");
                _local_5 = width;
                labelObj.move((getLabelWidth() + _local_3), _local_4);
                if (((parent) && (parent is Form)))
                {
                    _local_6 = Form(parent).viewMetricsAndPadding;
                    _local_5 = (parent.width - (((getLabelWidth() + _local_3) + _local_6.left) + _local_6.right));
                };
                labelObj.setActualSize(_local_5, height);
            };
        }

        public function set label(_arg_1:String):void
        {
            _label = _arg_1;
            invalidateProperties();
            dispatchEvent(new Event("labelChanged"));
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:Number = 0;
            var _local_2:Number = getStyle("paddingTop");
            if (labelObj)
            {
                if (isNaN(labelObj.measuredWidth))
                {
                    labelObj.validateSize();
                };
                _local_1 = labelObj.measuredWidth;
                _local_2 = (_local_2 + labelObj.measuredHeight);
            };
            _local_1 = (_local_1 + (getLabelWidth() + getStyle("indicatorGap")));
            measuredMinWidth = _local_1;
            measuredMinHeight = _local_2;
            measuredWidth = _local_1;
            measuredHeight = _local_2;
        }

        private function createLabel():void
        {
            if (((_label) && (_label.length > 0)))
            {
                if (!labelObj)
                {
                    labelObj = new Label();
                    labelObj.styleName = this;
                    addChild(labelObj);
                };
                if (labelObj.text != _label)
                {
                    labelObj.text = _label;
                    labelObj.validateSize();
                    invalidateSize();
                    invalidateDisplayList();
                };
            };
            if ((((_label == null) || (_label.length == 0)) && (labelObj)))
            {
                removeChild(labelObj);
                labelObj = null;
                invalidateSize();
                invalidateDisplayList();
            };
        }


    }
}//package mx.containers

