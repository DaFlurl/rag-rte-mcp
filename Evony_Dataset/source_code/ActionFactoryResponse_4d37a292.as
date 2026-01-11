// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.ActionFactoryResponse

package autoevony.common
{
    public dynamic class ActionFactoryResponse 
    {

        public function ActionFactoryResponse(_arg_1:XML=null)
        {
            var _local_2:*;
            var _local_9:*;
            super();
            if (_arg_1 == null)
            {
                return;
            };
            for each (_local_2 in _arg_1.attributes())
            {
                this[("@" + _local_2.name())] = _local_2.toString();
            };
            if (_arg_1.hasSimpleContent())
            {
                this["data"] = _arg_1.toString();
                return;
            };
            var _local_3:* = _arg_1.children();
            var _local_4:Object = new Object();
            var _local_5:String;
            var _local_6:* = null;
            var _local_7:Array;
            var _local_8:int;
            for each (_local_9 in _local_3)
            {
                _local_5 = _local_9.name().toString();
                if (_local_4[_local_5] == undefined)
                {
                    _local_4[_local_5] = _local_5;
                    _local_6 = _arg_1.child(_local_5);
                    if (_local_6.length() == 1)
                    {
                        this[_local_5] = new ActionFactoryResponse(XML(_local_6));
                    }
                    else
                    {
                        _local_7 = new Array();
                        this[_local_5] = _local_7;
                        _local_8 = 0;
                        for each (_local_9 in _local_6)
                        {
                            var _local_14:* = _local_8++;
                            _local_7[_local_14] = new ActionFactoryResponse(_local_9);
                        };
                    };
                };
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:String;
            var _local_4:int;
            var _local_2:* = "";
            for (_local_3 in this)
            {
                if (_local_2 != "")
                {
                    _local_2 = (_local_2 + "\n");
                };
                if ((this[_local_3] is Array))
                {
                    _local_4 = 0;
                    while (_local_4 < this[_local_3].length)
                    {
                        if (_local_4 != 0)
                        {
                            _local_2 = (_local_2 + "\n");
                        };
                        _local_2 = (_local_2 + this[_local_3][_local_4].toDebugString((((((_arg_1 + ".") + _local_3) + "[") + _local_4) + "]")));
                        _local_4++;
                    };
                }
                else
                {
                    if ((this[_local_3] is ActionFactoryResponse))
                    {
                        _local_2 = (_local_2 + this[_local_3].toDebugString(((_arg_1 + ".") + _local_3)));
                    }
                    else
                    {
                        _local_2 = (_local_2 + ((((_arg_1 + ".") + _local_3) + " = ") + this[_local_3]));
                    };
                };
            };
            return (_local_2);
        }


    }
}//package autoevony.common

