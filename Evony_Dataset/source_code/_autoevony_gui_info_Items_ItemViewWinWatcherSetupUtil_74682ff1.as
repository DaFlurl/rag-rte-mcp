package
{
   import autoevony.gui.info.Items.ItemViewWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ItemViewWin.watcherSetupUtil = new _autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("itemData",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[12],param3[14],param3[15],param3[17],param3[16],param3[19],param3[21],param3[23],param3[22],param3[25],param3[24]],param2);
         param4[6] = new PropertyWatcher("id",{"propertyChange":true},[param3[17],param3[16],param3[19],param3[2],param3[21],param3[23],param3[8],param3[12],param3[15]],null);
         param4[11] = new PropertyWatcher("desc",{"propertyChange":true},[param3[6]],null);
         param4[8] = new PropertyWatcher("price",{"propertyChange":true},[param3[3],param3[4],param3[5]],null);
         param4[10] = new PropertyWatcher("count",{"propertyChange":true},[param3[3],param3[22],param3[25],param3[24],param3[14]],null);
         param4[5] = new PropertyWatcher("itemType",{"propertyChange":true},[param3[2]],null);
         param4[3] = new PropertyWatcher("name",{"propertyChange":true},[param3[1]],null);
         param4[2] = new PropertyWatcher("iconUrl",{"propertyChange":true},[param3[0]],null);
         param4[12] = new PropertyWatcher("itemDesc",{"propertyChange":true},[param3[7]],null);
         param4[26] = new PropertyWatcher("zoneInfo",{"propertyChange":true},[param3[18]],param2);
         param4[28] = new PropertyWatcher("disappearHeros",{"propertyChange":true},[param3[20],param3[22]],param2);
         param4[31] = new PropertyWatcher("length",{"collectionChange":true},[param3[22]],null);
         param4[14] = new PropertyWatcher("_zone_Select",{"propertyChange":true},[param3[8],param3[9],param3[10],param3[11]],param2);
         param4[15] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "collectionChange":true,
            "change":true
         },[param3[8],param3[9],param3[10],param3[11]],null);
         param4[16] = new PropertyWatcher("selectedItem",{
            "valueCommit":true,
            "collectionChange":true,
            "change":true
         },[param3[9],param3[10],param3[11]],null);
         param4[17] = new PropertyWatcher("data",null,[param3[9],param3[10],param3[11]],null);
         param4[20] = new PropertyWatcher("rate",null,[param3[11]],null);
         param4[19] = new PropertyWatcher("castleCount",null,[param3[10]],null);
         param4[18] = new PropertyWatcher("playerCount",null,[param3[9]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[6]);
         param4[1].addChild(param4[11]);
         param4[1].addChild(param4[8]);
         param4[1].addChild(param4[10]);
         param4[1].addChild(param4[5]);
         param4[1].addChild(param4[3]);
         param4[1].addChild(param4[2]);
         param4[1].addChild(param4[12]);
         param4[26].updateParent(param1);
         param4[28].updateParent(param1);
         param4[28].addChild(param4[31]);
         param4[14].updateParent(param1);
         param4[14].addChild(param4[15]);
         param4[14].addChild(param4[16]);
         param4[16].addChild(param4[17]);
         param4[17].addChild(param4[20]);
         param4[17].addChild(param4[19]);
         param4[17].addChild(param4[18]);
      }
   }
}

