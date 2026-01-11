// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_AllianceExistWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.AllianceExist;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_AllianceExistWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceExist.watcherSetupUtil = new (_view_module_alliance_oldAlliance_AllianceExistWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[16] = new PropertyWatcher("indexAllianceInfoBean", {"propertyChange":true}, [_arg_3[19], _arg_3[16], _arg_3[18]], _arg_2);
            _arg_4[17] = new PropertyWatcher("allianceInfo", {"propertyChange":true}, [_arg_3[16]], null);
            _arg_4[19] = new PropertyWatcher("allianceNote", {"propertyChange":true}, [_arg_3[18]], null);
            _arg_4[11] = new PropertyWatcher("enemyListArray", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[3] = new PropertyWatcher("friendlyListArray", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[7] = new PropertyWatcher("middleListArray", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[16].addChild(_arg_4[17]);
            _arg_4[16].addChild(_arg_4[19]);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

