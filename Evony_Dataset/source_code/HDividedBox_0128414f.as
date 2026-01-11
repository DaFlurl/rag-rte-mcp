// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.containers.HDividedBox

package mx.containers
{
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class HDividedBox extends DividedBox 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function HDividedBox()
        {
            mx_internal::layoutObject.direction = BoxDirection.HORIZONTAL;
        }

        override public function set direction(_arg_1:String):void
        {
        }


    }
}//package mx.containers

