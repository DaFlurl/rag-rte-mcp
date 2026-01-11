// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseFindPending

package mx.controls.listClasses
{
    import mx.collections.CursorBookmark;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseFindPending 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var currentIndex:int;
        public var stopIndex:int;
        public var startingBookmark:CursorBookmark;
        public var searchString:String;
        public var offset:int;
        public var bookmark:CursorBookmark;

        public function ListBaseFindPending(_arg_1:String, _arg_2:CursorBookmark, _arg_3:CursorBookmark, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            this.searchString = _arg_1;
            this.startingBookmark = _arg_2;
            this.bookmark = _arg_3;
            this.offset = _arg_4;
            this.currentIndex = _arg_5;
            this.stopIndex = _arg_6;
        }

    }
}//package mx.controls.listClasses

