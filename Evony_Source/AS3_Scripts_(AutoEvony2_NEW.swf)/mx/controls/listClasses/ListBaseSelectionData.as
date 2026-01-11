// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListBaseSelectionData

package mx.controls.listClasses
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListBaseSelectionData 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var data:Object;
        mx_internal var prevSelectionData:ListBaseSelectionData;
        mx_internal var nextSelectionData:ListBaseSelectionData;
        public var approximate:Boolean;
        public var index:int;

        public function ListBaseSelectionData(_arg_1:Object, _arg_2:int, _arg_3:Boolean)
        {
            this.data = _arg_1;
            this.index = _arg_2;
            this.approximate = _arg_3;
        }

    }
}//package mx.controls.listClasses

