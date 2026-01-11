package
{
   import autoevony.gui.CityPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_CityPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_CityPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CityPanel.watcherSetupUtil = new _autoevony_gui_CityPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[35] = new PropertyWatcher("troopsData",{"propertyChange":true},[param3[45]],param2);
         param4[37] = new PropertyWatcher("fortificationsData",{"propertyChange":true},[param3[47]],param2);
         param4[34] = new PropertyWatcher("armyData",{"propertyChange":true},[param3[42]],param2);
         param4[26] = new PropertyWatcher("resourceData",{"propertyChange":true},[param3[27]],param2);
         param4[39] = new PropertyWatcher("externalTroopData",{"propertyChange":true},[param3[49]],param2);
         param4[1] = new PropertyWatcher("_cityPanelBean",{"propertyChange":true},[param3[1],param3[9],param3[10],param3[11]],param2);
         param4[2] = new PropertyWatcher("goalsTxt",{"propertyChange":true},[param3[1]],null);
         param4[3] = new PropertyWatcher("scriptTxt",{"propertyChange":true},[param3[9]],null);
         param4[4] = new PropertyWatcher("scriptIsRunning",{"propertyChange":true},[param3[10],param3[11]],null);
         param4[31] = new PropertyWatcher("buildingData",{"propertyChange":true},[param3[38]],param2);
         param4[36] = new PropertyWatcher("troopQueueData",{"propertyChange":true},[param3[46]],param2);
         param4[27] = new PropertyWatcher("valleyData",{"propertyChange":true},[param3[28]],param2);
         param4[32] = new PropertyWatcher("researchData",{"propertyChange":true},[param3[39]],param2);
         param4[38] = new PropertyWatcher("tradesData",{"propertyChange":true},[param3[48]],param2);
         param4[30] = new PropertyWatcher("heroData",{"propertyChange":true},[param3[34]],param2);
         param4[8] = new PropertyWatcher("_inputNewCastleName",{"propertyChange":true},[param3[15]],param2);
         param4[9] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[15]],null);
         param4[33] = new PropertyWatcher("gearsData",{"propertyChange":true},[param3[40]],param2);
         param4[28] = new PropertyWatcher("colonyData",{"propertyChange":true},[param3[30]],param2);
         param4[29] = new PropertyWatcher("innHeroData",{"propertyChange":true},[param3[32]],param2);
         param4[0] = new PropertyWatcher("_castleBean",{"propertyChange":true},[param3[0],param3[2],param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[12],param3[13],param3[14],param3[17],param3[16],param3[19],param3[18],param3[21],param3[20],param3[23],param3[22],param3[25],param3[24],param3[26]],param2);
         param4[7] = new PropertyWatcher("powerlevel",{"propertyChange":true},[param3[13],param3[14]],null);
         param4[5] = new PropertyWatcher("name",{"propertyChange":true},[param3[12]],null);
         param4[11] = new PropertyWatcher("resource",{"propertyChange":true},[param3[17],param3[16],param3[19],param3[18],param3[21],param3[20],param3[23],param3[25],param3[24]],null);
         param4[24] = new PropertyWatcher("workPeople",{"propertyChange":true},[param3[25],param3[24]],null);
         param4[12] = new PropertyWatcher("support",{"propertyChange":true},[param3[17],param3[16]],null);
         param4[22] = new PropertyWatcher("curPopulation",{"propertyChange":true},[param3[23],param3[25],param3[24]],null);
         param4[16] = new PropertyWatcher("texRate",{"propertyChange":true},[param3[21],param3[20]],null);
         param4[14] = new PropertyWatcher("complaint",{"propertyChange":true},[param3[19],param3[18]],null);
         param4[19] = new PropertyWatcher("fieldId",{"propertyChange":true},[param3[22]],null);
         param4[35].updateParent(param1);
         param4[37].updateParent(param1);
         param4[34].updateParent(param1);
         param4[26].updateParent(param1);
         param4[39].updateParent(param1);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[1].addChild(param4[3]);
         param4[1].addChild(param4[4]);
         param4[31].updateParent(param1);
         param4[36].updateParent(param1);
         param4[27].updateParent(param1);
         param4[32].updateParent(param1);
         param4[38].updateParent(param1);
         param4[30].updateParent(param1);
         param4[8].updateParent(param1);
         param4[8].addChild(param4[9]);
         param4[33].updateParent(param1);
         param4[28].updateParent(param1);
         param4[29].updateParent(param1);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[7]);
         param4[0].addChild(param4[5]);
         param4[0].addChild(param4[11]);
         param4[11].addChild(param4[24]);
         param4[11].addChild(param4[12]);
         param4[11].addChild(param4[22]);
         param4[11].addChild(param4[16]);
         param4[11].addChild(param4[14]);
         param4[0].addChild(param4[19]);
      }
   }
}

