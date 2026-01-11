package
{
   import autoevony.gui.controls.popup.PopUpWinBase;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PopUpWinBase.watcherSetupUtil = new _autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("windowTitle",{"propertyChange":true},[param3[0]],param2);
         param4[0].updateParent(param1);
      }
   }
}

