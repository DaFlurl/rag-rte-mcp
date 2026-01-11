// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TargetCount

package view.ui
{
    import flash.external.ExternalInterface;

    public class TargetCount 
    {

        public static const GOOGLE_VALUE:String = "gl";
        public static const CREATE_PLAYER_COUNT:String = "/evonyCreateCharacter";
        public static const REGISTER_LOGIN_OWNER:String = "/ServeroneRegister";
        public static const LOGIN_OWNER:String = "/ServeroneLogin";
        public static const IngameCreatedTwoOrMoreCities:String = "/IngameCreatedTwoOrMoreCities";
        public static const IngameReach100Prestige:String = "/IngameReach100Prestige";


        public static function clickCount(_arg_1:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("TrackPageView", _arg_1);
            };
        }

        public static function getExternalValue(_arg_1:String):String
        {
            var _local_2:String;
            if (ExternalInterface.available)
            {
                _local_2 = ExternalInterface.call(_arg_1);
            };
            return (_local_2);
        }


    }
}//package view.ui

