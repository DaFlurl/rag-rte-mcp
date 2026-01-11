// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_WarReportWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.WarReport;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_WarReportWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            WarReport.watcherSetupUtil = new (_autoevony_gui_info_Alliance_WarReportWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("situationsArray", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

