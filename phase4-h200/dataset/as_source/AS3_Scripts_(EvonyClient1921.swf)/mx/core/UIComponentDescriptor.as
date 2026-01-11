// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.UIComponentDescriptor

package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UIComponentDescriptor extends ComponentDescriptor 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        mx_internal var instanceIndices:Array;
        public var stylesFactory:Function;
        public var effects:Array;
        mx_internal var repeaters:Array;
        mx_internal var repeaterIndices:Array;

        public function UIComponentDescriptor(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function toString():String
        {
            return ("UIComponentDescriptor_" + id);
        }


    }
}//package mx.core

