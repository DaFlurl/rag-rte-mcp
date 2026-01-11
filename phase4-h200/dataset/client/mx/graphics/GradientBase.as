// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.GradientBase

package mx.graphics
{
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GradientBase extends EventDispatcher 
    {

        mx_internal var colors:Array = [];
        mx_internal var ratios:Array = [];
        mx_internal var alphas:Array = [];
        private var _entries:Array = [];


        public function set entries(_arg_1:Array):void
        {
            var _local_2:Array = _entries;
            _entries = _arg_1;
            processEntries();
            dispatchGradientChangedEvent("entries", _local_2, _arg_1);
        }

        private function processEntries():void
        {
            var _local_2:int;
            var _local_4:GradientEntry;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:int;
            colors = [];
            ratios = [];
            alphas = [];
            if (((!(_entries)) || (_entries.length == 0)))
            {
                return;
            };
            var _local_1:Number = 0xFF;
            var _local_3:int = _entries.length;
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _local_4 = _entries[_local_2];
                _local_4.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, entry_propertyChangeHandler, false, 0, true);
                colors.push(_local_4.color);
                alphas.push(_local_4.alpha);
                ratios.push((_local_4.ratio * _local_1));
                _local_2++;
            };
            if (isNaN(ratios[0]))
            {
                ratios[0] = 0;
            };
            if (isNaN(ratios[(_local_3 - 1)]))
            {
                ratios[(_local_3 - 1)] = 0xFF;
            };
            _local_2 = 1;
            while (true)
            {
                while (((_local_2 < _local_3) && (!(isNaN(ratios[_local_2])))))
                {
                    _local_2++;
                };
                if (_local_2 == _local_3) break;
                _local_5 = (_local_2 - 1);
                while (((_local_2 < _local_3) && (isNaN(ratios[_local_2]))))
                {
                    _local_2++;
                };
                _local_6 = ratios[_local_5];
                _local_7 = ratios[_local_2];
                _local_8 = 1;
                while (_local_8 < (_local_2 - _local_5))
                {
                    ratios[_local_8] = (_local_6 + ((_local_8 * (_local_7 - _local_6)) / (_local_2 - _local_5)));
                    _local_8++;
                };
            };
        }

        mx_internal function dispatchGradientChangedEvent(_arg_1:String, _arg_2:*, _arg_3:*):void
        {
            dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, _arg_1, _arg_2, _arg_3));
        }

        private function entry_propertyChangeHandler(_arg_1:Event):void
        {
            processEntries();
            dispatchGradientChangedEvent("entries", entries, entries);
        }

        [Bindable("propertyChange")]
        public function get entries():Array
        {
            return (_entries);
        }


    }
}//package mx.graphics

