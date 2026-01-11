// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceList_AllianceInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceList.AllianceInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_allianceList_AllianceInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceInfo.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceList_AllianceInfoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("allianceBean", {"propertyChange":true}, [_arg_3[4], _arg_3[8], _arg_3[6], _arg_3[16], _arg_3[14], _arg_3[12]], _arg_2);
            _arg_4[14] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[16] = new PropertyWatcher("prestigeCount", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[18] = new PropertyWatcher("allinaceInfo", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[8] = new PropertyWatcher("creator", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[6] = new PropertyWatcher("leader", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[10] = new PropertyWatcher("memberCount", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[2] = new PropertyWatcher("officalLevel", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[12] = new PropertyWatcher("curRank", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[20] = new PropertyWatcher("isShow", {"propertyChange":true}, [_arg_3[19], _arg_3[21], _arg_3[18], _arg_3[25], _arg_3[24], _arg_3[22]], _arg_2);
            _arg_4[0] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[14]);
            _arg_4[5].addChild(_arg_4[16]);
            _arg_4[5].addChild(_arg_4[18]);
            _arg_4[5].addChild(_arg_4[8]);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[5].addChild(_arg_4[10]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[20].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

