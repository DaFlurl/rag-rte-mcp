// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_SowDiscordReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.SowDiscordReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_SowDiscordReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            SowDiscordReportDetail.watcherSetupUtil = new (_view_module_info_reports_SowDiscordReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("heroVisible", {"propertyChange":true}, [_arg_3[2], _arg_3[6], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[3] = new PropertyWatcher("heroDesc", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[1] = new PropertyWatcher("imgSource", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[0] = new PropertyWatcher("desc", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

