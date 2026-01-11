package
{
   import autoevony.gui.info.LegendaryHero;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_LegendaryHeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_LegendaryHeroWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         LegendaryHero.watcherSetupUtil = new _autoevony_gui_info_LegendaryHeroWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[6] = new PropertyWatcher("faceSource",{"propertyChange":true},[param3[4]],param2);
         param4[0] = new PropertyWatcher("randomHeroBean",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[3]],param2);
         param4[4] = new PropertyWatcher("resetcount",{"propertyChange":true},[param3[3]],null);
         param4[3] = new PropertyWatcher("stratagem",{"propertyChange":true},[param3[2]],null);
         param4[2] = new PropertyWatcher("power",{"propertyChange":true},[param3[1]],null);
         param4[1] = new PropertyWatcher("management",{"propertyChange":true},[param3[0]],null);
         param4[6].updateParent(param1);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[4]);
         param4[0].addChild(param4[3]);
         param4[0].addChild(param4[2]);
         param4[0].addChild(param4[1]);
      }
   }
}

