package
{
   import autoevony.gui.info.Items.BuyItemWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         BuyItemWin.watcherSetupUtil = new _autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("itemData",{"propertyChange":true},[param3[1],param3[2],param3[3]],param2);
         param4[2] = new PropertyWatcher("price",{"propertyChange":true},[param3[1],param3[2],param3[3]],null);
         param4[4] = new PropertyWatcher("_buyCountInput1",{"propertyChange":true},[param3[2],param3[3]],param2);
         param4[5] = new PropertyWatcher("_useCountInput",{"propertyChange":true},[param3[2],param3[3]],null);
         param4[6] = new PropertyWatcher("text",{
            "change":false,
            "textChanged":true
         },[param3[2],param3[3]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[5]);
         param4[5].addChild(param4[6]);
      }
   }
}

