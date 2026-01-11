// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListData

package mx.controls.listClasses
{
    import mx.core.IUIComponent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListData extends BaseListData 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var icon:Class;
        public var labelField:String;

        public function ListData(_arg_1:String, _arg_2:Class, _arg_3:String, _arg_4:String, _arg_5:IUIComponent, _arg_6:int=0, _arg_7:int=0)
        {
            super(_arg_1, _arg_4, _arg_5, _arg_6, _arg_7);
            this.icon = _arg_2;
            this.labelField = _arg_3;
        }

    }
}//package mx.controls.listClasses

