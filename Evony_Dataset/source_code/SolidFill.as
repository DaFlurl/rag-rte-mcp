// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.SolidFill

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IGraphicsFill;
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import com.degrafa.paint.palette.PaletteEntry;
    import com.degrafa.IGeometryComposition;
    import com.degrafa.core.utils.ColorUtil;
    import mx.events.PropertyChangeEvent;

    [Bindable(event="propertyChange")]
    public class SolidFill extends DegrafaObject implements IGraphicsFill 
    {

        private var _lastContext:Graphics;
        private var _lastArgs:Array = [];
        private var _lastRect:Rectangle;
        private var _paletteEntry:PaletteEntry;
        protected var _colorFunction:Function;
        protected var _alpha:Number;
        protected var _color:Object;
        private var _requester:IGeometryComposition;

        public function SolidFill(_arg_1:Object=null, _arg_2:Number=NaN)
        {
            this.alpha = _arg_2;
            this.color = _arg_1;
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

        public function get restartFunction():Function
        {
            var copy:Array;
            var last:Graphics;
            copy = _lastArgs.concat();
            last = _lastContext;
            if (!_lastContext)
            {
                return (function (_arg_1:Graphics=null):void
                {
                    if (_arg_1)
                    {
                        _arg_1.beginFill(copy[0], copy[1]);
                    };
                });
            };
            return (function (_arg_1:Graphics=null):void
            {
                if (_arg_1)
                {
                    _arg_1.beginFill(copy[0], copy[1]);
                }
                else
                {
                    last.beginFill(copy[0], copy[1]);
                };
            });
        }

        public function get lastArgs():Array
        {
            return (_lastArgs);
        }

        public function set derive(_arg_1:SolidFill):void
        {
            if (!_color)
            {
                _color = uint(_arg_1.color);
            };
            if (isNaN(_alpha))
            {
                _alpha = _arg_1.alpha;
            };
        }

        public function get colorFunction():Function
        {
            return (_colorFunction);
        }

        public function get alpha():Number
        {
            if (isNaN(_alpha))
            {
                return (1);
            };
            return (_alpha);
        }

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
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

        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (isNaN(_alpha))
            {
                _alpha = 1;
            };
            _lastArgs.length = 0;
            _lastArgs[0] = (color as uint);
            _lastArgs[1] = alpha;
            _lastContext = _arg_1;
            _lastRect = _arg_2;
            _arg_1.beginFill((color as uint), alpha);
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

        public function set requester(_arg_1:IGeometryComposition):void
        {
            _requester = _arg_1;
        }

        public function get lastRectangle():Rectangle
        {
            return (_lastRect.clone());
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


    }
}//package com.degrafa.paint

