package
{
   import autoevony.gui.LoginScreen;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_LoginScreenWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_LoginScreenWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         LoginScreen.watcherSetupUtil = new _autoevony_gui_LoginScreenWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("proxySelectInfo",{"propertyChange":true},[param3[1]],param2);
         param4[2] = new PropertyWatcher("_proxySelect",{"propertyChange":true},[param3[2],param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[9]],param2);
         param4[3] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "collectionChange":true,
            "change":true
         },[param3[2],param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[9]],null);
         param4[4] = new PropertyWatcher("_skypeUnInput",{"propertyChange":true},[param3[10]],param2);
         param4[5] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[10]],null);
         param4[10] = new PropertyWatcher("themeSelectInfo",{"propertyChange":true},[param3[13]],param2);
         param4[0] = new PropertyWatcher("loginTypeSelectInfo",{"propertyChange":true},[param3[0]],param2);
         param4[1].updateParent(param1);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[3]);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[5]);
         param4[10].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}

