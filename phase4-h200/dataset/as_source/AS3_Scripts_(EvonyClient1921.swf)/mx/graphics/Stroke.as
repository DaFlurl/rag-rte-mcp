// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.graphics.Stroke

package mx.graphics
{
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Stroke extends EventDispatcher implements IStroke 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _caps:String = null;
        private var _scaleMode:String = "normal";
        private var _joints:String = null;
        private var _weight:Number;
        private var _miterLimit:Number = 0;
        private var _alpha:Number = 0;
        private var _color:uint = 0;
        private var _pixelHinting:Boolean = false;

        public function Stroke(_arg_1:uint=0, _arg_2:Number=0, _arg_3:Number=1, _arg_4:Boolean=false, _arg_5:String="normal", _arg_6:String=null, _arg_7:String=null, _arg_8:Number=0)
        {
            this.color = _arg_1;
            this._weight = _arg_2;
            this.alpha = _arg_3;
            this.pixelHinting = _arg_4;
            this.scaleMode = _arg_5;
            this.caps = _arg_6;
            this.joints = _arg_7;
            this.miterLimit = _arg_8;
        }

        public function set caps(_arg_1:String):void
        {
            var _local_2:String = _caps;
            if (_arg_1 != _local_2)
            {
                _caps = _arg_1;
                dispatchStrokeChangedEvent("caps", _local_2, _arg_1);
            };
        }

        public function set color(_arg_1:uint):void
        {
            var _local_2:uint = _color;
            if (_arg_1 != _local_2)
            {
                _color = _arg_1;
                dispatchStrokeChangedEvent("color", _local_2, _arg_1);
            };
        }

        [Bindable("propertyChange")]
        public function get scaleMode():String
        {
            return (_scaleMode);
        }

        public function set joints(_arg_1:String):void
        {
            var _local_2:String = _joints;
            if (_arg_1 != _local_2)
            {
                _joints = _arg_1;
                dispatchStrokeChangedEvent("joints", _local_2, _arg_1);
            };
        }

        [Bindable("propertyChange")]
        public function get pixelHinting():Boolean
        {
            return (_pixelHinting);
        }

        public function set scaleMode(_arg_1:String):void
        {
            var _local_2:String = _scaleMode;
            if (_arg_1 != _local_2)
            {
                _scaleMode = _arg_1;
                dispatchStrokeChangedEvent("scaleMode", _local_2, _arg_1);
            };
        }

        [Bindable("propertyChange")]
        public function get alpha():Number
        {
            return (_alpha);
        }

        [Bindable("propertyChange")]
        public function get caps():String
        {
            return (_caps);
        }

        [Bindable("propertyChange")]
        public function get color():uint
        {
            return (_color);
        }

        private function dispatchStrokeChangedEvent(_arg_1:String, _arg_2:*, _arg_3:*):void
        {
            dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, _arg_1, _arg_2, _arg_3));
        }

        [Bindable("propertyChange")]
        public function get joints():String
        {
            return (_joints);
        }

        public function set miterLimit(_arg_1:Number):void
        {
            var _local_2:Number = _miterLimit;
            if (_arg_1 != _local_2)
            {
                _miterLimit = _arg_1;
                dispatchStrokeChangedEvent("miterLimit", _local_2, _arg_1);
            };
        }

        public function set weight(_arg_1:Number):void
        {
            var _local_2:Number = _weight;
            if (_arg_1 != _local_2)
            {
                _weight = _arg_1;
                dispatchStrokeChangedEvent("weight", _local_2, _arg_1);
            };
        }

        public function set pixelHinting(_arg_1:Boolean):void
        {
            var _local_2:Boolean = _pixelHinting;
            if (_arg_1 != _local_2)
            {
                _pixelHinting = _arg_1;
                dispatchStrokeChangedEvent("pixelHinting", _local_2, _arg_1);
            };
        }

        public function apply(_arg_1:Graphics):void
        {
            _arg_1.lineStyle(weight, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
        }

        [Bindable("propertyChange")]
        public function get miterLimit():Number
        {
            return (_miterLimit);
        }

        [Bindable("propertyChange")]
        public function get weight():Number
        {
            return (_weight);
        }

        public function set alpha(_arg_1:Number):void
        {
            var _local_2:Number = _alpha;
            if (_arg_1 != _local_2)
            {
                _alpha = _arg_1;
                dispatchStrokeChangedEvent("alpha", _local_2, _arg_1);
            };
        }


    }
}//package mx.graphics

