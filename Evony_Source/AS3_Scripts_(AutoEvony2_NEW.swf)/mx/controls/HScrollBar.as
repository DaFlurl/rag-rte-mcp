// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.HScrollBar

package mx.controls
{
    import mx.controls.scrollClasses.ScrollBar;
    import mx.controls.scrollClasses.ScrollBarDirection;
    import flash.ui.Keyboard;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HScrollBar extends ScrollBar 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function HScrollBar()
        {
            super.direction = ScrollBarDirection.HORIZONTAL;
            scaleX = -1;
            rotation = -90;
        }

        override mx_internal function get virtualHeight():Number
        {
            return (unscaledWidth);
        }

        override protected function measure():void
        {
            super.measure();
            measuredWidth = _minHeight;
            measuredHeight = _minWidth;
        }

        override public function get minHeight():Number
        {
            return (_minWidth);
        }

        override mx_internal function get virtualWidth():Number
        {
            return (unscaledHeight);
        }

        override public function get minWidth():Number
        {
            return (_minHeight);
        }

        override mx_internal function isScrollBarKey(_arg_1:uint):Boolean
        {
            if (_arg_1 == Keyboard.LEFT)
            {
                lineScroll(-1);
                return (true);
            };
            if (_arg_1 == Keyboard.RIGHT)
            {
                lineScroll(1);
                return (true);
            };
            return (super.isScrollBarKey(_arg_1));
        }

        override public function set direction(_arg_1:String):void
        {
        }


    }
}//package mx.controls

