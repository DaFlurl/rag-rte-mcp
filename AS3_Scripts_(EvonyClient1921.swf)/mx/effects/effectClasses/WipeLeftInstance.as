// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.WipeLeftInstance

package mx.effects.effectClasses
{
    import mx.controls.SWFLoader;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class WipeLeftInstance extends MaskEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function WipeLeftInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function initMaskEffect():void
        {
            var _local_3:Number;
            super.initMaskEffect();
            var _local_1:Number = (((target is SWFLoader) && (target.content)) ? SWFLoader(target).contentWidth : (targetVisualBounds.width / Math.abs(target.scaleX)));
            var _local_2:Number = (((target is SWFLoader) && (target.content)) ? SWFLoader(target).contentHeight : (targetVisualBounds.height / Math.abs(target.scaleY)));
            if (target.rotation != 0)
            {
                _local_3 = ((target.rotation * Math.PI) / 180);
                _local_1 = Math.abs(((_local_1 * Math.cos(_local_3)) - (_local_2 * Math.sin(_local_3))));
            };
            if (showTarget)
            {
                xFrom = (_local_1 + targetVisualBounds.x);
                yFrom = targetVisualBounds.y;
                xTo = ((effectMask.width <= _local_1) ? ((_local_1 - effectMask.width) + targetVisualBounds.x) : targetVisualBounds.x);
                yTo = targetVisualBounds.y;
            }
            else
            {
                xFrom = ((effectMask.width <= _local_1) ? ((_local_1 - effectMask.width) + targetVisualBounds.x) : targetVisualBounds.x);
                yFrom = targetVisualBounds.y;
                xTo = (-(effectMask.width) + targetVisualBounds.x);
                yTo = targetVisualBounds.y;
            };
        }


    }
}//package mx.effects.effectClasses

