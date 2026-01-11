// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.IrisInstance

package mx.effects.effectClasses
{
    import mx.controls.SWFLoader;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class IrisInstance extends MaskEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function IrisInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function initMaskEffect():void
        {
            super.initMaskEffect();
            var _local_1:Number = (((target is SWFLoader) && (target.content)) ? SWFLoader(target).contentHeight : (targetVisualBounds.height / Math.abs(target.scaleY)));
            var _local_2:Number = (((target is SWFLoader) && (target.content)) ? SWFLoader(target).contentWidth : (targetVisualBounds.width / Math.abs(target.scaleX)));
            if (showTarget)
            {
                scaleXFrom = 0;
                scaleYFrom = 0;
                scaleXTo = 1;
                scaleYTo = 1;
                xFrom = ((_local_2 / 2) + targetVisualBounds.x);
                yFrom = ((_local_1 / 2) + targetVisualBounds.y);
                xTo = targetVisualBounds.x;
                yTo = targetVisualBounds.y;
            }
            else
            {
                scaleXFrom = 1;
                scaleYFrom = 1;
                scaleXTo = 0;
                scaleYTo = 0;
                xFrom = targetVisualBounds.x;
                yFrom = targetVisualBounds.y;
                xTo = ((_local_2 / 2) + targetVisualBounds.x);
                yTo = ((_local_1 / 2) + targetVisualBounds.y);
            };
        }


    }
}//package mx.effects.effectClasses

