package
{
   import autoevony.gui.ChatPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_ChatPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_ChatPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ChatPanel.watcherSetupUtil = new _autoevony_gui_ChatPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("cache",{"propertyChange":true},[param3[1]],param2);
         param4[3] = new PropertyWatcher("aChatText",{"propertyChange":true},[param3[1]],null);
         param4[7] = new PropertyWatcher("commandText",{"propertyChange":true},[param3[1]],null);
         param4[5] = new PropertyWatcher("wChatText",{"propertyChange":true},[param3[1]],null);
         param4[8] = new PropertyWatcher("emtpyStr",{"propertyChange":true},[param3[1]],null);
         param4[4] = new PropertyWatcher("pChatText",{"propertyChange":true},[param3[1]],null);
         param4[6] = new PropertyWatcher("systemText",{"propertyChange":true},[param3[1]],null);
         param4[0] = new PropertyWatcher("chatTab",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[1] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "click":true
         },[param3[1],param3[2]],null);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[3]);
         param4[2].addChild(param4[7]);
         param4[2].addChild(param4[5]);
         param4[2].addChild(param4[8]);
         param4[2].addChild(param4[4]);
         param4[2].addChild(param4[6]);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
      }
   }
}

