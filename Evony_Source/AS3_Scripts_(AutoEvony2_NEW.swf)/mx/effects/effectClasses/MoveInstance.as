// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.MoveInstance

package mx.effects.effectClasses
{
    import mx.events.MoveEvent;
    import flash.events.Event;
    import mx.core.EdgeMetrics;
    import mx.effects.EffectManager;
    import mx.core.mx_internal;
    import mx.core.IUIComponent;
    import mx.core.Container;
    import mx.styles.IStyleClient;

    use namespace mx_internal;

    public class MoveInstance extends TweenEffectInstance 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var xFrom:Number;
        public var yFrom:Number;
        private var left:*;
        private var forceClipping:Boolean = false;
        public var xTo:Number;
        private var top:*;
        private var horizontalCenter:*;
        public var yTo:Number;
        private var oldWidth:Number;
        private var right:*;
        private var bottom:*;
        private var oldHeight:Number;
        public var xBy:Number;
        public var yBy:Number;
        private var checkClipping:Boolean = true;
        private var verticalCenter:*;

        public function MoveInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function initEffect(_arg_1:Event):void
        {
            super.initEffect(_arg_1);
            if (((_arg_1 is MoveEvent) && (_arg_1.type == MoveEvent.MOVE)))
            {
                if (((((((isNaN(xFrom)) && (isNaN(xTo))) && (isNaN(xBy))) && (isNaN(yFrom))) && (isNaN(yTo))) && (isNaN(yBy))))
                {
                    xFrom = MoveEvent(_arg_1).oldX;
                    xTo = target.x;
                    yFrom = MoveEvent(_arg_1).oldY;
                    yTo = target.y;
                };
            };
        }

        override public function play():void
        {
            var _local_2:EdgeMetrics;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            super.play();
            var _local_9:* = EffectManager;
            (_local_9.mx_internal::startBitmapEffect(IUIComponent(target)));
            if (isNaN(xFrom))
            {
                xFrom = (((!(isNaN(xTo))) && (!(isNaN(xBy)))) ? (xTo - xBy) : target.x);
            };
            if (isNaN(xTo))
            {
                if ((((isNaN(xBy)) && (propertyChanges)) && (!(propertyChanges.end["x"] === undefined))))
                {
                    xTo = propertyChanges.end["x"];
                }
                else
                {
                    xTo = ((isNaN(xBy)) ? target.x : (xFrom + xBy));
                };
            };
            if (isNaN(yFrom))
            {
                yFrom = (((!(isNaN(yTo))) && (!(isNaN(yBy)))) ? (yTo - yBy) : target.y);
            };
            if (isNaN(yTo))
            {
                if ((((isNaN(yBy)) && (propertyChanges)) && (!(propertyChanges.end["y"] === undefined))))
                {
                    yTo = propertyChanges.end["y"];
                }
                else
                {
                    yTo = ((isNaN(yBy)) ? target.y : (yFrom + yBy));
                };
            };
            tween = createTween(this, [xFrom, yFrom], [xTo, yTo], duration);
            var _local_1:Container = (target.parent as Container);
            if (_local_1)
            {
                _local_2 = _local_1.viewMetrics;
                _local_3 = _local_2.left;
                _local_4 = (_local_1.width - _local_2.right);
                _local_5 = _local_2.top;
                _local_6 = (_local_1.height - _local_2.bottom);
                if (((((((((xFrom < _local_3) || (xTo < _local_3)) || ((xFrom + target.width) > _local_4)) || ((xTo + target.width) > _local_4)) || (yFrom < _local_5)) || (yTo < _local_5)) || ((yFrom + target.height) > _local_6)) || ((yTo + target.height) > _local_6)))
                {
                    forceClipping = true;
                    _local_1.mx_internal::forceClipping = true;
                };
            };
            (mx_internal::applyTweenStartValues());
            if ((target is IStyleClient))
            {
                left = target.getStyle("left");
                if (left != undefined)
                {
                    target.setStyle("left", undefined);
                };
                right = target.getStyle("right");
                if (right != undefined)
                {
                    target.setStyle("right", undefined);
                };
                top = target.getStyle("top");
                if (top != undefined)
                {
                    target.setStyle("top", undefined);
                };
                bottom = target.getStyle("bottom");
                if (bottom != undefined)
                {
                    target.setStyle("bottom", undefined);
                };
                horizontalCenter = target.getStyle("horizontalCenter");
                if (horizontalCenter != undefined)
                {
                    target.setStyle("horizontalCenter", undefined);
                };
                verticalCenter = target.getStyle("verticalCenter");
                if (verticalCenter != undefined)
                {
                    target.setStyle("verticalCenter", undefined);
                };
                if (((!(left == undefined)) && (!(right == undefined))))
                {
                    _local_7 = target.width;
                    oldWidth = target.explicitWidth;
                    target.width = _local_7;
                };
                if (((!(top == undefined)) && (!(bottom == undefined))))
                {
                    _local_8 = target.height;
                    oldHeight = target.explicitHeight;
                    target.height = _local_8;
                };
            };
        }

        override public function onTweenUpdate(_arg_1:Object):void
        {
            var _local_2:Container;
            var _local_3:EdgeMetrics;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            EffectManager.suspendEventHandling();
            if (((!(forceClipping)) && (checkClipping)))
            {
                _local_2 = (target.parent as Container);
                if (_local_2)
                {
                    _local_3 = _local_2.viewMetrics;
                    _local_4 = _local_3.left;
                    _local_5 = (_local_2.width - _local_3.right);
                    _local_6 = _local_3.top;
                    _local_7 = (_local_2.height - _local_3.bottom);
                    if (((((_arg_1[0] < _local_4) || ((_arg_1[0] + target.width) > _local_5)) || (_arg_1[1] < _local_6)) || ((_arg_1[1] + target.height) > _local_7)))
                    {
                        forceClipping = true;
                        _local_2.mx_internal::forceClipping = true;
                    };
                };
            };
            target.move(_arg_1[0], _arg_1[1]);
            EffectManager.resumeEventHandling();
        }

        override public function onTweenEnd(_arg_1:Object):void
        {
            var _local_2:Container;
            var _local_3:* = EffectManager;
            (_local_3.mx_internal::endBitmapEffect(IUIComponent(target)));
            if (left != undefined)
            {
                target.setStyle("left", left);
            };
            if (right != undefined)
            {
                target.setStyle("right", right);
            };
            if (top != undefined)
            {
                target.setStyle("top", top);
            };
            if (bottom != undefined)
            {
                target.setStyle("bottom", bottom);
            };
            if (horizontalCenter != undefined)
            {
                target.setStyle("horizontalCenter", horizontalCenter);
            };
            if (verticalCenter != undefined)
            {
                target.setStyle("verticalCenter", verticalCenter);
            };
            if (((!(left == undefined)) && (!(right == undefined))))
            {
                target.explicitWidth = oldWidth;
            };
            if (((!(top == undefined)) && (!(bottom == undefined))))
            {
                target.explicitHeight = oldHeight;
            };
            if (forceClipping)
            {
                _local_2 = (target.parent as Container);
                if (_local_2)
                {
                    forceClipping = false;
                    _local_2.mx_internal::forceClipping = false;
                };
            };
            checkClipping = false;
            super.onTweenEnd(_arg_1);
        }


    }
}//package mx.effects.effectClasses

