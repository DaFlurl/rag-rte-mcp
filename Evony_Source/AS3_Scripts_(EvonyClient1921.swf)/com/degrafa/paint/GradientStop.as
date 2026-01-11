// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.GradientStop

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.paint.palette.PaletteEntry;
    import com.degrafa.core.Measure;
    import com.degrafa.core.utils.ColorUtil;
    import mx.events.PropertyChangeEvent;

    [Bindable(event="propertyChange")]
    public class GradientStop extends DegrafaObject 
    {

        private var _color:Object;
        protected var _colorFunction:Function;
        private var _paletteEntry:PaletteEntry;
        private var _ratio:Measure = new Measure(-1, Measure.RATIO);
        private var _alpha:Number = 1;

        public function GradientStop(_arg_1:Object=0, _arg_2:Number=1, _arg_3:Number=-1, _arg_4:String="ratio")
        {
            this.color = _arg_1;
            _alpha = _arg_2;
            _ratio.value = _arg_3;
            _ratio.unit = _arg_4;
        }

        public function set ratioUnit(_arg_1:String):void
        {
            var _local_2:String;
            if (_ratio.unit != _arg_1)
            {
                _local_2 = _ratio.unit;
                _ratio.unit = _arg_1;
                initChange("ratio", _local_2, _ratio.unit, this);
            };
        }

        public function get color():Object
        {
            if (colorFunction != null)
            {
                return (ColorUtil.resolveColor(colorFunction()));
            };
            if (!_color)
            {
                return (0);
            };
            return (_color);
        }

        public function get alpha():Number
        {
            return (_alpha);
        }

        public function set color(_arg_1:Object):void
        {
            var _local_2:uint;
            if ((_arg_1 is PaletteEntry))
            {
                paletteEntry = (_arg_1 as PaletteEntry);
            }
            else
            {
                paletteEntry = null;
            };
            _arg_1 = ColorUtil.resolveColor(_arg_1);
            if (_color != _arg_1)
            {
                _local_2 = (_color as uint);
                _color = (_arg_1 as uint);
                initChange("color", _local_2, _color, this);
            };
        }

        private function onPaletteEntryChange(_arg_1:PropertyChangeEvent):void
        {
            if (((_arg_1.property == "value") && (_arg_1.kind == "update")))
            {
                color = _arg_1.source;
            };
        }

        private function set paletteEntry(_arg_1:PaletteEntry):void
        {
            if (_arg_1)
            {
                if (_paletteEntry !== _arg_1)
                {
                    if (_paletteEntry)
                    {
                        if (_paletteEntry.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
                        {
                            _paletteEntry.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPaletteEntryChange);
                        };
                    };
                    _paletteEntry = _arg_1;
                    if (_paletteEntry.enableEvents)
                    {
                        _paletteEntry.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPaletteEntryChange);
                    };
                };
            }
            else
            {
                if (_paletteEntry)
                {
                    if (_paletteEntry.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
                    {
                        _paletteEntry.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPaletteEntryChange);
                    };
                    _paletteEntry = null;
                };
            };
        }

        public function set ratio(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_ratio.value != _arg_1)
            {
                _local_2 = _ratio.value;
                _ratio.value = _arg_1;
                initChange("ratio", _local_2, _ratio.value, this);
            };
        }

        public function get ratioUnit():String
        {
            return (_ratio.unit);
        }

        public function get ratio():Number
        {
            return (_ratio.value);
        }

        public function get measure():Measure
        {
            return (_ratio);
        }

        public function get colorFunction():Function
        {
            return (_colorFunction);
        }

        public function set alpha(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_alpha != _arg_1)
            {
                _local_2 = _alpha;
                _alpha = _arg_1;
                initChange("alpha", _local_2, _alpha, this);
            };
        }

        public function set colorFunction(_arg_1:Function):void
        {
            var _local_2:Function;
            if (_colorFunction != _arg_1)
            {
                _local_2 = (_colorFunction as Function);
                _colorFunction = (_arg_1 as Function);
                initChange("colorFunction", _local_2, _colorFunction, this);
            };
        }


    }
}//package com.degrafa.paint

