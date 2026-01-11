package
{
   import autoevony.gui.info.Alliance.CheckApplyWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CheckApplyWin.watcherSetupUtil = new _autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("unionArray",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("propertiesObj",null,[param3[2]],param2);
         param4[0].updateParent(param1);
         param4[1].updateParent(param1);
      }
   }
}

