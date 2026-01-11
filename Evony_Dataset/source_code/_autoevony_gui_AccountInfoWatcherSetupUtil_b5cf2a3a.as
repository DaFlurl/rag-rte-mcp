package
{
   import autoevony.gui.AccountInfo;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_AccountInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_AccountInfoWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AccountInfo.watcherSetupUtil = new _autoevony_gui_AccountInfoWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[3] = new PropertyWatcher("label",null,[param3[0]],param2);
         param4[0] = new PropertyWatcher("accountInfoTab",{"propertyChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "click":true
         },[param3[0]],null);
         param4[3].updateParent(param1);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[2]);
      }
   }
}

