// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ForInCond

package r1.deval.rt
{
    public class ForInCond extends ObjectExprBase 
    {

        private var _fip:ForInPrologue;

        public function ForInCond(_arg_1:ForInPrologue)
        {
            this._fip = _arg_1;
        }

        override public function getBoolean():Boolean
        {
            var _local_1:Array = (Env.getProperty(_fip._temp_arr_name) as Array);
            var _local_2:int = (Env.getProperty(_fip._temp_idx_name) as int);
            if (_local_2 >= _local_1.length)
            {
                return (false);
            };
            Env.setProperty(_fip._iterVar, _local_1[_local_2]);
            Env.setProperty(_fip._temp_idx_name, (_local_2 + 1));
            return (true);
        }


    }
}//package r1.deval.rt

