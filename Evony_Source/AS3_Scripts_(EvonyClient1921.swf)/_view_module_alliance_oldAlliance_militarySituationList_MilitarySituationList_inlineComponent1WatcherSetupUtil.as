// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationList_inlineComponent1WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.militarySituationList.MilitarySituationList_inlineComponent1;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_oldAlliance_militarySituationList_MilitarySituationList_inlineComponent1WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MilitarySituationList_inlineComponent1.watcherSetupUtil = new (_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationList_inlineComponent1WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("outerDocument", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("lookUpStr", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

