// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_ScoutReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.ScoutReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_ScoutReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ScoutReportDetail.watcherSetupUtil = new (_view_module_info_reports_ScoutReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("battleObj", {"propertyChange":true}, [_arg_3[17], _arg_3[15], _arg_3[13], _arg_3[9], _arg_3[8], _arg_3[11], _arg_3[16], _arg_3[18], _arg_3[14], _arg_3[10]], _arg_2);
            _arg_4[8] = new PropertyWatcher("defendTroop", {"propertyChange":true}, [_arg_3[17], _arg_3[18]], null);
            _arg_4[7] = new PropertyWatcher("isBack", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[16], _arg_3[14]], null);
            _arg_4[3] = new PropertyWatcher("scoutInfoObj", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[3], _arg_3[7], _arg_3[5]], _arg_2);
            _arg_4[12] = new PropertyWatcher("autoHealObj", {"propertyChange":true}, [_arg_3[23], _arg_3[21], _arg_3[20], _arg_3[24], _arg_3[22]], _arg_2);
            _arg_4[1] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2] = new PropertyWatcher("ScoutObj", {"propertyChange":true}, [_arg_3[19], _arg_3[1]], _arg_2);
            _arg_4[9] = new PropertyWatcher("scoutInfo", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[8]);
            _arg_4[5].addChild(_arg_4[7]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[9]);
        }


    }
}//package 

