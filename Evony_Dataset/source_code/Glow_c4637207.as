// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Glow

package mx.effects
{
    import mx.effects.effectClasses.GlowInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Glow extends TweenEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var AFFECTED_PROPERTIES:Array = ["filters"];

        public var knockout:Boolean;
        public var color:uint = 0xFFFFFFFF;
        public var alphaFrom:Number;
        public var blurXTo:Number;
        public var blurYTo:Number;
        public var strength:Number;
        public var alphaTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var inner:Boolean;

        public function Glow(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = GlowInstance;
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_2:GlowInstance;
            super.initInstance(_arg_1);
            _local_2 = GlowInstance(_arg_1);
            _local_2.alphaFrom = alphaFrom;
            _local_2.alphaTo = alphaTo;
            _local_2.blurXFrom = blurXFrom;
            _local_2.blurXTo = blurXTo;
            _local_2.blurYFrom = blurYFrom;
            _local_2.blurYTo = blurYTo;
            _local_2.color = color;
            _local_2.inner = inner;
            _local_2.knockout = knockout;
            _local_2.strength = strength;
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }


    }
}//package mx.effects

