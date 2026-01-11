// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.HBox

package mx.containers
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class HBox extends Box 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function HBox()
        {
            mx_internal::layoutObject.direction = BoxDirection.HORIZONTAL;
        }

        override public function set direction(_arg_1:String):void
        {
        }


    }
}//package mx.containers

