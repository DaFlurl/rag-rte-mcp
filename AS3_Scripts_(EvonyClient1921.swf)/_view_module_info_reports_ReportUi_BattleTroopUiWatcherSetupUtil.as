// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_ReportUi_BattleTroopUiWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.ReportUi.BattleTroopUi;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_ReportUi_BattleTroopUiWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BattleTroopUi.watcherSetupUtil = new (_view_module_info_reports_ReportUi_BattleTroopUiWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("battleTroopObj", {"propertyChange":true}, [_arg_3[15], _arg_3[4], _arg_3[19], _arg_3[8], _arg_3[11], _arg_3[16], _arg_3[18], _arg_3[3], _arg_3[7], _arg_3[12], _arg_3[17], _arg_3[2], _arg_3[13], _arg_3[9], _arg_3[6], _arg_3[1], _arg_3[14], _arg_3[10], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[5] = new PropertyWatcher("heroExp", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[6], _arg_3[10], _arg_3[7]], null);
            _arg_4[6] = new PropertyWatcher("castlePos", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[11], _arg_3[6], _arg_3[14], _arg_3[7], _arg_3[12]], null);
            _arg_4[9] = new PropertyWatcher("troopUnit", {"propertyChange":true}, [_arg_3[17], _arg_3[19], _arg_3[16], _arg_3[18]], null);
            _arg_4[1] = new PropertyWatcher("heroUrl", {"propertyChange":true}, [_arg_3[1], _arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("heroName", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], null);
            _arg_4[4] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [_arg_3[4], _arg_3[5]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[9]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[4]);
        }


    }
}//package 

