// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.command.CommandStackItem

package com.degrafa.geometry.command
{
    import flash.net.registerClassAlias;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.degrafa.geometry.utilities.GeometryUtils;

    public final class CommandStackItem 
    {

        public static const IS_REGISTERED:Boolean = (!(((registerClassAlias("com.degrafa.geometry.command.CommandStackItem", CommandStackItem)) || (registerClassAlias("flash.geom.Point", Point))) || (registerClassAlias("flash.geom.Rectangle", Rectangle))));
        public static const MOVE_TO:int = 0;
        public static const LINE_TO:int = 1;
        public static const CURVE_TO:int = 2;
        public static const DELEGATE_TO:int = 3;
        public static const COMMAND_STACK:int = 4;

        private var _y:Number;
        private var _y1:Number;
        private var _cy:Number;
        public var id:String;
        private var _segmentLength:Number = 0;
        internal var indexInParent:uint;
        private var _cx:Number;
        internal var parent:CommandStack;
        private var _renderDelegateStart:Array;
        private var _renderDelegateEnd:Array;
        public var type:int;
        private var _lengthInvalidated:Boolean = true;
        private var _invalidated:Boolean = true;
        public var reference:String;
        private var _next:CommandStackItem;
        private var _bounds:Rectangle;
        private var _previous:CommandStackItem;
        private var _x1:Number;
        private var _commandStack:CommandStack;
        private var _delegate:Function;
        private var _x:Number;
        public var skip:Boolean;

        public function CommandStackItem(_arg_1:int=0, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Number=NaN, _arg_5:Number=NaN, _arg_6:Number=NaN, _arg_7:Number=NaN, _arg_8:CommandStack=null)
        {
            invalidated = true;
            this.type = _arg_1;
            _x = _arg_2;
            _y = _arg_3;
            _x1 = _arg_4;
            _y1 = _arg_5;
            _cx = _arg_6;
            _cy = _arg_7;
            if (_arg_8)
            {
                this.commandStack = _arg_8;
            };
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get commandStack():CommandStack
        {
            return (_commandStack);
        }

        public function get delegate():Function
        {
            return (_delegate);
        }

        public function set lengthInvalidated(_arg_1:Boolean):void
        {
            _lengthInvalidated = _arg_1;
            if (_lengthInvalidated != _arg_1)
            {
                _lengthInvalidated = _arg_1;
                if (_lengthInvalidated)
                {
                    parent.lengthInvalidated = _arg_1;
                };
            };
        }

        public function get invalidated():Boolean
        {
            return (_invalidated);
        }

        public function set delegate(_arg_1:Function):void
        {
            if (_delegate != _arg_1)
            {
                _delegate = _arg_1;
                invalidated = true;
            };
        }

        private function curvePointAt(_arg_1:Number, _arg_2:Point=null, _arg_3:Point=null):Point
        {
            var _local_4:Point = Point.interpolate(control, start, _arg_1);
            var _local_5:Point = Point.interpolate(end, control, _arg_1);
            return (Point.interpolate(_local_5, _local_4, _arg_1));
        }

        public function get segmentLength():Number
        {
            if (((!(_segmentLength)) || (lengthInvalidated)))
            {
                switch (type)
                {
                    case CommandStackItem.MOVE_TO:
                        _segmentLength = 0;
                        break;
                    case CommandStackItem.LINE_TO:
                        _segmentLength = lineLength(start, end);
                        break;
                    case CommandStackItem.CURVE_TO:
                        _segmentLength = curveLength();
                        break;
                    case CommandStackItem.COMMAND_STACK:
                        _segmentLength = commandStack.pathLength;
                        break;
                    default:
                        _segmentLength = 0;
                };
            };
            return (_segmentLength);
        }

        public function set invalidated(_arg_1:Boolean):void
        {
            _invalidated = _arg_1;
            if (_invalidated != _arg_1)
            {
                _invalidated = _arg_1;
                if (_invalidated)
                {
                    parent.invalidated = _invalidated;
                    lengthInvalidated = _invalidated;
                };
            };
        }

        private function curveAngleAt(_arg_1:Number, _arg_2:Point=null, _arg_3:Point=null):Number
        {
            _arg_2 = linePointAt(_arg_1, start, control);
            _arg_3 = linePointAt(_arg_1, control, end);
            return (lineAngleAt(_arg_1, _arg_2, _arg_3));
        }

        public function set y(_arg_1:Number):void
        {
            if (_y != _arg_1)
            {
                _y = _arg_1;
                invalidated = true;
            };
        }

        public function get renderDelegateEnd():Array
        {
            return (_renderDelegateEnd);
        }

        private function lineLength(_arg_1:Point=null, _arg_2:Point=null):Number
        {
            if (!_arg_1)
            {
                _arg_1 = start;
            };
            if (!_arg_2)
            {
                _arg_2 = end;
            };
            var _local_3:Number = (_arg_2.x - _arg_1.x);
            var _local_4:Number = (_arg_2.y - _arg_1.y);
            return (Math.sqrt(((_local_3 * _local_3) + (_local_4 * _local_4))));
        }

        public function set x1(_arg_1:Number):void
        {
            if (_x1 != _arg_1)
            {
                _x1 = _arg_1;
                invalidated = true;
            };
        }

        public function derive(_arg_1:CommandStackItem):void
        {
            if (!type)
            {
                type = _arg_1.type;
            };
            if (!x)
            {
                _x = _arg_1.x;
            };
            if (!y)
            {
                _y = _arg_1.y;
            };
            if (!x1)
            {
                _x1 = _arg_1.x1;
            };
            if (!y1)
            {
                _y1 = _arg_1.y1;
            };
            if (!cx)
            {
                _cx = _arg_1.cx;
            };
            if (!cy)
            {
                _cy = _arg_1.cy;
            };
            if (!reference)
            {
                reference = _arg_1.reference;
            };
            invalidated = true;
        }

        public function get bounds():Rectangle
        {
            if (invalidated)
            {
                calcBounds();
            };
            return (_bounds);
        }

        public function set end(_arg_1:Point):void
        {
            if (((type == 1) || (type == 0)))
            {
                x = _arg_1.x;
                y = _arg_1.y;
            }
            else
            {
                x1 = _arg_1.x;
                y1 = _arg_1.y;
            };
        }

        public function get x1():Number
        {
            return (_x1);
        }

        private function curveLength(_arg_1:int=5, _arg_2:Point=null, _arg_3:Point=null, _arg_4:Point=null):Number
        {
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_14:Point;
            var _local_15:int;
            if (!_arg_2)
            {
                _arg_2 = start;
            };
            if (!_arg_3)
            {
                _arg_3 = control;
            };
            if (!_arg_4)
            {
                _arg_4 = end;
            };
            var _local_5:Number = (_arg_4.x - _arg_2.x);
            var _local_6:Number = (_arg_4.y - _arg_2.y);
            var _local_7:Number = ((_local_5 == 0) ? 0 : ((_arg_3.x - _arg_2.x) / _local_5));
            var _local_8:Number = ((_local_6 == 0) ? 0 : ((_arg_3.y - _arg_2.y) / _local_6));
            var _local_12:Number = 0;
            var _local_13:Point = _arg_2;
            _local_15 = 1;
            while (_local_15 < _arg_1)
            {
                _local_11 = (_local_15 / _arg_1);
                _local_9 = ((2 * _local_11) * (1 - _local_11));
                _local_10 = (_local_11 * _local_11);
                _local_14 = new Point((_arg_2.x + (_local_5 * ((_local_9 * _local_7) + _local_10))), (_arg_2.y + (_local_6 * ((_local_9 * _local_8) + _local_10))));
                _local_12 = (_local_12 + lineLength(_local_13, _local_14));
                _local_13 = _local_14;
                _local_15++;
            };
            return (_local_12 + lineLength(_local_13, _arg_4));
        }

        public function set y1(_arg_1:Number):void
        {
            if (_y1 != _arg_1)
            {
                _y1 = _arg_1;
                invalidated = true;
            };
        }

        public function set renderDelegateEnd(_arg_1:Array):void
        {
            if (_renderDelegateEnd != _arg_1)
            {
                _renderDelegateEnd = _arg_1;
                invalidated = true;
            };
        }

        public function set control(_arg_1:Point):void
        {
            cx = _arg_1.x;
            cy = _arg_1.y;
        }

        public function get lengthInvalidated():Boolean
        {
            return (_lengthInvalidated);
        }

        public function set renderDelegateStart(_arg_1:Array):void
        {
            if (_renderDelegateStart != _arg_1)
            {
                _renderDelegateStart = _arg_1;
                invalidated = true;
            };
        }

        private function linePointAt(_arg_1:Number, _arg_2:Point=null, _arg_3:Point=null):Point
        {
            if (!_arg_2)
            {
                _arg_2 = start;
            };
            if (!_arg_3)
            {
                _arg_3 = end;
            };
            var _local_4:Number = (_arg_3.x - _arg_2.x);
            var _local_5:Number = (_arg_3.y - _arg_2.y);
            return (new Point((_arg_2.x + (_local_4 * _arg_1)), (_arg_2.y + (_local_5 * _arg_1))));
        }

        public function get transformedLength():Number
        {
            if (!CommandStack.transMatrix)
            {
                return (segmentLength);
            };
            var _local_1:Matrix = CommandStack.transMatrix;
            if (((!(_segmentLength)) || (lengthInvalidated)))
            {
                switch (type)
                {
                    case CommandStackItem.MOVE_TO:
                        return (0);
                    case CommandStackItem.LINE_TO:
                        return (lineLength(_local_1.transformPoint(start), _local_1.transformPoint(end)));
                    case CommandStackItem.CURVE_TO:
                        return (curveLength(5, _local_1.transformPoint(start), _local_1.transformPoint(control), _local_1.transformPoint(end)));
                    case CommandStackItem.COMMAND_STACK:
                        return (commandStack.transformedPathLength);
                };
            };
            return (0);
        }

        private function lineAngleAt(_arg_1:Number, _arg_2:Point=null, _arg_3:Point=null):Number
        {
            if (!_arg_2)
            {
                _arg_2 = start;
            };
            if (!_arg_3)
            {
                _arg_3 = end;
            };
            return (Math.atan2((_arg_3.y - _arg_2.y), (_arg_3.x - _arg_2.x)));
        }

        public function get control():Point
        {
            return (new Point(cx, cy));
        }

        public function get y1():Number
        {
            return (_y1);
        }

        public function segmentAngleAt(_arg_1:Number):Number
        {
            switch (type)
            {
                case CommandStackItem.MOVE_TO:
                    return (0);
                case CommandStackItem.LINE_TO:
                    return (lineAngleAt(_arg_1));
                case CommandStackItem.CURVE_TO:
                    return (curveAngleAt(_arg_1));
                case CommandStackItem.COMMAND_STACK:
                    return (commandStack.pathAngleAt(_arg_1));
                default:
                    return (0);
            };
        }

        public function get start():Point
        {
            if (_previous)
            {
                if (_previous.skip)
                {
                    return (_previous.start);
                };
                return (_previous.end);
            };
            return (new Point(0, 0));
        }

        public function set next(_arg_1:CommandStackItem):void
        {
            if (_next != _arg_1)
            {
                _next = _arg_1;
                if (type == CommandStackItem.COMMAND_STACK)
                {
                    commandStack.lastNonCommandStackItem.next = _arg_1;
                };
            };
        }

        public function get renderDelegateStart():Array
        {
            return (_renderDelegateStart);
        }

        public function segmentPointAt(_arg_1:Number):Point
        {
            switch (type)
            {
                case CommandStackItem.MOVE_TO:
                    return (start.clone());
                case CommandStackItem.LINE_TO:
                    return (linePointAt(_arg_1, start, end));
                case CommandStackItem.CURVE_TO:
                    return (curvePointAt(_arg_1));
                case CommandStackItem.COMMAND_STACK:
                    return (commandStack.pathPointAt(_arg_1));
                default:
                    return (null);
            };
        }

        public function calcBounds():void
        {
            var _local_1:Point;
            if (!invalidated)
            {
                return;
            };
            switch (type)
            {
                case CommandStackItem.MOVE_TO:
                    if (((isNaN(_x)) || (isNaN(_y))))
                    {
                        _bounds = new Rectangle();
                        skip = true;
                        break;
                    };
                    _bounds = new Rectangle(x, y, 0, 0);
                    break;
                case CommandStackItem.LINE_TO:
                    if (((isNaN(_x)) || (isNaN(_y))))
                    {
                        _bounds = new Rectangle();
                        skip = true;
                        break;
                    };
                    _local_1 = this.start;
                    _bounds = new Rectangle(Math.min(x, _local_1.x), Math.min(y, _local_1.y), Math.abs((x - _local_1.x)), Math.abs((y - _local_1.y)));
                    if (!_bounds.width)
                    {
                        _bounds.width = 0.0001;
                    };
                    if (!_bounds.height)
                    {
                        _bounds.height = 0.0001;
                    };
                    break;
                case CommandStackItem.CURVE_TO:
                    if (((((isNaN(_cx)) || (isNaN(_cy))) || (isNaN(_x1))) || (isNaN(_y1))))
                    {
                        _bounds = new Rectangle();
                        skip = true;
                        break;
                    };
                    _local_1 = this.start;
                    _bounds = GeometryUtils.bezierBounds(_local_1.x, _local_1.y, cx, cy, x1, y1).clone();
                    break;
                case CommandStackItem.COMMAND_STACK:
                    _bounds = commandStack.bounds;
                    break;
            };
            invalidated = false;
        }

        public function set cy(_arg_1:Number):void
        {
            if (_cy != _arg_1)
            {
                _cy = _arg_1;
                invalidated = true;
            };
        }

        public function set previous(_arg_1:CommandStackItem):void
        {
            if (_previous != _arg_1)
            {
                _previous = _arg_1;
                if (_arg_1.type == CommandStackItem.COMMAND_STACK)
                {
                    _previous = _arg_1.commandStack.lastNonCommandStackItem;
                };
                if (((type == CommandStackItem.COMMAND_STACK) && (commandStack.length)))
                {
                    CommandStackItem(commandStack.source[0]).previous = _previous;
                };
            };
        }

        public function set x(_arg_1:Number):void
        {
            if (_x != _arg_1)
            {
                _x = _arg_1;
                invalidated = true;
            };
        }

        public function set cx(_arg_1:Number):void
        {
            if (_cx != _arg_1)
            {
                _cx = _arg_1;
                invalidated = true;
            };
        }

        public function get next():CommandStackItem
        {
            return (_next);
        }

        public function get cy():Number
        {
            return (_cy);
        }

        public function get previous():CommandStackItem
        {
            return (_previous);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function set commandStack(_arg_1:CommandStack):void
        {
            if (_commandStack != _arg_1)
            {
                _commandStack = _arg_1;
                _arg_1.parent = this;
                invalidated = true;
            };
        }

        public function get cx():Number
        {
            return (_cx);
        }

        public function get end():Point
        {
            return (new Point((((type == 1) || (type == 0)) ? _x : _x1), (((type == 1) || (type == 0)) ? _y : _y1)));
        }


    }
}//package com.degrafa.geometry.command

