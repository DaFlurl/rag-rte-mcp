package
{
   import autoevony.gui.info.FormatRanking_inlineComponent0;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_FormatRanking_inlineComponent0WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_FormatRanking_inlineComponent0WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FormatRanking_inlineComponent0.watcherSetupUtil = new _autoevony_gui_info_FormatRanking_inlineComponent0WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("data",{"dataChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("ranking",null,[param3[0]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
      }
   }
}

