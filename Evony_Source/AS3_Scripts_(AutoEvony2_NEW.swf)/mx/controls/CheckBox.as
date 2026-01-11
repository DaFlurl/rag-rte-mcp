// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.CheckBox

package mx.controls
{
    import mx.core.IToggleButton;
    import mx.core.FlexVersion;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CheckBox extends Button implements IToggleButton 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;

        public function CheckBox()
        {
            _toggle = true;
            centerContent = false;
            extraSpacing = 8;
        }

        override public function set toggle(_arg_1:Boolean):void
        {
        }

        override public function set emphasized(_arg_1:Boolean):void
        {
        }

        override protected function initializeAccessibility():void
        {
            if (CheckBox.createAccessibilityImplementation != null)
            {
                CheckBox.createAccessibilityImplementation(this);
            };
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
                _local_3 = 0;
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


    }
}//package mx.controls

