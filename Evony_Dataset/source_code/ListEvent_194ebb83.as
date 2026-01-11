// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.events.ListEvent

package mx.events
{
    import flash.events.Event;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListEvent extends Event 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const CHANGE:String = "change";
        public static const ITEM_EDIT_BEGIN:String = "itemEditBegin";
        public static const ITEM_EDIT_END:String = "itemEditEnd";
        public static const ITEM_FOCUS_IN:String = "itemFocusIn";
        public static const ITEM_FOCUS_OUT:String = "itemFocusOut";
        public static const ITEM_EDIT_BEGINNING:String = "itemEditBeginning";
        public static const ITEM_CLICK:String = "itemClick";
        public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
        public static const ITEM_ROLL_OUT:String = "itemRollOut";
        public static const ITEM_ROLL_OVER:String = "itemRollOver";

        public var reason:String;
        public var itemRenderer:IListItemRenderer;
        public var rowIndex:int;
        public var columnIndex:int;

        public function ListEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:int=-1, _arg_5:int=-1, _arg_6:String=null, _arg_7:IListItemRenderer=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this.columnIndex = _arg_4;
            this.rowIndex = _arg_5;
            this.reason = _arg_6;
            this.itemRenderer = _arg_7;
        }

        override public function clone():Event
        {
            return (new ListEvent(type, bubbles, cancelable, columnIndex, rowIndex, reason, itemRenderer));
        }


    }
}//package mx.events

