package
{
   import autoevony.gui.info.Alliance.AllianceInfoWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AllianceInfoWin.watcherSetupUtil = new _autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("officalLevel",{"propertyChange":true},[param3[1]],param2);
         param4[7] = new PropertyWatcher("curRank",{"propertyChange":true},[param3[5]],param2);
         param4[3] = new PropertyWatcher("allianceBean",{"propertyChange":true},[param3[2],param3[3],param3[4],param3[6],param3[7],param3[8]],param2);
         param4[9] = new PropertyWatcher("honor",{"propertyChange":true},[param3[6]],null);
         param4[4] = new PropertyWatcher("leader",{"propertyChange":true},[param3[2]],null);
         param4[11] = new PropertyWatcher("prestigeCount",{"propertyChange":true},[param3[7]],null);
         param4[6] = new PropertyWatcher("memberCount",{"propertyChange":true},[param3[4]],null);
         param4[12] = new PropertyWatcher("allinaceInfo",{"propertyChange":true},[param3[8]],null);
         param4[5] = new PropertyWatcher("creator",{"propertyChange":true},[param3[3]],null);
         param4[0] = new PropertyWatcher("allianceName",{"propertyChange":true},[param3[0]],param2);
         param4[13] = new PropertyWatcher("isShow",{"propertyChange":true},[param3[9],param3[10],param3[11],param3[12],param3[13],param3[14]],param2);
         param4[1].updateParent(param1);
         param4[7].updateParent(param1);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[9]);
         param4[3].addChild(param4[4]);
         param4[3].addChild(param4[11]);
         param4[3].addChild(param4[6]);
         param4[3].addChild(param4[12]);
         param4[3].addChild(param4[5]);
         param4[0].updateParent(param1);
         param4[13].updateParent(param1);
      }
   }
}

