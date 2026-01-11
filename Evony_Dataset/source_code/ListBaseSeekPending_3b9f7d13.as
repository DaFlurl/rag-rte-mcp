// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseSeekPending

package mx.controls.listClasses
{
    import mx.collections.CursorBookmark;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseSeekPending 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var offset:int;
        public var bookmark:CursorBookmark;

        public function ListBaseSeekPending(_arg_1:CursorBookmark, _arg_2:int)
        {
            this.bookmark = _arg_1;
            this.offset = _arg_2;
        }

    }
}//package mx.controls.listClasses

