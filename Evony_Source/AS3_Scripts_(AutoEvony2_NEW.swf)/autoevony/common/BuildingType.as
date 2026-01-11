// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.BuildingType

package autoevony.common
{
    import com.evony.common.constants.BuildingConstants;

    public class BuildingType 
    {


        public static function isBuildTime5MinOrLess(_arg_1:int, _arg_2:int):Boolean
        {
            if (((_arg_1 == BuildingConstants.TYPE_HEROS_MANSION) && (_arg_2 == 1)))
            {
                return (true);
            };
            if (((_arg_1 < 0) || (_arg_1 >= buildingBaseTime.length)))
            {
                return (false);
            };
            if (buildingBaseTime[_arg_1] == 0)
            {
                return (false);
            };
            var _local_3:int = buildingBaseTime[_arg_1];
            var _local_4:int = 1;
            while (_local_4 < _arg_2)
            {
                _local_3 = (_local_3 * 2);
                _local_4++;
            };
            return (_local_3 <= 300);
        }

        public static function get buildingBaseTime():Array
        {
            return ([0, 75, 300, 600, 45, 60, 90, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 240, 180, 750, 3600, 480, 540, 360, 720, 150, 450, 1800, 1800]);
        }

        public static function fromString(_arg_1:String):int
        {
            switch (_arg_1.toLowerCase())
            {
                case "a":
                case "academy":
                    return (BuildingConstants.TYPE_ACADEMY);
                case "b":
                case "barrack":
                    return (BuildingConstants.TYPE_BARRACK);
                case "be":
                case "beacon":
                case "sentry_building":
                    return (BuildingConstants.TYPE_SENTRY_BUILDING);
                case "c":
                case "cottage":
                case "h":
                case "house":
                    return (BuildingConstants.TYPE_HOUSE);
                case "e":
                case "embassy":
                    return (BuildingConstants.TYPE_EMBASSY);
                case "f":
                case "fl":
                case "farm":
                case "farm_land":
                    return (BuildingConstants.TYPE_FARM_LAND);
                case "fh":
                case "hm":
                case "feasting":
                case "heros_mansion":
                    return (BuildingConstants.TYPE_HEROS_MANSION);
                case "fo":
                case "forge":
                case "bl":
                case "blacksmith":
                    return (BuildingConstants.TYPE_BLACKSMITH);
                case "inn":
                case "tavern":
                    return (BuildingConstants.TYPE_TAVERN);
                case "i":
                case "iron":
                case "iron_mine":
                    return (BuildingConstants.TYPE_IRON_MINE);
                case "m":
                case "market":
                    return (BuildingConstants.TYPE_MARKET);
                case "q":
                case "quarry":
                case "stone":
                case "stone_mine":
                    return (BuildingConstants.TYPE_STONE_MINE);
                case "r":
                case "rally":
                case "tf":
                case "trainning_feild":
                    return (BuildingConstants.TYPE_TRAINNING_FEILD);
                case "rs":
                case "relief":
                case "ts":
                case "transport_station":
                    return (BuildingConstants.TYPE_TRANSPORT_STATION);
                case "s":
                case "saw":
                case "sawmill":
                case "l":
                case "lumber":
                case "lumber_mill":
                    return (BuildingConstants.TYPE_LUMBER_MILL);
                case "st":
                case "stable":
                    return (BuildingConstants.TYPE_STABLE);
                case "t":
                case "town":
                case "town_hall":
                    return (BuildingConstants.TYPE_TOWN_HALL);
                case "w":
                case "wall":
                    return (BuildingConstants.TYPE_WALL);
                case "wh":
                case "warehouse":
                    return (BuildingConstants.TYPE_WAREHOUSE);
                case "ws":
                case "workshop":
                    return (BuildingConstants.TYPE_WORKSHOP);
                case "*":
                    return (-9);
                default:
                    return (-1);
            };
        }

        public static function toString(_arg_1:int):String
        {
            switch (_arg_1)
            {
                case BuildingConstants.TYPE_ACADEMY:
                    return ("academy");
                case BuildingConstants.TYPE_BARRACK:
                    return ("barrack");
                case BuildingConstants.TYPE_SENTRY_BUILDING:
                    return ("beacon");
                case BuildingConstants.TYPE_HOUSE:
                    return ("cottage");
                case BuildingConstants.TYPE_EMBASSY:
                    return ("embassy");
                case BuildingConstants.TYPE_FARM_LAND:
                    return ("farm");
                case BuildingConstants.TYPE_HEROS_MANSION:
                    return ("feasting hall");
                case BuildingConstants.TYPE_BLACKSMITH:
                    return ("forge");
                case BuildingConstants.TYPE_TAVERN:
                    return ("inn");
                case BuildingConstants.TYPE_IRON_MINE:
                    return ("iron mine");
                case BuildingConstants.TYPE_MARKET:
                    return ("market");
                case BuildingConstants.TYPE_STONE_MINE:
                    return ("quarry");
                case BuildingConstants.TYPE_TRAINNING_FEILD:
                    return ("rally point");
                case BuildingConstants.TYPE_TRANSPORT_STATION:
                    return ("relief station");
                case BuildingConstants.TYPE_LUMBER_MILL:
                    return ("sawmill");
                case BuildingConstants.TYPE_STABLE:
                    return ("stable");
                case BuildingConstants.TYPE_TOWN_HALL:
                    return ("town hall");
                case BuildingConstants.TYPE_WALL:
                    return ("wall");
                case BuildingConstants.TYPE_WAREHOUSE:
                    return ("warehouse");
                case BuildingConstants.TYPE_WORKSHOP:
                    return ("workshop");
                case -9:
                    return ("any");
            };
            return (null);
        }

        public static function get buildingExtNames():Array
        {
            return (["", "Cottage", "Barrack", "Warehouse", "Sawmill", "Quarry", "Ironmine", "Farm", "", "", "", "", "", "", "", "", "", "", "", "", "Stable", "Inn", "Forge", "Market", "Relief Station", "Academy", "Workshop", "Feasting Hall", "Embassy", "Rally Spot", "Beacon Tower", "Townhall", "Wall"]);
        }

        public static function get buildingAbrNames():Array
        {
            return (["", "c", "b", "wh", "s", "q", "i", "f", "", "", "", "", "", "", "", "", "", "", "", "", "st", "inn", "fo", "m", "rs", "a", "ws", "fh", "e", "r", "be", "t", "w"]);
        }

        public static function isExteriorBuilding(_arg_1:int):Boolean
        {
            return ((((_arg_1 == BuildingConstants.TYPE_LUMBER_MILL) || (_arg_1 == BuildingConstants.TYPE_STONE_MINE)) || (_arg_1 == BuildingConstants.TYPE_IRON_MINE)) || (_arg_1 == BuildingConstants.TYPE_FARM_LAND));
        }


    }
}//package autoevony.common

