package autoevony.common
{
   import com.evony.common.constants.TechConstants;
   
   public class TechType
   {
      
      public static var techExtNames:Array = ["","Agriculture","Lumbering","Masonry","Mining","Metal Casting","","Informatics","Military Science","Military Tradition","Iron Working","Logistics","Compass","Horseback Riding","Archery","Stockpile","Medicine","Construction","Engineering","Machinery","Privateering"];
      
      public static var techAbrNames:Array = ["","ag","lu","mas","mi","met","","in","ms","mt","ir","lo","com","ho","ar","st","med","con","en","mac","pr"];
      
      public function TechType()
      {
         super();
      }
      
      public static function fromString(param1:String) : int
      {
         switch(param1.toLowerCase())
         {
            case "ag":
            case "agriculture":
               return TechConstants.CROP_TECH;
            case "lu":
            case "lumbering":
               return TechConstants.HEW_TECH;
            case "mas":
            case "masonry":
               return TechConstants.EXCAVATION_TECH;
            case "mi":
            case "mining":
               return TechConstants.SMELT_TECH;
            case "met":
            case "metal":
               return TechConstants.MAKE_TECH;
            case "in":
            case "info":
               return TechConstants.SCOUT_SKILL;
            case "ms":
            case "mscience":
            case "militaryscience":
               return TechConstants.TRAIN_SKILL;
            case "mt":
            case "mtradition":
            case "militarytradition":
               return TechConstants.COMBAT_SKILL;
            case "ir":
            case "ironwork":
               return TechConstants.DEFEND_SKILL;
            case "lo":
            case "logistics":
               return TechConstants.LOAD_TECH;
            case "com":
            case "compass":
               return TechConstants.MARCH_SKILL;
            case "ho":
            case "horseback":
               return TechConstants.DRIVE_SKILL;
            case "ar":
            case "archery":
               return TechConstants.THROW_SKILL;
            case "st":
            case "stockpile":
               return TechConstants.STORE_TECH;
            case "med":
            case "medicine":
               return TechConstants.SUPPLY_SKILL;
            case "con":
            case "construct":
               return TechConstants.BUILD_TECH;
            case "en":
            case "engineer":
               return TechConstants.FORTIFICATION_TECH;
            case "mac":
            case "machinery":
               return TechConstants.REPAIR_TECH;
            case "pr":
            case "privateer":
               return TechConstants.HARRY_SKILL;
            default:
               return -1;
         }
      }
      
      public static function toString(param1:int) : String
      {
         return techExtNames[param1];
      }
   }
}

