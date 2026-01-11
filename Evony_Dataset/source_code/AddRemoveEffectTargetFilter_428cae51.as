// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.effectClasses.AddRemoveEffectTargetFilter

package mx.effects.effectClasses
{
    import mx.effects.EffectTargetFilter;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AddRemoveEffectTargetFilter extends EffectTargetFilter 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public var add:Boolean = true;

        public function AddRemoveEffectTargetFilter()
        {
            filterProperties = ["parent"];
        }

        override protected function defaultFilterFunction(_arg_1:Array, _arg_2:Object):Boolean
        {
            var _local_5:PropertyChanges;
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1[_local_4];
                if (_local_5.target == _arg_2)
                {
                    if (add)
                    {
                        return ((_local_5.start["parent"] == null) && (!(_local_5.end["parent"] == null)));
                    };
                    return ((!(_local_5.start["parent"] == null)) && (_local_5.end["parent"] == null));
                };
                _local_4++;
            };
            return (false);
        }


    }
}//package mx.effects.effectClasses

