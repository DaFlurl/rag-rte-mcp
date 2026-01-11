package
{
   import autoevony.gui.CityPanel_inlineComponent2_2;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_CityPanel_inlineComponent2_2WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_CityPanel_inlineComponent2_2WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CityPanel_inlineComponent2_2.watcherSetupUtil = new _autoevony_gui_CityPanel_inlineComponent2_2WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("data",{"dataChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("col9",null,[param3[0]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
      }
   }
}

