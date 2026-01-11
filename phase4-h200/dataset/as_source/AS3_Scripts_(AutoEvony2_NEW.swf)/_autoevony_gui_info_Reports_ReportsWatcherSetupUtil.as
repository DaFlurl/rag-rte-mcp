// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Reports_ReportsWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Reports.Reports;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Reports_ReportsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Reports.watcherSetupUtil = new (_autoevony_gui_info_Reports_ReportsWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("dg", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("selectedIndex", {
                "valueCommit":true,
                "change":true
            }, [_arg_3[1]], null);
            _arg_4[3] = new PropertyWatcher("reportsArray", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("length", {"collectionChange":true}, [_arg_3[2]], null);
            _arg_4[0] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

