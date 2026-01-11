package
{
   import autoevony.gui.info.Alliance.Events;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_EventsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Alliance_EventsWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Events.watcherSetupUtil = new _autoevony_gui_info_Alliance_EventsWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("totalPage",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("eventsArray",{"propertyChange":true},[param3[1]],param2);
         param4[0].updateParent(param1);
         param4[1].updateParent(param1);
      }
   }
}

