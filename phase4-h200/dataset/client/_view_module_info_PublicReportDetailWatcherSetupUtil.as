// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_PublicReportDetailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.PublicReportDetail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_PublicReportDetailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PublicReportDetail.watcherSetupUtil = new (_view_module_info_PublicReportDetailWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[12] = new PropertyWatcher("strUrl", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[3] = new PropertyWatcher("bean", {"propertyChange":true}, [_arg_3[4], _arg_3[6], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[6] = new PropertyWatcher("title", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[11] = new PropertyWatcher("content", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[8] = new PropertyWatcher("eventTime", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[10] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[4] = new PropertyWatcher("miliS", {"propertyChange":true}, [_arg_3[4], _arg_3[3], _arg_3[5]], _arg_2);
            _arg_4[7] = new PropertyWatcher("time", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[9] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[5] = new PropertyWatcher("eventName", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[6]);
            _arg_4[3].addChild(_arg_4[11]);
            _arg_4[3].addChild(_arg_4[8]);
            _arg_4[3].addChild(_arg_4[10]);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[7]);
            _arg_4[4].addChild(_arg_4[9]);
            _arg_4[4].addChild(_arg_4[5]);
        }


    }
}//package 

