// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.paint.BitmapFill

package com.degrafa.paint
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IGraphicsFill;
    import com.degrafa.core.IBlend;
    import com.degrafa.core.ITransformablePaint;
    import flash.display.BitmapData;
    import com.degrafa.transform.ITransform;
    import flash.display.Graphics;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import com.degrafa.utilities.external.ExternalBitmapData;
    import flash.display.Sprite;
    import com.degrafa.utilities.external.LoadingLocation;
    import com.degrafa.IGeometryComposition;
    import com.degrafa.core.Measure;
    import com.degrafa.utilities.external.ExternalDataAsset;
    import flash.events.Event;
    import com.degrafa.utilities.external.ExternalDataPropertyChangeEvent;
    import mx.events.PropertyChangeEventKind;
    import mx.events.PropertyChangeEvent;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import flash.display.Shape;
    import com.degrafa.geometry.Geometry;
    import flash.display.Bitmap;
    import flash.utils.getDefinitionByName;
    import flash.utils.setTimeout;

    public class BitmapFill extends DegrafaObject implements IGraphicsFill, IBlend, ITransformablePaint 
    {

        public static const NONE:String = "none";
        public static const REPEAT:String = "repeat";
        public static const SPACE:String = "space";
        public static const STRETCH:String = "stretch";

        private var bitmapData:BitmapData;
        private var _transform:ITransform;
        private var _lastContext:Graphics;
        private var _waiting:Boolean;
        private var target:DisplayObject;
        private var _blendMode:String = "normal";
        private var _lastRect:Rectangle;
        private var _originX:Number = 0;
        private var _originY:Number = 0;
        private var _externalBitmapData:ExternalBitmapData;
        private var sprite:Sprite;
        private var _smooth:Boolean = false;
        private var _loadingLocation:LoadingLocation;
        private var _rotation:Number = 0;
        private var _repeatX:String = "repeat";
        private var _repeatY:String = "repeat";
        private var _scaleX:Number = 1;
        private var _scaleY:Number = 1;
        private var _requester:IGeometryComposition;

        private var _offsetX:Measure = new Measure();
        private var _offsetY:Measure = new Measure();
        private var _lastArgs:Array = [];

        public function BitmapFill(_arg_1:Object=null, _arg_2:LoadingLocation=null)
        {
            this._loadingLocation = _arg_2;
            this.source = _arg_1;
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

        private function externalBitmapHandler(_arg_1:Event):void
        {
            var _local_2:Object;
            switch (_arg_1.type)
            {
                case ExternalDataAsset.STATUS_READY:
                    _local_2 = bitmapData;
                    bitmapData = _arg_1.target.content;
                    initChange("source", _local_2, bitmapData, this);
                    waiting = false;
                    return;
            };
        }

        public function set offsetXUnit(_arg_1:String):void
        {
            if (_offsetX.unit != _arg_1)
            {
                initChange("offsetXUnit", _offsetX.unit, (_offsetX.unit = _arg_1), this);
            };
        }

        public function get lastArgs():Array
        {
            return (_lastArgs);
        }

        [Bindable(event="propertyChange")]
        public function get blendMode():String
        {
            return (_blendMode);
        }

        public function get loadingLocation():LoadingLocation
        {
            return (_loadingLocation);
        }

        public function set scaleX(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_scaleX != _arg_1)
            {
                _local_2 = _arg_1;
                _scaleX = _arg_1;
                initChange("scaleX", _local_2, _scaleX, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get repeatX():String
        {
            return (_repeatX);
        }

        [Bindable(event="propertyChange")]
        public function get repeatY():String
        {
            return (_repeatY);
        }

        public function set waiting(_arg_1:Boolean):void
        {
            if (_arg_1 != _waiting)
            {
                _waiting = _arg_1;
                dispatchEvent(new ExternalDataPropertyChangeEvent(ExternalDataPropertyChangeEvent.EXTERNAL_DATA_PROPERTY_CHANGE, false, false, PropertyChangeEventKind.UPDATE, "waiting", (!(_waiting)), _waiting, this));
            };
        }

        [Bindable(event="propertyChange")]
        public function set offsetYUnit(_arg_1:String):void
        {
            if (_offsetY.unit != _arg_1)
            {
                initChange("offsetYUnit", _offsetY.unit, (_offsetY.unit = _arg_1), this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get offsetX():Number
        {
            return (_offsetX.value);
        }

        [Bindable(event="propertyChange")]
        public function get offsetY():Number
        {
            return (_offsetY.value);
        }

        public function set blendMode(_arg_1:String):void
        {
            var _local_2:String;
            if (_blendMode != _arg_1)
            {
                _local_2 = _blendMode;
                _blendMode = _arg_1;
                initChange("blendMode", _local_2, _blendMode, this);
            };
        }

        public function set loadingLocation(_arg_1:LoadingLocation):void
        {
            if (_arg_1)
            {
                _loadingLocation = _arg_1;
            };
        }

        private function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            dispatchEvent(_arg_1);
        }

        public function set scaleY(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_scaleY != _arg_1)
            {
                _local_2 = _arg_1;
                _scaleY = _arg_1;
                initChange("scaleY", _local_2, _scaleY, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get smooth():Boolean
        {
            return (_smooth);
        }

        public function begin(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_8:Point;
            var _local_9:ITransform;
            var _local_10:Matrix;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:BitmapData;
            var _local_16:Rectangle;
            var _local_17:Matrix;
            var _local_18:Shape;
            var _local_19:Geometry;
            if (!bitmapData)
            {
                return;
            };
            var _local_3:BitmapData = bitmapData;
            var _local_4:Boolean = true;
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Matrix = new Matrix();
            _local_7.translate(_arg_2.x, _arg_2.y);
            if (((repeatX == BitmapFill.STRETCH) || (repeatY == BitmapFill.STRETCH)))
            {
                _local_11 = ((repeatX == STRETCH) ? _arg_2.width : _local_3.width);
                _local_12 = ((repeatY == STRETCH) ? _arg_2.height : _local_3.height);
                if (target)
                {
                    target.width = _local_11;
                    target.height = _local_12;
                    _local_3 = new BitmapData(_local_11, _local_12, true, 0);
                    if (sprite)
                    {
                        _local_3.draw(sprite);
                    }
                    else
                    {
                        _local_3.draw(target);
                    };
                }
                else
                {
                    _local_7.scale((_local_11 / _local_3.width), (_local_12 / _local_3.height));
                };
            };
            if (((repeatX == BitmapFill.SPACE) || (repeatY == BitmapFill.SPACE)))
            {
                _local_13 = ((repeatX == BitmapFill.SPACE) ? Math.round(((_arg_2.width % _local_3.width) / int((_arg_2.width / _local_3.width)))) : 0);
                _local_14 = ((repeatY == BitmapFill.SPACE) ? Math.round(((_arg_2.height % _local_3.height) / int((_arg_2.height / _local_3.height)))) : 0);
                _local_15 = new BitmapData(Math.round((_local_13 + _local_3.width)), Math.round((_local_14 + _local_3.height)), true, 0);
                _local_15.copyPixels(_local_3, _local_3.rect, new Point(Math.round((_local_13 / 2)), Math.round((_local_14 / 2))));
                _local_3 = _local_15;
            };
            if (((repeatX == BitmapFill.NONE) || (repeatX == BitmapFill.REPEAT)))
            {
                _local_5 = _offsetX.relativeTo((_arg_2.width - _local_3.width));
            };
            if (((repeatY == BitmapFill.NONE) || (repeatY == BitmapFill.REPEAT)))
            {
                _local_6 = _offsetY.relativeTo((_arg_2.height - _local_3.height));
            };
            if (((repeatX == BitmapFill.NONE) || (repeatY == BitmapFill.NONE)))
            {
                _local_16 = new Rectangle(1, 1, _arg_2.width, _arg_2.height);
                _local_17 = new Matrix();
                if (repeatX == BitmapFill.NONE)
                {
                    _local_16.width = _local_3.width;
                }
                else
                {
                    _local_17.translate(_local_5, 0);
                    _local_5 = 0;
                };
                if (repeatY == BitmapFill.NONE)
                {
                    _local_16.height = _local_3.height;
                }
                else
                {
                    _local_17.translate(0, _local_6);
                    _local_6 = 0;
                };
                _local_18 = new Shape();
                _local_18.graphics.beginBitmapFill(_local_3, _local_17);
                _local_18.graphics.drawRect(0, 0, _local_16.width, _local_16.height);
                _local_18.graphics.endFill();
                _local_3 = new BitmapData((_local_16.width + 2), (_local_16.height + 2), true, 0);
                _local_3.draw(_local_18, new Matrix(1, 0, 0, 1, 1, 1), null, null, _local_16);
                _local_4 = false;
            };
            _local_7.translate(-(_originX), -(_originY));
            _local_7.scale(_scaleX, _scaleY);
            _local_7.rotate((_rotation * (Math.PI / 180)));
            _local_7.translate(_local_5, _local_6);
            if (((_requester) && ((_requester as Geometry).hasLayout)))
            {
                _local_19 = (_requester as Geometry);
                if (_local_19._layoutMatrix)
                {
                    _local_7.concat(_local_19._layoutMatrix);
                };
            };
            if (((_transform) && (!(_transform.isIdentity))))
            {
                _local_10 = new Matrix();
                _local_8 = _transform.getRegPointForRectangle(_arg_2);
                _local_10.translate(-(_local_8.x), -(_local_8.y));
                _local_10.concat(_transform.transformMatrix);
                _local_10.translate(_local_8.x, _local_8.y);
                _local_7.concat(_local_10);
            };
            if (((_requester) && ((_local_9 = (_requester as Geometry).transform) || ((_requester as Geometry).transformContext))))
            {
                if (_local_9)
                {
                    _local_7.concat(_local_9.getTransformFor(_requester));
                }
                else
                {
                    _local_7.concat((_requester as Geometry).transformContext);
                };
                _requester = null;
            };
            _lastArgs.length = 0;
            _lastArgs[0] = _local_3;
            _lastArgs[1] = _local_7;
            _lastArgs[2] = _local_4;
            _lastArgs[3] = smooth;
            _lastContext = _arg_1;
            _lastRect = _arg_2;
            _arg_1.beginBitmapFill(_local_3, _local_7, _local_4, smooth);
        }

        public function set source(value:Object):void
        {
            var cls:Class;
            var tempRect:Rectangle;
            var oldValue:Object = bitmapData;
            target = null;
            if (_externalBitmapData)
            {
                _externalBitmapData.removeEventListener(ExternalDataAsset.STATUS_READY, externalBitmapHandler);
                _externalBitmapData = null;
            };
            if (!value)
            {
                bitmapData = null;
                if (oldValue != null)
                {
                    initChange("source", oldValue, null, this);
                };
                return;
            };
            if ((value is ExternalBitmapData))
            {
                _externalBitmapData = (value as ExternalBitmapData);
                if (value.content)
                {
                    value = value.content;
                }
                else
                {
                    value.addEventListener(ExternalDataAsset.STATUS_READY, externalBitmapHandler);
                    waiting = true;
                    return;
                };
            };
            if ((value is BitmapData))
            {
                bitmapData = (value as BitmapData);
                initChange("source", oldValue, bitmapData, this);
                return;
            };
            if ((value is Class))
            {
                target = new (value)();
                sprite = new Sprite();
                sprite.addChild(target);
            }
            else
            {
                if ((value is Bitmap))
                {
                    bitmapData = value.bitmapData;
                    target = (value as Bitmap);
                }
                else
                {
                    if ((value is DisplayObject))
                    {
                        target = (value as DisplayObject);
                    }
                    else
                    {
                        if ((value is String))
                        {
                            try
                            {
                                cls = Class(getDefinitionByName((value as String)));
                            }
                            catch(e:Error)
                            {
                                if (!isInitialized)
                                {
                                    setTimeout(function ():void
                                    {
                                        source = value;
                                    }, 1);
                                }
                                else
                                {
                                    source = ExternalBitmapData.getUniqueInstance((value as String), _loadingLocation);
                                };
                                return;
                            };
                            target = new (cls)();
                        }
                        else
                        {
                            bitmapData = null;
                            if (oldValue != null)
                            {
                                initChange("source", oldValue, null, this);
                            };
                            return;
                        };
                    };
                };
            };
            if (target != null)
            {
                if (((!(target.width)) || (!(target.height))))
                {
                    tempRect = target.getBounds(target);
                    if (!tempRect.isEmpty())
                    {
                        bitmapData = new BitmapData(Math.ceil(tempRect.width), Math.ceil(tempRect.height), true, 0);
                        bitmapData.draw(target, new Matrix(1, 0, 0, 1, -(tempRect.x), -(tempRect.y)));
                    }
                    else
                    {
                        bitmapData = null;
                    };
                }
                else
                {
                    bitmapData = new BitmapData(target.width, target.height, true, 0);
                    bitmapData.draw(target);
                };
            };
            initChange("source", oldValue, bitmapData, this);
        }

        public function set repeatY(_arg_1:String):void
        {
            var _local_2:String;
            if (_repeatY != _arg_1)
            {
                _local_2 = _arg_1;
                _repeatY = _arg_1;
                initChange("repeatY", _local_2, _repeatY, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get source():Object
        {
            return (bitmapData);
        }

        public function get lastRectangle():Rectangle
        {
            return ((_lastRect) ? _lastRect.clone() : null);
        }

        public function set repeatX(_arg_1:String):void
        {
            var _local_2:String;
            if (_repeatX != _arg_1)
            {
                _local_2 = _arg_1;
                _repeatX = _arg_1;
                initChange("repeatX", _local_2, _repeatX, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get offsetXUnit():String
        {
            return (_offsetX.unit);
        }

        public function set offsetX(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_offsetX.value != _arg_1)
            {
                _local_2 = _arg_1;
                _offsetX.value = _arg_1;
                initChange("offsetX", _local_2, _offsetX, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get scaleY():Number
        {
            return (_scaleY);
        }

        public function get offsetYUnit():String
        {
            return (_offsetY.unit);
        }

        public function set offsetY(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_offsetY.value != _arg_1)
            {
                _local_2 = _arg_1;
                _offsetY.value = _arg_1;
                initChange("offsetY", _local_2, _offsetY, this);
            };
        }

        [Bindable("externalDataPropertyChange")]
        public function get waiting():Boolean
        {
            return (_waiting == true);
        }

        [Bindable(event="propertyChange")]
        public function get scaleX():Number
        {
            return (_scaleX);
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

        public function end(_arg_1:Graphics):void
        {
            _arg_1.endFill();
        }

        public function set smooth(_arg_1:Boolean):void
        {
            var _local_2:Boolean;
            if (_smooth != _arg_1)
            {
                _local_2 = _arg_1;
                _smooth = _arg_1;
                initChange("smooth", _local_2, _smooth, this);
            };
        }

        public function set originX(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_originX != _arg_1)
            {
                _local_2 = _originX;
                _originX = _arg_1;
                initChange("originX", _local_2, _originX, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get originX():Number
        {
            return (_originX);
        }

        [Bindable(event="propertyChange")]
        public function get originY():Number
        {
            return (_originY);
        }

        public function set originY(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_originY != _arg_1)
            {
                _local_2 = _originY;
                _originY = _arg_1;
                initChange("originY", _local_2, _originY, this);
            };
        }

        public function set requester(_arg_1:IGeometryComposition):void
        {
            _requester = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get transform():ITransform
        {
            return (_transform);
        }

        public function set rotation(_arg_1:Number):void
        {
            var _local_2:Number;
            if (_rotation != _arg_1)
            {
                _local_2 = _arg_1;
                _rotation = _arg_1;
                initChange("rotation", _local_2, _rotation, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get rotation():Number
        {
            return (_rotation);
        }


    }
}//package com.degrafa.paint

