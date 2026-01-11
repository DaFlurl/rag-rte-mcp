// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.GradientEntry

package mx.graphics
{
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GradientEntry extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _color:uint;
        private var _ratio:Number;
        private var _alpha:Number = 1;

        public function GradientEntry(_arg_1:uint=0, _arg_2:Number=-1, _arg_3:Number=1)
        {
            this.color = _arg_1;
            if (_arg_2 >= 0)
            {
                this.ratio = _arg_2;
            };
            this.alpha = _arg_3;
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
                dispatchEntryChangedEvent("color", _local_2, _arg_1);
            };
        }

        [Bindable("propertyChange")]
        public function get ratio():Number
        {
            return (_ratio);
        }

        private function dispatchEntryChangedEvent(_arg_1:String, _arg_2:*, _arg_3:*):void
        {
            dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, _arg_1, _arg_2, _arg_3));
        }

        public function set ratio(_arg_1:Number):void
        {
            var _local_2:Number = _ratio;
            if (_arg_1 != _local_2)
            {
                _ratio = _arg_1;
                dispatchEntryChangedEvent("ratio", _local_2, _arg_1);
            };
        }

        public function set alpha(_arg_1:Number):void
        {
            var _local_2:Number = _alpha;
            if (_arg_1 != _local_2)
            {
                _alpha = _arg_1;
                dispatchEntryChangedEvent("alpha", _local_2, _arg_1);
            };
        }


    }
}//package mx.graphics

