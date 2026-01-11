package
{
   import autoevony.gui.info.Stats.Heroes;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Stats_HeroesWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Stats_HeroesWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Heroes.watcherSetupUtil = new _autoevony_gui_info_Stats_HeroesWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("beansArray",{"propertyChange":true},[param3[2]],param2);
         param4[1] = new PropertyWatcher("totalPage",{"propertyChange":true},[param3[1]],param2);
         param4[2].updateParent(param1);
         param4[1].updateParent(param1);
      }
   }
}

