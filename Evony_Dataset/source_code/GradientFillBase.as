// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.GradientFillBase

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.ITransformablePaint;
    import flash.geom.Rectangle;
    import com.degrafa.core.collections.GradientStopsCollection;
    import com.degrafa.transform.ITransform;
    import flash.display.Graphics;
    import com.degrafa.IGeometryComposition;
    import mx.events.PropertyChangeEvent;
    import flash.geom.Matrix;
    import com.degrafa.geometry.Geometry;
    import flash.geom.Point;

    [Bindable(event="propertyChange")]
    public class GradientFillBase extends DegrafaObject implements ITransformablePaint 
    {

        private var _lastRect:Rectangle;
        protected var _spreadMethod:String;
        protected var _blendMode:String;
        protected var _coordType:String = "absolute";
        protected var _angle:Number;
        protected var _gradientStops:GradientStopsCollection;
        protected var _interpolationMethod:String;
        protected var _gradientType:String;
        protected var _transform:ITransform;
        protected var _focalPointRatio:Number;
        private var _lastContext:Graphics;
        protected var _requester:IGeometryComposition;

        protected var _colors:Array = [];
        protected var _ratios:Array = [];
        protected var _alphas:Array = [];
        private var _lastArgs:Array = [];


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
                });
            };
            return (function (_arg_1:Graphics=null):void
            {
                if (_arg_1)
                {
                    _arg_1.beginGradientFill.apply(_arg_1, copy);
                }
                else
                {
                    last.beginGradientFill.apply(last, copy);
                };
            });
        }

        public function get gradientType():String
        {
            if (!_gradientType)
            {
                return ("linear");
            };
            return (_gradientType);
        }

        public function get blendMode():String
        {
            if (!_blendMode)
            {
                return (null);
            };
            return (_blendMode);
        }

        public function get lastArgs():Array
        {
            return (_lastArgs);
        }

        public function set gradientType(_arg_1:String):void
        {
            var _local_2:String;
            if (_gradientType != _arg_1)
            {
                _local_2 = _gradientType;
                _gradientType = _arg_1;
                initChange("gradientType", _local_2, _gradientType, this);
            };
        }

        public function get focalPointRatio():Number
        {
            if (!_focalPointRatio)
            {
                return (0);
            };
            return (_focalPointRatio);
        }

        protected function processEntries(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_5:GradientStop;
            var _local_6:Number;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:int;
            _colors = [];
            _ratios = [];
            _alphas = [];
            if (((!(_gradientStops)) || (_gradientStops.items.length == 0)))
            {
                return;
            };
            var _local_2:Number = 0xFF;
            var _local_4:int = _gradientStops.items.length;
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_5 = _gradientStops.items[_local_3];
                _colors.push(_local_5.color);
                _alphas.push(_local_5.alpha);
                if (((!(_local_5.measure == null)) && (_local_5.measure.value >= 0)))
                {
                    _local_6 = (_local_5.measure.relativeTo(_arg_1) / _arg_1);
                    _ratios.push((Math.min(_local_6, 1) * _local_2));
                }
                else
                {
                    _ratios.push(NaN);
                };
                _local_3++;
            };
            if (isNaN(_ratios[0]))
            {
                _ratios[0] = 0;
            };
            if (isNaN(_ratios[(_local_4 - 1)]))
            {
                _ratios[(_local_4 - 1)] = 0xFF;
            };
            _local_3 = 1;
            while (true)
            {
                while (((_local_3 < _local_4) && (!(isNaN(_ratios[_local_3])))))
                {
                    _local_3++;
                };
                if (_local_3 == _local_4) break;
                _local_7 = (_local_3 - 1);
                while (((_local_3 < _local_4) && (isNaN(_ratios[_local_3]))))
                {
                    _local_3++;
                };
                _local_8 = _ratios[_local_7];
                _local_9 = _ratios[_local_3];
                _local_10 = 1;
                while (_local_10 < (_local_3 - _local_7))
                {
                    _ratios[_local_10] = (_local_8 + ((_local_10 * (_local_9 - _local_8)) / (_local_3 - _local_7)));
                    _local_10++;
                };
            };
        }

        public function set coordinateType(_arg_1:String):void
        {
            if (_arg_1 != _coordType)
            {
                initChange("coordinateType", _coordType, (_coordType = _arg_1), this);
            };
        }

        private function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            dispatchEvent(_arg_1);
        }

        public function set angle(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_angle != _arg_1)
            {
                _local_2 = _angle;
                _angle = _arg_1;
                initChange("angle", _local_2, _angle, this);
            };
        }

        public function set blendMode(_arg_1:String):void
        {
            if (_blendMode != _arg_1)
            {
                initChange("blendMode", _blendMode, (_blendMode = _arg_1), this);
            };
        }

        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:Matrix;
            var _local_4:ITransform;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Geometry;
            var _local_8:Point;
            var _local_9:Matrix;
            if (!_angle)
            {
                _angle = 0;
            };
            if (!_focalPointRatio)
            {
                _focalPointRatio = 0;
            };
            if (!_spreadMethod)
            {
                _spreadMethod = "pad";
            };
            if (!_interpolationMethod)
            {
                _interpolationMethod = "rgb";
            };
            _local_3 = new Matrix();
            if (_arg_2)
            {
                _local_3.createGradientBox(_arg_2.width, _arg_2.height, ((_angle / 180) * Math.PI), _arg_2.x, _arg_2.y);
                _local_5 = ((angle % 90) / 90);
                _local_6 = (1 - _local_5);
                processEntries(((_arg_2.width * _local_5) + (_arg_2.height * _local_6)));
            };
            if (((_requester) && ((_requester as Geometry).hasLayout)))
            {
                _local_7 = (_requester as Geometry);
                if (_local_7._layoutMatrix)
                {
                    _local_3.concat(_local_7._layoutMatrix);
                };
            };
            if (((_transform) && (!(_transform.isIdentity))))
            {
                _local_9 = new Matrix();
                _local_8 = _transform.getRegPointForRectangle(_arg_2);
                _local_9.translate(-(_local_8.x), -(_local_8.y));
                _local_9.concat(_transform.transformMatrix);
                _local_9.translate(_local_8.x, _local_8.y);
                _local_3.concat(_local_9);
            };
            if (((_requester) && ((_local_4 = (_requester as Geometry).transform) || ((_requester as Geometry).transformContext))))
            {
                if (_local_4)
                {
                    _local_3.concat(_local_4.getTransformFor(_requester));
                }
                else
                {
                    _local_3.concat((_requester as Geometry).transformContext);
                };
                _requester = null;
            };
            _lastArgs.length = 0;
            _lastArgs[0] = gradientType;
            _lastArgs[1] = _colors;
            _lastArgs[2] = _alphas;
            _lastArgs[3] = _ratios;
            _lastArgs[4] = _local_3;
            _lastArgs[5] = spreadMethod;
            _lastArgs[6] = interpolationMethod;
            _lastArgs[7] = focalPointRatio;
            _lastContext = _arg_1;
            _lastRect = _arg_2;
            _arg_1.beginGradientFill(gradientType, _colors, _alphas, _ratios, _local_3, spreadMethod, interpolationMethod, focalPointRatio);
        }

        public function get interpolationMethod():String
        {
            if (!_interpolationMethod)
            {
                return ("rgb");
            };
            return (_interpolationMethod);
        }

        private function initGradientStopsCollection():void
        {
            if (!_gradientStops)
            {
                _gradientStops = new GradientStopsCollection();
                if (enableEvents)
                {
                    _gradientStops.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        public function get spreadMethod():String
        {
            if (!_spreadMethod)
            {
                return ("pad");
            };
            return (_spreadMethod);
        }

        public function set focalPointRatio(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_focalPointRatio != _arg_1)
            {
                _local_2 = _focalPointRatio;
                _focalPointRatio = _arg_1;
                initChange("focalPointRatio", _local_2, _focalPointRatio, this);
            };
        }

        public function set gradientStops(_arg_1:Array):void
        {
            initGradientStopsCollection();
            _gradientStops.items = _arg_1;
        }

        public function set interpolationMethod(_arg_1:String):void
        {
            var _local_2:String;
            if (_interpolationMethod != _arg_1)
            {
                _local_2 = _interpolationMethod;
                _interpolationMethod = _arg_1;
                initChange("interpolationMethod", _local_2, _interpolationMethod, this);
            };
        }

        public function get angle():Number
        {
            if (!_angle)
            {
                return (0);
            };
            return (_angle);
        }

        public function set transform(_arg_1:ITransform):void
        {
            var _local_2:Object;
            if (_transform != _arg_1)
            {
                _local_2 = _transform;
                if (_transform)
                {
                    if (_transform.hasEventManager)
                    {
                        _transform.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    };
                };
                _transform = _arg_1;
                if (enableEvents)
                {
                    _transform.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
                initChange("transform", _local_2, _transform, this);
            };
        }

        public function get coordinateType():String
        {
            return (_coordType);
        }

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
        }

        public function get gradientStopsCollection():GradientStopsCollection
        {
            initGradientStopsCollection();
            return (_gradientStops);
        }

        public function get gradientStops():Array
        {
            initGradientStopsCollection();
            return (_gradientStops.items);
        }

        public function set spreadMethod(_arg_1:String):void
        {
            var _local_2:String;
            if (_spreadMethod != _arg_1)
            {
                _local_2 = _spreadMethod;
                _spreadMethod = _arg_1;
                initChange("spreadMethod", _local_2, _spreadMethod, this);
            };
        }

        public function get transform():ITransform
        {
            return (_transform);
        }

        public function get lastRectangle():Rectangle
        {
            return (_lastRect.clone());
        }

        public function set requester(_arg_1:IGeometryComposition):void
        {
            _requester = _arg_1;
        }


    }
}//package com.degrafa.paint

