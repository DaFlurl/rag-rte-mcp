// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Form

package mx.containers
{
    import mx.core.Container;
    import mx.containers.utilityClasses.BoxLayout;
    import mx.core.mx_internal;
    import mx.styles.StyleManager;
    import flash.display.DisplayObject;
    import mx.core.IUIComponent;
    import mx.core.IInvalidating;
    import mx.controls.Label;

    use namespace mx_internal;

    public class Form extends Container 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var classInitialized:Boolean = false;

        mx_internal var layoutObject:BoxLayout = new BoxLayout();
        private var measuredLabelWidth:Number;

        public function Form()
        {
            if (!classInitialized)
            {
                initializeClass();
                classInitialized = true;
            };
            showInAutomationHierarchy = true;
            mx_internal::layoutObject.target = this;
            mx_internal::layoutObject.direction = BoxDirection.VERTICAL;
        }

        private static function initializeClass():void
        {
            StyleManager.registerInheritingStyle("labelWidth");
            StyleManager.registerSizeInvalidatingStyle("labelWidth");
            StyleManager.registerInheritingStyle("indicatorGap");
            StyleManager.registerSizeInvalidatingStyle("indicatorGap");
        }


        override public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            invalidateLabelWidth();
            return (super.addChild(_arg_1));
        }

        override public function styleChanged(_arg_1:String):void
        {
            if ((((!(_arg_1)) || (_arg_1 == "styleName")) || (StyleManager.isSizeInvalidatingStyle(_arg_1))))
            {
                invalidateLabelWidth();
            };
            super.styleChanged(_arg_1);
        }

        override public function removeChildAt(_arg_1:int):DisplayObject
        {
            invalidateLabelWidth();
            return (super.removeChildAt(_arg_1));
        }

        internal function calculateLabelWidth():Number
        {
            var _local_5:DisplayObject;
            if (!isNaN(measuredLabelWidth))
            {
                return (measuredLabelWidth);
            };
            var _local_1:Number = 0;
            var _local_2:Boolean;
            var _local_3:int = numChildren;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = getChildAt(_local_4);
                if (((_local_5 is FormItem) && (FormItem(_local_5).includeInLayout)))
                {
                    _local_1 = Math.max(_local_1, FormItem(_local_5).getPreferredLabelWidth());
                    _local_2 = true;
                };
                _local_4++;
            };
            if (_local_2)
            {
                measuredLabelWidth = _local_1;
            };
            return (_local_1);
        }

        internal function invalidateLabelWidth():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:IUIComponent;
            if (((!(isNaN(measuredLabelWidth))) && (initialized)))
            {
                measuredLabelWidth = NaN;
                _local_1 = numChildren;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    _local_3 = IUIComponent(getChildAt(_local_2));
                    if ((_local_3 is IInvalidating))
                    {
                        IInvalidating(_local_3).invalidateSize();
                    };
                    _local_2++;
                };
            };
        }

        [Bindable("updateComplete")]
        public function get maxLabelWidth():Number
        {
            var _local_3:DisplayObject;
            var _local_4:Label;
            var _local_1:int = numChildren;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                _local_3 = getChildAt(_local_2);
                if ((_local_3 is FormItem))
                {
                    _local_4 = FormItem(_local_3).itemLabel;
                    if (_local_4)
                    {
                        return (_local_4.width);
                    };
                };
                _local_2++;
            };
            return (0);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            mx_internal::layoutObject.updateDisplayList(_arg_1, _arg_2);
        }

        override public function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject
        {
            invalidateLabelWidth();
            return (super.addChildAt(_arg_1, _arg_2));
        }

        override protected function measure():void
        {
            super.measure();
            mx_internal::layoutObject.measure();
            calculateLabelWidth();
        }

        override public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            invalidateLabelWidth();
            return (super.removeChild(_arg_1));
        }


    }
}//package mx.containers

