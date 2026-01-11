package
{
   import autoevony.gui.newarmy.NewArmyWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         NewArmyWin.watcherSetupUtil = new _autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[70] = new PropertyWatcher("heros",{"propertyChange":true},[param3[18]],param2);
         param4[113] = new PropertyWatcher("travelTime",{"propertyChange":true},[param3[34],param3[33]],param2);
         param4[111] = new PropertyWatcher("foodNeeded",{"propertyChange":true},[param3[32]],param2);
         param4[67] = new PropertyWatcher("savedTroopCfg",{"propertyChange":true},[param3[15]],param2);
         param4[69] = new PropertyWatcher("missionTypeArray",{"propertyChange":true},[param3[17]],param2);
         param4[7] = new PropertyWatcher("_tInputW",{"propertyChange":true},[param3[1]],param2);
         param4[8] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[9] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[3] = new PropertyWatcher("maxDispatchLimit",{"propertyChange":true},[param3[1]],param2);
         param4[114] = new PropertyWatcher("camptTime",{"propertyChange":true},[param3[34],param3[33]],param2);
         param4[25] = new PropertyWatcher("_tInputCata",{"propertyChange":true},[param3[1]],param2);
         param4[26] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[27] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[68] = new PropertyWatcher("quickCoords",{"propertyChange":true},[param3[16]],param2);
         param4[13] = new PropertyWatcher("_tInputP",{"propertyChange":true},[param3[1]],param2);
         param4[14] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[15] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[1] = new PropertyWatcher("fieldId",{"propertyChange":true},[param3[0],param3[31]],param2);
         param4[34] = new PropertyWatcher("_tInputR",{"propertyChange":true},[param3[1]],param2);
         param4[35] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[36] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[10] = new PropertyWatcher("_tInputS",{"propertyChange":true},[param3[1]],param2);
         param4[11] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[12] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[28] = new PropertyWatcher("_tInputT",{"propertyChange":true},[param3[1]],param2);
         param4[29] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[30] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[108] = new PropertyWatcher("_yInput",{"propertyChange":true},[param3[31]],param2);
         param4[109] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[31]],null);
         param4[31] = new PropertyWatcher("_tInputB",{"propertyChange":true},[param3[1]],param2);
         param4[32] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[33] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[19] = new PropertyWatcher("_tInputA",{"propertyChange":true},[param3[1]],param2);
         param4[20] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[21] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[22] = new PropertyWatcher("_tInputC",{"propertyChange":true},[param3[1]],param2);
         param4[23] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[24] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[71] = new PropertyWatcher("selectedHero",{"propertyChange":true},[param3[19],param3[20]],param2);
         param4[72] = new PropertyWatcher("id",{"propertyChange":true},[param3[19],param3[20]],null);
         param4[43] = new PropertyWatcher("troop",{"propertyChange":true},[param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[9],param3[10],param3[11],param3[12],param3[13],param3[14]],param2);
         param4[66] = new PropertyWatcher("catapult",{"propertyChange":true},[param3[14]],null);
         param4[54] = new PropertyWatcher("archer",{"propertyChange":true},[param3[8]],null);
         param4[44] = new PropertyWatcher("peasants",{"propertyChange":true},[param3[3]],null);
         param4[62] = new PropertyWatcher("ballista",{"propertyChange":true},[param3[12]],null);
         param4[60] = new PropertyWatcher("carriage",{"propertyChange":true},[param3[11]],null);
         param4[48] = new PropertyWatcher("scouter",{"propertyChange":true},[param3[5]],null);
         param4[58] = new PropertyWatcher("heavyCavalry",{"propertyChange":true},[param3[10]],null);
         param4[46] = new PropertyWatcher("militia",{"propertyChange":true},[param3[4]],null);
         param4[56] = new PropertyWatcher("lightCavalry",{"propertyChange":true},[param3[9]],null);
         param4[52] = new PropertyWatcher("swordsmen",{"propertyChange":true},[param3[7]],null);
         param4[50] = new PropertyWatcher("pikemen",{"propertyChange":true},[param3[6]],null);
         param4[64] = new PropertyWatcher("batteringRam",{"propertyChange":true},[param3[13]],null);
         param4[41] = new PropertyWatcher("availableRallySlots",{"propertyChange":true},[param3[2]],param2);
         param4[81] = new PropertyWatcher("_rInputW",{"propertyChange":true},[param3[22]],param2);
         param4[82] = new PropertyWatcher("rInput",{"propertyChange":true},[param3[22]],null);
         param4[83] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[22]],null);
         param4[106] = new PropertyWatcher("_xInput",{"propertyChange":true},[param3[31]],param2);
         param4[107] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[31]],null);
         param4[84] = new PropertyWatcher("_rInputS",{"propertyChange":true},[param3[22]],param2);
         param4[85] = new PropertyWatcher("rInput",{"propertyChange":true},[param3[22]],null);
         param4[86] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[22]],null);
         param4[75] = new PropertyWatcher("_rInputG",{"propertyChange":true},[param3[22]],param2);
         param4[76] = new PropertyWatcher("rInput",{"propertyChange":true},[param3[22]],null);
         param4[77] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[22]],null);
         param4[92] = new PropertyWatcher("resource",{"propertyChange":true},[param3[23],param3[25],param3[24],param3[27],param3[26]],param2);
         param4[95] = new PropertyWatcher("wood",{"propertyChange":true},[param3[24]],null);
         param4[93] = new PropertyWatcher("food",{"propertyChange":true},[param3[23]],null);
         param4[97] = new PropertyWatcher("stone",{"propertyChange":true},[param3[25]],null);
         param4[101] = new PropertyWatcher("gold",{"propertyChange":true},[param3[27]],null);
         param4[99] = new PropertyWatcher("iron",{"propertyChange":true},[param3[26]],null);
         param4[87] = new PropertyWatcher("_rInputI",{"propertyChange":true},[param3[22]],param2);
         param4[88] = new PropertyWatcher("rInput",{"propertyChange":true},[param3[22]],null);
         param4[89] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[22]],null);
         param4[37] = new PropertyWatcher("_tInputCp",{"propertyChange":true},[param3[1]],param2);
         param4[38] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[39] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[4] = new PropertyWatcher("_tInputWo",{"propertyChange":true},[param3[1]],param2);
         param4[5] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[6] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[16] = new PropertyWatcher("_tInputSw",{"propertyChange":true},[param3[1]],param2);
         param4[17] = new PropertyWatcher("tInput",{"propertyChange":true},[param3[1]],null);
         param4[18] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[1]],null);
         param4[102] = new PropertyWatcher("localArmiesData",{"propertyChange":true},[param3[28]],param2);
         param4[78] = new PropertyWatcher("_rInputF",{"propertyChange":true},[param3[22]],param2);
         param4[79] = new PropertyWatcher("rInput",{"propertyChange":true},[param3[22]],null);
         param4[80] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[22]],null);
         param4[74] = new PropertyWatcher("loadCapacity",{"propertyChange":true},[param3[22]],param2);
         param4[70].updateParent(param1);
         param4[113].updateParent(param1);
         param4[111].updateParent(param1);
         param4[67].updateParent(param1);
         param4[69].updateParent(param1);
         param4[7].updateParent(param1);
         param4[7].addChild(param4[8]);
         param4[8].addChild(param4[9]);
         param4[3].updateParent(param1);
         param4[114].updateParent(param1);
         param4[25].updateParent(param1);
         param4[25].addChild(param4[26]);
         param4[26].addChild(param4[27]);
         param4[68].updateParent(param1);
         param4[13].updateParent(param1);
         param4[13].addChild(param4[14]);
         param4[14].addChild(param4[15]);
         param4[1].updateParent(param1);
         param4[34].updateParent(param1);
         param4[34].addChild(param4[35]);
         param4[35].addChild(param4[36]);
         param4[10].updateParent(param1);
         param4[10].addChild(param4[11]);
         param4[11].addChild(param4[12]);
         param4[28].updateParent(param1);
         param4[28].addChild(param4[29]);
         param4[29].addChild(param4[30]);
         param4[108].updateParent(param1);
         param4[108].addChild(param4[109]);
         param4[31].updateParent(param1);
         param4[31].addChild(param4[32]);
         param4[32].addChild(param4[33]);
         param4[19].updateParent(param1);
         param4[19].addChild(param4[20]);
         param4[20].addChild(param4[21]);
         param4[22].updateParent(param1);
         param4[22].addChild(param4[23]);
         param4[23].addChild(param4[24]);
         param4[71].updateParent(param1);
         param4[71].addChild(param4[72]);
         param4[43].updateParent(param1);
         param4[43].addChild(param4[66]);
         param4[43].addChild(param4[54]);
         param4[43].addChild(param4[44]);
         param4[43].addChild(param4[62]);
         param4[43].addChild(param4[60]);
         param4[43].addChild(param4[48]);
         param4[43].addChild(param4[58]);
         param4[43].addChild(param4[46]);
         param4[43].addChild(param4[56]);
         param4[43].addChild(param4[52]);
         param4[43].addChild(param4[50]);
         param4[43].addChild(param4[64]);
         param4[41].updateParent(param1);
         param4[81].updateParent(param1);
         param4[81].addChild(param4[82]);
         param4[82].addChild(param4[83]);
         param4[106].updateParent(param1);
         param4[106].addChild(param4[107]);
         param4[84].updateParent(param1);
         param4[84].addChild(param4[85]);
         param4[85].addChild(param4[86]);
         param4[75].updateParent(param1);
         param4[75].addChild(param4[76]);
         param4[76].addChild(param4[77]);
         param4[92].updateParent(param1);
         param4[92].addChild(param4[95]);
         param4[92].addChild(param4[93]);
         param4[92].addChild(param4[97]);
         param4[92].addChild(param4[101]);
         param4[92].addChild(param4[99]);
         param4[87].updateParent(param1);
         param4[87].addChild(param4[88]);
         param4[88].addChild(param4[89]);
         param4[37].updateParent(param1);
         param4[37].addChild(param4[38]);
         param4[38].addChild(param4[39]);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[5]);
         param4[5].addChild(param4[6]);
         param4[16].updateParent(param1);
         param4[16].addChild(param4[17]);
         param4[17].addChild(param4[18]);
         param4[102].updateParent(param1);
         param4[78].updateParent(param1);
         param4[78].addChild(param4[79]);
         param4[79].addChild(param4[80]);
         param4[74].updateParent(param1);
      }
   }
}

