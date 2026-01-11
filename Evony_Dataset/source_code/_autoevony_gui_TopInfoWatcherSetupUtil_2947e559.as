package
{
   import autoevony.gui.TopInfo;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_TopInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_TopInfoWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TopInfo.watcherSetupUtil = new _autoevony_gui_TopInfoWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[3] = new PropertyWatcher("office",{"propertyChange":true},[param3[3]],param2);
         param4[1] = new PropertyWatcher("alliance",{"propertyChange":true},[param3[1]],param2);
         param4[6] = new PropertyWatcher("allianceLvLArr",{"propertyChange":true},[param3[6]],param2);
         param4[12] = new PropertyWatcher("gift",{"propertyChange":true},[param3[10]],param2);
         param4[11] = new PropertyWatcher("title",{"propertyChange":true},[param3[9]],param2);
         param4[2] = new PropertyWatcher("prestige",{"propertyChange":true},[param3[2]],param2);
         param4[8] = new PropertyWatcher("roleImg",{"propertyChange":true},[param3[6]],param2);
         param4[10] = new PropertyWatcher("honor",{"propertyChange":true},[param3[8]],param2);
         param4[4] = new PropertyWatcher("gameCoins",{"propertyChange":true},[param3[4]],param2);
         param4[9] = new PropertyWatcher("role",{"propertyChange":true},[param3[7]],param2);
         param4[0] = new PropertyWatcher("server",{"propertyChange":true},[param3[0]],param2);
         param4[5] = new PropertyWatcher("ranking",{"propertyChange":true},[param3[5]],param2);
         param4[3].updateParent(param1);
         param4[1].updateParent(param1);
         param4[6].updateParent(param1);
         param4[12].updateParent(param1);
         param4[11].updateParent(param1);
         param4[2].updateParent(param1);
         param4[8].updateParent(param1);
         param4[10].updateParent(param1);
         param4[4].updateParent(param1);
         param4[9].updateParent(param1);
         param4[0].updateParent(param1);
         param4[5].updateParent(param1);
      }
   }
}

