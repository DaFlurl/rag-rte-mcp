// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.GlowInstance

package mx.effects.effectClasses
{
    import flash.events.Event;
    import mx.styles.StyleManager;
    import mx.core.Application;
    import flash.filters.GlowFilter;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class GlowInstance extends TweenEffectInstance 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var strength:Number;
        public var inner:Boolean;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var color:uint = 0xFFFFFFFF;
        public var alphaFrom:Number;
        public var blurYTo:Number;
        public var blurXTo:Number;
        public var alphaTo:Number;
        public var knockout:Boolean;

        public function GlowInstance(_arg_1:Object)
        {
            super(_arg_1);
        }

        override public function initEffect(_arg_1:Event):void
        {
            super.initEffect(_arg_1);
        }

        override public function play():void
        {
            super.play();
            if (isNaN(alphaFrom))
            {
                alphaFrom = 1;
            };
            if (isNaN(alphaTo))
            {
                alphaTo = 0;
            };
            if (isNaN(blurXFrom))
            {
                blurXFrom = 5;
            };
            if (isNaN(blurXTo))
            {
                blurXTo = 0;
            };
            if (isNaN(blurYFrom))
            {
                blurYFrom = 5;
            };
            if (isNaN(blurYTo))
            {
                blurYTo = 0;
            };
            if (color == StyleManager.NOT_A_COLOR)
            {
                color = Application.application.getStyle("themeColor");
            };
            if (isNaN(strength))
            {
                strength = 2;
            };
            tween = createTween(this, [color, alphaFrom, blurXFrom, blurYFrom], [color, alphaTo, blurXTo, blurYTo], duration);
        }

        private function setGlowFilter(_arg_1:uint, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            var _local_5:Array = target.filters;
            var _local_6:int = _local_5.length;
            var _local_7:int;
            while (_local_7 < _local_6)
            {
                if ((_local_5[_local_7] is GlowFilter))
                {
                    _local_5.splice(_local_7, 1);
                };
                _local_7++;
            };
            if ((((_arg_3) || (_arg_4)) || (_arg_2)))
            {
                _local_5.push(new GlowFilter(_arg_1, _arg_2, _arg_3, _arg_4, strength, 1, inner, knockout));
            };
            target.filters = _local_5;
        }

        override public function onTweenEnd(_arg_1:Object):void
        {
            setGlowFilter(_arg_1[0], _arg_1[1], _arg_1[2], _arg_1[3]);
            super.onTweenEnd(_arg_1);
        }

        override public function onTweenUpdate(_arg_1:Object):void
        {
            setGlowFilter(_arg_1[0], _arg_1[1], _arg_1[2], _arg_1[3]);
        }


    }
}//package mx.effects.effectClasses

