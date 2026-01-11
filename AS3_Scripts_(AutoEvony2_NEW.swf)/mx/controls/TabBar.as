// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.TabBar

package mx.controls
{
    import mx.core.ClassFactory;
    import mx.controls.tabBarClasses.Tab;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import mx.core.IFlexDisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TabBar extends ToggleButtonBar 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        mx_internal static var createAccessibilityImplementation:Function;

        public function TabBar()
        {
            buttonHeightProp = "tabHeight";
            buttonStyleNameProp = "tabStyleName";
            firstButtonStyleNameProp = "firstTabStyleName";
            lastButtonStyleNameProp = "lastTabStyleName";
            buttonWidthProp = "tabWidth";
            navItemFactory = new ClassFactory(Tab);
            selectedButtonTextStyleNameProp = "selectedTabTextStyleName";
        }

        override protected function clickHandler(_arg_1:MouseEvent):void
        {
            if (getChildIndex(DisplayObject(_arg_1.currentTarget)) == selectedIndex)
            {
                Button(_arg_1.currentTarget).selected = true;
                _arg_1.stopImmediatePropagation();
                return;
            };
            super.clickHandler(_arg_1);
        }

        override protected function createNavItem(_arg_1:String, _arg_2:Class=null):IFlexDisplayObject
        {
            var _local_3:IFlexDisplayObject = super.createNavItem(_arg_1, _arg_2);
            DisplayObject(_local_3).addEventListener(MouseEvent.MOUSE_DOWN, tab_mouseDownHandler);
            DisplayObject(_local_3).addEventListener(MouseEvent.DOUBLE_CLICK, tab_doubleClickHandler);
            return (_local_3);
        }

        private function tab_doubleClickHandler(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).selected = true;
        }

        private function tab_mouseDownHandler(_arg_1:MouseEvent):void
        {
            selectButton(_arg_1.currentTarget.parent.getChildIndex(_arg_1.currentTarget), true, _arg_1);
        }

        override protected function initializeAccessibility():void
        {
            if (TabBar.createAccessibilityImplementation != null)
            {
                TabBar.createAccessibilityImplementation(this);
            };
        }


    }
}//package mx.controls

