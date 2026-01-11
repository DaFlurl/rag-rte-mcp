// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseSelectionPending

package mx.controls.listClasses
{
    import mx.collections.CursorBookmark;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseSelectionPending 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var offset:int;
        public var stopData:Object;
        public var index:int;
        public var placeHolder:CursorBookmark;
        public var bookmark:CursorBookmark;
        public var incrementing:Boolean;
        public var transition:Boolean;

        public function ListBaseSelectionPending(_arg_1:Boolean, _arg_2:int, _arg_3:Object, _arg_4:Boolean, _arg_5:CursorBookmark, _arg_6:CursorBookmark, _arg_7:int)
        {
            this.incrementing = _arg_1;
            this.index = _arg_2;
            this.stopData = _arg_3;
            this.transition = _arg_4;
            this.placeHolder = _arg_5;
            this.bookmark = _arg_6;
            this.offset = _arg_7;
        }

    }
}//package mx.controls.listClasses

