// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Parallel

package mx.effects
{
    import mx.effects.effectClasses.ParallelInstance;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Parallel extends CompositeEffect 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public function Parallel(_arg_1:Object=null)
        {
            super(_arg_1);
            instanceClass = ParallelInstance;
        }

    }
}//package mx.effects

