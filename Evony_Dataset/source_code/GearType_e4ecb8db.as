// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.common.GearType

package autoevony.common
{
    public class GearType 
    {

        private static var gearAbrNames:Array = new Array("", "we", "shi", "mo", "ne", "cha", "ri", "he", "sho", "che", "ba", "ga", "be", "le", "fo");
        private static var gearExtNames:Array = new Array("", "weapon", "shield", "mount", "necklace", "charm", "ring", "head", "shoulder", "chest", "back", "gauntlets", "belts", "legs", "foot");


        public static function toAbbrString(_arg_1:int):String
        {
            return (gearAbrNames[_arg_1]);
        }

        public static function toNameString(_arg_1:int):String
        {
            return (gearExtNames[_arg_1]);
        }

        public static function fromString(_arg_1:String):int
        {
            var _local_2:int;
            _arg_1 = _arg_1.toLowerCase();
            if ((_local_2 = gearExtNames.indexOf(_arg_1)) == -1)
            {
                _local_2 = gearAbrNames.indexOf(_arg_1);
            };
            return (_local_2);
        }


    }
}//package autoevony.common

