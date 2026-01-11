// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.CreationPolicy

package autoevony.scripts
{
    import autoevony.common.BuildingType;
    import com.evony.common.constants.BuildingConstants;
    import autoevony.common.ScriptError;
    import com.evony.common.beans.BuildingBean;
    import mx.collections.ArrayCollection;

    public class CreationPolicy 
    {


        internal static function getPositionByPolicy(_arg_1:Array, _arg_2:String, _arg_3:String):int
        {
            var _local_4:int = BuildingType.fromString(_arg_2);
            var _local_5:Array = getAvailablePositionList(_arg_1, BuildingType.isExteriorBuilding(_local_4));
            if (_local_5.length == 0)
            {
                return (-1);
            };
            if (_local_4 == BuildingConstants.TYPE_WALL)
            {
                if (Version.isTraceOn())
                {
                    trace("CreationPolicy-select: Wall was provided, overrode to POSITION_WALL");
                };
                return (BuildingConstants.POSITION_WALL);
            };
            if (_arg_3.toLocaleLowerCase() == "firstavailable")
            {
                return (_local_5[0]);
            };
            if (positionIsAvailable(parseInt(_arg_3), _arg_1, BuildingType.isExteriorBuilding(_local_4)))
            {
                return (parseInt(_arg_3));
            };
            throw (new ScriptError("Invalid creation policy!", -1));
        }

        private static function getAvailablePositionList(_arg_1:Array, _arg_2:Boolean):Array
        {
            var _local_3:int;
            var _local_4:BuildingBean;
            var _local_7:int;
            var _local_5:ArrayCollection = new ArrayCollection();
            if (_arg_2)
            {
                _local_7 = 0;
                for each (_local_4 in _arg_1)
                {
                    if (_local_4.typeId == BuildingConstants.TYPE_TOWN_HALL)
                    {
                        _local_7 = _local_4.level;
                    };
                };
                _local_3 = BuildingConstants.BUILDING_OUTSIDE_MIN;
                while (_local_3 < ((BuildingConstants.BUILDING_OUTSIDE_MIN + 10) + (_local_7 * 3)))
                {
                    _local_5.addItem(_local_3);
                    _local_3++;
                };
            }
            else
            {
                _local_3 = BuildingConstants.BUILDING_INSIDE_MIN;
                while (_local_3 <= BuildingConstants.BUILDING_INSIDE_MAX)
                {
                    _local_5.addItem(_local_3);
                    _local_3++;
                };
            };
            var _local_6:int;
            for each (_local_4 in _arg_1)
            {
                _local_6 = _local_4.positionId;
                if (_local_5.contains(_local_6))
                {
                    _local_5.removeItemAt(_local_5.getItemIndex(_local_6));
                };
            };
            return (_local_5.toArray());
        }

        private static function positionIsAvailable(_arg_1:int, _arg_2:Array, _arg_3:Boolean):Boolean
        {
            var _local_4:Array = getAvailablePositionList(_arg_2, _arg_3);
            var _local_5:int;
            while (_local_5 < _local_4.length)
            {
                if (_arg_1 == _local_4[_local_5])
                {
                    return (true);
                };
                _local_5++;
            };
            return (false);
        }


    }
}//package autoevony.scripts

