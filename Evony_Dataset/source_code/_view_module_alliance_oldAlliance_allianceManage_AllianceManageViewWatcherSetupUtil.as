// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceManage_AllianceManageViewWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceManage.AllianceManageView;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_allianceManage_AllianceManageViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceManageView.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceManage_AllianceManageViewWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("officalLevel", {"propertyChange":true}, [_arg_3[17], _arg_3[15], _arg_3[13], _arg_3[9], _arg_3[11], _arg_3[1], _arg_3[3], _arg_3[7], _arg_3[5]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

