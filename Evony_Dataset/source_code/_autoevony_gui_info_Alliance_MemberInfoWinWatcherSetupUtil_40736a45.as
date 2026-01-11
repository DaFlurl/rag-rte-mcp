package
{
   import autoevony.gui.info.Alliance.MemberInfoWin;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      public function _autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MemberInfoWin.watcherSetupUtil = new _autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("memberInfoBean",{"propertyChange":true},[param3[2],param3[3],param3[4],param3[5],param3[6],param3[7],param3[8],param3[9],param3[10],param3[11],param3[12],param3[13],param3[15]],param2);
         param4[6] = new PropertyWatcher("office",null,[param3[5]],null);
         param4[4] = new PropertyWatcher("alliance",null,[param3[3]],null);
         param4[5] = new PropertyWatcher("allianceLevel",null,[param3[4],param3[13]],null);
         param4[16] = new PropertyWatcher("prestige",null,[param3[11]],null);
         param4[9] = new PropertyWatcher("faceUrl",null,[param3[7]],null);
         param4[19] = new PropertyWatcher("levelId",null,[param3[15]],null);
         param4[18] = new PropertyWatcher("honor",null,[param3[12]],null);
         param4[7] = new PropertyWatcher("titleStr",null,[param3[6]],null);
         param4[3] = new PropertyWatcher("userName",null,[param3[2]],null);
         param4[14] = new PropertyWatcher("castleCount",null,[param3[10]],null);
         param4[13] = new PropertyWatcher("ranking",null,[param3[9]],null);
         param4[11] = new PropertyWatcher("population",null,[param3[8]],null);
         param4[21] = new PropertyWatcher("isOwner",{"propertyChange":true},[param3[16]],param2);
         param4[1] = new PropertyWatcher("canChangePower",{"propertyChange":true},[param3[1],param3[14]],param2);
         param4[0] = new PropertyWatcher("dataPCB",{"propertyChange":true},[param3[0]],param2);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[6]);
         param4[2].addChild(param4[4]);
         param4[2].addChild(param4[5]);
         param4[2].addChild(param4[16]);
         param4[2].addChild(param4[9]);
         param4[2].addChild(param4[19]);
         param4[2].addChild(param4[18]);
         param4[2].addChild(param4[7]);
         param4[2].addChild(param4[3]);
         param4[2].addChild(param4[14]);
         param4[2].addChild(param4[13]);
         param4[2].addChild(param4[11]);
         param4[21].updateParent(param1);
         param4[1].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}

