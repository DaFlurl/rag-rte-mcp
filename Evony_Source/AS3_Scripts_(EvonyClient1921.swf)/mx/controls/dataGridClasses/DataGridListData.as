// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridListData

package mx.controls.dataGridClasses
{
    import mx.controls.listClasses.BaseListData;
    import mx.core.IUIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridListData extends BaseListData 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var dataField:String;

        public function DataGridListData(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:IUIComponent, _arg_6:int=0)
        {
            super(_arg_1, _arg_4, _arg_5, _arg_6, _arg_3);
            this.dataField = _arg_2;
        }

    }
}//package mx.controls.dataGridClasses

