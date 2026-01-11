// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_ArmyDetailsWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.ArmyDetailsWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;

    public class _autoevony_gui_ArmyDetailsWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyDetailsWin.watcherSetupUtil = new (_autoevony_gui_ArmyDetailsWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[32] = new PropertyWatcher("itemSelectInfo", {"propertyChange":true}, [bindings[15]], propertyGetter);
            watchers[31] = new PropertyWatcher("resoData", {"propertyChange":true}, [bindings[14]], propertyGetter);
            watchers[15] = new PropertyWatcher("armyLandsIn", {"propertyChange":true}, [bindings[5]], propertyGetter);
            watchers[0] = new PropertyWatcher("armyType", {"propertyChange":true}, [bindings[0], bindings[7]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("charAt", target, function ():Array
            {
                return ([0]);
            }, null, [bindings[0]], null);
            watchers[4] = new PropertyWatcher("army", {"propertyChange":true}, [bindings[17], bindings[1], bindings[2], bindings[3], bindings[4], bindings[7], bindings[8], bindings[9], bindings[10], bindings[11], bindings[12], bindings[13]], propertyGetter);
            watchers[27] = new PropertyWatcher("alliance", {"propertyChange":true}, [bindings[10]], null);
            watchers[30] = new PropertyWatcher("hero", {"propertyChange":true}, [bindings[12]], null);
            watchers[22] = new PropertyWatcher("direction", {"propertyChange":true}, [bindings[17], bindings[8]], null);
            watchers[8] = new PropertyWatcher("startPosName", {"propertyChange":true}, [bindings[2]], null);
            watchers[26] = new PropertyWatcher("king", {"propertyChange":true}, [bindings[9]], null);
            watchers[5] = new PropertyWatcher("armyId", {"propertyChange":true}, [bindings[1]], null);
            watchers[9] = new PropertyWatcher("reachTime", {"propertyChange":true}, [bindings[3]], null);
            watchers[28] = new PropertyWatcher("heroid", {"propertyChange":true}, [bindings[11], bindings[13]], null);
            watchers[29] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [bindings[12]], null);
            watchers[18] = new PropertyWatcher("missionType", {"propertyChange":true}, [bindings[7]], null);
            watchers[6] = new PropertyWatcher("startFieldId", {"propertyChange":true}, [bindings[2]], null);
            watchers[12] = new PropertyWatcher("targetFieldId", {"propertyChange":true}, [bindings[4]], null);
            watchers[13] = new PropertyWatcher("targetPosName", {"propertyChange":true}, [bindings[4]], null);
            watchers[16] = new PropertyWatcher("troopData", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[33] = new PropertyWatcher("itemCount", {"propertyChange":true}, [bindings[16]], propertyGetter);
            watchers[32].updateParent(target);
            watchers[31].updateParent(target);
            watchers[15].updateParent(target);
            watchers[0].updateParent(target);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[4].updateParent(target);
            watchers[4].addChild(watchers[27]);
            watchers[4].addChild(watchers[30]);
            watchers[4].addChild(watchers[22]);
            watchers[4].addChild(watchers[8]);
            watchers[4].addChild(watchers[26]);
            watchers[4].addChild(watchers[5]);
            watchers[4].addChild(watchers[9]);
            watchers[4].addChild(watchers[28]);
            watchers[4].addChild(watchers[29]);
            watchers[4].addChild(watchers[18]);
            watchers[4].addChild(watchers[6]);
            watchers[4].addChild(watchers[12]);
            watchers[4].addChild(watchers[13]);
            watchers[16].updateParent(target);
            watchers[33].updateParent(target);
        }


    }
}//package 

