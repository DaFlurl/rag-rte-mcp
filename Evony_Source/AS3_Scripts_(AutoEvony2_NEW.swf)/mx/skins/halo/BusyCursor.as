// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.BusyCursor

package mx.skins.halo
{
    import mx.core.FlexSprite;
    import flash.display.Shape;
    import flash.display.Graphics;
    import mx.styles.StyleManager;
    import mx.styles.CSSStyleDeclaration;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import mx.core.FlexShape;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BusyCursor extends FlexSprite 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var hourHand:Shape;
        private var minuteHand:Shape;

        public function BusyCursor()
        {
            var _local_6:Graphics;
            super();
            var _local_1:CSSStyleDeclaration = StyleManager.getStyleDeclaration("CursorManager");
            var _local_2:Class = _local_1.getStyle("busyCursorBackground");
            var _local_3:DisplayObject = new (_local_2)();
            if ((_local_3 is InteractiveObject))
            {
                InteractiveObject(_local_3).mouseEnabled = false;
            };
            addChild(_local_3);
            var _local_4:Number = -0.5;
            var _local_5:Number = -0.5;
            minuteHand = new FlexShape();
            minuteHand.name = "minuteHand";
            _local_6 = minuteHand.graphics;
            _local_6.beginFill(0);
            _local_6.moveTo(_local_4, _local_5);
            _local_6.lineTo((1 + _local_4), (0 + _local_5));
            _local_6.lineTo((1 + _local_4), (5 + _local_5));
            _local_6.lineTo((0 + _local_4), (5 + _local_5));
            _local_6.lineTo((0 + _local_4), (0 + _local_5));
            _local_6.endFill();
            addChild(minuteHand);
            hourHand = new FlexShape();
            hourHand.name = "hourHand";
            _local_6 = hourHand.graphics;
            _local_6.beginFill(0);
            _local_6.moveTo(_local_4, _local_5);
            _local_6.lineTo((4 + _local_4), (0 + _local_5));
            _local_6.lineTo((4 + _local_4), (1 + _local_5));
            _local_6.lineTo((0 + _local_4), (1 + _local_5));
            _local_6.lineTo((0 + _local_4), (0 + _local_5));
            _local_6.endFill();
            addChild(hourHand);
            addEventListener(Event.ADDED, handleAdded);
            addEventListener(Event.REMOVED, handleRemoved);
        }

        private function enterFrameHandler(_arg_1:Event):void
        {
            minuteHand.rotation = (minuteHand.rotation + 12);
            hourHand.rotation = (hourHand.rotation + 1);
        }

        private function handleAdded(_arg_1:Event):void
        {
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function handleRemoved(_arg_1:Event):void
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }


    }
}//package mx.skins.halo

