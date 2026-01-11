// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.EffectTargetFilter

package mx.effects
{
    import mx.effects.effectClasses.PropertyChanges;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class EffectTargetFilter 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        public var requiredSemantics:Object = null;

        public var filterFunction:Function = defaultFilterFunctionEx;
        public var filterProperties:Array = [];
        public var filterStyles:Array = [];


        protected function defaultFilterFunctionEx(_arg_1:Array, _arg_2:IEffectTargetHost, _arg_3:Object):Boolean
        {
            var _local_4:String;
            if (requiredSemantics)
            {
                for (_local_4 in requiredSemantics)
                {
                    if (!_arg_2)
                    {
                        return (false);
                    };
                    if (_arg_2.getRendererSemanticValue(_arg_3, _local_4) != requiredSemantics[_local_4])
                    {
                        return (false);
                    };
                };
                return (true);
            };
            return (defaultFilterFunction(_arg_1, _arg_3));
        }

        protected function defaultFilterFunction(_arg_1:Array, _arg_2:Object):Boolean
        {
            var _local_5:PropertyChanges;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:int;
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1[_local_4];
                if (_local_5.target == _arg_2)
                {
                    _local_6 = filterProperties.concat(filterStyles);
                    _local_7 = _local_6.length;
                    _local_8 = 0;
                    while (_local_8 < _local_7)
                    {
                        if (((!(_local_5.start[_local_6[_local_8]] === undefined)) && (!(_local_5.end[_local_6[_local_8]] == _local_5.start[_local_6[_local_8]]))))
                        {
                            return (true);
                        };
                        _local_8++;
                    };
                };
                _local_4++;
            };
            return (false);
        }

        public function filterInstance(_arg_1:Array, _arg_2:IEffectTargetHost, _arg_3:Object):Boolean
        {
            if (filterFunction.length == 2)
            {
                return (filterFunction(_arg_1, _arg_3));
            };
            return (filterFunction(_arg_1, _arg_2, _arg_3));
        }


    }
}//package mx.effects

