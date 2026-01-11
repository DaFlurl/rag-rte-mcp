// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceList_AllianceListWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceList.AllianceList;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_allianceList_AllianceListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceList.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceList_AllianceListWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[8] = new PropertyWatcher("curPageNum", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[9] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[0] = new PropertyWatcher("allianceArray", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

