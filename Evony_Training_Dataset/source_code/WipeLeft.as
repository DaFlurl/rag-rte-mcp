// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.WipeLeft

package mx.effects
{
    import mx.effects.effectClasses.WipeLeftInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class WipeLeft extends MaskEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function WipeLeft(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = WipeLeftInstance;
        }

    }
}//package mx.effects

