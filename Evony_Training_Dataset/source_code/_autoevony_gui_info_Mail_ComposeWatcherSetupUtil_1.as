package
{
   import autoevony.gui.info.Mail.Compose;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Mail_ComposeWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Mail_ComposeWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Compose.watcherSetupUtil = new _autoevony_gui_info_Mail_ComposeWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("_alliance",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("selected",{
            "valueCommit":true,
            "click":true
         },[param3[0]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
      }
   }
}

