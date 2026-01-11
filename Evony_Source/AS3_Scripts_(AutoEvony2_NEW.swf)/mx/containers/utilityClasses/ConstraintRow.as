// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.ConstraintRow

package mx.containers.utilityClasses
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.core.IInvalidating;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ConstraintRow extends EventDispatcher implements IMXMLObject 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _container:IInvalidating;
        mx_internal var _height:Number;
        private var _explicitMinHeight:Number;
        private var _y:Number;
        private var _percentHeight:Number;
        private var _explicitMaxHeight:Number;
        mx_internal var contentSize:Boolean = false;
        private var _explicitHeight:Number;
        private var _id:String;


        public function get container():IInvalidating
        {
            return (_container);
        }

        public function set container(_arg_1:IInvalidating):void
        {
            _container = _arg_1;
        }

        public function set y(_arg_1:Number):void
        {
            if (_arg_1 != _y)
            {
                _y = _arg_1;
                dispatchEvent(new Event("yChanged"));
            };
        }

        public function set height(_arg_1:Number):void
        {
            if (explicitHeight != _arg_1)
            {
                explicitHeight = _arg_1;
                if (_height != _arg_1)
                {
                    _height = _arg_1;
                    if (container)
                    {
                        container.invalidateSize();
                        container.invalidateDisplayList();
                    };
                    dispatchEvent(new Event("heightChanged"));
                };
            };
        }

        public function set maxHeight(_arg_1:Number):void
        {
            if (_explicitMaxHeight != _arg_1)
            {
                _explicitMaxHeight = _arg_1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                };
                dispatchEvent(new Event("maxHeightChanged"));
            };
        }

        public function setActualHeight(_arg_1:Number):void
        {
            if (_height != _arg_1)
            {
                _height = _arg_1;
                dispatchEvent(new Event("heightChanged"));
            };
        }

        [Bindable("minHeightChanged")]
        public function get minHeight():Number
        {
            return (_explicitMinHeight);
        }

        public function get id():String
        {
            return (_id);
        }

        public function set percentHeight(_arg_1:Number):void
        {
            if (_percentHeight == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _explicitHeight = NaN;
            };
            _percentHeight = _arg_1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            };
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.id = _arg_2;
            if (((!(this.height)) && (!(this.percentHeight))))
            {
                contentSize = true;
            };
        }

        [Bindable("percentHeightChanged")]
        public function get percentHeight():Number
        {
            return (_percentHeight);
        }

        [Bindable("heightChanged")]
        public function get height():Number
        {
            return (_height);
        }

        [Bindable("maxHeightChanged")]
        public function get maxHeight():Number
        {
            return (_explicitMaxHeight);
        }

        public function set minHeight(_arg_1:Number):void
        {
            if (_explicitMinHeight != _arg_1)
            {
                _explicitMinHeight = _arg_1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                };
                dispatchEvent(new Event("minHeightChanged"));
            };
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        [Bindable("yChanged")]
        public function get y():Number
        {
            return (_y);
        }

        [Bindable("explicitHeightChanged")]
        public function get explicitHeight():Number
        {
            return (_explicitHeight);
        }

        public function set explicitHeight(_arg_1:Number):void
        {
            if (_explicitHeight == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _percentHeight = NaN;
            };
            _explicitHeight = _arg_1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitHeightChanged"));
        }


    }
}//package mx.containers.utilityClasses

