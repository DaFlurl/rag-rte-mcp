package
{
   import autoevony.gui.info.Reports.Reports;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Reports_ReportsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Reports_ReportsWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Reports.watcherSetupUtil = new _autoevony_gui_info_Reports_ReportsWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("dg",{"propertyChange":true},[param3[1]],param2);
         param4[2] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "change":true
         },[param3[1]],null);
         param4[3] = new PropertyWatcher("reportsArray",{"propertyChange":true},[param3[2],param3[3]],param2);
         param4[4] = new PropertyWatcher("length",{"collectionChange":true},[param3[2]],null);
         param4[0] = new PropertyWatcher("totalPage",{"propertyChange":true},[param3[0]],param2);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[4]);
         param4[0].updateParent(param1);
      }
   }
}

