// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.SolidColor

package mx.graphics
{
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class SolidColor extends EventDispatcher implements IFill 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _color:uint = 0;
        private var _alpha:Number = 1;

        public function SolidColor(_arg_1:uint=0, _arg_2:Number=1)
        {
            this.color = _arg_1;
            this.alpha = _arg_2;
        }

        [Bindable("propertyChange")]
        public function get color():uint
        {
            return (_color);
        }

        [Bindable("propertyChange")]
        public function get alpha():Number
        {
            return (_alpha);
        }

        public function set color(_arg_1:uint):void
        {
            var _local_2:uint = _color;
            if (_arg_1 != _local_2)
            {
                _color = _arg_1;
                dispatchFillChangedEvent("color", _local_2, _arg_1);
            };
        }

        private function dispatchFillChangedEvent(_arg_1:String, _arg_2:*, _arg_3:*):void
        {
            dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, _arg_1, _arg_2, _arg_3));
        }

        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            _arg_1.beginFill(color, alpha);
        }

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
        }

        public function set alpha(_arg_1:Number):void
        {
            var _local_2:Number = _alpha;
            if (_arg_1 != _local_2)
            {
                _alpha = _arg_1;
                dispatchFillChangedEvent("alpha", _local_2, _arg_1);
            };
        }


    }
}//package mx.graphics

