// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Fade

package mx.effects
{
    import mx.effects.effectClasses.FadeInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Fade extends TweenEffect 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var AFFECTED_PROPERTIES:Array = ["alpha", "visible"];

        public var alphaFrom:Number;
        public var alphaTo:Number;

        public function Fade(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = FadeInstance;
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            super.initInstance(_arg_1);
            var _local_2:FadeInstance = FadeInstance(_arg_1);
            _local_2.alphaFrom = alphaFrom;
            _local_2.alphaTo = alphaTo;
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }


    }
}//package mx.effects

