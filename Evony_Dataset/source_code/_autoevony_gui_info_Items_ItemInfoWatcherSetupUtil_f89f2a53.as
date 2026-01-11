package
{
   import autoevony.gui.info.Items.ItemInfo;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Items_ItemInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Items_ItemInfoWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ItemInfo.watcherSetupUtil = new _autoevony_gui_info_Items_ItemInfoWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("itemsArray",{"propertyChange":true},[param3[1]],param2);
         param4[0] = new PropertyWatcher("filterOptions",{"propertyChange":true},[param3[0]],param2);
         param4[1].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}

