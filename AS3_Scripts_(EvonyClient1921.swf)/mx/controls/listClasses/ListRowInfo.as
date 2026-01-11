// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListRowInfo

package mx.controls.listClasses
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListRowInfo 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var itemOldY:Number;
        public var height:Number;
        public var uid:String;
        public var data:Object;
        public var oldY:Number;
        public var y:Number;

        public function ListRowInfo(_arg_1:Number, _arg_2:Number, _arg_3:String, _arg_4:Object=null)
        {
            this.y = _arg_1;
            this.height = _arg_2;
            this.uid = _arg_3;
            this.data = _arg_4;
        }

    }
}//package mx.controls.listClasses

