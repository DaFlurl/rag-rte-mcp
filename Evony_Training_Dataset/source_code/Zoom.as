// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Zoom

package mx.effects
{
    import mx.effects.effectClasses.ZoomInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Zoom extends TweenEffect 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var AFFECTED_PROPERTIES:Array = ["scaleX", "scaleY", "x", "y", "width", "height"];

        public var zoomHeightFrom:Number;
        public var zoomWidthTo:Number;
        public var originX:Number;
        public var zoomHeightTo:Number;
        public var originY:Number;
        public var captureRollEvents:Boolean;
        public var zoomWidthFrom:Number;

        public function Zoom(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = ZoomInstance;
            applyActualDimensions = false;
            relevantProperties = ["scaleX", "scaleY", "width", "height", "visible"];
        }

        override protected function initInstance(_arg_1:IEffectInstance):void
        {
            var _local_2:ZoomInstance;
            super.initInstance(_arg_1);
            _local_2 = ZoomInstance(_arg_1);
            _local_2.zoomWidthFrom = zoomWidthFrom;
            _local_2.zoomWidthTo = zoomWidthTo;
            _local_2.zoomHeightFrom = zoomHeightFrom;
            _local_2.zoomHeightTo = zoomHeightTo;
            _local_2.originX = originX;
            _local_2.originY = originY;
            _local_2.captureRollEvents = captureRollEvents;
        }

        override public function getAffectedProperties():Array
        {
            return (AFFECTED_PROPERTIES);
        }


    }
}//package mx.effects

