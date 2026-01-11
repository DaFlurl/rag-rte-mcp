package
{
   import autoevony.gui.info.Alliance.AllianceView;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AllianceView.watcherSetupUtil = new _autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("showInAlliance",{"propertyChange":true},[param3[0]],param2);
         param4[3] = new PropertyWatcher("allianceAddPlayerByLeaderInfoBeanListArray",{"propertyChange":true},[param3[3]],param2);
         param4[1] = new PropertyWatcher("allianceWanted",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[6] = new PropertyWatcher("memberLevel",{"propertyChange":true},[param3[9],param3[11]],param2);
         param4[4] = new PropertyWatcher("indexAllianceInfoBean",{"propertyChange":true},[param3[5],param3[8],param3[10]],param2);
         param4[9] = new PropertyWatcher("allianceNote",{"propertyChange":true},[param3[10]],null);
         param4[5] = new PropertyWatcher("allianceInfo",{"propertyChange":true},[param3[8]],null);
         param4[0].updateParent(param1);
         param4[3].updateParent(param1);
         param4[1].updateParent(param1);
         param4[6].updateParent(param1);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[9]);
         param4[4].addChild(param4[5]);
      }
   }
}

