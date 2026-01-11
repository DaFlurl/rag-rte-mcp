// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Move

package mx.effects
{
    import mx.effects.effectClasses.MoveInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Move extends TweenEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var AFFECTED_PROPERTIES:Array = ["x", "y"];

        public var xFrom:Number;
        public var yFrom:Number;
        public var xBy:Number;
        public var yBy:Number;
        public var yTo:Number;
        public var xTo:Number;

        public function Move(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = MoveInstance;
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_2:MoveInstance;
            super.initInstance(_arg_1);
            _local_2 = MoveInstance(_arg_1);
            _local_2.xFrom = xFrom;
            _local_2.xTo = xTo;
            _local_2.xBy = xBy;
            _local_2.yFrom = yFrom;
            _local_2.yTo = yTo;
            _local_2.yBy = yBy;
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }


    }
}//package mx.effects

