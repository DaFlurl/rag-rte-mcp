// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.LinkButton

package mx.controls
{
    import flash.text.TextLineMetrics;
    import mx.core.FlexVersion;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LinkButton extends Button 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var createAccessibilityImplementation:Function;

        public function LinkButton()
        {
            buttonMode = true;
            extraSpacing = 4;
        }

        override public function set emphasized(_arg_1:Boolean):void
        {
        }

        override protected function measure():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:TextLineMetrics;
            super.measure();
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _local_1 = 8;
                _local_2 = 8;
                if (label)
                {
                    _local_7 = measureText(label);
                    _local_1 = (_local_1 + _local_7.width);
                    _local_2 = (_local_2 + _local_7.height);
                };
                _local_1 = (_local_1 + (getStyle("paddingLeft") + getStyle("paddingRight")));
                viewIcon();
                viewSkin();
                _local_3 = ((currentIcon) ? currentIcon.width : 0);
                _local_4 = ((currentIcon) ? currentIcon.height : 0);
                _local_5 = 0;
                _local_6 = 0;
                if (((labelPlacement == ButtonLabelPlacement.LEFT) || (labelPlacement == ButtonLabelPlacement.RIGHT)))
                {
                    if (((label) && (label.length > 0)))
                    {
                        _local_5 = (_local_1 + _local_3);
                    }
                    else
                    {
                        _local_5 = _local_3;
                    };
                    if (_local_3 != 0)
                    {
                        _local_5 = (_local_5 + getStyle("horizontalGap"));
                    };
                    _local_6 = Math.max(_local_2, _local_4);
                }
                else
                {
                    _local_5 = Math.max(_local_1, _local_3);
                    if (((label) && (label.length > 0)))
                    {
                        _local_6 = (_local_2 + _local_4);
                    }
                    else
                    {
                        _local_6 = _local_4;
                    };
                    if (_local_4 != 0)
                    {
                        _local_6 = (_local_6 + getStyle("verticalGap"));
                    };
                };
                if (((label) && (!(label == ""))))
                {
                    _local_5 = (_local_5 + extraSpacing);
                };
                _local_5 = Math.max(20, _local_5);
                _local_6 = Math.max(14, _local_6);
                measuredMinWidth = (measuredWidth = _local_5);
                measuredMinHeight = (measuredHeight = _local_6);
            };
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            buttonMode = _arg_1;
        }

        override protected function initializeAccessibility():void
        {
            if (createAccessibilityImplementation != null)
            {
                createAccessibilityImplementation(this);
            };
        }


    }
}//package mx.controls

