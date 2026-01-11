package
{
   import autoevony.gui.heroview.BuffsArray_inlineComponent0;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_heroview_BuffsArray_inlineComponent0WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_heroview_BuffsArray_inlineComponent0WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         BuffsArray_inlineComponent0.watcherSetupUtil = new _autoevony_gui_heroview_BuffsArray_inlineComponent0WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("data",{"dataChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("endTime",null,[param3[0]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
      }
   }
}

