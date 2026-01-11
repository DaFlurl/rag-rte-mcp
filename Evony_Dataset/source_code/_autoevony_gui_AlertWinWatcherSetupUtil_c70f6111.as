package
{
   import autoevony.gui.AlertWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_AlertWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_AlertWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AlertWin.watcherSetupUtil = new _autoevony_gui_AlertWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("showNoBtn",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[3],param3[4]],param2);
         param4[0].updateParent(param1);
      }
   }
}

