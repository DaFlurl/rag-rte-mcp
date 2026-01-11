// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Blur

package mx.effects
{
    import mx.effects.effectClasses.BlurInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Blur extends TweenEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var AFFECTED_PROPERTIES:Array = ["filters"];

        public var blurXTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var blurYTo:Number;

        public function Blur(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = BlurInstance;
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_2:BlurInstance;
            super.initInstance(_arg_1);
            _local_2 = BlurInstance(_arg_1);
            _local_2.blurXFrom = blurXFrom;
            _local_2.blurXTo = blurXTo;
            _local_2.blurYFrom = blurYFrom;
            _local_2.blurYTo = blurYTo;
        }


    }
}//package mx.effects

