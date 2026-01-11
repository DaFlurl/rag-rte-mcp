// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.states.Transition

package mx.states
{
    import mx.effects.IEffect;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Transition 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var effect:IEffect;
        public var toState:String = "*";
        public var fromState:String = "*";


    }
}//package mx.states

