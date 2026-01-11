// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.RotateInstance

package mx.effects.effectClasses
{
    import mx.effects.EffectManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class RotateInstance extends TweenEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var originX:Number;
        public var originY:Number;
        private var centerX:Number;
        private var centerY:Number;
        public var angleTo:Number = 360;
        private var originalOffsetX:Number;
        private var originalOffsetY:Number;
        private var newX:Number;
        private var newY:Number;
        public var angleFrom:Number = 0;

        public function RotateInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function onTweenUpdate(_arg_1:Object):void
        {
            if (Math.abs((newX - target.x)) > 0.1)
            {
                centerX = (target.x + originalOffsetX);
            };
            if (Math.abs((newY - target.y)) > 0.1)
            {
                centerY = (target.y + originalOffsetY);
            };
            var _local_2:Number = Number(_arg_1);
            var _local_3:Number = ((Math.PI * _local_2) / 180);
            EffectManager.suspendEventHandling();
            target.rotation = _local_2;
            newX = ((centerX - (originX * Math.cos(_local_3))) + (originY * Math.sin(_local_3)));
            newY = ((centerY - (originX * Math.sin(_local_3))) - (originY * Math.cos(_local_3)));
            newX = Number(newX.toFixed(1));
            newY = Number(newY.toFixed(1));
            target.move(newX, newY);
            EffectManager.resumeEventHandling();
        }

        override public function play():void
        {
            super.play();
            var _local_1:Number = ((Math.PI * target.rotation) / 180);
            if (isNaN(originX))
            {
                originX = (target.width / 2);
            };
            if (isNaN(originY))
            {
                originY = (target.height / 2);
            };
            centerX = ((target.x + (originX * Math.cos(_local_1))) - (originY * Math.sin(_local_1)));
            centerY = ((target.y + (originX * Math.sin(_local_1))) + (originY * Math.cos(_local_1)));
            if (isNaN(angleFrom))
            {
                angleFrom = target.rotation;
            };
            if (isNaN(angleTo))
            {
                angleTo = ((target.rotation == 0) ? ((angleFrom > 180) ? 360 : 0) : target.rotation);
            };
            tween = createTween(this, angleFrom, angleTo, duration);
            target.rotation = angleFrom;
            _local_1 = ((Math.PI * angleFrom) / 180);
            EffectManager.suspendEventHandling();
            originalOffsetX = ((originX * Math.cos(_local_1)) - (originY * Math.sin(_local_1)));
            originalOffsetY = ((originX * Math.sin(_local_1)) + (originY * Math.cos(_local_1)));
            newX = Number((centerX - originalOffsetX).toFixed(1));
            newY = Number((centerY - originalOffsetY).toFixed(1));
            target.move(newX, newY);
            EffectManager.resumeEventHandling();
        }


    }
}//package mx.effects.effectClasses

