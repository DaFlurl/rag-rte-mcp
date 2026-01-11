package
{
   import autoevony.gui.info.Alliance.EditIntroductionWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         EditIntroductionWin.watcherSetupUtil = new _autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("unionArray",{"propertyChange":true},[param3[0],param3[1],param3[2]],param2);
         param4[2] = new PropertyWatcher("allianceNote",{"propertyChange":true},[param3[1]],null);
         param4[3] = new PropertyWatcher("allianceName",{"propertyChange":true},[param3[2]],null);
         param4[1] = new PropertyWatcher("allianceInfo",{"propertyChange":true},[param3[0]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[2]);
         param4[0].addChild(param4[3]);
         param4[0].addChild(param4[1]);
      }
   }
}

