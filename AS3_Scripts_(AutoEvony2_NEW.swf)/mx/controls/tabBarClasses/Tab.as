// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.tabBarClasses.Tab

package mx.controls.tabBarClasses
{
    import mx.controls.Button;
    import mx.core.IFlexDisplayObject;
    import flash.display.DisplayObject;
    import mx.styles.ISimpleStyleClient;
    import mx.core.IStateClient;
    import mx.core.IProgrammaticSkin;
    import flash.text.TextLineMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Tab extends Button 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var focusSkin:IFlexDisplayObject;

        public function Tab()
        {
            focusEnabled = false;
        }

        override public function drawFocus(_arg_1:Boolean):void
        {
            var _local_2:Boolean;
            var _local_3:Class;
            if ((((_arg_1) && (!(selected))) && (!(isEffectStarted))))
            {
                if (!focusSkin)
                {
                    _local_2 = false;
                    _local_3 = getStyle(overSkinName);
                    if (!_local_3)
                    {
                        _local_3 = getStyle(skinName);
                        _local_2 = true;
                    };
                    if (_local_3)
                    {
                        focusSkin = new (_local_3)();
                        DisplayObject(focusSkin).name = overSkinName;
                        if ((focusSkin is ISimpleStyleClient))
                        {
                            ISimpleStyleClient(focusSkin).styleName = this;
                        };
                        addChild(DisplayObject(focusSkin));
                        if ((((_local_2) && (!(focusSkin is IProgrammaticSkin))) && (focusSkin is IStateClient)))
                        {
                            IStateClient(focusSkin).currentState = "over";
                        };
                    };
                };
                invalidateDisplayList();
                validateNow();
            }
            else
            {
                if (focusSkin)
                {
                    removeChild(DisplayObject(focusSkin));
                    focusSkin = null;
                };
            };
        }

        override mx_internal function layoutContents(_arg_1:Number, _arg_2:Number, _arg_3:Boolean):void
        {
            super.layoutContents(_arg_1, _arg_2, _arg_3);
            if (selected)
            {
                textField.y++;
                if (currentIcon)
                {
                    currentIcon.y++;
                };
            };
            if (currentSkin)
            {
                setChildIndex(DisplayObject(currentSkin), (numChildren - 1));
            };
            if (((focusSkin) && (!(selected))))
            {
                focusSkin.setActualSize(_arg_1, _arg_2);
                setChildIndex(DisplayObject(focusSkin), (numChildren - 1));
            };
            if (currentIcon)
            {
                setChildIndex(DisplayObject(currentIcon), (numChildren - 1));
            };
            if (textField)
            {
                setChildIndex(DisplayObject(textField), (numChildren - 1));
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (currentIcon)
            {
                currentIcon.scaleX = 1;
                currentIcon.scaleY = 1;
            };
            viewIcon();
        }

        override public function measureText(_arg_1:String):TextLineMetrics
        {
            return ((textField.styleName == this) ? super.measureText(_arg_1) : textField.getUITextFormat().measureText(_arg_1));
        }

        override mx_internal function viewIcon():void
        {
            var _local_1:Number;
            super.viewIcon();
            if (currentIcon)
            {
                if (((!(height == 0)) && (currentIcon.height > (height - 4))))
                {
                    _local_1 = ((height - 4) / currentIcon.height);
                    currentIcon.scaleX = _local_1;
                    currentIcon.scaleY = _local_1;
                    invalidateSize();
                    if (height > 0)
                    {
                        layoutContents(width, height, false);
                    };
                };
            };
        }


    }
}//package mx.controls.tabBarClasses

