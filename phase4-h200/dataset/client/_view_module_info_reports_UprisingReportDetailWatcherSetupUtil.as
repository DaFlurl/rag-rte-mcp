// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_UprisingReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.UprisingReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_UprisingReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            UprisingReportDetail.watcherSetupUtil = new (_view_module_info_reports_UprisingReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[9] = new PropertyWatcher("obj", {"propertyChange":true}, [_arg_3[13], _arg_3[9], _arg_3[8], _arg_3[11], _arg_3[14], _arg_3[10], _arg_3[12]], _arg_2);
            _arg_4[16] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[14] = new PropertyWatcher("stone", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[10] = new PropertyWatcher("population", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[13] = new PropertyWatcher("wood", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[12] = new PropertyWatcher("food", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[15] = new PropertyWatcher("iron", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[11] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[0] = new PropertyWatcher("castlePos", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[9].addChild(_arg_4[16]);
            _arg_4[9].addChild(_arg_4[14]);
            _arg_4[9].addChild(_arg_4[10]);
            _arg_4[9].addChild(_arg_4[13]);
            _arg_4[9].addChild(_arg_4[12]);
            _arg_4[9].addChild(_arg_4[15]);
            _arg_4[9].addChild(_arg_4[11]);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

