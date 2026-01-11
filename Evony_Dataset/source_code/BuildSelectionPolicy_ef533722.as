// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.BuildSelectionPolicy

package autoevony.scripts
{
    import com.evony.common.beans.BuildingBean;
    import autoevony.common.BuildingType;
    import autoevony.common.ScriptError;

    public class BuildSelectionPolicy 
    {


        public static function findByPolicy(_arg_1:Array, _arg_2:String, _arg_3:String, _arg_4:int=9):BuildingBean
        {
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_5:BuildingBean;
            var _local_6:BuildingBean;
            var _local_7:String;
            var _local_8:* = "";
            var _local_9:String = _arg_3.substr(0, 2).toLowerCase();
            if (_local_9 == "hi")
            {
                _local_10 = -1;
                for (_local_7 in _arg_1)
                {
                    if ((_local_5 = _arg_1[_local_7]).status == 0)
                    {
                        if (((((_arg_2 == "*") || (_local_5.typeId == BuildingType.fromString(_arg_2))) && (_local_5.level > _local_10)) && (_local_5.level <= _arg_4)))
                        {
                            _local_6 = _local_5;
                            _local_10 = _local_5.level;
                        };
                    };
                };
                _local_8 = ((" level " + _arg_4) + " or lower.");
            }
            else
            {
                if (_local_9 == "lo")
                {
                    _local_11 = 100;
                    for (_local_7 in _arg_1)
                    {
                        if ((_local_5 = _arg_1[_local_7]).status == 0)
                        {
                            if (((((_arg_2 == "*") || (_local_5.typeId == BuildingType.fromString(_arg_2))) && (_local_5.level < _local_11)) && (_local_5.level < _arg_4)))
                            {
                                _local_6 = _local_5;
                                _local_11 = _local_5.level;
                            };
                        };
                    };
                    _local_8 = (" lower than level " + _arg_4);
                }
                else
                {
                    if (_local_9 == "le")
                    {
                        _local_12 = parseInt(_arg_3.substr(5, 2));
                        for (_local_7 in _arg_1)
                        {
                            if ((_local_5 = _arg_1[_local_7]).status == 0)
                            {
                                if ((((_arg_2 == "*") || (_local_5.typeId == BuildingType.fromString(_arg_2))) && (_local_5.level == _local_12)))
                                {
                                    _local_6 = _local_5;
                                    break;
                                };
                            };
                        };
                        _local_8 = (" equal to level " + _local_12);
                    }
                    else
                    {
                        throw (new ScriptError((_arg_3 + " is an invalid Build policy."), -9999));
                    };
                };
            };
            if (_local_6 == null)
            {
                throw (new ScriptError((("Unable to select a " + BuildingType.toString(BuildingType.fromString(_arg_2))) + _local_8), -9999));
            };
            return (_local_6);
        }


    }
}//package autoevony.scripts

