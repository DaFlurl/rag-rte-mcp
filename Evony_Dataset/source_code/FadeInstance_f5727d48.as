// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.FadeInstance

package mx.effects.effectClasses
{
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.core.mx_internal;

    use namespace mx_internal;

    public class FadeInstance extends TweenEffectInstance 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var alphaFrom:Number;
        private var restoreAlpha:Boolean;
        public var alphaTo:Number;
        private var origAlpha:Number = NaN;

        public function FadeInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function initEffect(_arg_1:Event):void
        {
            super.initEffect(_arg_1);
            switch (_arg_1.type)
            {
                case "childrenCreationComplete":
                case FlexEvent.CREATION_COMPLETE:
                case FlexEvent.SHOW:
                case Event.ADDED:
                case "resizeEnd":
                    if (isNaN(alphaFrom))
                    {
                        alphaFrom = 0;
                    };
                    if (isNaN(alphaTo))
                    {
                        alphaTo = target.alpha;
                    };
                    return;
                case FlexEvent.HIDE:
                case Event.REMOVED:
                case "resizeStart":
                    restoreAlpha = true;
                    if (isNaN(alphaFrom))
                    {
                        alphaFrom = target.alpha;
                    };
                    if (isNaN(alphaTo))
                    {
                        alphaTo = 0;
                    };
                    return;
            };
        }

        override public function onTweenEnd(_arg_1:Object):void
        {
            super.onTweenEnd(_arg_1);
            if (((mx_internal::hideOnEffectEnd) || (restoreAlpha)))
            {
                target.alpha = origAlpha;
            };
        }

        override public function play():void
        {
            super.play();
            origAlpha = target.alpha;
            var _local_1:PropertyChanges = propertyChanges;
            if (((isNaN(alphaFrom)) && (isNaN(alphaTo))))
            {
                if (((_local_1) && (!(_local_1.end["alpha"] === undefined))))
                {
                    alphaFrom = origAlpha;
                    alphaTo = _local_1.end["alpha"];
                }
                else
                {
                    if (((_local_1) && (!(_local_1.end["visible"] === undefined))))
                    {
                        alphaFrom = ((_local_1.start["visible"]) ? origAlpha : 0);
                        alphaTo = ((_local_1.end["visible"]) ? origAlpha : 0);
                    }
                    else
                    {
                        alphaFrom = 0;
                        alphaTo = origAlpha;
                    };
                };
            }
            else
            {
                if (isNaN(alphaFrom))
                {
                    alphaFrom = ((alphaTo == 0) ? origAlpha : 0);
                }
                else
                {
                    if (isNaN(alphaTo))
                    {
                        if (((_local_1) && (!(_local_1.end["alpha"] === undefined))))
                        {
                            alphaTo = _local_1.end["alpha"];
                        }
                        else
                        {
                            alphaTo = ((alphaFrom == 0) ? origAlpha : 0);
                        };
                    };
                };
            };
            tween = createTween(this, alphaFrom, alphaTo, duration);
            target.alpha = tween.mx_internal::getCurrentValue(0);
        }

        override public function onTweenUpdate(_arg_1:Object):void
        {
            target.alpha = _arg_1;
        }


    }
}//package mx.effects.effectClasses

