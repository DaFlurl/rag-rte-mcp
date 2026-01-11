// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.VScrollBar

package mx.controls
{
    import mx.controls.scrollClasses.ScrollBar;
    import mx.controls.scrollClasses.ScrollBarDirection;
    import flash.ui.Keyboard;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class VScrollBar extends ScrollBar 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function VScrollBar()
        {
            super.direction = ScrollBarDirection.VERTICAL;
        }

        override protected function measure():void
        {
            super.measure();
            measuredWidth = _minWidth;
            measuredHeight = _minHeight;
        }

        override public function get minHeight():Number
        {
            return (_minHeight);
        }

        override mx_internal function isScrollBarKey(_arg_1:uint):Boolean
        {
            if (_arg_1 == Keyboard.UP)
            {
                lineScroll(-1);
                return (true);
            };
            if (_arg_1 == Keyboard.DOWN)
            {
                lineScroll(1);
                return (true);
            };
            if (_arg_1 == Keyboard.PAGE_UP)
            {
                pageScroll(-1);
                return (true);
            };
            if (_arg_1 == Keyboard.PAGE_DOWN)
            {
                pageScroll(1);
                return (true);
            };
            return (super.isScrollBarKey(_arg_1));
        }

        override public function get minWidth():Number
        {
            return (_minWidth);
        }

        override public function set direction(_arg_1:String):void
        {
        }


    }
}//package mx.controls

