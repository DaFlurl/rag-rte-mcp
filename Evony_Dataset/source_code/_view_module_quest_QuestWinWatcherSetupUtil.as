// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_quest_QuestWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.quest.QuestWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.data.FbData;

    public class _view_module_quest_QuestWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            QuestWin.watcherSetupUtil = new (_view_module_quest_QuestWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[33] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[35]], null);
            watchers[28] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[29]], null);
            watchers[41] = new PropertyWatcher("posX", {"propertyChange":true}, [bindings[44]], propertyGetter);
            watchers[1] = new PropertyWatcher("hasQuest", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[20] = new PropertyWatcher("showDecBtn", {"propertyChange":true}, [bindings[34], bindings[19], bindings[33], bindings[18]], propertyGetter);
            watchers[59] = new PropertyWatcher("sortArray", {"propertyChange":true}, [bindings[62]], propertyGetter);
            watchers[60] = new PropertyWatcher("commArray", {"propertyChange":true}, [bindings[63]], propertyGetter);
            watchers[70] = new PropertyWatcher("iFinishCount3", {"propertyChange":true}, [bindings[77], bindings[75], bindings[76]], propertyGetter);
            watchers[50] = new PropertyWatcher("myCommArray", {"propertyChange":true}, [bindings[53]], propertyGetter);
            watchers[46] = new PropertyWatcher("cityList", {"propertyChange":true}, [bindings[49]], propertyGetter);
            watchers[74] = new PropertyWatcher("curQuestTypeName", {"propertyChange":true}, [bindings[81]], propertyGetter);
            watchers[25] = new PropertyWatcher("btnStackIndex", {"propertyChange":true}, [bindings[26]], propertyGetter);
            watchers[14] = new PropertyWatcher("showFavotiteBtn", {"propertyChange":true}, [bindings[13], bindings[12]], propertyGetter);
            watchers[44] = new PropertyWatcher("taskTypeData", {"propertyChange":true}, [bindings[47]], propertyGetter);
            watchers[15] = new PropertyWatcher("showDigiBtn", {"propertyChange":true}, [bindings[15], bindings[23], bindings[21], bindings[20], bindings[14], bindings[22]], propertyGetter);
            watchers[32] = new PropertyWatcher("showDelTaskBtn", {"propertyChange":true}, [bindings[32], bindings[38], bindings[31]], propertyGetter);
            watchers[21] = new PropertyWatcher("NewshowDecBtn", {"propertyChange":true}, [bindings[19], bindings[18]], propertyGetter);
            watchers[5] = new PropertyWatcher("curQuest", {"propertyChange":true}, [bindings[17], bindings[4], bindings[36], bindings[9], bindings[28], bindings[6], bindings[16], bindings[29], bindings[35], bindings[25], bindings[7]], propertyGetter);
            watchers[11] = new PropertyWatcher("manual", {"propertyChange":true}, [bindings[9]], null);
            watchers[27] = new PropertyWatcher("isFinish", {"propertyChange":true}, [bindings[36], bindings[28], bindings[29], bindings[35]], null);
            watchers[24] = new PropertyWatcher("award", {"propertyChange":true}, [bindings[25]], null);
            watchers[30] = new PropertyWatcher("questId", {"propertyChange":true}, [bindings[29], bindings[35]], null);
            watchers[9] = new PropertyWatcher("description", {"propertyChange":true}, [bindings[7]], null);
            watchers[16] = new PropertyWatcher("targetsArray", {"propertyChange":true}, [bindings[17], bindings[16]], null);
            watchers[17] = new PropertyWatcher("length", {"collectionChange":true}, [bindings[17], bindings[16]], null);
            watchers[6] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[4]], null);
            watchers[8] = new PropertyWatcher("version", {"propertyChange":true}, [bindings[6]], null);
            watchers[2] = new PropertyWatcher("curQuestType", {"propertyChange":true}, [bindings[2], bindings[3]], propertyGetter);
            watchers[4] = new PropertyWatcher("description", {"propertyChange":true}, [bindings[3]], null);
            watchers[3] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[2]], null);
            watchers[57] = new PropertyWatcher("filterArray", {"propertyChange":true}, [bindings[60]], propertyGetter);
            watchers[71] = new PropertyWatcher("questTypeArray", {"propertyChange":true}, [bindings[78]], propertyGetter);
            watchers[69] = new PropertyWatcher("iFinishCount1", {"propertyChange":true}, [bindings[73], bindings[72], bindings[74]], propertyGetter);
            watchers[42] = new PropertyWatcher("posY", {"propertyChange":true}, [bindings[45]], propertyGetter);
            watchers[18] = new PropertyWatcher("curDailyTarget", {"propertyChange":true}, [bindings[17], bindings[16]], propertyGetter);
            watchers[19] = new PropertyWatcher("length", {"collectionChange":true}, [bindings[17]], null);
            watchers[37] = new PropertyWatcher("showArmyList", {"propertyChange":true}, [bindings[40]], propertyGetter);
            watchers[73] = new PropertyWatcher("questList", {"propertyChange":true}, [bindings[80]], propertyGetter);
            watchers[33].updateParent(FbData);
            watchers[28].updateParent(FbData);
            watchers[41].updateParent(target);
            watchers[1].updateParent(target);
            watchers[20].updateParent(target);
            watchers[59].updateParent(target);
            watchers[60].updateParent(target);
            watchers[70].updateParent(target);
            watchers[50].updateParent(target);
            watchers[46].updateParent(target);
            watchers[74].updateParent(target);
            watchers[25].updateParent(target);
            watchers[14].updateParent(target);
            watchers[44].updateParent(target);
            watchers[15].updateParent(target);
            watchers[32].updateParent(target);
            watchers[21].updateParent(target);
            watchers[5].updateParent(target);
            watchers[5].addChild(watchers[11]);
            watchers[5].addChild(watchers[27]);
            watchers[5].addChild(watchers[24]);
            watchers[5].addChild(watchers[30]);
            watchers[5].addChild(watchers[9]);
            watchers[5].addChild(watchers[16]);
            watchers[16].addChild(watchers[17]);
            watchers[5].addChild(watchers[6]);
            watchers[5].addChild(watchers[8]);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[4]);
            watchers[2].addChild(watchers[3]);
            watchers[57].updateParent(target);
            watchers[71].updateParent(target);
            watchers[69].updateParent(target);
            watchers[42].updateParent(target);
            watchers[18].updateParent(target);
            watchers[18].addChild(watchers[19]);
            watchers[37].updateParent(target);
            watchers[73].updateParent(target);
        }


    }
}//package 

