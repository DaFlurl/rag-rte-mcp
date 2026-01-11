// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseSelectionDataPending

package mx.controls.listClasses
{
    import mx.collections.CursorBookmark;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseSelectionDataPending 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var items:Array;
        public var index:int;
        public var bookmark:CursorBookmark;
        public var offset:int;
        public var useFind:Boolean;

        public function ListBaseSelectionDataPending(_arg_1:Boolean, _arg_2:int, _arg_3:Array, _arg_4:CursorBookmark, _arg_5:int)
        {
            this.useFind = _arg_1;
            this.index = _arg_2;
            this.items = _arg_3;
            this.bookmark = _arg_4;
            this.offset = _arg_5;
        }

    }
}//package mx.controls.listClasses

