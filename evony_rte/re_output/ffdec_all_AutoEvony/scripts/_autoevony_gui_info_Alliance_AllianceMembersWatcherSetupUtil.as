package
{
   import autoevony.gui.info.Alliance.AllianceMembers;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AllianceMembers.watcherSetupUtil = new _autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[5] = new PropertyWatcher("membersArray",{"propertyChange":true},[param3[3],param3[8],param3[10]],param2);
         param4[7] = new PropertyWatcher("length",{"collectionChange":true},[param3[8],param3[10]],null);
         param4[0] = new PropertyWatcher("memberLevel",{"propertyChange":true},[param3[0],param3[1],param3[2],param3[8],param3[9],param3[10]],param2);
         param4[5].updateParent(param1);
         param4[5].addChild(param4[7]);
         param4[0].updateParent(param1);
      }
   }
}

