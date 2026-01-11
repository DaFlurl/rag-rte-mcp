// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationListWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.militarySituationList.MilitarySituationList;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_militarySituationList_MilitarySituationListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MilitarySituationList.watcherSetupUtil = new (_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationListWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[9] = new PropertyWatcher("curRepoet", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[7] = new PropertyWatcher("curPage", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[8] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[0] = new PropertyWatcher("viewstackSelectIndex", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("warDataP", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

