// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.ComplexFill

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IGraphicsFill;
    import com.degrafa.core.IBlend;
    import com.degrafa.core.ITransformablePaint;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import com.degrafa.transform.ITransform;
    import flash.geom.Rectangle;
    import com.degrafa.IGeometryComposition;
    import mx.graphics.IFill;
    import mx.events.PropertyChangeEvent;
    import flash.geom.Matrix;
    import com.degrafa.geometry.Geometry;
    import flash.geom.Point;

    public class ComplexFill extends DegrafaObject implements IGraphicsFill, IBlend, ITransformablePaint 
    {

        private var fillsChanged:Boolean;
        private var _lastContext:Graphics;
        private var _lastArgs:Array = [];
        private var _fills:Array;
        private var _blendMode:String = "normal";
        private var bitmapData:BitmapData;
        private var shape:Shape;
        protected var _transform:ITransform;
        private var _lastRect:Rectangle;
        private var _requester:IGeometryComposition;

        public function ComplexFill(_arg_1:Array=null)
        {
            shape = new Shape();
            this.fills = _arg_1;
        }

        public static function add(_arg_1:IFill, _arg_2:ComplexFill):void
        {
            var _local_4:IFill;
            var _local_3:ComplexFill = _arg_2;
            if (_local_3 == null)
            {
                _local_3 = new (ComplexFill)();
            };
            if (_local_3.fills == null)
            {
                _local_3.fills = new Array();
            };
            if ((_arg_1 is ComplexFill))
            {
                for each (_local_4 in (_arg_1 as ComplexFill).fills)
                {
                    _local_3.fills.push(_local_4);
                    _local_3.refresh();
                };
            }
            else
            {
                if (_arg_1 != null)
                {
                    _local_3.fills.push(_arg_1);
                    _local_3.refresh();
                };
            };
        }


        public function get lastRectangle():Rectangle
        {
            return ((_lastRect) ? _lastRect.clone() : null);
        }

        private function addFillListeners(_arg_1:Array):void
        {
            var _local_2:IGraphicsFill;
            for each (_local_2 in _arg_1)
            {
                if ((_local_2 is IGraphicsFill))
                {
                    (_local_2 as IGraphicsFill).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
            };
        }

        private function removeFillListeners(_arg_1:Array):void
        {
            var _local_2:IGraphicsFill;
            for each (_local_2 in _arg_1)
            {
                if ((_local_2 is IGraphicsFill))
                {
                    (_local_2 as IGraphicsFill).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false);
                };
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
                    last.beginBitmapFill.apply(last, copy);
                };
            });
        }

        public function get fills():Array
        {
            return (_fills);
        }

        public function get lastArgs():Array
        {
            return (_lastArgs);
        }

        public function get blendMode():String
        {
            return (_blendMode);
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

        public function set fills(_arg_1:Array):void
        {
            if (_fills != _arg_1)
            {
                removeFillListeners(_fills);
                addFillListeners((_fills = _arg_1));
                fillsChanged = true;
            };
        }

        private function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            refresh();
            dispatchEvent(_arg_1);
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
            var _local_5:Graphics;
            var _local_6:String;
            var _local_7:IFill;
            var _local_8:Geometry;
            var _local_9:Point;
            var _local_10:Matrix;
            if (((((_arg_2.width > 0) && (_arg_2.height > 0)) && (!(_fills == null))) && (_fills.length > 0)))
            {
                if (_fills.length == 1)
                {
                    if ((_fills[0] is ITransformablePaint))
                    {
                        (_fills[0] as ITransformablePaint).requester = _requester;
                    };
                    (_fills[0] as IFill).begin(_arg_1, _arg_2);
                }
                else
                {
                    _local_3 = new Matrix(1, 0, 0, 1, (_arg_2.x * -1), (_arg_2.y * -1));
                    if (((((fillsChanged) || (bitmapData == null)) || (!(Math.ceil(_arg_2.width) == bitmapData.width))) || (!(Math.ceil(_arg_2.height) == bitmapData.height))))
                    {
                        bitmapData = new BitmapData(Math.ceil(_arg_2.width), Math.ceil(_arg_2.height), true, 0);
                        _local_5 = shape.graphics;
                        _local_5.clear();
                        for each (_local_7 in _fills)
                        {
                            if ((_local_7 is IBlend))
                            {
                                if (_local_6 == "fill")
                                {
                                    bitmapData.draw(shape, _local_3, null, null, null, true);
                                };
                                _local_5.clear();
                                _local_7.begin(_local_5, _arg_2);
                                _local_5.drawRect(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height);
                                _local_7.end(_local_5);
                                bitmapData.draw(shape, _local_3, null, (_local_7 as IBlend).blendMode, null, true);
                                _local_6 = "blend";
                            }
                            else
                            {
                                _local_7.begin(_local_5, _arg_2);
                                _local_5.drawRect(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height);
                                _local_7.end(_local_5);
                                _local_6 = "fill";
                            };
                        };
                        if (_local_6 == "fill")
                        {
                            bitmapData.draw(shape, _local_3);
                        };
                        fillsChanged = false;
                    };
                    _local_3.invert();
                    if (((_requester) && ((_requester as Geometry).hasLayout)))
                    {
                        _local_8 = (_requester as Geometry);
                        if (_local_8._layoutMatrix)
                        {
                            _local_3.concat(_local_8._layoutMatrix);
                        };
                    };
                    if (((_transform) && (!(_transform.isIdentity))))
                    {
                        _local_10 = new Matrix();
                        _local_9 = _transform.getRegPointForRectangle(_arg_2);
                        _local_10.translate(-(_local_9.x), -(_local_9.y));
                        _local_10.concat(_transform.transformMatrix);
                        _local_10.translate(_local_9.x, _local_9.y);
                        _local_3.concat(_local_10);
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
                    _lastArgs[0] = bitmapData;
                    _lastArgs[1] = _local_3;
                    _lastRect = _arg_2;
                    _arg_1.beginBitmapFill(bitmapData, _local_3);
                };
            };
        }

        public function get transform():ITransform
        {
            return (_transform);
        }

        public function refresh():void
        {
            fillsChanged = true;
        }

        public function set requester(_arg_1:IGeometryComposition):void
        {
            _requester = _arg_1;
        }

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
        }


    }
}//package com.degrafa.paint

