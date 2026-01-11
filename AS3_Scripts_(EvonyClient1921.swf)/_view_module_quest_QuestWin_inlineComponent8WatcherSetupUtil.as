// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_quest_QuestWin_inlineComponent8WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.quest.QuestWin_inlineComponent8;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_quest_QuestWin_inlineComponent8WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            QuestWin_inlineComponent8.watcherSetupUtil = new (_view_module_quest_QuestWin_inlineComponent8WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[2], _arg_3[4], _arg_3[6], _arg_3[3], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("isFinish", null, [_arg_3[2], _arg_3[3]], null);
            _arg_4[1] = new PropertyWatcher("name", null, [_arg_3[0]], null);
            _arg_4[6] = new PropertyWatcher("recommend", null, [_arg_3[6], _arg_3[7]], null);
            _arg_4[5] = new PropertyWatcher("version", null, [_arg_3[4], _arg_3[5]], null);
            _arg_4[2] = new PropertyWatcher("outerDocument", {"propertyChange":true}, [_arg_3[6], _arg_3[1], _arg_3[7]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[2].updateParent(_arg_1);
        }


    }
}//package 

