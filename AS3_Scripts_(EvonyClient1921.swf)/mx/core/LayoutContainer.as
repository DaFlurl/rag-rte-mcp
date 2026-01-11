// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.LayoutContainer

package mx.core
{
    import mx.containers.utilityClasses.IConstraintLayout;
    import mx.containers.utilityClasses.Layout;
    import mx.containers.utilityClasses.BoxLayout;
    import mx.containers.utilityClasses.CanvasLayout;
    import mx.containers.utilityClasses.ConstraintColumn;
    import mx.containers.BoxDirection;
    import flash.events.Event;
    import mx.containers.utilityClasses.ConstraintRow;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class LayoutContainer extends Container implements IConstraintLayout 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var useProgressiveLayout:Boolean = false;

        private var _layout:String = "vertical";
        private var processingCreationQueue:Boolean = false;
        private var resizeHandlerAdded:Boolean = false;
        private var preloadObj:Object;

        protected var layoutObject:Layout = new BoxLayout();
        protected var canvasLayoutClass:Class = CanvasLayout;
        protected var boxLayoutClass:Class = BoxLayout;
        private var creationQueue:Array = [];
        private var _constraintColumns:Array = [];
        private var _constraintRows:Array = [];

        public function LayoutContainer()
        {
            layoutObject.target = this;
        }

        public function get constraintColumns():Array
        {
            return (_constraintColumns);
        }

        override mx_internal function get usePadding():Boolean
        {
            return (!(layout == ContainerLayout.ABSOLUTE));
        }

        override protected function layoutChrome(_arg_1:Number, _arg_2:Number):void
        {
            super.layoutChrome(_arg_1, _arg_2);
            if (!doingLayout)
            {
                createBorder();
            };
        }

        public function set constraintColumns(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1 != _constraintColumns)
            {
                _local_2 = _arg_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    ConstraintColumn(_arg_1[_local_3]).container = this;
                    _local_3++;
                };
                _constraintColumns = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }

        public function set layout(_arg_1:String):void
        {
            if (_layout != _arg_1)
            {
                _layout = _arg_1;
                if (layoutObject)
                {
                    layoutObject.target = null;
                };
                if (_layout == ContainerLayout.ABSOLUTE)
                {
                    layoutObject = new canvasLayoutClass();
                }
                else
                {
                    layoutObject = new boxLayoutClass();
                    if (_layout == ContainerLayout.VERTICAL)
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.VERTICAL;
                    }
                    else
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.HORIZONTAL;
                    };
                };
                if (layoutObject)
                {
                    layoutObject.target = this;
                };
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("layoutChanged"));
            };
        }

        public function get constraintRows():Array
        {
            return (_constraintRows);
        }

        override protected function measure():void
        {
            super.measure();
            layoutObject.measure();
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            layoutObject.updateDisplayList(_arg_1, _arg_2);
            createBorder();
        }

        [Bindable("layoutChanged")]
        public function get layout():String
        {
            return (_layout);
        }

        public function set constraintRows(_arg_1:Array):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1 != _constraintRows)
            {
                _local_2 = _arg_1.length;
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    ConstraintRow(_arg_1[_local_3]).container = this;
                    _local_3++;
                };
                _constraintRows = _arg_1;
                invalidateSize();
                invalidateDisplayList();
            };
        }


    }
}//package mx.core

