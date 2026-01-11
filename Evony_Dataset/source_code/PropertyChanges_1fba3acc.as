// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.PropertyChanges

package mx.effects.effectClasses
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PropertyChanges 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var target:Object;

        public var end:Object = {};
        public var start:Object = {};

        public function PropertyChanges(_arg_1:Object)
        {
            this.target = _arg_1;
        }

    }
}//package mx.effects.effectClasses

