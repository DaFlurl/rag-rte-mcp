// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingLogoMovieClip

package view.ui
{
    import com.evony.util.EvonyAnimation;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.common.beans.BuildingBean;

    public class BuildingLogoMovieClip extends EvonyAnimation 
    {


        public function gotoMc(_arg_1:int, _arg_2:int):String
        {
            var _local_3:int = ((_arg_1 + 3) - GetLevelDep(_arg_2));
            return (("images/buildinglogo/" + _local_3) + ".jpg");
        }

        private function GetLevelDep(_arg_1:int):int
        {
            if (_arg_1 <= 3)
            {
                return (0);
            };
            if (_arg_1 <= 6)
            {
                return (1);
            };
            if (_arg_1 <= 9)
            {
                return (2);
            };
            return (3);
        }

        public function GetImg(_arg_1:BuildingBean):String
        {
            if (_arg_1 != null)
            {
                switch (_arg_1.typeId)
                {
                    case BuildingConstants.TYPE_FARM_LAND:
                        return (gotoMc(73, _arg_1.level));
                    case BuildingConstants.TYPE_ACADEMY:
                        return (gotoMc(21, _arg_1.level));
                    case BuildingConstants.TYPE_BARRACK:
                        return (gotoMc(45, _arg_1.level));
                    case BuildingConstants.TYPE_BLACKSMITH:
                        return (gotoMc(13, _arg_1.level));
                    case BuildingConstants.TYPE_EMBASSY:
                        return (gotoMc(57, _arg_1.level));
                    case BuildingConstants.TYPE_HEROS_MANSION:
                        return (gotoMc(33, _arg_1.level));
                    case BuildingConstants.TYPE_HOUSE:
                        return (gotoMc(17, _arg_1.level));
                    case BuildingConstants.TYPE_IRON_MINE:
                        return (gotoMc(77, _arg_1.level));
                    case BuildingConstants.TYPE_LUMBER_MILL:
                        return (gotoMc(65, _arg_1.level));
                    case BuildingConstants.TYPE_MARKET:
                        return (gotoMc(25, _arg_1.level));
                    case BuildingConstants.TYPE_SENTRY_BUILDING:
                        return (gotoMc(41, _arg_1.level));
                    case BuildingConstants.TYPE_STABLE:
                        return (gotoMc(49, _arg_1.level));
                    case BuildingConstants.TYPE_STONE_MINE:
                        return (gotoMc(69, _arg_1.level));
                    case BuildingConstants.TYPE_TAVERN:
                        return (gotoMc(29, _arg_1.level));
                    case BuildingConstants.TYPE_TOWN_HALL:
                        return (gotoMc(61, _arg_1.level));
                    case BuildingConstants.TYPE_TRAINNING_FEILD:
                        return (gotoMc(37, _arg_1.level));
                    case BuildingConstants.TYPE_TRANSPORT_STATION:
                        return (gotoMc(1, _arg_1.level));
                    case BuildingConstants.TYPE_WALL:
                        return (gotoMc(81, _arg_1.level));
                    case BuildingConstants.TYPE_WAREHOUSE:
                        return (gotoMc(9, _arg_1.level));
                    case BuildingConstants.TYPE_WORKSHOP:
                        return (gotoMc(5, _arg_1.level));
                };
            };
            return ("");
        }


    }
}//package view.ui

