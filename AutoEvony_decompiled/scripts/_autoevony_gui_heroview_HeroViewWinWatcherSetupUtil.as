package
{
   import autoevony.gui.heroview.HeroViewWin;
   import com.evony.common.constants.EquipmentTech;
   import flash.display.Sprite;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_heroview_HeroViewWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_heroview_HeroViewWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         HeroViewWin.watcherSetupUtil = new _autoevony_gui_heroview_HeroViewWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var bindings:Array = param3;
         var watchers:Array = param4;
         watchers[154] = new PropertyWatcher("slotChangeAllOptions",{"propertyChange":true},[bindings[123]],propertyGetter);
         watchers[29] = new PropertyWatcher("addPolPoints",{"propertyChange":true},[bindings[34],bindings[19],bindings[20],bindings[37],bindings[22],bindings[25],bindings[40],bindings[30]],propertyGetter);
         watchers[31] = new PropertyWatcher("addIntPoints",{"propertyChange":true},[bindings[34],bindings[32],bindings[20],bindings[37],bindings[25],bindings[40],bindings[29],bindings[30]],propertyGetter);
         watchers[1] = new PropertyWatcher("hero",{"propertyChange":true},[bindings[0],bindings[1],bindings[2],bindings[4],bindings[5],bindings[6],bindings[7],bindings[8],bindings[9],bindings[10],bindings[11],bindings[12],bindings[13],bindings[14],bindings[15],bindings[17],bindings[16],bindings[19],bindings[18],bindings[21],bindings[20],bindings[23],bindings[25],bindings[24],bindings[26],bindings[29],bindings[28],bindings[31],bindings[30],bindings[34],bindings[35],bindings[33],bindings[38],bindings[39],bindings[36],bindings[37],bindings[42],bindings[43],bindings[41],bindings[46],bindings[47],bindings[44],bindings[45],bindings[51],bindings[50],bindings[49],bindings[48],bindings[54],bindings[53],bindings[52],bindings[58],bindings[57],bindings[56],bindings[62],bindings[61],bindings[60],bindings[68],bindings[69],bindings[70],bindings[64],bindings[65],bindings[66],bindings[76],bindings[77],bindings[78],bindings[72],bindings[73],bindings[74],bindings[85],bindings[84],bindings[86],bindings[81],bindings[80]
         ,bindings[82],bindings[93],bindings[92],bindings[94],bindings[89],bindings[88],bindings[90],bindings[102],bindings[100],bindings[101],bindings[98],bindings[96],bindings[97],bindings[110],bindings[108],bindings[109],bindings[106],bindings[104],bindings[105],bindings[118],bindings[117],bindings[116],bindings[114],bindings[113],bindings[112],bindings[121],bindings[120]],propertyGetter);
         watchers[4] = new PropertyWatcher("isHero",{"propertyChange":true},[bindings[2],bindings[6],bindings[52],bindings[42],bindings[12],bindings[44]],null);
         watchers[49] = new PropertyWatcher("sex",{"propertyChange":true},[bindings[57]],null);
         watchers[53] = new PropertyWatcher("equipmentbeanArray",{"propertyChange":true},[bindings[68],bindings[69],bindings[70],bindings[64],bindings[65],bindings[66],bindings[76],bindings[77],bindings[78],bindings[72],bindings[73],bindings[74],bindings[85],bindings[84],bindings[86],bindings[81],bindings[80],bindings[82],bindings[93],bindings[92],bindings[94],bindings[89],bindings[88],bindings[90],bindings[102],bindings[100],bindings[101],bindings[98],bindings[96],bindings[97],bindings[110],bindings[108],bindings[109],bindings[106],bindings[104],bindings[105],bindings[118],bindings[117],bindings[116],bindings[114],bindings[113],bindings[112],bindings[58],bindings[62],bindings[121],bindings[61],bindings[120],bindings[60]],null);
         watchers[136] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1];
         },{"collectionChange":true},[bindings[110]],null);
         watchers[69] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1];
         },{"collectionChange":true},[bindings[66]],null);
         watchers[138] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1];
         },{"collectionChange":true},[bindings[112]],null);
         watchers[71] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1];
         },{"collectionChange":true},[bindings[68]],null);
         watchers[140] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1];
         },{"collectionChange":true},[bindings[113]],null);
         watchers[65] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_CHEST - 1];
         },{"collectionChange":true},[bindings[64]],null);
         watchers[142] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_R - 1];
         },{"collectionChange":true},[bindings[114]],null);
         watchers[67] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_CHEST - 1];
         },{"collectionChange":true},[bindings[65]],null);
         watchers[128] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WRIST - 1];
         },{"collectionChange":true},[bindings[105]],null);
         watchers[77] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1];
         },{"collectionChange":true},[bindings[72]],null);
         watchers[130] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WAIST - 1];
         },{"collectionChange":true},[bindings[106]],null);
         watchers[79] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1];
         },{"collectionChange":true},[bindings[73]],null);
         watchers[132] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WAIST - 1];
         },{"collectionChange":true},[bindings[108]],null);
         watchers[73] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1];
         },{"collectionChange":true},[bindings[69]],null);
         watchers[134] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WAIST - 1];
         },{"collectionChange":true},[bindings[109]],null);
         watchers[75] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1];
         },{"collectionChange":true},[bindings[70]],null);
         watchers[152] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_FEET - 1];
         },{"collectionChange":true},[bindings[121]],null);
         watchers[85] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1];
         },{"collectionChange":true},[bindings[77]],null);
         watchers[87] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1];
         },{"collectionChange":true},[bindings[78]],null);
         watchers[81] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1];
         },{"collectionChange":true},[bindings[74]],null);
         watchers[83] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1];
         },{"collectionChange":true},[bindings[76]],null);
         watchers[144] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_R - 1];
         },{"collectionChange":true},[bindings[116]],null);
         watchers[93] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_L - 1];
         },{"collectionChange":true},[bindings[82]],null);
         watchers[146] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_R - 1];
         },{"collectionChange":true},[bindings[117]],null);
         watchers[95] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_L - 1];
         },{"collectionChange":true},[bindings[84]],null);
         watchers[148] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_FEET - 1];
         },{"collectionChange":true},[bindings[118]],null);
         watchers[89] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1];
         },{"collectionChange":true},[bindings[80]],null);
         watchers[150] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_FEET - 1];
         },{"collectionChange":true},[bindings[120]],null);
         watchers[91] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1];
         },{"collectionChange":true},[bindings[81]],null);
         watchers[102] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1];
         },{"collectionChange":true},[bindings[88]],null);
         watchers[99] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1];
         },{"collectionChange":true},[bindings[86]],null);
         watchers[97] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_RING_L - 1];
         },{"collectionChange":true},[bindings[85]],null);
         watchers[110] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1];
         },{"collectionChange":true},[bindings[93]],null);
         watchers[108] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1];
         },{"collectionChange":true},[bindings[92]],null);
         watchers[106] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1];
         },{"collectionChange":true},[bindings[90]],null);
         watchers[104] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1];
         },{"collectionChange":true},[bindings[89]],null);
         watchers[118] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_BACK - 1];
         },{"collectionChange":true},[bindings[98]],null);
         watchers[116] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1];
         },{"collectionChange":true},[bindings[97]],null);
         watchers[114] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1];
         },{"collectionChange":true},[bindings[96]],null);
         watchers[54] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_HEAD - 1];
         },{"collectionChange":true},[bindings[58]],null);
         watchers[112] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1];
         },{"collectionChange":true},[bindings[94]],null);
         watchers[126] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WRIST - 1];
         },{"collectionChange":true},[bindings[104]],null);
         watchers[58] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_HEAD - 1];
         },{"collectionChange":true},[bindings[60]],null);
         watchers[124] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_WRIST - 1];
         },{"collectionChange":true},[bindings[102]],null);
         watchers[63] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_CHEST - 1];
         },{"collectionChange":true},[bindings[62]],null);
         watchers[122] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_BACK - 1];
         },{"collectionChange":true},[bindings[101]],null);
         watchers[61] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_HEAD - 1];
         },{"collectionChange":true},[bindings[61]],null);
         watchers[120] = new FunctionReturnWatcher("getItemAt",target,function():Array
         {
            return [EquipmentTech.EQUIPMENT_SLOT_BACK - 1];
         },{"collectionChange":true},[bindings[100]],null);
         watchers[38] = new PropertyWatcher("stratagem",{"propertyChange":true},[bindings[29]],null);
         watchers[40] = new PropertyWatcher("stratagemBuffAdded",{"propertyChange":true},[bindings[29]],null);
         watchers[25] = new PropertyWatcher("politics",{"propertyChange":true},[bindings[19]],null);
         watchers[35] = new PropertyWatcher("powerBuffAdded",{"propertyChange":true},[bindings[24]],null);
         watchers[11] = new PropertyWatcher("level",{"propertyChange":true},[bindings[35],bindings[4],bindings[52]],null);
         watchers[44] = new PropertyWatcher("maxStrength",{"propertyChange":true},[bindings[48],bindings[46]],null);
         watchers[17] = new PropertyWatcher("upgradeExp",{"propertyChange":true},[bindings[5],bindings[7]],null);
         watchers[26] = new PropertyWatcher("managementBuffAdded",{"propertyChange":true},[bindings[19]],null);
         watchers[3] = new PropertyWatcher("name",{"propertyChange":true},[bindings[1]],null);
         watchers[33] = new PropertyWatcher("power",{"propertyChange":true},[bindings[24]],null);
         watchers[15] = new PropertyWatcher("experience",{"propertyChange":true},[bindings[5],bindings[7]],null);
         watchers[42] = new PropertyWatcher("loyalty",{"propertyChange":true},[bindings[42],bindings[44]],null);
         watchers[39] = new PropertyWatcher("intelligence",{"propertyChange":true},[bindings[29]],null);
         watchers[43] = new PropertyWatcher("stamina",{"propertyChange":true},[bindings[48],bindings[46]],null);
         watchers[5] = new PropertyWatcher("status",{"propertyChange":true},[bindings[2],bindings[39],bindings[36],bindings[7],bindings[37],bindings[43],bindings[9],bindings[11],bindings[47],bindings[13],bindings[14],bindings[45],bindings[15],bindings[17],bindings[16],bindings[49],bindings[18],bindings[53],bindings[56]],null);
         watchers[45] = new PropertyWatcher("leadership",{"propertyChange":true},[bindings[50]],null);
         watchers[46] = new PropertyWatcher("speed",{"propertyChange":true},[bindings[51]],null);
         watchers[2] = new PropertyWatcher("logoUrl",{"propertyChange":true},[bindings[0]],null);
         watchers[27] = new PropertyWatcher("remainPoint",{"propertyChange":true},[bindings[34],bindings[35],bindings[33],bindings[38],bindings[41],bindings[19],bindings[21],bindings[20],bindings[23],bindings[25],bindings[24],bindings[26],bindings[29],bindings[28],bindings[31],bindings[30]],null);
         watchers[48] = new PropertyWatcher("buffsArray",{"propertyChange":true},[bindings[54]],null);
         watchers[34] = new PropertyWatcher("attack",{"propertyChange":true},[bindings[24]],null);
         watchers[24] = new PropertyWatcher("management",{"propertyChange":true},[bindings[19]],null);
         watchers[57] = new PropertyWatcher("slotChangeOptions",{"propertyChange":true},[bindings[103],bindings[71],bindings[99],bindings[67],bindings[111],bindings[79],bindings[107],bindings[75],bindings[119],bindings[115],bindings[83],bindings[59],bindings[95],bindings[63],bindings[91]],propertyGetter);
         watchers[8] = new PropertyWatcher("_inputNewHeroName",{"propertyChange":true},[bindings[3]],propertyGetter);
         watchers[9] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[bindings[3]],null);
         watchers[30] = new PropertyWatcher("addAtkPoints",{"propertyChange":true},[bindings[34],bindings[20],bindings[37],bindings[25],bindings[24],bindings[40],bindings[27],bindings[30]],propertyGetter);
         watchers[101] = new PropertyWatcher("mountChangeOptions",{"propertyChange":true},[bindings[87]],propertyGetter);
         watchers[59] = new PropertyWatcher("addAttributeType",null,[bindings[68],bindings[100],bindings[64],bindings[96],bindings[76],bindings[108],bindings[72],bindings[104],bindings[84],bindings[116],bindings[80],bindings[112],bindings[92],bindings[88],bindings[120],bindings[60]],propertyGetter);
         watchers[56] = new PropertyWatcher("equipmenttech",null,[bindings[102],bindings[70],bindings[98],bindings[66],bindings[110],bindings[78],bindings[106],bindings[74],bindings[118],bindings[86],bindings[114],bindings[82],bindings[58],bindings[94],bindings[62],bindings[90]],propertyGetter);
         watchers[154].updateParent(target);
         watchers[29].updateParent(target);
         watchers[31].updateParent(target);
         watchers[1].updateParent(target);
         watchers[1].addChild(watchers[4]);
         watchers[1].addChild(watchers[49]);
         watchers[1].addChild(watchers[53]);
         watchers[136].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[136]);
         watchers[69].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[69]);
         watchers[138].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[138]);
         watchers[71].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[71]);
         watchers[140].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[140]);
         watchers[65].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[65]);
         watchers[142].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[142]);
         watchers[67].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[67]);
         watchers[128].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[128]);
         watchers[77].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[77]);
         watchers[130].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[130]);
         watchers[79].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[79]);
         watchers[132].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[132]);
         watchers[73].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[73]);
         watchers[134].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[134]);
         watchers[75].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[75]);
         watchers[152].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[152]);
         watchers[85].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[85]);
         watchers[87].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[87]);
         watchers[81].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[81]);
         watchers[83].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[83]);
         watchers[144].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[144]);
         watchers[93].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[93]);
         watchers[146].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[146]);
         watchers[95].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[95]);
         watchers[148].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[148]);
         watchers[89].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[89]);
         watchers[150].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[150]);
         watchers[91].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[91]);
         watchers[102].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[102]);
         watchers[99].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[99]);
         watchers[97].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[97]);
         watchers[110].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[110]);
         watchers[108].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[108]);
         watchers[106].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[106]);
         watchers[104].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[104]);
         watchers[118].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[118]);
         watchers[116].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[116]);
         watchers[114].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[114]);
         watchers[54].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[54]);
         watchers[112].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[112]);
         watchers[126].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[126]);
         watchers[58].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[58]);
         watchers[124].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[124]);
         watchers[63].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[63]);
         watchers[122].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[122]);
         watchers[61].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[61]);
         watchers[120].parentWatcher = watchers[53];
         watchers[53].addChild(watchers[120]);
         watchers[1].addChild(watchers[38]);
         watchers[1].addChild(watchers[40]);
         watchers[1].addChild(watchers[25]);
         watchers[1].addChild(watchers[35]);
         watchers[1].addChild(watchers[11]);
         watchers[1].addChild(watchers[44]);
         watchers[1].addChild(watchers[17]);
         watchers[1].addChild(watchers[26]);
         watchers[1].addChild(watchers[3]);
         watchers[1].addChild(watchers[33]);
         watchers[1].addChild(watchers[15]);
         watchers[1].addChild(watchers[42]);
         watchers[1].addChild(watchers[39]);
         watchers[1].addChild(watchers[43]);
         watchers[1].addChild(watchers[5]);
         watchers[1].addChild(watchers[45]);
         watchers[1].addChild(watchers[46]);
         watchers[1].addChild(watchers[2]);
         watchers[1].addChild(watchers[27]);
         watchers[1].addChild(watchers[48]);
         watchers[1].addChild(watchers[34]);
         watchers[1].addChild(watchers[24]);
         watchers[57].updateParent(target);
         watchers[8].updateParent(target);
         watchers[8].addChild(watchers[9]);
         watchers[30].updateParent(target);
         watchers[101].updateParent(target);
         watchers[59].updateParent(target);
         watchers[56].updateParent(target);
      }
   }
}

