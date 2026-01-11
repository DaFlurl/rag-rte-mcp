// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_quest_QuestAmryInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.quest.QuestAmryInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_quest_QuestAmryInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            QuestAmryInfo.watcherSetupUtil = new (_view_module_quest_QuestAmryInfoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[11] = new PropertyWatcher("myTroop", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[2] = new PropertyWatcher("Description", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[1] = new PropertyWatcher("DescshowId", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[6] = new PropertyWatcher("armyBean", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[6], _arg_3[7]], _arg_2);
            _arg_4[7] = new PropertyWatcher("king", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[8] = new PropertyWatcher("alliance", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[9] = new PropertyWatcher("hero", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[10] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[3] = new PropertyWatcher("armyRankArray", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[0] = new PropertyWatcher("tasker", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[7]);
            _arg_4[6].addChild(_arg_4[8]);
            _arg_4[6].addChild(_arg_4[9]);
            _arg_4[6].addChild(_arg_4[10]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

