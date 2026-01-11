package
{
   import autoevony.gui.CityPanel_inlineComponent7;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CityPanel_inlineComponent7.watcherSetupUtil = new _autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("data",{"dataChange":true},[param3[0],param3[1],param3[2]],param2);
         param4[1] = new PropertyWatcher("col7",null,[param3[0]],null);
         param4[3] = new PropertyWatcher("col9",null,[param3[2]],null);
         param4[2] = new PropertyWatcher("col8",null,[param3[1]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
         param4[0].addChild(param4[3]);
         param4[0].addChild(param4[2]);
      }
   }
}

