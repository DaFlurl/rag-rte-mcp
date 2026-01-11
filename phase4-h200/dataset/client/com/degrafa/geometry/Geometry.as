// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.Geometry

package com.degrafa.geometry
{
    import com.degrafa.core.DegrafaObject;
    import com.degrafa.core.IDegrafaObject;
    import com.degrafa.IGeometryComposition;
    import com.degrafa.states.IDegrafaStateClient;
    import mx.styles.ISimpleStyleClient;
    import com.degrafa.core.collections.DisplayObjectCollection;
    import flash.geom.Rectangle;
    import com.degrafa.core.IGraphicsFill;
    import com.degrafa.core.collections.FilterCollection;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.utils.Dictionary;
    import com.degrafa.geometry.layout.LayoutConstraint;
    import com.degrafa.core.collections.DecoratorCollection;
    import com.degrafa.core.IGraphicsStroke;
    import com.degrafa.core.collections.GeometryCollection;
    import com.degrafa.states.StateManager;
    import com.degrafa.geometry.command.CommandStack;
    import com.degrafa.transform.ITransform;
    import flash.display.Stage;
    import flash.events.Event;
    import mx.core.UIComponent;
    import mx.events.FlexEvent;
    import com.degrafa.states.State;
    import mx.binding.utils.ChangeWatcher;
    import mx.events.PropertyChangeEvent;
    import flash.display.DisplayObject;
    import com.degrafa.core.ITransformablePaint;
    import flash.display.Graphics;
    import com.degrafa.events.DegrafaEvent;
    import com.degrafa.triggers.ITrigger;
    import flash.geom.Point;
    import com.degrafa.core.IGraphicSkin;

    [Bindable(event="propertyChange")]
    public class Geometry extends DegrafaObject implements IDegrafaObject, IGeometryComposition, IDegrafaStateClient, ISimpleStyleClient 
    {

        private var _graphicsTarget:DisplayObjectCollection;
        private var _maskMode:String;
        private var methodQue:Array = [];
        public var hasFilters:Boolean;
        private var _stateEvent:String;
        private var _autoClearGraphicsTarget:Boolean = true;
        private var _clippingRectangle:Rectangle = null;
        private var _styleName:Object;
        protected var _fill:IGraphicsFill;
        public var hasLayout:Boolean;
        public var hasTriggers:Boolean;
        private var _currentState:String = "";
        private var _data:String;
        private var _filters:FilterCollection;
        private var _invalidated:Boolean;
        protected var _currentGraphicsTarget:Sprite;
        private var _transformContext:Matrix;
        private var targetDictionary:Dictionary = new Dictionary(true);
        private var _inheritStroke:Boolean = true;
        protected var _layoutConstraint:LayoutConstraint;
        private var _triggers:Array = [];
        private var _states:Array = [];
        protected var _layoutRectangle:Rectangle;
        private var _visible:Boolean = true;
        private var _decorators:DecoratorCollection;
        public var hasStates:Boolean;
        protected var _stroke:IGraphicsStroke;
        private var _inheritFill:Boolean = true;
        public var _layoutMatrix:Matrix;
        private var _state:String;
        private var _mask:IGeometryComposition;
        private var _geometry:GeometryCollection;
        public var hasDecorators:Boolean;
        private var stateManager:StateManager;
        private var _isRootGeometry:Boolean = false;
        private var _commandStack:CommandStack;
        private var _transform:ITransform;
        private var _stage:Stage;


        public function get states():Array
        {
            return (_states);
        }

        private function onTargetRender(_arg_1:Event):void
        {
            if (!_stage)
            {
                _stage = _arg_1.currentTarget.stage;
            };
            if (_stage)
            {
                _arg_1.currentTarget.removeEventListener(Event.RENDER, onTargetRender);
                _arg_1.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, onTargetRender);
                if ((_arg_1.currentTarget is UIComponent))
                {
                    _arg_1.currentTarget.removeEventListener(FlexEvent.UPDATE_COMPLETE, onTargetRender);
                };
            }
            else
            {
                return;
            };
            if ((_arg_1.currentTarget is UIComponent))
            {
                initLayoutChangeWatcher((_arg_1.currentTarget as UIComponent));
            };
            initDrawQue();
            queDraw(_arg_1.currentTarget, _arg_1.currentTarget.graphics, null);
        }

        public function get left():Number
        {
            return ((hasLayout) ? layoutConstraint.left : NaN);
        }

        public function get maintainAspectRatio():Boolean
        {
            return ((hasLayout) ? layoutConstraint.maintainAspectRatio : false);
        }

        public function set states(_arg_1:Array):void
        {
            var _local_2:State;
            _states = _arg_1;
            if (_arg_1)
            {
                if (!stateManager)
                {
                    stateManager = new StateManager(this);
                    for each (_local_2 in _states)
                    {
                        _local_2.stateManager = stateManager;
                    };
                };
            }
            else
            {
                stateManager = null;
            };
            if (((_arg_1) && (!(_arg_1.length == 0))))
            {
                hasStates = true;
            }
            else
            {
                hasStates = false;
            };
        }

        public function set maintainAspectRatio(_arg_1:Boolean):void
        {
            layoutConstraint.maintainAspectRatio = _arg_1;
        }

        public function set left(_arg_1:Number):void
        {
            layoutConstraint.left = _arg_1;
        }

        public function get minHeight():Number
        {
            return ((hasLayout) ? layoutConstraint.minHeight : NaN);
        }

        public function get right():Number
        {
            return ((hasLayout) ? layoutConstraint.right : NaN);
        }

        public function set inheritStroke(_arg_1:Boolean):void
        {
            _inheritStroke = _arg_1;
        }

        private function onTargetChange(_arg_1:Event):void
        {
            var _local_3:Array;
            var _local_4:ChangeWatcher;
            var _local_5:UIComponent;
            var _local_6:Rectangle;
            var _local_2:Object = requestTarget((_arg_1.currentTarget as UIComponent));
            if (_local_2)
            {
                _local_3 = _local_2.data.watchers;
            };
            if (_local_2)
            {
                if (!hasLayout)
                {
                    for each (_local_4 in _local_3)
                    {
                        _local_4.unwatch();
                    };
                    removeTarget((_arg_1.currentTarget as UIComponent));
                    return;
                };
            };
            if (_local_2)
            {
                _local_5 = (_arg_1.currentTarget as UIComponent);
                _local_6 = new Rectangle(_local_5.x, _local_5.y, _local_5.width, _local_5.height);
                if (!_local_6.equals(_local_2.data.oldbounds))
                {
                    addUpdateTarget(_local_5, {
                        "oldbounds":_local_6,
                        "watchers":_local_3
                    });
                    queDraw(_local_5, _local_5.graphics, null);
                };
            };
        }

        public function get bottom():Number
        {
            return ((hasLayout) ? layoutConstraint.bottom : NaN);
        }

        public function calculateLayout(_arg_1:Rectangle=null):void
        {
            var _local_2:Rectangle;
            if (_layoutConstraint)
            {
                if (!_arg_1)
                {
                    _arg_1 = new Rectangle(0, 0, 1, 1);
                };
                if (((parent) && (parent is Geometry)))
                {
                    _layoutConstraint.computeLayoutRectangle(_arg_1, Geometry(parent).layoutRectangle);
                    return;
                };
                if (_currentGraphicsTarget)
                {
                    _local_2 = _currentGraphicsTarget.getRect(_currentGraphicsTarget);
                    if (_local_2.isEmpty())
                    {
                        if (((!(_currentGraphicsTarget.width == 0)) || (!(_currentGraphicsTarget.height == 0))))
                        {
                            _local_2.x = _currentGraphicsTarget.x;
                            _local_2.y = _currentGraphicsTarget.y;
                            _local_2.width = _currentGraphicsTarget.width;
                            _local_2.height = _currentGraphicsTarget.height;
                        };
                    };
                    _layoutConstraint.computeLayoutRectangle(_arg_1, _local_2);
                    return;
                };
                if (document)
                {
                    _layoutConstraint.computeLayoutRectangle(_arg_1, new Rectangle(document.x, document.y, document.width, document.height));
                    return;
                };
            };
        }

        public function set minHeight(_arg_1:Number):void
        {
            layoutConstraint.minHeight = _arg_1;
        }

        public function get stroke():IGraphicsStroke
        {
            return (_stroke);
        }

        public function set inheritFill(_arg_1:Boolean):void
        {
            _inheritFill = _arg_1;
        }

        public function get minX():Number
        {
            return ((hasLayout) ? layoutConstraint.minX : NaN);
        }

        public function get minY():Number
        {
            return ((hasLayout) ? layoutConstraint.minY : NaN);
        }

        public function set height(_arg_1:Number):void
        {
            layoutConstraint.height = _arg_1;
        }

        public function set right(_arg_1:Number):void
        {
            layoutConstraint.right = _arg_1;
        }

        public function set bottom(_arg_1:Number):void
        {
            layoutConstraint.bottom = _arg_1;
        }

        public function angleAt(_arg_1:Number):Number
        {
            return (commandStack.pathAngleAt(_arg_1));
        }

        public function set stroke(_arg_1:IGraphicsStroke):void
        {
            var _local_2:Object;
            if (_stroke != _arg_1)
            {
                _local_2 = _stroke;
                if (_stroke)
                {
                    if (_stroke.hasEventManager)
                    {
                        _stroke.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    };
                };
                _stroke = _arg_1;
                if (((enableEvents) && (_stroke)))
                {
                    _stroke.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
                initChange("stroke", _local_2, _stroke, this);
            };
        }

        private function processMethodQue(_arg_1:Event):void
        {
            if (methodQue.length == 0)
            {
                return;
            };
            var _local_2:Array = methodQue;
            methodQue = [];
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_2[_local_4].method.apply(null, [_local_2[_local_4].args[0]]);
                _local_4++;
            };
            _local_2.length = 0;
            if (((methodQue.length == 0) && (_stage)))
            {
                _stage.removeEventListener(Event.ENTER_FRAME, processMethodQue);
            };
        }

        public function get geometry():Array
        {
            initGeometryCollection();
            return (_geometry.items);
        }

        public function get x():Number
        {
            return ((hasLayout) ? layoutConstraint.x : NaN);
        }

        public function get y():Number
        {
            return ((hasLayout) ? layoutConstraint.y : NaN);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get geometricLength():Number
        {
            return (commandStack.pathLength);
        }

        public function get percentWidth():Number
        {
            return ((hasLayout) ? layoutConstraint.percentWidth : NaN);
        }

        public function set minX(_arg_1:Number):void
        {
            layoutConstraint.minX = _arg_1;
        }

        public function preDraw():void
        {
        }

        public function get invalidated():Boolean
        {
            return (_invalidated);
        }

        public function get state():String
        {
            return (_state);
        }

        public function get minWidth():Number
        {
            return ((hasLayout) ? layoutConstraint.minWidth : NaN);
        }

        public function set minY(_arg_1:Number):void
        {
            layoutConstraint.minY = _arg_1;
        }

        public function get stateEvent():String
        {
            return (_stateEvent);
        }

        public function get targetCoordinateSpace():DisplayObject
        {
            return ((hasLayout) ? layoutConstraint.targetCoordinateSpace : null);
        }

        [Bindable("currentStateChange")]
        public function get currentState():String
        {
            return ((stateManager) ? stateManager.currentState : "");
        }

        public function get transformContext():Matrix
        {
            return (_transformContext);
        }

        public function get layoutConstraint():LayoutConstraint
        {
            if (!_layoutConstraint)
            {
                layoutConstraint = new LayoutConstraint();
            };
            return (_layoutConstraint);
        }

        public function set top(_arg_1:Number):void
        {
            layoutConstraint.top = _arg_1;
        }

        public function get maskMode():String
        {
            return ((_maskMode) ? _maskMode : "clip");
        }

        public function get geometryCollection():GeometryCollection
        {
            initGeometryCollection();
            return (_geometry);
        }

        public function initFill(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (parent)
            {
                if ((((inheritFill) && (!(_fill))) && (parent is Geometry)))
                {
                    _fill = Geometry(parent).fill;
                };
            };
            if (_fill)
            {
                if ((_fill is ITransformablePaint))
                {
                    (_fill as ITransformablePaint).requester = this;
                };
                _fill.begin(_arg_1, ((_arg_2) ? _arg_2 : null));
                CommandStack.currentFill = _fill;
            }
            else
            {
                CommandStack.currentFill = null;
            };
        }

        public function get bounds():Rectangle
        {
            return (commandStack.bounds);
        }

        public function endDraw(_arg_1:Graphics):void
        {
            var _local_2:IGeometryComposition;
            if (fill)
            {
                _arg_1.lineStyle.apply(_arg_1, null);
                fill.end(_arg_1);
            };
            if (((stroke) && (!(fill))))
            {
                _arg_1.moveTo.call(_arg_1, null, null);
            };
            if (geometry)
            {
                for each (_local_2 in geometry)
                {
                    _local_2.draw(_arg_1, null);
                };
            };
            dispatchEvent(new DegrafaEvent(DegrafaEvent.RENDER));
        }

        public function get maxWidth():Number
        {
            return ((hasLayout) ? layoutConstraint.maxWidth : NaN);
        }

        public function get clippingRectangle():Rectangle
        {
            return (_clippingRectangle);
        }

        public function set transform(_arg_1:ITransform):void
        {
            var _local_2:Object;
            if (((parent) && ((parent as Geometry).transform)))
            {
                _transformContext = (parent as Geometry).transform.getTransformFor((parent as Geometry));
            };
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

        public function set verticalCenter(_arg_1:Number):void
        {
            layoutConstraint.verticalCenter = _arg_1;
        }

        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:Boolean;
            if (_visible != _arg_1)
            {
                _local_2 = _visible;
                _visible = _arg_1;
                invalidated = true;
                initChange("visible", _local_2, _visible, this);
            };
        }

        public function set maxX(_arg_1:Number):void
        {
            layoutConstraint.maxX = _arg_1;
        }

        public function set geometry(_arg_1:Array):void
        {
            initGeometryCollection();
            _geometry.items = _arg_1;
        }

        public function get mask():IGeometryComposition
        {
            return (_mask);
        }

        public function set x(_arg_1:Number):void
        {
            layoutConstraint.x = _arg_1;
        }

        private function initGraphicsTargetCollection():void
        {
            if (!_graphicsTarget)
            {
                _graphicsTarget = new DisplayObjectCollection();
                if (enableEvents)
                {
                    _graphicsTarget.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        public function set y(_arg_1:Number):void
        {
            layoutConstraint.y = _arg_1;
        }

        public function set autoClearGraphicsTarget(_arg_1:Boolean):void
        {
            _autoClearGraphicsTarget = _arg_1;
        }

        public function set maxY(_arg_1:Number):void
        {
            layoutConstraint.maxY = _arg_1;
        }

        private function addUpdateTarget(_arg_1:UIComponent, _arg_2:Object):void
        {
            if (!targetDictionary[_arg_1])
            {
                targetDictionary[_arg_1] = [];
                targetDictionary[_arg_1].data = _arg_2;
            }
            else
            {
                targetDictionary[_arg_1].data = _arg_2;
            };
        }

        public function get isInvalidated():Boolean
        {
            return (_invalidated);
        }

        private function requestTarget(_arg_1:UIComponent):Object
        {
            return (targetDictionary[_arg_1]);
        }

        public function set fill(_arg_1:IGraphicsFill):void
        {
            var _local_2:Object;
            if (_fill != _arg_1)
            {
                _local_2 = _fill;
                if (_fill)
                {
                    if (_fill.hasEventManager)
                    {
                        _fill.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    };
                };
                _fill = _arg_1;
                if (enableEvents)
                {
                    _fill.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
                initChange("fill", _local_2, _fill, this);
            };
        }

        public function set percentWidth(_arg_1:Number):void
        {
            layoutConstraint.percentWidth = _arg_1;
        }

        public function get inheritStroke():Boolean
        {
            return (_inheritStroke);
        }

        public function set invalidated(_arg_1:Boolean):void
        {
            if (_invalidated != _arg_1)
            {
                _invalidated = _arg_1;
                if (((_invalidated) && (_isRootGeometry)))
                {
                    drawToTargets();
                };
            };
        }

        public function get inheritFill():Boolean
        {
            return (_inheritFill);
        }

        public function set state(_arg_1:String):void
        {
            _state = _arg_1;
        }

        public function drawToTargets():void
        {
            var _local_1:Object;
            if (_graphicsTarget)
            {
                for each (_local_1 in _graphicsTarget.items)
                {
                    queDraw(_local_1, _local_1.graphics, null);
                };
            };
            _currentGraphicsTarget = null;
        }

        public function get height():Number
        {
            return ((hasLayout) ? layoutConstraint.height : NaN);
        }

        public function set minWidth(_arg_1:Number):void
        {
            layoutConstraint.minWidth = _arg_1;
        }

        public function set stateEvent(_arg_1:String):void
        {
            _stateEvent = _arg_1;
        }

        public function set decorators(_arg_1:Array):void
        {
            initDecoratorsCollection();
            _decorators.items = _arg_1;
            if (((_arg_1) && (!(_arg_1.length == 0))))
            {
                hasDecorators = true;
            }
            else
            {
                hasDecorators = false;
            };
        }

        public function set horizontalCenter(_arg_1:Number):void
        {
            layoutConstraint.horizontalCenter = _arg_1;
        }

        private function removeTarget(_arg_1:UIComponent):void
        {
            delete targetDictionary[_arg_1];
        }

        public function get decoratorCollection():DecoratorCollection
        {
            initDecoratorsCollection();
            return (_decorators);
        }

        public function set targetCoordinateSpace(_arg_1:DisplayObject):void
        {
            layoutConstraint.targetCoordinateSpace = _arg_1;
        }

        public function set currentState(_arg_1:String):void
        {
            stateManager.currentState = _arg_1;
        }

        public function get transformBounds():Rectangle
        {
            return (commandStack.transformBounds);
        }

        public function draw(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (!visible)
            {
                return;
            };
            commandStack.draw(_arg_1, _arg_2);
            endDraw(_arg_1);
        }

        public function set transformContext(_arg_1:Matrix):void
        {
            _transformContext = _arg_1;
        }

        public function set layoutConstraint(_arg_1:LayoutConstraint):void
        {
            var _local_2:Object;
            if (_layoutConstraint != _arg_1)
            {
                _local_2 = _layoutConstraint;
                if (_layoutConstraint)
                {
                    if (_layoutConstraint.hasEventManager)
                    {
                        _layoutConstraint.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    };
                };
                _layoutConstraint = _arg_1;
                if (enableEvents)
                {
                    _layoutConstraint.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler, false, 0, true);
                };
                initChange("layoutConstraint", _local_2, _layoutConstraint, this);
                hasLayout = true;
            };
        }

        private function drawToTarget(_arg_1:Object):void
        {
            if (_arg_1)
            {
                if (autoClearGraphicsTarget)
                {
                    _arg_1.graphics.clear();
                };
                _currentGraphicsTarget = (_arg_1 as Sprite);
                draw(_arg_1.graphics, null);
            };
        }

        public function get top():Number
        {
            return ((hasLayout) ? layoutConstraint.top : NaN);
        }

        public function set maxHeight(_arg_1:Number):void
        {
            layoutConstraint.maxHeight = _arg_1;
        }

        public function set data(_arg_1:String):void
        {
            _data = _arg_1;
        }

        public function set maskMode(_arg_1:String):void
        {
            if (((!(_mask == _arg_1)) && ((_arg_1 == "alpha") || (_arg_1 == "clip"))))
            {
                if (_mask)
                {
                    initChange("maskMode", maskMode, (_maskMode = _arg_1), this);
                }
                else
                {
                    _maskMode = _arg_1;
                };
            };
        }

        public function get layoutRectangle():Rectangle
        {
            return ((_layoutRectangle) ? _layoutRectangle : bounds);
        }

        private function initFilterCollection():void
        {
            if (!_filters)
            {
                _filters = new FilterCollection();
                _filters.parent = this;
                if (enableEvents)
                {
                    _filters.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        public function initStroke(_arg_1:Graphics, _arg_2:Rectangle):void
        {
            if (parent)
            {
                if ((((inheritStroke) && (!(_stroke))) && (parent is Geometry)))
                {
                    _stroke = Geometry(parent).stroke;
                };
            };
            if (_stroke)
            {
                if ((_stroke is ITransformablePaint))
                {
                    (_stroke as ITransformablePaint).requester = this;
                };
                _stroke.apply(_arg_1, ((_arg_2) ? _arg_2 : null));
                CommandStack.currentStroke = _stroke;
            }
            else
            {
                _arg_1.lineStyle();
                CommandStack.currentStroke = null;
            };
        }

        public function get verticalCenter():Number
        {
            return ((hasLayout) ? layoutConstraint.verticalCenter : NaN);
        }

        public function get transform():ITransform
        {
            return (_transform);
        }

        public function get maxX():Number
        {
            return ((hasLayout) ? layoutConstraint.maxX : NaN);
        }

        public function get maxY():Number
        {
            return ((hasLayout) ? layoutConstraint.maxY : NaN);
        }

        public function set triggers(_arg_1:Array):void
        {
            var _local_2:ITrigger;
            _triggers = _arg_1;
            if (_triggers)
            {
                for each (_local_2 in _triggers)
                {
                    _local_2.triggerParent = this;
                };
            };
            if (((_arg_1) && (!(_arg_1.length == 0))))
            {
                hasTriggers = true;
            }
            else
            {
                hasTriggers = false;
            };
        }

        public function get autoClearGraphicsTarget():Boolean
        {
            return (_autoClearGraphicsTarget);
        }

        public function get fill():IGraphicsFill
        {
            return (_fill);
        }

        public function set maxWidth(_arg_1:Number):void
        {
            layoutConstraint.maxWidth = _arg_1;
        }

        private function initDecoratorsCollection():void
        {
            if (!_decorators)
            {
                _decorators = new DecoratorCollection();
                if (enableEvents)
                {
                    _decorators.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        public function set width(_arg_1:Number):void
        {
            layoutConstraint.width = _arg_1;
        }

        public function get decorators():Array
        {
            initDecoratorsCollection();
            return (_decorators.items);
        }

        public function get horizontalCenter():Number
        {
            return ((hasLayout) ? layoutConstraint.horizontalCenter : NaN);
        }

        public function set clippingRectangle(_arg_1:Rectangle):void
        {
            var _local_2:Rectangle;
            if (_clippingRectangle != _arg_1)
            {
                _local_2 = _clippingRectangle;
                _clippingRectangle = _arg_1;
                initChange("clippingRectangle", _local_2, _clippingRectangle, this);
            };
        }

        public function set percentHeight(_arg_1:Number):void
        {
            layoutConstraint.percentHeight = _arg_1;
        }

        private function queDraw(... _args):void
        {
            var _local_2:Object;
            for each (_local_2 in methodQue)
            {
                if (_local_2.args[0] == _args[0])
                {
                    return;
                };
            };
            methodQue.push({
                "method":drawToTarget,
                "args":_args
            });
            if (_stage)
            {
                _stage.addEventListener(Event.ENTER_FRAME, processMethodQue);
            }
            else
            {
                if (graphicsTarget.length)
                {
                    if (graphicsTarget[0].stage)
                    {
                        _stage = graphicsTarget[0].stage;
                        _stage.addEventListener(Event.ENTER_FRAME, processMethodQue);
                    };
                };
            };
        }

        public function get data():String
        {
            return (_data);
        }

        public function get maxHeight():Number
        {
            return ((hasLayout) ? layoutConstraint.maxHeight : NaN);
        }

        protected function propertyChangeHandler(_arg_1:PropertyChangeEvent):void
        {
            if (!parent)
            {
                dispatchEvent(_arg_1);
                drawToTargets();
            }
            else
            {
                dispatchEvent(_arg_1);
            };
        }

        private function initDrawQue():void
        {
            _stage.addEventListener(Event.ENTER_FRAME, processMethodQue);
        }

        private function initLayoutChangeWatcher(_arg_1:UIComponent):void
        {
            var _local_2:Rectangle = new Rectangle(_arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
            var _local_3:Array = [];
            _local_3.push(ChangeWatcher.watch(_arg_1, "width", onTargetChange, true));
            _local_3.push(ChangeWatcher.watch(_arg_1, "height", onTargetChange, true));
            _local_3.push(ChangeWatcher.watch(_arg_1, "x", onTargetChange, true));
            _local_3.push(ChangeWatcher.watch(_arg_1, "y", onTargetChange, true));
            if (!requestTarget(_arg_1))
            {
                addUpdateTarget(_arg_1, {
                    "oldbounds":_local_2,
                    "watchers":_local_3
                });
            };
        }

        public function get triggers():Array
        {
            return (_triggers);
        }

        public function get isRootGeometry():Boolean
        {
            return (_isRootGeometry);
        }

        public function get graphicsTargetCollection():DisplayObjectCollection
        {
            initGraphicsTargetCollection();
            return (_graphicsTarget);
        }

        public function styleChanged(_arg_1:String):void
        {
        }

        public function get width():Number
        {
            return ((hasLayout) ? _layoutConstraint.width : NaN);
        }

        public function set styleName(_arg_1:Object):void
        {
            _styleName = _arg_1;
        }

        public function get percentHeight():Number
        {
            return ((hasLayout) ? layoutConstraint.percentHeight : NaN);
        }

        public function set mask(_arg_1:IGeometryComposition):void
        {
            var _local_2:IGeometryComposition;
            if (((!(_mask == _arg_1)) && (!(_arg_1 == this))))
            {
                if (_mask)
                {
                    Geometry(_mask).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
                _local_2 = _mask;
                _mask = _arg_1;
                Geometry(_mask).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                initChange("mask", _local_2, _mask, this);
            };
        }

        private function initGeometryCollection():void
        {
            if (!_geometry)
            {
                _geometry = new GeometryCollection();
                _geometry.parent = this;
                if (enableEvents)
                {
                    _geometry.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                };
            };
        }

        public function pointAt(_arg_1:Number):Point
        {
            return (commandStack.pathPointAt(_arg_1));
        }

        public function get styleName():Object
        {
            return (_styleName);
        }

        public function clearGraphicsTargets():void
        {
            var _local_1:Object;
            if (graphicsTarget)
            {
                for each (_local_1 in graphicsTarget)
                {
                    if (_local_1)
                    {
                        _local_1.graphics.clear();
                    };
                };
            };
        }

        public function set filters(_arg_1:Array):void
        {
            var _local_2:Array;
            initFilterCollection();
            if (_filters.items != _arg_1)
            {
                _local_2 = _filters.items;
                _filters.items = _arg_1;
                initChange("filters", _local_2, _filters.items, this);
            };
            if (((_arg_1) && (!(_arg_1.length == 0))))
            {
                hasFilters = true;
            }
            else
            {
                hasFilters = false;
            };
        }

        public function set graphicsTarget(_arg_1:Array):void
        {
            var _local_2:Object;
            var _local_3:DisplayObject;
            if (!_arg_1)
            {
                return;
            };
            for each (_local_2 in _arg_1)
            {
                if (!_local_2)
                {
                    return;
                };
            };
            initGraphicsTargetCollection();
            _graphicsTarget.items = _arg_1;
            for each (_local_3 in _graphicsTarget.items)
            {
                if (!(_local_3 is IGraphicSkin))
                {
                    _local_3.addEventListener(Event.RENDER, onTargetRender);
                    _local_3.addEventListener(Event.ADDED_TO_STAGE, onTargetRender);
                    if ((_local_3 is UIComponent))
                    {
                        _local_3.addEventListener(FlexEvent.UPDATE_COMPLETE, onTargetRender);
                    };
                };
            };
            _isRootGeometry = true;
        }

        public function set commandStack(_arg_1:CommandStack):void
        {
            _commandStack = _arg_1;
        }

        public function get filters():Array
        {
            initFilterCollection();
            return (_filters.items);
        }

        public function get graphicsTarget():Array
        {
            initGraphicsTargetCollection();
            return (_graphicsTarget.items);
        }

        public function get commandStack():CommandStack
        {
            if (!_commandStack)
            {
                _commandStack = new CommandStack(this);
            };
            return (_commandStack);
        }


    }
}//package com.degrafa.geometry

