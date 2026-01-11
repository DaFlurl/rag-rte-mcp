// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_TroopMoveListWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.TroopMoveList;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_info_reports_TroopMoveListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TroopMoveList.watcherSetupUtil = new (_view_module_info_reports_TroopMoveListWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("targetPos", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3] = new PropertyWatcher("troopMoves", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
        }


    }
}//package 

