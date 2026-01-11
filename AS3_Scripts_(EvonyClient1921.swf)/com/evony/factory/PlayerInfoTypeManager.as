// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.factory.PlayerInfoTypeManager

package com.evony.factory
{
    import com.evony.Lang;
    import com.evony.common.constants.CityConstants;

    public class PlayerInfoTypeManager 
    {


        public static function getTitle(_arg_1:int):String
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case 0:
                    _local_2 = Lang.msg("平民");
                    break;
                case 1:
                    _local_2 = Lang.msg("骑士");
                    break;
                case 2:
                    _local_2 = Lang.msg("准男爵");
                    break;
                case 3:
                    _local_2 = Lang.msg("男爵");
                    break;
                case 4:
                    _local_2 = Lang.msg("子爵");
                    break;
                case 5:
                    _local_2 = Lang.msg("伯爵");
                    break;
                case 6:
                    _local_2 = Lang.msg("侯爵");
                    break;
                case 7:
                    _local_2 = Lang.msg("公爵");
                    break;
                case 8:
                    _local_2 = Lang.msg("下级亲王");
                    break;
                case 9:
                    _local_2 = Lang.msg("上级亲王");
                    break;
            };
            return (_local_2);
        }

        public static function getState(_arg_1:int):String
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case CityConstants.CASTLE_NOMAL_STATE:
                    _local_2 = Lang.msg("和平");
                    break;
                case CityConstants.CASTLE_ANTI_BATTLE_STATE:
                    _local_2 = Lang.msg("免战");
                    break;
                case CityConstants.CASTLE_FRESH_MAN_STATE:
                    _local_2 = Lang.msg("新手");
                    break;
                case CityConstants.CASTLE_AT_WAR:
                    _local_2 = Lang.msg("战斗");
                    break;
                case CityConstants.CASTLE_VACATION_STATE:
                    _local_2 = Lang.msg("休假");
                    break;
                case CityConstants.CASTLE_DREAM_TRUCE_STATE:
                    _local_2 = Lang.msg("时间段休战");
                    break;
            };
            return (_local_2);
        }

        public static function getOffice(_arg_1:int):String
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case 0:
                    _local_2 = Lang.msg("平民");
                    break;
                case 1:
                    _local_2 = Lang.msg("少尉");
                    break;
                case 2:
                    _local_2 = Lang.msg("上尉");
                    break;
                case 3:
                    _local_2 = Lang.msg("少校");
                    break;
                case 4:
                    _local_2 = Lang.msg("上校");
                    break;
                case 5:
                    _local_2 = Lang.msg("将军");
                    break;
            };
            return (_local_2);
        }


    }
}//package com.evony.factory

