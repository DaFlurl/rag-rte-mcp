// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.GridItem

package mx.containers
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GridItem extends HBox 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        internal var colIndex:int = 0;
        private var _rowSpan:int = 1;
        private var _colSpan:int = 1;


        public function set rowSpan(_arg_1:int):void
        {
            _rowSpan = _arg_1;
            invalidateSize();
        }

        public function get colSpan():int
        {
            return (_colSpan);
        }

        public function set colSpan(_arg_1:int):void
        {
            _colSpan = _arg_1;
            invalidateSize();
        }

        public function get rowSpan():int
        {
            return (_rowSpan);
        }


    }
}//package mx.containers

