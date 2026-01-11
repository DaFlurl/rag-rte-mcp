// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.BlurInstance

package mx.effects.effectClasses
{
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BlurInstance extends TweenEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var blurXTo:Number;
        public var blurYTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;

        public function BlurInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function initEffect(_arg_1:Event):void
        {
            super.initEffect(_arg_1);
        }

        override public function onTweenEnd(_arg_1:Object):void
        {
            setBlurFilter(_arg_1[0], _arg_1[1]);
            super.onTweenEnd(_arg_1);
        }

        private function setBlurFilter(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Array = target.filters;
            var _local_4:int = _local_3.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                if ((_local_3[_local_5] is BlurFilter))
                {
                    _local_3.splice(_local_5, 1);
                };
                _local_5++;
            };
            if (((_arg_1) || (_arg_2)))
            {
                _local_3.push(new BlurFilter(_arg_1, _arg_2));
            };
            target.filters = _local_3;
        }

        override public function play():void
        {
            super.play();
            if (isNaN(blurXFrom))
            {
                blurXFrom = 4;
            };
            if (isNaN(blurXTo))
            {
                blurXTo = 0;
            };
            if (isNaN(blurYFrom))
            {
                blurYFrom = 4;
            };
            if (isNaN(blurYTo))
            {
                blurYTo = 0;
            };
            tween = createTween(this, [blurXFrom, blurYFrom], [blurXTo, blurYTo], duration);
        }

        override public function onTweenUpdate(_arg_1:Object):void
        {
            setBlurFilter(_arg_1[0], _arg_1[1]);
        }


    }
}//package mx.effects.effectClasses

