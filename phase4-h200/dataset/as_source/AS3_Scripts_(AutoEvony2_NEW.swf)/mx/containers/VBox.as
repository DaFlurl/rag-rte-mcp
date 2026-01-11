// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.VBox

package mx.containers
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class VBox extends Box 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function VBox()
        {
            mx_internal::layoutObject.direction = BoxDirection.VERTICAL;
        }

        override public function set direction(_arg_1:String):void
        {
        }


    }
}//package mx.containers

