// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.ForInPrologue

package r1.deval.rt
{
    public class ForInPrologue extends EmptyStmt 
    {

        internal var _forEach:Boolean;
        internal var _iterVar:String;
        internal var _temp_arr_name:String;
        internal var _temp_idx_name:String;
        internal var _collection:IExpr;

        public function ForInPrologue(_arg_1:int, _arg_2:String, _arg_3:IExpr, _arg_4:Boolean, _arg_5:int)
        {
            super(_arg_5);
            this._iterVar = _arg_2;
            this._collection = _arg_3;
            this._forEach = _arg_4;
            this._temp_arr_name = ("_tmp_arr_" + _arg_1);
            this._temp_idx_name = ("_tmp_idx_" + _arg_1);
        }

        override public function exec():void
        {
            var _local_2:Array;
            var _local_3:*;
            var _local_1:Object = _collection.getAny();
            if (_forEach)
            {
                if ((_local_1 is Array))
                {
                    _local_2 = (_local_1 as Array);
                }
                else
                {
                    _local_2 = [];
                    for each (_local_3 in _local_1)
                    {
                        _local_2.push(_local_3);
                    };
                };
            }
            else
            {
                _local_2 = [];
                for (_local_3 in _local_1)
                {
                    _local_2.push(_local_3);
                };
            };
            Env.setProperty(_temp_arr_name, _local_2);
            Env.setProperty(_temp_idx_name, 0);
        }


    }
}//package r1.deval.rt

