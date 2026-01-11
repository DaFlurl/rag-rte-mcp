// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.ListDropIndicator

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import flash.display.Graphics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListDropIndicator extends ProgrammaticSkin 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var direction:String = "horizontal";


        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = graphics;
            _local_3.clear();
            _local_3.lineStyle(2, 2831164);
            if (direction == "horizontal")
            {
                _local_3.moveTo(0, 0);
                _local_3.lineTo(_arg_1, 0);
            }
            else
            {
                _local_3.moveTo(0, 0);
                _local_3.lineTo(0, _arg_2);
            };
        }


    }
}//package mx.skins.halo

