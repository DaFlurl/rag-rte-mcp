package
{
   import autoevony.gui.newarmy.TroopInput;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_newarmy_TroopInputWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_newarmy_TroopInputWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TroopInput.watcherSetupUtil = new _autoevony_gui_newarmy_TroopInputWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("parentDocument",{"initialize":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("_applyStygandrsBannerOfTheHorde",null,[param3[0]],null);
         param4[2] = new PropertyWatcher("selected",null,[param3[0]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
         param4[1].addChild(param4[2]);
      }
   }
}

