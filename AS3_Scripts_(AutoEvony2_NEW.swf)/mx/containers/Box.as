// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Box

package mx.containers
{
    import mx.core.Container;
    import mx.containers.utilityClasses.BoxLayout;
    import flash.events.Event;
    import mx.core.IUIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Box extends Container 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        mx_internal var layoutObject:BoxLayout = new BoxLayout();

        public function Box()
        {
            layoutObject.target = this;
        }

        mx_internal function isVertical():Boolean
        {
            return (!(direction == BoxDirection.HORIZONTAL));
        }

        public function set direction(_arg_1:String):void
        {
            layoutObject.direction = _arg_1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            layoutObject.updateDisplayList(_arg_1, _arg_2);
        }

        public function pixelsToPercent(_arg_1:Number):Number
        {
            var _local_8:IUIComponent;
            var _local_9:Number;
            var _local_10:Number;
            var _local_2:Boolean = isVertical();
            var _local_3:Number = 0;
            var _local_4:Number = 0;
            var _local_5:int = numChildren;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_8 = IUIComponent(getChildAt(_local_6));
                _local_9 = ((_local_2) ? _local_8.height : _local_8.width);
                _local_10 = ((_local_2) ? _local_8.percentHeight : _local_8.percentWidth);
                if (!isNaN(_local_10))
                {
                    _local_3 = (_local_3 + _local_10);
                    _local_4 = (_local_4 + _local_9);
                };
                _local_6++;
            };
            var _local_7:Number = 100;
            if (_local_4 != _arg_1)
            {
                _local_7 = (((_local_4 * _local_3) / (_local_4 - _arg_1)) - _local_3);
            };
            return (_local_7);
        }

        override protected function measure():void
        {
            super.measure();
            layoutObject.measure();
        }

        [Bindable("directionChanged")]
        public function get direction():String
        {
            return (layoutObject.direction);
        }


    }
}//package mx.containers

