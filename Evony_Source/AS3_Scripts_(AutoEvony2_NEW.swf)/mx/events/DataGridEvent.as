// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.DataGridEvent

package mx.events
{
    import flash.events.Event;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
        public static const ITEM_EDIT_END:String = "itemEditEnd";
        public static const ITEM_FOCUS_IN:String = "itemFocusIn";
        public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
        public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
        public static const ITEM_EDITOR_CREATE:String = "itemEditorCreate";
        public static const COLUMN_STRETCH:String = "columnStretch";
        public static const HEADER_RELEASE:String = "headerRelease";

        public var reason:String;
        public var localX:Number;
        public var dataField:String;
        public var itemRenderer:IListItemRenderer;
        public var rowIndex:int;
        public var columnIndex:int;

        public function DataGridEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:String=null, _arg_6:int=-1, _arg_7:String=null, _arg_8:IListItemRenderer=null, _arg_9:Number=NaN)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.columnIndex = _arg_4;
            this.dataField = _arg_5;
            this.rowIndex = _arg_6;
            this.reason = _arg_7;
            this.itemRenderer = _arg_8;
            this.localX = _arg_9;
        }

        override public function clone():Event
        {
            return (new DataGridEvent(type, bubbles, cancelable, columnIndex, dataField, rowIndex, reason, itemRenderer, localX));
        }


    }
}//package mx.events

