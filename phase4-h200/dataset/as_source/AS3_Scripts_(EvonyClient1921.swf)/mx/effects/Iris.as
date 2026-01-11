// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Iris

package mx.effects
{
    import mx.effects.effectClasses.IrisInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Iris extends MaskEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function Iris(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = IrisInstance;
        }

    }
}//package mx.effects

