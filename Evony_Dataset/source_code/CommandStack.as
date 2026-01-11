// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.command.CommandStack

package com.degrafa.geometry.command
{
    import flash.net.registerClassAlias;
    import flash.geom.Matrix;
    import com.degrafa.core.IGraphicsStroke;
    import com.degrafa.core.IGraphicsFill;
    import flash.display.Graphics;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.display.Shape;
    import com.degrafa.geometry.Geometry;
    import flash.geom.Rectangle;
    import com.degrafa.core.collections.DegrafaCursor;
    import com.degrafa.geometry.utilities.GeometryUtils;
    import flash.filters.BitmapFilter;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import com.degrafa.decorators.IRenderDecorator;
    import com.degrafa.geometry.display.IDisplayObjectProxy;
    import com.degrafa.decorators.IDecorator;
    import com.degrafa.transform.TransformBase;

    public final class CommandStack 
    {

        public static const IS_REGISTERED:Boolean = (!(registerClassAlias("com.degrafa.geometry.command.CommandStack", CommandStack)));
        public static var transMatrix:Matrix = new Matrix();
        public static var currentLayoutMatrix:Matrix = new Matrix();
        public static var currentTransformMatrix:Matrix = new Matrix();
        public static var currentStroke:IGraphicsStroke;
        public static var currentFill:IGraphicsFill;
        public static var currentContext:Graphics;
        private static var transXY:Point = new Point();
        private static var transCP:Point = new Point();

        private var hasmask:Boolean;
        private var _container:Sprite;
        private var lineTo:Function;
        private var _pathLength:Number = 0;
        public var source:Array = [];
        private var hasRenderDecoration:Boolean;
        private var hasfilters:Boolean;
        public var parent:CommandStackItem;
        private var moveTo:Function;
        private var _fxShape:Shape;
        public var owner:Geometry;
        private var _maskRender:Shape;
        private var _globalRenderDelegateStart:Array;
        private var curveTo:Function;
        private var _invalidated:Boolean = true;
        private var _transformedPathLength:Number = 0;
        private var _lengthInvalidated:Boolean = true;
        private var _bounds:Rectangle = new Rectangle();
        private var _cursor:DegrafaCursor;
        private var _globalRenderDelegateEnd:Array;

        public function CommandStack(_arg_1:Geometry=null)
        {
            this.owner = _arg_1;
        }

        public function pathAngleAt(t:Number):Number
        {
            var curLength:Number;
            var item:CommandStackItem;
            var firstSegment:CommandStackItem;
            if (!source.length)
            {
                return (0);
            };
            t = cleant(t);
            curLength = 0;
            if (t == 0)
            {
                firstSegment = firstSegmentWithLength;
                curLength = firstSegment.segmentLength;
                return (firstSegment.segmentAngleAt(t));
            };
            if (t == 1)
            {
                return (lastSegmentWithLength.segmentAngleAt(t));
            };
            var tLength:Number = (t * pathLength);
            var lastLength:Number = 0;
            var n:Number = source.length;
            for each (item in source)
            {
                var _local_5:* = item;
                with (_local_5)
                {
                    if (type != 0)
                    {
                        curLength = (curLength + segmentLength);
                    }
                    else
                    {
                        continue;
                    };
                    if (tLength <= curLength)
                    {
                        return (segmentAngleAt(((tLength - lastLength) / segmentLength)));
                    };
                };
                lastLength = curLength;
            };
            return (0);
        }

        public function addCubicBezierTo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number, _arg_8:Number, _arg_9:int=1):Array
        {
            return (GeometryUtils.cubicToQuadratic(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, 1, this));
        }

        public function pathPointAt(t:Number):Point
        {
            var curLength:Number;
            var item:CommandStackItem;
            var firstSegment:CommandStackItem;
            if (!source.length)
            {
                return (new Point(0, 0));
            };
            t = cleant(t);
            curLength = 0;
            if (t == 0)
            {
                firstSegment = firstSegmentWithLength;
                curLength = firstSegment.segmentLength;
                return (adjustPointToLayoutAndTransform(firstSegment.segmentPointAt(t)));
            };
            if (t == 1)
            {
                return (adjustPointToLayoutAndTransform(lastSegmentWithLength.segmentPointAt(t)));
            };
            var tLength:Number = (t * pathLength);
            var lastLength:Number = 0;
            var n:Number = source.length;
            for each (item in source)
            {
                var _local_5:* = item;
                with (_local_5)
                {
                    if (type != 0)
                    {
                        curLength = (curLength + segmentLength);
                    }
                    else
                    {
                        continue;
                    };
                    if (tLength <= curLength)
                    {
                        return (adjustPointToLayoutAndTransform(segmentPointAt(((tLength - lastLength) / segmentLength))));
                    };
                };
                lastLength = curLength;
            };
            return (new Point(0, 0));
        }

        public function set globalRenderDelegateStart(_arg_1:Array):void
        {
            if (_globalRenderDelegateStart != _arg_1)
            {
                _globalRenderDelegateStart = _arg_1;
                invalidated = true;
            };
        }

        public function set lengthInvalidated(_arg_1:Boolean):void
        {
            if (_lengthInvalidated != _arg_1)
            {
                _lengthInvalidated = _arg_1;
            };
        }

        public function get invalidated():Boolean
        {
            return (_invalidated);
        }

        public function set invalidated(_arg_1:Boolean):void
        {
            if (_invalidated != _arg_1)
            {
                _invalidated = _arg_1;
                if (_invalidated)
                {
                    lengthInvalidated = true;
                };
            };
        }

        private function updateToFilterRectangle(_arg_1:Rectangle, _arg_2:DisplayObject):Rectangle
        {
            var _local_4:BitmapFilter;
            var _local_3:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            for each (_local_4 in owner.filters)
            {
                _arg_1 = _arg_1.union(_local_3.generateFilterRect(_arg_1, _local_4));
            };
            return (_arg_1);
        }

        public function get firstSegmentWithLength():CommandStackItem
        {
            var _local_1:CommandStackItem;
            for each (_local_1 in source)
            {
                switch (_local_1.type)
                {
                    case 1:
                    case 2:
                        return (_local_1);
                    case 4:
                        return (_local_1.commandStack.firstSegmentWithLength);
                };
            };
            return (source[0]);
        }

        public function getItem(_arg_1:int):CommandStackItem
        {
            return (source[_arg_1]);
        }

        public function addLineTo(_arg_1:Number, _arg_2:Number):CommandStackItem
        {
            var _local_3:int = (source.push(new CommandStackItem(CommandStackItem.LINE_TO, _arg_1, _arg_2, NaN, NaN, NaN, NaN)) - 1);
            updateItemRelations(source[_local_3], _local_3);
            source[_local_3].indexInParent = _local_3;
            source[_local_3].parent = this;
            invalidated = true;
            return (source[_local_3]);
        }

        private function processDelegateArray(_arg_1:Array, _arg_2:CommandStackItem, _arg_3:Graphics, _arg_4:int):CommandStackItem
        {
            var _local_5:Function;
            for each (_local_5 in _arg_1)
            {
                _arg_2 = _local_5(this, _arg_2, _arg_3, _arg_4);
            };
            return (_arg_2);
        }

        public function get lastNonCommandStackItem():CommandStackItem
        {
            var _local_1:int = (source.length - 1);
            while (_local_1 > 0)
            {
                if (source[_local_1].type != CommandStackItem.COMMAND_STACK)
                {
                    return (source[_local_1]);
                };
                return (CommandStackItem(source[_local_1]).commandStack.lastNonCommandStackItem);
            };
            return (source[0]);
        }

        public function addMoveTo(_arg_1:Number, _arg_2:Number):CommandStackItem
        {
            var _local_3:int = (source.push(new CommandStackItem(CommandStackItem.MOVE_TO, _arg_1, _arg_2, NaN, NaN, NaN, NaN)) - 1);
            updateItemRelations(source[_local_3], _local_3);
            source[_local_3].indexInParent = _local_3;
            return (source[_local_3]);
        }

        private function delegateGraphicsCall(_arg_1:String, _arg_2:Graphics, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0, _arg_8:Number=0):*
        {
            var _local_9:IRenderDecorator;
            for each (_local_9 in owner.decorators)
            {
                switch (_arg_1)
                {
                    case "moveTo":
                        return (_local_9.moveTo(_arg_3, _arg_4, _arg_2));
                    case "lineTo":
                        return (_local_9.lineTo(_arg_3, _arg_4, _arg_2));
                    case "curveTo":
                        return (_local_9.curveTo(_arg_5, _arg_6, _arg_7, _arg_8, _arg_2));
                };
            };
        }

        private function renderCommandStack(graphics:Graphics, rc:Rectangle, cursor:DegrafaCursor=null):void
        {
            var item:CommandStackItem;
            while (cursor.moveNext())
            {
                item = cursor.current;
                if (item.renderDelegateStart)
                {
                    item = processDelegateArray(item.renderDelegateStart, item, graphics, cursor.currentIndex);
                };
                if (_globalRenderDelegateStart)
                {
                    item = processDelegateArray(_globalRenderDelegateStart, item, graphics, cursor.currentIndex);
                };
                if (!item.skip)
                {
                    var _local_5:* = item;
                    with (_local_5)
                    {
                        switch (type)
                        {
                            case CommandStackItem.MOVE_TO:
                                if (transMatrix)
                                {
                                    transXY.x = x;
                                    transXY.y = y;
                                    transXY = transMatrix.transformPoint(transXY);
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("moveTo", graphics, transXY.x, transXY.y);
                                    }
                                    else
                                    {
                                        moveTo(transXY.x, transXY.y);
                                    };
                                }
                                else
                                {
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("moveTo", graphics, x, y);
                                    }
                                    else
                                    {
                                        moveTo(x, y);
                                    };
                                };
                                break;
                            case CommandStackItem.LINE_TO:
                                if (transMatrix)
                                {
                                    transXY.x = x;
                                    transXY.y = y;
                                    transXY = transMatrix.transformPoint(transXY);
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("lineTo", graphics, transXY.x, transXY.y);
                                    }
                                    else
                                    {
                                        lineTo(transXY.x, transXY.y);
                                    };
                                }
                                else
                                {
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("lineTo", graphics, x, y);
                                    }
                                    else
                                    {
                                        lineTo(x, y);
                                    };
                                };
                                break;
                            case CommandStackItem.CURVE_TO:
                                if (transMatrix)
                                {
                                    transXY.x = x1;
                                    transXY.y = y1;
                                    transCP.x = cx;
                                    transCP.y = cy;
                                    transXY = transMatrix.transformPoint(transXY);
                                    transCP = transMatrix.transformPoint(transCP);
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("curveTo", graphics, 0, 0, transCP.x, transCP.y, transXY.x, transXY.y);
                                    }
                                    else
                                    {
                                        curveTo(transCP.x, transCP.y, transXY.x, transXY.y);
                                    };
                                }
                                else
                                {
                                    if (hasRenderDecoration)
                                    {
                                        delegateGraphicsCall("curveTo", graphics, 0, 0, cx, cy, x1, y1);
                                    }
                                    else
                                    {
                                        curveTo(cx, cy, x1, y1);
                                    };
                                };
                                break;
                            case CommandStackItem.DELEGATE_TO:
                                item.delegate(this, item, graphics, cursor.currentIndex);
                                break;
                            case CommandStackItem.COMMAND_STACK:
                                renderCommandStack(graphics, rc, new DegrafaCursor(commandStack.source));
                                break;
                        };
                    };
                    if (item.renderDelegateEnd)
                    {
                        item = processDelegateArray(item.renderDelegateEnd, item, graphics, cursor.currentIndex);
                    };
                    if (_globalRenderDelegateEnd)
                    {
                        item = processDelegateArray(_globalRenderDelegateEnd, item, graphics, cursor.currentIndex);
                    };
                };
            };
        }

        public function get bounds():Rectangle
        {
            var _local_1:CommandStackItem;
            if (!invalidated)
            {
                return (_bounds);
            };
            _bounds.setEmpty();
            for each (_local_1 in source)
            {
                if (_local_1.bounds)
                {
                    _bounds = _bounds.union(_local_1.bounds);
                };
            };
            invalidated = false;
            if (_bounds.height != 0.0001)
            {
                _bounds.height = Number(_bounds.height.toPrecision(3));
            };
            if (_bounds.width != 0.0001)
            {
                _bounds.width = Number(_bounds.width.toPrecision(3));
            };
            if (_bounds.isEmpty())
            {
                invalidated = true;
            };
            return (_bounds);
        }

        public function get globalRenderDelegateEnd():Array
        {
            return ((_globalRenderDelegateEnd) ? _globalRenderDelegateEnd : null);
        }

        public function addCommandStack(_arg_1:CommandStack):CommandStackItem
        {
            var _local_2:int = (source.push(new CommandStackItem(CommandStackItem.COMMAND_STACK, NaN, NaN, NaN, NaN, NaN, NaN, _arg_1)) - 1);
            updateItemRelations(source[_local_2], _local_2);
            source[_local_2].indexInParent = _local_2;
            source[_local_2].parent = this;
            invalidated = true;
            return (source[_local_2]);
        }

        public function addItemAt(_arg_1:CommandStackItem, _arg_2:int=-1):CommandStackItem
        {
            var _local_3:int = _arg_2;
            if (_local_3 == -1)
            {
                _local_3 = (source.push(_arg_1) - 1);
            }
            else
            {
                source.splice(_local_3, 0, _arg_1);
                _local_3 = (_local_3 + -1);
            };
            updateItemRelations(source[_local_3], _local_3);
            _arg_1.indexInParent = _local_3;
            _arg_1.parent = this;
            invalidated = true;
            return (source[_local_3]);
        }

        public function get lengthInvalidated():Boolean
        {
            return (_lengthInvalidated);
        }

        public function draw(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            var _local_3:DisplayObject;
            var _local_4:DisplayObject;
            var _local_5:Matrix;
            var _local_6:Matrix;
            var _local_7:Matrix;
            var _local_8:Matrix;
            if (((source.length == 0) && (!(owner is IDisplayObjectProxy))))
            {
                return;
            };
            currentContext = _arg_1;
            predraw();
            if ((owner is IDisplayObjectProxy))
            {
                if (!IDisplayObjectProxy(owner).displayObject)
                {
                    return;
                };
                _local_3 = IDisplayObjectProxy(owner).displayObject;
                if (owner.hasFilters)
                {
                    _local_3.filters = owner.filters;
                };
                if (((transMatrix) && ((IDisplayObjectProxy(owner).transformBeforeRender) || ((owner._layoutMatrix) && (IDisplayObjectProxy(owner).layoutMode == "scale")))))
                {
                    if (Sprite(_local_3).numChildren != 0)
                    {
                        _local_4 = Sprite(_local_3).getChildAt(0);
                        if (!IDisplayObjectProxy(owner).transformBeforeRender)
                        {
                            _local_4.transform.matrix = CommandStack.currentLayoutMatrix;
                        }
                        else
                        {
                            if (IDisplayObjectProxy(owner).layoutMode == "scale")
                            {
                                _local_4.transform.matrix = CommandStack.transMatrix;
                            }
                            else
                            {
                                if (owner._layoutMatrix)
                                {
                                    _local_5 = owner._layoutMatrix.clone();
                                    _local_5.a = 1;
                                    _local_5.d = 1;
                                    _local_5.concat(CommandStack.currentTransformMatrix);
                                    _local_4.transform.matrix = _local_5;
                                }
                                else
                                {
                                    _local_4.transform.matrix = CommandStack.currentTransformMatrix;
                                };
                            };
                        };
                    };
                };
                owner.initStroke(_arg_1, _arg_2);
                owner.initFill(_arg_1, _arg_2);
                renderBitmapDatatoContext(IDisplayObjectProxy(owner).displayObject, _arg_1, (!(IDisplayObjectProxy(owner).transformBeforeRender)), _arg_2);
            }
            else
            {
                _cursor = new DegrafaCursor(source);
                hasmask = (!(owner.mask == null));
                hasfilters = owner.hasFilters;
                if (((hasfilters) || (hasmask)))
                {
                    if (!_fxShape)
                    {
                        _fxShape = new Shape();
                        _container = new Sprite();
                        _container.addChild(_fxShape);
                    }
                    else
                    {
                        _fxShape.graphics.clear();
                    };
                    if (hasmask)
                    {
                        if (!_maskRender)
                        {
                            _maskRender = new Shape();
                            _container.addChild(_maskRender);
                        };
                        _maskRender.graphics.clear();
                        _local_6 = ((currentLayoutMatrix) ? currentLayoutMatrix.clone() : null);
                        _local_7 = ((currentTransformMatrix) ? currentTransformMatrix.clone() : null);
                        _local_8 = ((transMatrix) ? transMatrix.clone() : null);
                        owner.mask.draw(_maskRender.graphics, owner.mask.bounds);
                        _maskRender.cacheAsBitmap = (owner.maskMode == "alpha");
                        _fxShape.cacheAsBitmap = (owner.maskMode == "alpha");
                        currentLayoutMatrix = _local_6;
                        currentTransformMatrix = _local_7;
                        transMatrix = _local_8;
                        _fxShape.mask = _maskRender;
                    }
                    else
                    {
                        if (_fxShape.mask)
                        {
                            _fxShape.mask = null;
                        };
                    };
                    owner.initStroke(_fxShape.graphics, _arg_2);
                    owner.initFill(_fxShape.graphics, _arg_2);
                    if (owner.hasDecorators)
                    {
                        initDecorators();
                    };
                    lineTo = _fxShape.graphics.lineTo;
                    curveTo = _fxShape.graphics.curveTo;
                    moveTo = _fxShape.graphics.moveTo;
                    renderCommandStack(_fxShape.graphics, _arg_2, _cursor);
                    if (owner.hasDecorators)
                    {
                        endDecorators();
                    };
                    renderBitmapDatatoContext(_container, _arg_1);
                }
                else
                {
                    owner.initStroke(_arg_1, _arg_2);
                    owner.initFill(_arg_1, _arg_2);
                    if (owner.hasDecorators)
                    {
                        initDecorators();
                    };
                    lineTo = _arg_1.lineTo;
                    curveTo = _arg_1.curveTo;
                    moveTo = _arg_1.moveTo;
                    renderCommandStack(_arg_1, _arg_2, _cursor);
                    if (owner.hasDecorators)
                    {
                        endDecorators();
                    };
                };
            };
        }

        public function addDelegate(_arg_1:Function):CommandStackItem
        {
            var _local_2:int = (source.push(new CommandStackItem(CommandStackItem.DELEGATE_TO)) - 1);
            source[_local_2].delegate = _arg_1;
            updateItemRelations(source[_local_2], _local_2);
            source[_local_2].indexInParent = _local_2;
            source[_local_2].parent = this;
            return (source[_local_2]);
        }

        private function initDecorators():void
        {
            var _local_1:IDecorator;
            for each (_local_1 in owner.decorators)
            {
                _local_1.initialize(this);
                if ((_local_1 is IRenderDecorator))
                {
                    hasRenderDecoration = true;
                };
            };
        }

        public function get globalRenderDelegateStart():Array
        {
            return ((_globalRenderDelegateStart) ? _globalRenderDelegateStart : null);
        }

        public function set length(_arg_1:int):void
        {
            source.length = _arg_1;
            invalidated = true;
        }

        public function get firstNonCommandStackItem():CommandStackItem
        {
            var _local_1:int = (source.length - 1);
            while (_local_1 < (source.length - 1))
            {
                if (source[_local_1].type != CommandStackItem.COMMAND_STACK)
                {
                    return (source[_local_1]);
                };
                return (CommandStackItem(source[_local_1]).commandStack.firstNonCommandStackItem);
            };
            return (null);
        }

        public function get transformBounds():Rectangle
        {
            if (transMatrix)
            {
                return (TransformBase.transformBounds(_bounds.clone(), transMatrix));
            };
            return (_bounds);
        }

        private function cleant(_arg_1:Number, _arg_2:Number=NaN):Number
        {
            if (isNaN(_arg_1))
            {
                _arg_1 = _arg_2;
            }
            else
            {
                if (((_arg_1 < 0) || (_arg_1 > 1)))
                {
                    _arg_1 = (_arg_1 % 1);
                    if (_arg_1 == 0)
                    {
                        _arg_1 = _arg_2;
                    }
                    else
                    {
                        if (_arg_1 < 0)
                        {
                            _arg_1 = (_arg_1 + 1);
                        };
                    };
                };
            };
            return (_arg_1);
        }

        private function endDecorators():void
        {
            var _local_1:IDecorator;
            for each (_local_1 in owner.decorators)
            {
                _local_1.end(this);
                if ((_local_1 is IRenderDecorator))
                {
                    hasRenderDecoration = true;
                };
            };
        }

        public function get cursor():DegrafaCursor
        {
            if (!_cursor)
            {
                _cursor = new DegrafaCursor(source);
            };
            return (_cursor);
        }

        private function updateItemRelations(_arg_1:CommandStackItem, _arg_2:int):void
        {
            _arg_1.previous = ((_arg_2 > 0) ? source[(_arg_2 - 1)] : null);
            if (_arg_1.previous)
            {
                if (_arg_1.previous.type == CommandStackItem.COMMAND_STACK)
                {
                    _arg_1.previous = _arg_1.previous.commandStack.lastNonCommandStackItem;
                };
                _arg_1.previous.next = ((_arg_1.type == CommandStackItem.COMMAND_STACK) ? _arg_1.commandStack.firstNonCommandStackItem : _arg_1);
            };
        }

        public function get transformedPathLength():Number
        {
            var _local_1:CommandStackItem;
            _transformedPathLength = 0;
            for each (_local_1 in source)
            {
                _transformedPathLength = (_transformedPathLength + _local_1.transformedLength);
            };
            return (_transformedPathLength);
        }

        public function adjustPointToLayoutAndTransform(_arg_1:Point):Point
        {
            if (!owner)
            {
                return (_arg_1);
            };
            if (transMatrix)
            {
                return (transMatrix.transformPoint(_arg_1));
            };
            return (_arg_1);
        }

        public function resetBounds():void
        {
            if (_bounds)
            {
                _bounds.setEmpty();
                invalidated = true;
            };
        }

        private function renderBitmapDatatoContext(_arg_1:DisplayObject, _arg_2:Graphics, _arg_3:Boolean=false, _arg_4:Rectangle=null):void
        {
            var _local_7:BitmapData;
            var _local_9:Matrix;
            var _local_10:Matrix;
            var _local_11:Matrix;
            if (!_arg_1)
            {
                return;
            };
            var _local_5:Rectangle = _arg_1.getBounds(_arg_1);
            if (owner.mask)
            {
                _local_5 = _local_5.intersection(_maskRender.getBounds(_maskRender));
            };
            if (_local_5.isEmpty())
            {
                return;
            };
            var _local_6:Rectangle = _local_5.clone();
            if (hasfilters)
            {
                _arg_1.filters = owner.filters;
                _local_6.x = (_local_6.y = 0);
                _local_6.width = Math.ceil(_local_6.width);
                _local_6.height = Math.ceil(_local_6.height);
                if (((!(_local_6.width)) || (!(_local_6.height))))
                {
                    return;
                };
                _local_6 = updateToFilterRectangle(_local_6, _arg_1);
                _local_6.offset(_local_5.x, _local_5.y);
            };
            var _local_8:Rectangle = ((owner.clippingRectangle) ? owner.clippingRectangle : null);
            if (((_local_6.width < 1) || (_local_6.height < 1)))
            {
                return;
            };
            _local_6.y = Math.floor(_local_6.y);
            _local_6.width = Math.ceil((_local_6.width + (_local_6.x - (_local_6.x = Math.floor(_local_6.x)))));
            _local_6.height = Math.ceil((_local_6.height + (_local_6.y - (_local_6.y = Math.floor(_local_6.y)))));
            if (((_local_6.width > 2880) || (_local_6.height > 2880)))
            {
                return;
            };
            if ((owner is IDisplayObjectProxy))
            {
                _local_7 = new BitmapData((_local_6.width + 4), (_local_6.height + 4), true, 0);
                _local_9 = new Matrix(1, 0, 0, 1, (2 - _local_6.x), (2 - _local_6.y));
            }
            else
            {
                _local_7 = new BitmapData(_local_6.width, _local_6.height, true, 0);
                _local_9 = new Matrix(1, 0, 0, 1, -(_local_6.x), -(_local_6.y));
            };
            _local_7.draw(_arg_1, _local_9, null, null, _local_8, true);
            _local_9.invert();
            if (!_arg_3)
            {
                if ((((owner.hasFilters) && (!(_local_5.equals(_local_6)))) && (owner is IDisplayObjectProxy)))
                {
                    _local_9 = new Matrix((_local_5.width / _local_6.width), 0, 0, (_local_5.height / _local_6.height), _local_9.tx, _local_9.ty);
                    _arg_2.lineStyle();
                    _arg_2.beginBitmapFill(_local_7, _local_9, false, true);
                    _arg_2.drawRect(Math.floor(_local_5.x), Math.floor(_local_5.y), Math.ceil(_local_5.width), Math.ceil(_local_5.height));
                    _arg_2.endFill();
                }
                else
                {
                    _arg_2.lineStyle();
                    _arg_2.beginBitmapFill(_local_7, _local_9, false, true);
                    _arg_2.drawRect(_local_6.x, _local_6.y, _local_6.width, _local_6.height);
                    _arg_2.endFill();
                };
            }
            else
            {
                if (transMatrix)
                {
                    if ((owner is IDisplayObjectProxy))
                    {
                        if (((owner._layoutMatrix) && (IDisplayObjectProxy(owner).layoutMode == "scale")))
                        {
                            _local_9.concat(CommandStack.currentTransformMatrix);
                        }
                        else
                        {
                            _local_9.concat(currentTransformMatrix);
                            transMatrix = currentTransformMatrix;
                        };
                    }
                    else
                    {
                        _local_9.concat(transMatrix);
                    };
                };
                _arg_2.beginBitmapFill(_local_7, _local_9, false, true);
                lineTo = _arg_2.lineTo;
                curveTo = _arg_2.curveTo;
                moveTo = _arg_2.moveTo;
                renderCommandStack(_arg_2, _arg_4, new DegrafaCursor(this.source));
            };
        }

        private function predraw():void
        {
            var _local_4:Rectangle;
            var _local_1:Geometry = owner;
            while (_local_1.parent)
            {
                _local_1 = (_local_1.parent as Geometry);
                if (_local_1.transform)
                {
                    owner.transformContext = _local_1.transform.getTransformFor(_local_1);
                    break;
                };
            };
            var _local_2:Boolean = owner.hasLayout;
            transMatrix = null;
            currentLayoutMatrix.identity();
            if (_local_2)
            {
                _local_4 = ((owner is IDisplayObjectProxy) ? owner.bounds : bounds);
                if (!_local_4.equals(owner.layoutRectangle))
                {
                    currentLayoutMatrix.translate(-(_local_4.x), -(_local_4.y));
                    currentLayoutMatrix.scale((owner.layoutRectangle.width / _local_4.width), (owner.layoutRectangle.height / _local_4.height));
                    currentLayoutMatrix.translate(owner.layoutRectangle.x, owner.layoutRectangle.y);
                    owner._layoutMatrix = currentLayoutMatrix.clone();
                    transMatrix = currentLayoutMatrix.clone();
                }
                else
                {
                    _local_2 = false;
                    owner._layoutMatrix = null;
                    currentLayoutMatrix.identity();
                };
            }
            else
            {
                if (owner._layoutMatrix)
                {
                    owner._layoutMatrix = null;
                };
            };
            var _local_3:Boolean = ((owner.transformContext) || ((owner.transform) && (!(owner.transform.isIdentity))));
            if (_local_3)
            {
                currentTransformMatrix = ((owner.transform) ? owner.transform.getTransformFor(owner) : owner.transformContext);
                if (!_local_2)
                {
                    transMatrix = ((owner.transform) ? owner.transform.getTransformFor(owner) : owner.transformContext);
                }
                else
                {
                    transMatrix.concat(((owner.transform) ? owner.transform.getTransformFor(owner) : owner.transformContext));
                };
            }
            else
            {
                currentTransformMatrix.identity();
                if (!_local_2)
                {
                    transMatrix = null;
                };
            };
        }

        public function simpleRender(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            lineTo = _arg_1.lineTo;
            curveTo = _arg_1.curveTo;
            moveTo = _arg_1.moveTo;
            renderCommandStack(_arg_1, _arg_2, new DegrafaCursor(this.source));
        }

        public function addCurveTo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):CommandStackItem
        {
            var _local_5:int = (source.push(new CommandStackItem(CommandStackItem.CURVE_TO, NaN, NaN, _arg_3, _arg_4, _arg_1, _arg_2)) - 1);
            updateItemRelations(source[_local_5], _local_5);
            source[_local_5].indexInParent = _local_5;
            source[_local_5].parent = this;
            invalidated = true;
            return (source[_local_5]);
        }

        public function get pathLength():Number
        {
            var _local_1:CommandStackItem;
            if (lengthInvalidated)
            {
                lengthInvalidated = false;
                _pathLength = 0;
                for each (_local_1 in source)
                {
                    _pathLength = (_pathLength + _local_1.segmentLength);
                };
            };
            return (_pathLength);
        }

        public function addItem(_arg_1:CommandStackItem):CommandStackItem
        {
            var _local_2:int = (source.push(_arg_1) - 1);
            updateItemRelations(source[_local_2], _local_2);
            _arg_1.indexInParent = _local_2;
            _arg_1.parent = this;
            invalidated = true;
            return (source[_local_2]);
        }

        public function get length():int
        {
            return (source.length);
        }

        public function get lastSegmentWithLength():CommandStackItem
        {
            var _local_1:int = (source.length - 1);
            while (_local_1 > 0)
            {
                if (((source[_local_1].type == 1) || (source[_local_1].type == 2)))
                {
                    return (source[_local_1]);
                };
                if (source[_local_1].type == 4)
                {
                    return (source[_local_1].commandStack.lastSegmentWithLength);
                };
                _local_1--;
            };
            return (source[(length - 1)]);
        }

        public function set globalRenderDelegateEnd(_arg_1:Array):void
        {
            if (_globalRenderDelegateEnd != _arg_1)
            {
                _globalRenderDelegateEnd = _arg_1;
                invalidated = true;
            };
        }


    }
}//package com.degrafa.geometry.command

