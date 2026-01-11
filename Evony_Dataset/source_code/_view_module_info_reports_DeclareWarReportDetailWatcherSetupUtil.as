// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_DeclareWarReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.DeclareWarReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_DeclareWarReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            DeclareWarReportDetail.watcherSetupUtil = new (_view_module_info_reports_DeclareWarReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("warDir", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("startTime", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[5] = new PropertyWatcher("endTime", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
        }


    }
}//package 

