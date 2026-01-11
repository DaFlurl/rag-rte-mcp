// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_TradeReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.TradeReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_TradeReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TradeReportDetail.watcherSetupUtil = new (_view_module_info_reports_TradeReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("obj", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("resName", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[2] = new PropertyWatcher("tradeType", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[7] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[3] = new PropertyWatcher("dealedAmount", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[7]);
            _arg_4[1].addChild(_arg_4[3]);
        }


    }
}//package 

