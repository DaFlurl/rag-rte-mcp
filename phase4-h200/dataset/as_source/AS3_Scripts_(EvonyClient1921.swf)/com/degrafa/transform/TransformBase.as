// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.transform.TransformBase

package com.degrafa.transform
{
    import com.degrafa.core.DegrafaObject;
    import flash.geom.Matrix;
    import com.degrafa.geometry.Geometry;
    import com.degrafa.IGeometryComposition;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class TransformBase extends DegrafaObject implements ITransform 
    {

        private static var identity:Matrix = new Matrix();

        public var invalidated:Boolean;
        protected var _transformMatrix:Matrix = new Matrix();
        protected var _skewX:Number = 0;
        private var _data:String;
        protected var _skewY:Number = 0;
        protected var _tx:Number = 0;
        protected var _ty:Number = 0;
        protected var _angle:Number = 0;
        protected var _registrationPoint:String;
        protected var _centerX:Number = NaN;
        protected var _centerY:Number = NaN;
        protected var _scaleX:Number = 1;
        protected var _scaleY:Number = 1;


        public static function getRenderedBounds(_arg_1:IGeometryComposition):Rectangle
        {
            var _local_3:Matrix;
            var _local_2:Geometry = (_arg_1 as Geometry);
            if (_local_2.transform)
            {
                return ((_local_2.transform as TransformBase).getTransformedBoundsFor(_arg_1));
            };
            _local_3 = _local_2.transformContext;
            if (!_local_3)
            {
                while (_local_2.parent)
                {
                    _local_2 = (_local_2.parent as Geometry);
                    if (_local_2.transform)
                    {
                        _local_3 = _local_2.transform.getTransformFor(_local_2);
                        break;
                    };
                };
            };
            if (_local_3)
            {
                return (transformBounds(_local_2.bounds, _local_3));
            };
            return (_local_2.bounds.clone());
        }

        public static function transformBounds(_arg_1:Rectangle, _arg_2:Matrix):Rectangle
        {
            var _local_6:Point;
            var _local_7:Point;
            var _local_9:Point;
            var _local_3:Rectangle = _arg_1.clone();
            var _local_4:Point = _local_3.topLeft;
            var _local_5:Point = _local_3.bottomRight;
            (_local_6 = _local_4.clone()).offset((_local_5.x - _local_4.x), 0);
            (_local_7 = _local_4.clone()).offset(0, (_local_5.y - _local_4.y));
            var _local_8:Array = [_arg_2.transformPoint(_local_4), _arg_2.transformPoint(_local_5), _arg_2.transformPoint(_local_6), _arg_2.transformPoint(_local_7)];
            _local_3.setEmpty();
            _local_3.topLeft = _arg_2.transformPoint(_local_4);
            for each (_local_9 in _local_8)
            {
                if (_local_3.right < _local_9.x)
                {
                    _local_3.right = _local_9.x;
                };
                if (_local_3.top > _local_9.y)
                {
                    _local_3.top = _local_9.y;
                };
                if (_local_3.left > _local_9.x)
                {
                    _local_3.left = _local_9.x;
                };
                if (_local_3.bottom < _local_9.y)
                {
                    _local_3.bottom = _local_9.y;
                };
            };
            return (_local_3);
        }


        public function hasExplicitSetting():Boolean
        {
            return ((_registrationPoint) || (!((isNaN(_centerX)) || (isNaN(_centerY)))));
        }

        public function get isIdentity():Boolean
        {
            var _local_1:Matrix;
            if (invalidated)
            {
                _local_1 = transformMatrix;
            };
            return ((((((_transformMatrix.a == 1) && (!(_transformMatrix.b))) && (!(_transformMatrix.c))) && (_transformMatrix.d == 1)) && (!(_transformMatrix.tx))) && (!(_transformMatrix.ty)));
        }

        public function get skewX():Number
        {
            return (_skewX);
        }

        public function get skewY():Number
        {
            return (_skewY);
        }

        public function getRegPointForRectangle(_arg_1:Rectangle):Point
        {
            var _local_2:Point;
            if (_registrationPoint)
            {
                _local_2 = getRegistrationPoint(null, _arg_1);
            }
            else
            {
                _local_2 = new Point(((_arg_1.x + (_arg_1.width / 2)) + centerX), ((_arg_1.y + (_arg_1.height / 2)) + centerY));
            };
            return (_local_2);
        }

        public function set transformMatrix(_arg_1:Matrix):void
        {
            _transformMatrix = _arg_1;
        }

        protected function getRegistrationPoint(_arg_1:IGeometryComposition, _arg_2:Rectangle=null):Point
        {
            var _local_3:Point;
            if (_arg_1)
            {
                _arg_2 = (((_arg_1 as Geometry).hasLayout) ? Geometry(_arg_1).layoutRectangle : Geometry(_arg_1).bounds);
            };
            switch (_registrationPoint)
            {
                case "topLeft":
                    _local_3 = _arg_2.topLeft;
                    break;
                case "centerLeft":
                    _local_3 = new Point(_arg_2.left, (_arg_2.y + (_arg_2.height / 2)));
                    break;
                case "bottomLeft":
                    _local_3 = new Point(_arg_2.left, _arg_2.bottom);
                    break;
                case "centerTop":
                    _local_3 = new Point((_arg_2.x + (_arg_2.width / 2)), _arg_2.y);
                    break;
                case "center":
                    _local_3 = new Point((_arg_2.x + (_arg_2.width / 2)), (_arg_2.y + (_arg_2.height / 2)));
                    break;
                case "centerBottom":
                    _local_3 = new Point((_arg_2.x + (_arg_2.width / 2)), _arg_2.bottom);
                    break;
                case "topRight":
                    _local_3 = new Point(_arg_2.right, _arg_2.top);
                    break;
                case "centerRight":
                    _local_3 = new Point(_arg_2.right, (_arg_2.y + (_arg_2.height / 2)));
                    break;
                case "bottomRight":
                    _local_3 = _arg_2.bottomRight;
                    break;
            };
            return (_local_3);
        }

        public function get data():String
        {
            return (_data);
        }

        public function get centerX():Number
        {
            return ((isNaN(_centerX)) ? 0 : _centerX);
        }

        public function get centerY():Number
        {
            return ((isNaN(_centerY)) ? 0 : _centerY);
        }

        public function set registrationPoint(_arg_1:String):void
        {
            var _local_2:String;
            if (_registrationPoint != _arg_1)
            {
                _local_2 = _registrationPoint;
                _registrationPoint = _arg_1;
            };
        }

        public function getTransformFor(_arg_1:IGeometryComposition):Matrix
        {
            var _local_2:Point = ((_registrationPoint) ? getRegistrationPoint(_arg_1) : new Point(centerX, centerY));
            var _local_3:Geometry = (_arg_1 as Geometry);
            var _local_4:Matrix = _local_3.transformContext;
            if (!_local_4)
            {
                while (_local_3.parent)
                {
                    _local_3 = (_local_3.parent as Geometry);
                    if (_local_3.transform)
                    {
                        _local_4 = _local_3.transform.getTransformFor(_local_3);
                        break;
                    };
                };
            };
            var _local_5:Matrix = new Matrix();
            _local_5.translate(-(_local_2.x), -(_local_2.y));
            _local_5.concat(transformMatrix);
            _local_5.translate(_local_2.x, _local_2.y);
            if (_local_4)
            {
                _local_5.concat(_local_4);
            };
            return (_local_5);
        }

        public function set centerY(_arg_1:Number):void
        {
            if (_centerY != _arg_1)
            {
                _centerY = _arg_1;
                invalidated = true;
            };
        }

        public function get transformMatrix():Matrix
        {
            var _local_1:Matrix;
            if (!invalidated)
            {
                return (_transformMatrix);
            };
            _transformMatrix.identity();
            if (((!(_scaleX == 1)) || (!(_scaleY == 1))))
            {
                _transformMatrix.scale(_scaleX, _scaleY);
            };
            if (((_skewX) || (_skewY)))
            {
                _local_1 = new Matrix();
                _local_1.a = Math.cos(((_skewY * Math.PI) / 180));
                _local_1.b = Math.sin(((_skewY * Math.PI) / 180));
                _local_1.c = -(Math.sin(((_skewX * Math.PI) / 180)));
                _local_1.d = Math.cos(((_skewX * Math.PI) / 180));
                _transformMatrix.concat(_local_1);
            };
            if (_angle)
            {
                _transformMatrix.rotate(((_angle * Math.PI) / 180));
            };
            if (((_tx) || (_ty)))
            {
                _transformMatrix.translate(_tx, _ty);
            };
            invalidated = false;
            return (_transformMatrix);
        }

        public function get scaleX():Number
        {
            return (_scaleX);
        }

        public function getRegPoint(_arg_1:IGeometryComposition):Point
        {
            if (_registrationPoint)
            {
                return (getRegistrationPoint(_arg_1));
            };
            return (new Point(centerX, centerY));
        }

        public function get angle():Number
        {
            return (_angle);
        }

        public function set centerX(_arg_1:Number):void
        {
            if (_centerX != _arg_1)
            {
                _centerX = _arg_1;
                invalidated = true;
            };
        }

        public function get scaleY():Number
        {
            return (_scaleY);
        }

        public function set data(_arg_1:String):void
        {
            _data = _arg_1;
        }

        public function get registrationPoint():String
        {
            return (_registrationPoint);
        }

        public function get x():Number
        {
            return (_tx);
        }

        public function get y():Number
        {
            return (_ty);
        }

        public function getTransformedBoundsFor(_arg_1:IGeometryComposition):Rectangle
        {
            var _local_2:Geometry = (_arg_1 as Geometry);
            var _local_3:Matrix = getTransformFor(_arg_1);
            return (transformBounds(_local_2.bounds, _local_3));
        }


    }
}//package com.degrafa.transform

