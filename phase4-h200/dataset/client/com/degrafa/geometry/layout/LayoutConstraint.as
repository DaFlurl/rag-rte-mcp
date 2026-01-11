// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.layout.LayoutConstraint

package com.degrafa.geometry.layout
{
    import com.degrafa.core.DegrafaObject;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import mx.events.PropertyChangeEvent;

    public class LayoutConstraint extends DegrafaObject implements ILayout 
    {

        private var _right:Number;
        private var _maxWidth:Number;
        private var _minX:Number;
        private var _minY:Number;
        private var _maxHeight:Number;
        private var _layoutRectangle:Rectangle = new Rectangle();
        private var _maintainAspectRatio:Boolean = false;
        private var _height:Number;
        private var _maxY:Number;
        private var _bottom:Number;
        private var _maxX:Number;
        private var _percentWidth:Number;
        private var container:Rectangle;
        private var _verticalCenter:Number;
        private var _top:Number;
        private var _minHeight:Number;
        private var _targetCoordinateSpace:DisplayObject;
        private var _width:Number;
        private var _invalidated:Boolean;
        private var _percentHeight:Number;
        private var _left:Number;
        private var _minWidth:Number;
        private var _horizontalCenter:Number;
        private var _x:Number;
        private var _y:Number;


        [Bindable(event="propertyChange")]
        public function set y(_arg_1:Number):void
        {
            var _local_2:Object = this.y;
            if (_local_2 !== _arg_1)
            {
                this._121y = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "y", _local_2, _arg_1));
            };
        }

        private function set _3351623minY(_arg_1:Number):void
        {
            if (_minY != _arg_1)
            {
                _minY = _arg_1;
                invalidated = true;
            };
        }

        public function get left():Number
        {
            if (!_left)
            {
                return (NaN);
            };
            return (_left);
        }

        public function get maintainAspectRatio():Boolean
        {
            return (_maintainAspectRatio);
        }

        private function set _3351622minX(_arg_1:Number):void
        {
            if (_minX != _arg_1)
            {
                _minX = _arg_1;
                invalidated = true;
            };
        }

        private function set _3344244maxX(_arg_1:Number):void
        {
            if (_maxX != _arg_1)
            {
                _maxX = _arg_1;
                invalidated = true;
            };
        }

        private function set _120x(_arg_1:Number):void
        {
            if (_x != _arg_1)
            {
                _x = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set percentWidth(_arg_1:Number):void
        {
            var _local_2:Object = this.percentWidth;
            if (_local_2 !== _arg_1)
            {
                this._1127236479percentWidth = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percentWidth", _local_2, _arg_1));
            };
        }

        public function set invalidated(_arg_1:Boolean):void
        {
            _invalidated = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function set left(_arg_1:Number):void
        {
            var _local_2:Object = this.left;
            if (_local_2 !== _arg_1)
            {
                this._3317767left = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "left", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set maintainAspectRatio(_arg_1:Boolean):void
        {
            var _local_2:Object = this.maintainAspectRatio;
            if (_local_2 !== _arg_1)
            {
                this._574021640maintainAspectRatio = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maintainAspectRatio", _local_2, _arg_1));
            };
        }

        private function set _3344245maxY(_arg_1:Number):void
        {
            if (_maxY != _arg_1)
            {
                _maxY = _arg_1;
                invalidated = true;
            };
        }

        public function get right():Number
        {
            if (!_right)
            {
                return (NaN);
            };
            return (_right);
        }

        private function calculateLayoutRectangle():void
        {
            var _local_1:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_2:Boolean = isNaN(_left);
            var _local_3:Boolean = isNaN(_right);
            var _local_4:Boolean = isNaN(_horizontalCenter);
            var _local_5:* = (!(Boolean(_local_2)));
            var _local_6:* = (!(Boolean(_local_3)));
            if (container)
            {
                if (((!(_local_5)) && (!(_local_6))))
                {
                    if (_local_4)
                    {
                        _layoutRectangle.width = ((isNaN(_percentWidth)) ? _width : ((_percentWidth > 1) ? ((_percentWidth / 100) * container.width) : (_percentWidth * container.width)));
                        _layoutRectangle.x = ((isNaN(_x)) ? 0 : (_x + container.left));
                    }
                    else
                    {
                        _layoutRectangle.width = ((isNaN(_percentWidth)) ? _width : ((_percentWidth > 1) ? ((_percentWidth / 100) * container.width) : (_percentWidth * container.width)));
                        _layoutRectangle.x = (((_horizontalCenter - (_layoutRectangle.width / 2)) + container.left) + (container.width / 2));
                    };
                }
                else
                {
                    if (!_local_6)
                    {
                        _layoutRectangle.width = ((isNaN(_percentWidth)) ? _width : ((_percentWidth > 1) ? ((_percentWidth / 100) * container.width) : (_percentWidth * container.width)));
                        _layoutRectangle.x = (container.left + _left);
                    }
                    else
                    {
                        if (!_local_5)
                        {
                            _layoutRectangle.width = ((isNaN(_percentWidth)) ? _width : ((_percentWidth > 1) ? ((_percentWidth / 100) * container.width) : (_percentWidth * container.width)));
                            _layoutRectangle.x = ((container.right - _right) - _layoutRectangle.width);
                        }
                        else
                        {
                            _layoutRectangle.right = (container.right - _right);
                            _layoutRectangle.left = (container.left + _left);
                        };
                    };
                };
            };
            if (!isNaN(_minX))
            {
                _local_1 = (container.x + _minX);
                if (_local_1 > _layoutRectangle.x)
                {
                    _layoutRectangle.x = _local_1;
                };
            };
            if (!isNaN(_maxX))
            {
                _local_1 = (container.x + _maxX);
                if (_local_1 < _layoutRectangle.x)
                {
                    _layoutRectangle.x = _local_1;
                };
            };
            _local_1 = 0;
            if (((!(isNaN(_minWidth))) && (_minWidth > _layoutRectangle.width)))
            {
                _local_1 = (_layoutRectangle.width - _minWidth);
            }
            else
            {
                if (((!(isNaN(_maxWidth))) && (_maxWidth < _layoutRectangle.width)))
                {
                    _local_1 = (_layoutRectangle.width - _maxWidth);
                };
            };
            if (_local_1)
            {
                if (!_local_5)
                {
                    if (_local_6)
                    {
                        _layoutRectangle.x = (_layoutRectangle.x + _local_1);
                    }
                    else
                    {
                        if (!_local_4)
                        {
                            _layoutRectangle.x = (_layoutRectangle.x + (_local_1 / 2));
                        };
                    };
                }
                else
                {
                    if (((_local_5) && (_local_6)))
                    {
                        _layoutRectangle.x = (_layoutRectangle.x + (_local_1 / 2));
                    };
                };
                _layoutRectangle.width = (_layoutRectangle.width - _local_1);
            };
            var _local_7:Boolean = isNaN(_top);
            var _local_8:Boolean = isNaN(_bottom);
            var _local_9:Boolean = isNaN(_verticalCenter);
            var _local_10:* = (!(Boolean(_local_7)));
            var _local_11:* = (!(Boolean(_local_8)));
            if (container)
            {
                if (((!(_local_10)) && (!(_local_11))))
                {
                    if (_local_9)
                    {
                        _layoutRectangle.height = ((isNaN(_percentHeight)) ? _height : ((_percentHeight > 1) ? ((_percentHeight / 100) * container.height) : (_percentHeight * container.height)));
                        _layoutRectangle.y = ((isNaN(_y)) ? 0 : (_y + container.top));
                    }
                    else
                    {
                        _layoutRectangle.height = ((isNaN(_percentHeight)) ? _height : ((_percentHeight > 1) ? ((_percentHeight / 100) * container.height) : (_percentHeight * container.height)));
                        _layoutRectangle.y = (((_verticalCenter - (_layoutRectangle.height / 2)) + container.top) + (container.height / 2));
                    };
                }
                else
                {
                    if (!_local_11)
                    {
                        _layoutRectangle.height = ((isNaN(_percentHeight)) ? _height : ((_percentHeight > 1) ? ((_percentHeight / 100) * container.height) : (_percentHeight * container.height)));
                        _layoutRectangle.y = (container.top + _top);
                    }
                    else
                    {
                        if (!_local_10)
                        {
                            _layoutRectangle.height = ((isNaN(_percentHeight)) ? _height : ((_percentHeight > 1) ? ((_percentHeight / 100) * container.height) : (_percentHeight * container.height)));
                            _layoutRectangle.y = ((container.bottom - _bottom) - _layoutRectangle.height);
                        }
                        else
                        {
                            _layoutRectangle.bottom = (container.bottom - _bottom);
                            _layoutRectangle.top = (container.top + _top);
                        };
                    };
                };
            };
            if (!isNaN(_minY))
            {
                _local_1 = (container.y + _minY);
                if (_local_1 > _layoutRectangle.y)
                {
                    _layoutRectangle.y = _local_1;
                };
            };
            if (!isNaN(_maxY))
            {
                _local_1 = (container.y + _maxY);
                if (_local_1 < _layoutRectangle.y)
                {
                    _layoutRectangle.y = _local_1;
                };
            };
            _local_1 = 0;
            if (((!(isNaN(_minHeight))) && (_minHeight > _layoutRectangle.height)))
            {
                _local_1 = (_layoutRectangle.height - _minHeight);
            }
            else
            {
                if (((!(isNaN(_maxHeight))) && (_maxHeight < _layoutRectangle.height)))
                {
                    _local_1 = (_layoutRectangle.height - _maxHeight);
                };
            };
            if (_local_1)
            {
                if (!_local_10)
                {
                    if (_local_11)
                    {
                        _layoutRectangle.y = (_layoutRectangle.y + _local_1);
                    }
                    else
                    {
                        if (!_local_9)
                        {
                            _layoutRectangle.y = (_layoutRectangle.y + (_local_1 / 2));
                        };
                    };
                }
                else
                {
                    if (((_local_10) && (_local_11)))
                    {
                        _layoutRectangle.y = (_layoutRectangle.y + (_local_1 / 2));
                    };
                };
                _layoutRectangle.height = (_layoutRectangle.height - _local_1);
            };
            if ((((_maintainAspectRatio) && (_height)) && (_width)))
            {
                _local_12 = (_height / _width);
                _local_13 = (_layoutRectangle.height / _layoutRectangle.width);
                if (_local_12 > _local_13)
                {
                    _local_1 = (_layoutRectangle.height / _local_12);
                    if (!_local_5)
                    {
                        if (_local_6)
                        {
                            _layoutRectangle.x = (_layoutRectangle.x + (_layoutRectangle.width - _local_1));
                        }
                        else
                        {
                            if (!_local_4)
                            {
                                _layoutRectangle.x = (_layoutRectangle.x + ((_layoutRectangle.width - _local_1) / 2));
                            };
                        };
                    }
                    else
                    {
                        if (((_local_5) && (_local_6)))
                        {
                            _layoutRectangle.x = (_layoutRectangle.x + ((_layoutRectangle.width - _local_1) / 2));
                        };
                    };
                    _layoutRectangle.width = _local_1;
                }
                else
                {
                    if (_local_12 < _local_13)
                    {
                        _local_1 = (_layoutRectangle.width * _local_12);
                        if (!_local_10)
                        {
                            if (_local_11)
                            {
                                _layoutRectangle.y = (_layoutRectangle.y + (_layoutRectangle.height - _local_1));
                            }
                            else
                            {
                                if (!_local_9)
                                {
                                    _layoutRectangle.y = (_layoutRectangle.y + ((_layoutRectangle.height - _local_1) / 2));
                                };
                            };
                        }
                        else
                        {
                            if (((_local_10) && (_local_11)))
                            {
                                _layoutRectangle.y = (_layoutRectangle.y + ((_layoutRectangle.height - _local_1) / 2));
                            };
                        };
                        _layoutRectangle.height = _local_1;
                    };
                };
            };
        }

        public function get minHeight():Number
        {
            return (_minHeight);
        }

        private function set _926273685verticalCenter(_arg_1:Number):void
        {
            if (_verticalCenter != _arg_1)
            {
                _verticalCenter = _arg_1;
                invalidated = true;
            };
        }

        private function set _574021640maintainAspectRatio(_arg_1:Boolean):void
        {
            if (_maintainAspectRatio != _arg_1)
            {
                _maintainAspectRatio = _arg_1;
                invalidated = true;
            };
        }

        public function get height():Number
        {
            return (_height);
        }

        [Bindable(event="propertyChange")]
        public function set minWidth(_arg_1:Number):void
        {
            var _local_2:Object = this.minWidth;
            if (_local_2 !== _arg_1)
            {
                this._1375815020minWidth = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minWidth", _local_2, _arg_1));
            };
        }

        public function get bottom():Number
        {
            if (!_bottom)
            {
                return (NaN);
            };
            return (_bottom);
        }

        public function computeLayoutRectangle(_arg_1:Rectangle, _arg_2:Rectangle):Rectangle
        {
            if (_arg_2.isEmpty())
            {
                return (null);
            };
            _layoutRectangle = _arg_1.clone();
            if (isNaN(_width))
            {
                _width = ((layoutRectangle.width) ? layoutRectangle.width : 1);
            };
            if (isNaN(_height))
            {
                _height = ((layoutRectangle.height) ? layoutRectangle.height : 1);
            };
            if (isNaN(_x))
            {
                _x = ((layoutRectangle.x) ? layoutRectangle.x : 0);
            };
            if (isNaN(_y))
            {
                _y = ((layoutRectangle.y) ? layoutRectangle.y : 0);
            };
            container = _arg_2.clone();
            calculateLayoutRectangle();
            return (layoutRectangle);
        }

        [Bindable(event="propertyChange")]
        public function set horizontalCenter(_arg_1:Number):void
        {
            var _local_2:Object = this.horizontalCenter;
            if (_local_2 !== _arg_1)
            {
                this._2016110183horizontalCenter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "horizontalCenter", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set right(_arg_1:Number):void
        {
            var _local_2:Object = this.right;
            if (_local_2 !== _arg_1)
            {
                this._108511772right = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "right", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set minHeight(_arg_1:Number):void
        {
            var _local_2:Object = this.minHeight;
            if (_local_2 !== _arg_1)
            {
                this._133587431minHeight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minHeight", _local_2, _arg_1));
            };
        }

        private function set _1854666595targetCoordinateSpace(_arg_1:DisplayObject):void
        {
            if (_targetCoordinateSpace != _arg_1)
            {
                _targetCoordinateSpace = _arg_1;
                invalidated = true;
            };
        }

        private function set _400381634maxWidth(_arg_1:Number):void
        {
            if (_maxWidth != _arg_1)
            {
                _maxWidth = _arg_1;
                invalidated = true;
            };
        }

        public function get minX():Number
        {
            return (_minX);
        }

        public function get minY():Number
        {
            return (_minY);
        }

        private function set _1383228885bottom(_arg_1:Number):void
        {
            if (_bottom != _arg_1)
            {
                _bottom = _arg_1;
                invalidated = true;
            };
        }

        public function set derive(_arg_1:LayoutConstraint):void
        {
            if (!_x)
            {
                _x = _arg_1.x;
            };
            if (!_minX)
            {
                _minX = _arg_1.minX;
            };
            if (!_maxX)
            {
                _maxX = _arg_1.maxX;
            };
            if (!_y)
            {
                _y = _arg_1.y;
            };
            if (!_minY)
            {
                _minY = _arg_1.minY;
            };
            if (!_maxY)
            {
                _maxY = _arg_1.maxY;
            };
            if (!_width)
            {
                _width = _arg_1.width;
            };
            if (!_minWidth)
            {
                _minWidth = _arg_1.minWidth;
            };
            if (!_maxWidth)
            {
                _maxWidth = _arg_1.maxWidth;
            };
            if (!_percentWidth)
            {
                _percentWidth = _arg_1.percentWidth;
            };
            if (!_height)
            {
                _height = _arg_1.height;
            };
            if (!_minHeight)
            {
                _minHeight = _arg_1.minHeight;
            };
            if (!_maxHeight)
            {
                _maxHeight = _arg_1.maxHeight;
            };
            if (!_percentHeight)
            {
                _percentHeight = _arg_1.percentHeight;
            };
            if (!_top)
            {
                _top = _arg_1.top;
            };
            if (!_right)
            {
                _right = _arg_1.right;
            };
            if (!_bottom)
            {
                _bottom = _arg_1.bottom;
            };
            if (!_left)
            {
                _left = _arg_1.left;
            };
            if (!_horizontalCenter)
            {
                _horizontalCenter = _arg_1.horizontalCenter;
            };
            if (!_verticalCenter)
            {
                _verticalCenter = _arg_1.verticalCenter;
            };
            if (!_maintainAspectRatio)
            {
                _maintainAspectRatio = _arg_1.maintainAspectRatio;
            };
            if (!_targetCoordinateSpace)
            {
                _targetCoordinateSpace = _arg_1.targetCoordinateSpace;
            };
            invalidated = true;
        }

        private function set _121y(_arg_1:Number):void
        {
            if (_y != _arg_1)
            {
                _y = _arg_1;
                invalidated = true;
            };
        }

        private function set _108511772right(_arg_1:Number):void
        {
            if (_right != _arg_1)
            {
                _right = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set targetCoordinateSpace(_arg_1:DisplayObject):void
        {
            var _local_2:Object = this.targetCoordinateSpace;
            if (_local_2 !== _arg_1)
            {
                this._1854666595targetCoordinateSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetCoordinateSpace", _local_2, _arg_1));
            };
        }

        public function get top():Number
        {
            if (!_top)
            {
                return (NaN);
            };
            return (_top);
        }

        [Bindable(event="propertyChange")]
        public function set maxHeight(_arg_1:Number):void
        {
            var _local_2:Object = this.maxHeight;
            if (_local_2 !== _arg_1)
            {
                this._906066005maxHeight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxHeight", _local_2, _arg_1));
            };
        }

        private function set _1127236479percentWidth(_arg_1:Number):void
        {
            if (_percentWidth != _arg_1)
            {
                _percentWidth = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set height(_arg_1:Number):void
        {
            var _local_2:Object = this.height;
            if (_local_2 !== _arg_1)
            {
                this._1221029593height = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "height", _local_2, _arg_1));
            };
        }

        private function set _113126854width(_arg_1:Number):void
        {
            if (_width != _arg_1)
            {
                _width = _arg_1;
                _percentWidth = NaN;
                invalidated = true;
            };
        }

        public function get layoutRectangle():Rectangle
        {
            return (_layoutRectangle.clone());
        }

        public function get verticalCenter():Number
        {
            if (!_verticalCenter)
            {
                return (NaN);
            };
            return (_verticalCenter);
        }

        private function set _2016110183horizontalCenter(_arg_1:Number):void
        {
            if (_horizontalCenter != _arg_1)
            {
                _horizontalCenter = _arg_1;
                invalidated = true;
            };
        }

        private function set _3317767left(_arg_1:Number):void
        {
            if (_left != _arg_1)
            {
                _left = _arg_1;
                invalidated = true;
            };
        }

        public function get maxY():Number
        {
            return (_maxY);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get maxX():Number
        {
            return (_maxX);
        }

        [Bindable(event="propertyChange")]
        public function set bottom(_arg_1:Number):void
        {
            var _local_2:Object = this.bottom;
            if (_local_2 !== _arg_1)
            {
                this._1383228885bottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bottom", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set maxWidth(_arg_1:Number):void
        {
            var _local_2:Object = this.maxWidth;
            if (_local_2 !== _arg_1)
            {
                this._400381634maxWidth = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxWidth", _local_2, _arg_1));
            };
        }

        public function get percentWidth():Number
        {
            if (!_percentWidth)
            {
                return (NaN);
            };
            return (_percentWidth);
        }

        public function get invalidated():Boolean
        {
            return (_invalidated);
        }

        private function set _1375815020minWidth(_arg_1:Number):void
        {
            if (_minWidth != _arg_1)
            {
                _minWidth = _arg_1;
                invalidated = true;
            };
        }

        private function set _906066005maxHeight(_arg_1:Number):void
        {
            if (_maxHeight != _arg_1)
            {
                _maxHeight = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set minY(_arg_1:Number):void
        {
            var _local_2:Object = this.minY;
            if (_local_2 !== _arg_1)
            {
                this._3351623minY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minY", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set percentHeight(_arg_1:Number):void
        {
            var _local_2:Object = this.percentHeight;
            if (_local_2 !== _arg_1)
            {
                this._1017587252percentHeight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percentHeight", _local_2, _arg_1));
            };
        }

        public function get horizontalCenter():Number
        {
            if (!_horizontalCenter)
            {
                return (NaN);
            };
            return (_horizontalCenter);
        }

        public function get minWidth():Number
        {
            return (_minWidth);
        }

        public function get targetCoordinateSpace():DisplayObject
        {
            if (!_targetCoordinateSpace)
            {
                return (null);
            };
            return (_targetCoordinateSpace);
        }

        [Bindable(event="propertyChange")]
        public function set width(_arg_1:Number):void
        {
            var _local_2:Object = this.width;
            if (_local_2 !== _arg_1)
            {
                this._113126854width = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "width", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set top(_arg_1:Number):void
        {
            var _local_2:Object = this.top;
            if (_local_2 !== _arg_1)
            {
                this._115029top = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "top", _local_2, _arg_1));
            };
        }

        public function get maxHeight():Number
        {
            return (_maxHeight);
        }

        [Bindable(event="propertyChange")]
        public function set minX(_arg_1:Number):void
        {
            var _local_2:Object = this.minX;
            if (_local_2 !== _arg_1)
            {
                this._3351622minX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minX", _local_2, _arg_1));
            };
        }

        private function set _115029top(_arg_1:Number):void
        {
            if (_top != _arg_1)
            {
                _top = _arg_1;
                invalidated = true;
            };
        }

        private function set _1221029593height(_arg_1:Number):void
        {
            if (_height != _arg_1)
            {
                _height = _arg_1;
                _percentHeight = NaN;
                invalidated = true;
            };
        }

        public function get maxWidth():Number
        {
            return (_maxWidth);
        }

        public function get width():Number
        {
            return (_width);
        }

        public function get percentHeight():Number
        {
            if (!_percentHeight)
            {
                return (NaN);
            };
            return (_percentHeight);
        }

        private function set _133587431minHeight(_arg_1:Number):void
        {
            if (_minHeight != _arg_1)
            {
                _minHeight = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set verticalCenter(_arg_1:Number):void
        {
            var _local_2:Object = this.verticalCenter;
            if (_local_2 !== _arg_1)
            {
                this._926273685verticalCenter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "verticalCenter", _local_2, _arg_1));
            };
        }

        private function set _1017587252percentHeight(_arg_1:Number):void
        {
            if (_percentHeight != _arg_1)
            {
                _percentHeight = _arg_1;
                invalidated = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function set maxX(_arg_1:Number):void
        {
            var _local_2:Object = this.maxX;
            if (_local_2 !== _arg_1)
            {
                this._3344244maxX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxX", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set maxY(_arg_1:Number):void
        {
            var _local_2:Object = this.maxY;
            if (_local_2 !== _arg_1)
            {
                this._3344245maxY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxY", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function set x(_arg_1:Number):void
        {
            var _local_2:Object = this.x;
            if (_local_2 !== _arg_1)
            {
                this._120x = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "x", _local_2, _arg_1));
            };
        }


    }
}//package com.degrafa.geometry.layout

