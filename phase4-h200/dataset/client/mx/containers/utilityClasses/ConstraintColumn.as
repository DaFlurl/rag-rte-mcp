// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.utilityClasses.ConstraintColumn

package mx.containers.utilityClasses
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.core.IInvalidating;
    import flash.events.Event;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ConstraintColumn extends EventDispatcher implements IMXMLObject 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _container:IInvalidating;
        private var _explicitMinWidth:Number;
        mx_internal var _width:Number;
        mx_internal var contentSize:Boolean = false;
        private var _percentWidth:Number;
        private var _explicitWidth:Number;
        private var _explicitMaxWidth:Number;
        private var _x:Number;
        private var _id:String;


        public function get container():IInvalidating
        {
            return (_container);
        }

        [Bindable("widthChanged")]
        public function get width():Number
        {
            return (_width);
        }

        [Bindable("percentWidthChanged")]
        public function get percentWidth():Number
        {
            return (_percentWidth);
        }

        public function set container(_arg_1:IInvalidating):void
        {
            _container = _arg_1;
        }

        public function set maxWidth(_arg_1:Number):void
        {
            if (_explicitMaxWidth != _arg_1)
            {
                _explicitMaxWidth = _arg_1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                };
                dispatchEvent(new Event("maxWidthChanged"));
            };
        }

        public function set width(_arg_1:Number):void
        {
            if (explicitWidth != _arg_1)
            {
                explicitWidth = _arg_1;
                if (_width != _arg_1)
                {
                    _width = _arg_1;
                    if (container)
                    {
                        container.invalidateSize();
                        container.invalidateDisplayList();
                    };
                    dispatchEvent(new Event("widthChanged"));
                };
            };
        }

        [Bindable("maxWidthChanged")]
        public function get maxWidth():Number
        {
            return (_explicitMaxWidth);
        }

        [Bindable("minWidthChanged")]
        public function get minWidth():Number
        {
            return (_explicitMinWidth);
        }

        public function get id():String
        {
            return (_id);
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.id = _arg_2;
            if (((!(this.width)) && (!(this.percentWidth))))
            {
                contentSize = true;
            };
        }

        public function set explicitWidth(_arg_1:Number):void
        {
            if (_explicitWidth == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _percentWidth = NaN;
            };
            _explicitWidth = _arg_1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            };
            dispatchEvent(new Event("explicitWidthChanged"));
        }

        public function setActualWidth(_arg_1:Number):void
        {
            if (_width != _arg_1)
            {
                _width = _arg_1;
                dispatchEvent(new Event("widthChanged"));
            };
        }

        public function set minWidth(_arg_1:Number):void
        {
            if (_explicitMinWidth != _arg_1)
            {
                _explicitMinWidth = _arg_1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                };
                dispatchEvent(new Event("minWidthChanged"));
            };
        }

        public function set percentWidth(_arg_1:Number):void
        {
            if (_percentWidth == _arg_1)
            {
                return;
            };
            if (!isNaN(_arg_1))
            {
                _explicitWidth = NaN;
            };
            _percentWidth = _arg_1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            };
            dispatchEvent(new Event("percentWidthChanged"));
        }

        public function set x(_arg_1:Number):void
        {
            if (_arg_1 != _x)
            {
                _x = _arg_1;
                dispatchEvent(new Event("xChanged"));
            };
        }

        [Bindable("explicitWidthChanged")]
        public function get explicitWidth():Number
        {
            return (_explicitWidth);
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        [Bindable("xChanged")]
        public function get x():Number
        {
            return (_x);
        }


    }
}//package mx.containers.utilityClasses

