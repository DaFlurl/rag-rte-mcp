// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_RobReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.RobReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_RobReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            RobReportDetail.watcherSetupUtil = new (_view_module_info_reports_RobReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[5] = new PropertyWatcher("troop", {"propertyChange":true}, [_arg_3[9], _arg_3[10]], _arg_2);
            _arg_4[1] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("robResource", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[8], _arg_3[6], _arg_3[1], _arg_3[3], _arg_3[7]], _arg_2);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
        }


    }
}//package 

