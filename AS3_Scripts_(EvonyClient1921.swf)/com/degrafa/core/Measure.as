// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.Measure

package com.degrafa.core
{
    import flash.system.Capabilities;

    public class Measure 
    {

        public static const EM:String = "em";
        public static const EX:String = "ex";
        public static const PIXELS:String = "pixels";
        public static const CH:String = "ch";
        public static const PERCENT:String = "percent";
        public static const RATIO:String = "ratio";
        public static const INCHES:String = "inches";
        public static const CENTIMETERS:String = "centimeters";
        public static const MILLIMETERS:String = "millimeters";
        public static const POINTS:String = "points";
        public static const PICAS:String = "picas";
        public static const DEGREES:String = "degrees";

        public var unit:String;
        public var chSize:Number = -1;
        public var emSize:Number = -1;
        public var value:Number;
        public var exSize:Number = -1;

        public function Measure(_arg_1:Number=0, _arg_2:String="pixels"):void
        {
            this.value = _arg_1;
            this.unit = _arg_2;
        }

        public function relativeTo(_arg_1:Number, _arg_2:Object=null):Number
        {
            switch (unit)
            {
                case Measure.PIXELS:
                    return (value);
                case Measure.PERCENT:
                    return (_arg_1 * (value / 100));
                case Measure.RATIO:
                    return (_arg_1 * value);
                case Measure.POINTS:
                    return ((value / 72) * Capabilities.screenDPI);
                case Measure.INCHES:
                    return (value * Capabilities.screenDPI);
                case Measure.CENTIMETERS:
                    return ((value / 2.54) * Capabilities.screenDPI);
                case Measure.MILLIMETERS:
                    return ((value / 25.4) * Capabilities.screenDPI);
                case Measure.PICAS:
                    return ((value / 6) * Capabilities.screenDPI);
                case Measure.EM:
                    updateFontSizes();
                    return (value * emSize);
                case Measure.EX:
                    updateFontSizes();
                    return (value * exSize);
                case Measure.CH:
                    updateFontSizes();
                    return (value * chSize);
                default:
                    return (value);
            };
        }

        public function valueOf():Number
        {
            return (relativeTo(100));
        }

        private function updateFontSizes():void
        {
            if (emSize < 0)
            {
                emSize = ((12 / 72) * Capabilities.screenDPI);
            };
            if (exSize < 0)
            {
                exSize = ((6 / 72) * Capabilities.screenDPI);
            };
            if (chSize < 0)
            {
                chSize = ((12 / 72) * Capabilities.screenDPI);
            };
        }

        public function toString():String
        {
            return (value.toString() + unit);
        }


    }
}//package com.degrafa.core

