// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.MaskEffectInstance

package mx.effects.effectClasses
{
    import mx.effects.EffectInstance;
    import flash.display.Shape;
    import mx.effects.Tween;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import mx.events.ResizeEvent;
    import mx.core.Container;
    import mx.core.IInvalidating;
    import mx.effects.EffectManager;
    import mx.core.IUIComponent;
    import mx.events.TweenEvent;
    import mx.controls.SWFLoader;
    import mx.core.FlexShape;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import flash.utils.getTimer;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class MaskEffectInstance extends EffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var useSnapshotBounds:Boolean = true;
        public var scaleEasingFunction:Function;
        public var xTo:Number;
        private var _showTarget:Boolean = true;
        private var stoppedEarly:Boolean = false;
        public var scaleXFrom:Number;
        public var scaleYFrom:Number;
        protected var effectMask:Shape;
        private var _createMaskFunction:Function;
        private var moveTween:Tween;
        public var scaleYTo:Number;
        private var scaleTween:Tween;
        public var xFrom:Number;
        public var yFrom:Number;
        public var targetArea:Rectangle;
        protected var targetVisualBounds:Rectangle;
        private var invalidateBorder:Boolean = false;
        private var origMask:DisplayObject;
        private var currentMoveTweenValue:Object;
        private var dispatchedStartEvent:Boolean = false;
        mx_internal var persistAfterEnd:Boolean = false;
        public var moveEasingFunction:Function;
        public var yTo:Number;
        private var _showExplicitlySet:Boolean = false;
        public var scaleXTo:Number;
        private var tweenCount:int = 0;
        private var origScrollRect:Rectangle;
        private var currentScaleTweenValue:Object;
        private var effectMaskRefCount:Number = 0;
        private var MASK_NAME:String = "_maskEffectMask";

        public function MaskEffectInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function get playheadTime():Number
        {
            var _local_1:Number;
            if (moveTween)
            {
                _local_1 = moveTween.playheadTime;
            }
            else
            {
                if (scaleTween)
                {
                    _local_1 = scaleTween.playheadTime;
                }
                else
                {
                    return (0);
                };
            };
            return (_local_1 + super.playheadTime);
        }

        public function set createMaskFunction(_arg_1:Function):void
        {
            _createMaskFunction = _arg_1;
        }

        override public function stop():void
        {
            stoppedEarly = true;
            super.stop();
            if (moveTween)
            {
                moveTween.stop();
            };
            if (scaleTween)
            {
                scaleTween.stop();
            };
        }

        override public function finishEffect():void
        {
            target.removeEventListener(ResizeEvent.RESIZE, eventHandler);
            if (((!(persistAfterEnd)) && (!(stoppedEarly))))
            {
                removeMask();
            };
            super.finishEffect();
        }

        private function removeMask():void
        {
            if (--effectMaskRefCount == 0)
            {
                if (((origMask == null) || ((origMask) && (!(origMask.name == MASK_NAME)))))
                {
                    target.mask = origMask;
                };
                if (origScrollRect)
                {
                    target.scrollRect = origScrollRect;
                };
                if ((target is Container))
                {
                    target.rawChildren.removeChild(effectMask);
                }
                else
                {
                    target.removeChild(effectMask);
                };
                effectMask = null;
            };
        }

        private function initMask():void
        {
            if (!effectMask)
            {
                if (useSnapshotBounds)
                {
                    targetVisualBounds = getVisibleBounds(DisplayObject(target));
                }
                else
                {
                    targetVisualBounds = new Rectangle(0, 0, target.width, target.height);
                };
                effectMask = createMaskFunction(target, targetVisualBounds);
                if ((target is Container))
                {
                    target.rawChildren.addChild(effectMask);
                }
                else
                {
                    target.addChild(effectMask);
                };
                effectMask.name = MASK_NAME;
                effectMaskRefCount = 0;
            };
            effectMask.x = 0;
            effectMask.y = 0;
            effectMask.alpha = 0.3;
            effectMask.visible = false;
            if (effectMaskRefCount++ == 0)
            {
                if (target.mask)
                {
                    origMask = target.mask;
                };
                target.mask = effectMask;
                if (target.scrollRect)
                {
                    origScrollRect = target.scrollRect;
                    target.scrollRect = null;
                };
            };
            invalidateBorder = ((((target is Container) && (!(Container(target).border == null))) && (Container(target).border is IInvalidating)) && (!(DisplayObject(Container(target).border).filters == null)));
        }

        protected function onMoveTweenUpdate(_arg_1:Object):void
        {
            saveTweenValue(_arg_1, null);
            if (effectMask)
            {
                effectMask.x = _arg_1[0];
                effectMask.y = _arg_1[1];
            };
            if (invalidateBorder)
            {
                IInvalidating(Container(target).border).invalidateDisplayList();
            };
        }

        private function finishTween():void
        {
            var _local_1:Array;
            var _local_2:Object;
            if (((tweenCount == 0) || (--tweenCount == 0)))
            {
                EffectManager.endVectorEffect(IUIComponent(target));
                _local_1 = [];
                if (moveTween)
                {
                    _local_2 = moveTween.getCurrentValue(duration);
                    _local_1.push(_local_2[0]);
                    _local_1.push(_local_2[1]);
                }
                else
                {
                    _local_1.push(null);
                    _local_1.push(null);
                };
                if (scaleTween)
                {
                    _local_2 = scaleTween.getCurrentValue(duration);
                    _local_1.push(_local_2[0]);
                    _local_1.push(_local_2[1]);
                }
                else
                {
                    _local_1.push(null);
                    _local_1.push(null);
                };
                dispatchEvent(new TweenEvent(TweenEvent.TWEEN_END, false, false, _local_1));
                finishRepeat();
            };
        }

        override public function startEffect():void
        {
            initMask();
            target.addEventListener(ResizeEvent.RESIZE, eventHandler);
            super.startEffect();
        }

        public function get createMaskFunction():Function
        {
            return ((_createMaskFunction != null) ? _createMaskFunction : defaultCreateMask);
        }

        protected function defaultCreateMask(_arg_1:Object, _arg_2:Rectangle):Shape
        {
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_3:Number = (_arg_2.width / Math.abs(_arg_1.scaleX));
            var _local_4:Number = (_arg_2.height / Math.abs(_arg_1.scaleY));
            if ((_arg_1 is SWFLoader))
            {
                _arg_1.validateDisplayList();
                if (_arg_1.content)
                {
                    _local_3 = _arg_1.contentWidth;
                    _local_4 = _arg_1.contentHeight;
                };
            };
            var _local_5:Shape = new FlexShape();
            var _local_6:Graphics = _local_5.graphics;
            _local_6.beginFill(0xFFFF00);
            _local_6.drawRect(0, 0, _local_3, _local_4);
            _local_6.endFill();
            if (target.rotation == 0)
            {
                _local_5.width = _local_3;
                _local_5.height = _local_4;
            }
            else
            {
                _local_7 = ((_arg_1.rotation * Math.PI) / 180);
                _local_8 = Math.sin(_local_7);
                _local_9 = Math.cos(_local_7);
                _local_5.width = Math.abs(((_local_3 * _local_9) - (_local_4 * _local_8)));
                _local_5.height = Math.abs(((_local_3 * _local_8) + (_local_4 * _local_9)));
            };
            return (_local_5);
        }

        private function saveTweenValue(_arg_1:Object, _arg_2:Object):void
        {
            var _local_3:Array;
            if (_arg_1 != null)
            {
                currentMoveTweenValue = _arg_1;
            }
            else
            {
                if (_arg_2 != null)
                {
                    currentScaleTweenValue = _arg_2;
                };
            };
            if ((((moveTween == null) || (!(currentMoveTweenValue == null))) && ((scaleTween == null) || (!(currentScaleTweenValue == null)))))
            {
                _local_3 = [];
                if (currentMoveTweenValue)
                {
                    _local_3.push(currentMoveTweenValue[0]);
                    _local_3.push(currentMoveTweenValue[1]);
                }
                else
                {
                    _local_3.push(null);
                    _local_3.push(null);
                };
                if (currentScaleTweenValue)
                {
                    _local_3.push(currentScaleTweenValue[0]);
                    _local_3.push(currentScaleTweenValue[1]);
                }
                else
                {
                    _local_3.push(null);
                    _local_3.push(null);
                };
                if (!dispatchedStartEvent)
                {
                    dispatchEvent(new TweenEvent(TweenEvent.TWEEN_START));
                    dispatchedStartEvent = true;
                };
                dispatchEvent(new TweenEvent(TweenEvent.TWEEN_UPDATE, false, false, _local_3));
                currentMoveTweenValue = null;
                currentScaleTweenValue = null;
            };
        }

        override mx_internal function set playReversed(_arg_1:Boolean):void
        {
            if (moveTween)
            {
                moveTween.playReversed = _arg_1;
            };
            if (scaleTween)
            {
                scaleTween.playReversed = _arg_1;
            };
            super.playReversed = _arg_1;
        }

        override public function play():void
        {
            super.play();
            initMaskEffect();
            EffectManager.startVectorEffect(IUIComponent(target));
            if (((((!(isNaN(xFrom))) && (!(isNaN(yFrom)))) && (!(isNaN(xTo)))) && (!(isNaN(yTo)))))
            {
                tweenCount++;
                moveTween = new Tween(this, [xFrom, yFrom], [xTo, yTo], duration, -1, onMoveTweenUpdate, onMoveTweenEnd);
                moveTween.playReversed = playReversed;
                if (moveEasingFunction != null)
                {
                    moveTween.easingFunction = moveEasingFunction;
                };
            };
            if (((((!(isNaN(scaleXFrom))) && (!(isNaN(scaleYFrom)))) && (!(isNaN(scaleXTo)))) && (!(isNaN(scaleYTo)))))
            {
                tweenCount++;
                scaleTween = new Tween(this, [scaleXFrom, scaleYFrom], [scaleXTo, scaleYTo], duration, -1, onScaleTweenUpdate, onScaleTweenEnd);
                scaleTween.playReversed = playReversed;
                if (scaleEasingFunction != null)
                {
                    scaleTween.easingFunction = scaleEasingFunction;
                };
            };
            dispatchedStartEvent = false;
            if (moveTween)
            {
                onMoveTweenUpdate(moveTween.getCurrentValue(0));
            };
            if (scaleTween)
            {
                onScaleTweenUpdate(scaleTween.getCurrentValue(0));
            };
        }

        override public function resume():void
        {
            super.resume();
            if (moveTween)
            {
                moveTween.resume();
            };
            if (scaleTween)
            {
                scaleTween.resume();
            };
        }

        private function getVisibleBounds(_arg_1:DisplayObject):Rectangle
        {
            var _local_2:BitmapData = new BitmapData((_arg_1.width + 200), (_arg_1.height + 200), true, 0);
            var _local_3:Matrix = new Matrix();
            _local_3.translate(100, 100);
            _local_2.draw(_arg_1, _local_3);
            var _local_4:Rectangle = _local_2.getColorBoundsRect(0xFF000000, 0, false);
            _local_4.x = (_local_4.x - 100);
            _local_4.y = (_local_4.y - 100);
            _local_2.dispose();
            if (_local_4.width < _arg_1.width)
            {
                _local_4.width = _arg_1.width;
                _local_4.x = 0;
            };
            if (_local_4.height < _arg_1.height)
            {
                _local_4.height = _arg_1.height;
                _local_4.y = 0;
            };
            return (_local_4);
        }

        override public function initEffect(_arg_1:Event):void
        {
            super.initEffect(_arg_1);
            switch (_arg_1.type)
            {
                case "childrenCreationComplete":
                case FlexEvent.CREATION_COMPLETE:
                case FlexEvent.SHOW:
                case Event.ADDED:
                case "resizeEnd":
                    showTarget = true;
                    return;
                case FlexEvent.HIDE:
                case Event.REMOVED:
                case "resizeStart":
                    showTarget = false;
                    return;
                case Event.RESIZE:
                    useSnapshotBounds = false;
                    return;
            };
        }

        public function set showTarget(_arg_1:Boolean):void
        {
            _showTarget = _arg_1;
            _showExplicitlySet = true;
        }

        protected function onScaleTweenEnd(_arg_1:Object):void
        {
            onScaleTweenUpdate(_arg_1);
            finishTween();
        }

        override mx_internal function eventHandler(_arg_1:Event):void
        {
            var _local_2:Tween;
            var _local_3:Number;
            super.eventHandler(_arg_1);
            if (_arg_1.type == ResizeEvent.RESIZE)
            {
                _local_2 = moveTween;
                if (((!(_local_2)) && (scaleTween)))
                {
                    _local_2 = scaleTween;
                };
                if (_local_2)
                {
                    _local_3 = (getTimer() - _local_2.startTime);
                    if (moveTween)
                    {
                        Tween.removeTween(moveTween);
                    };
                    if (scaleTween)
                    {
                        Tween.removeTween(scaleTween);
                    };
                    tweenCount = 0;
                    removeMask();
                    initMask();
                    play();
                    if (moveTween)
                    {
                        moveTween.startTime = (moveTween.startTime - _local_3);
                        moveTween.doInterval();
                    };
                    if (scaleTween)
                    {
                        scaleTween.startTime = (scaleTween.startTime - _local_3);
                        scaleTween.doInterval();
                    };
                };
            };
        }

        protected function onMoveTweenEnd(_arg_1:Object):void
        {
            onMoveTweenUpdate(_arg_1);
            finishTween();
        }

        override public function reverse():void
        {
            super.reverse();
            if (moveTween)
            {
                moveTween.reverse();
            };
            if (scaleTween)
            {
                scaleTween.reverse();
            };
            super.playReversed = (!(playReversed));
        }

        override public function end():void
        {
            stopRepeat = true;
            if (moveTween)
            {
                moveTween.endTween();
            };
            if (scaleTween)
            {
                scaleTween.endTween();
            };
        }

        protected function initMaskEffect():void
        {
            if ((((!(_showExplicitlySet)) && (propertyChanges)) && (!(propertyChanges.start["visible"] === undefined))))
            {
                _showTarget = (!(propertyChanges.start["visible"]));
            };
        }

        protected function onScaleTweenUpdate(_arg_1:Object):void
        {
            saveTweenValue(null, _arg_1);
            if (effectMask)
            {
                effectMask.scaleX = _arg_1[0];
                effectMask.scaleY = _arg_1[1];
            };
        }

        public function get showTarget():Boolean
        {
            return (_showTarget);
        }

        override public function pause():void
        {
            super.pause();
            if (moveTween)
            {
                moveTween.pause();
            };
            if (scaleTween)
            {
                scaleTween.pause();
            };
        }


    }
}//package mx.effects.effectClasses

