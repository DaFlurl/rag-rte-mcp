// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.Canvas

package mx.containers
{
    import mx.core.Container;
    import mx.containers.utilityClasses.IConstraintLayout;
    import mx.containers.utilityClasses.CanvasLayout;
    import mx.containers.utilityClasses.ConstraintRow;
    import mx.containers.utilityClasses.ConstraintColumn;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Canvas extends Container implements IConstraintLayout 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var layoutObject:CanvasLayout = new CanvasLayout();
        private var _constraintColumns:Array = [];
        private var _constraintRows:Array = [];

        public function Canvas()
        {
            layoutObject.target = this;
        }

        public function get constraintColumns():Array
        {
            return (_constraintColumns);
        }

        override mx_internal function get usePadding():Boolean
        {
            return (false);
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

        public function get constraintRows():Array
        {
            return (_constraintRows);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            layoutObject.updateDisplayList(_arg_1, _arg_2);
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

        override protected function measure():void
        {
            super.measure();
            layoutObject.measure();
        }


    }
}//package mx.containers

