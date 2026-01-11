// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.BaseListData

package mx.controls.listClasses
{
    import mx.core.IUIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BaseListData 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _uid:String;
        public var owner:IUIComponent;
        [Bindable("dataChange")]
        public var label:String;
        public var rowIndex:int;
        public var columnIndex:int;

        public function BaseListData(_arg_1:String, _arg_2:String, _arg_3:IUIComponent, _arg_4:int=0, _arg_5:int=0)
        {
            this.label = _arg_1;
            this.uid = _arg_2;
            this.owner = _arg_3;
            this.rowIndex = _arg_4;
            this.columnIndex = _arg_5;
        }

        public function set uid(_arg_1:String):void
        {
            _uid = _arg_1;
        }

        public function get uid():String
        {
            return (_uid);
        }


    }
}//package mx.controls.listClasses

