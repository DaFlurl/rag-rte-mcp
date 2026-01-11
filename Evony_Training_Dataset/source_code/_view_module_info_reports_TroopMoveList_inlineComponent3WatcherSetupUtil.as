// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_reports_TroopMoveList_inlineComponent3WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.TroopMoveList_inlineComponent3;
    import mx.core.IFlexModuleFactory;

    public class _view_module_info_reports_TroopMoveList_inlineComponent3WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TroopMoveList_inlineComponent3.watcherSetupUtil = new (_view_module_info_reports_TroopMoveList_inlineComponent3WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

