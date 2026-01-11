// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_infoWin_ArmyInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.infoWin.ArmyInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_info_infoWin_ArmyInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyInfoWin.watcherSetupUtil = new (_view_module_info_infoWin_ArmyInfoWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[8] = new PropertyWatcher("armyBean", {"propertyChange":true}, [bindings[17], bindings[15], bindings[8], bindings[16], bindings[14]], propertyGetter);
            watchers[9] = new PropertyWatcher("king", {"propertyChange":true}, [bindings[8], bindings[14]], null);
            watchers[19] = new PropertyWatcher("alliance", {"propertyChange":true}, [bindings[15]], null);
            watchers[20] = new PropertyWatcher("hero", {"propertyChange":true}, [bindings[16]], null);
            watchers[21] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [bindings[17]], null);
            watchers[1] = new PropertyWatcher("myTroop", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[10] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[11] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[12] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[8]], null);
            watchers[13] = new PropertyWatcher("userName", {"propertyChange":true}, [bindings[8]], null);
            watchers[4] = new PropertyWatcher("myResource", {"propertyChange":true}, [bindings[4]], propertyGetter);
            watchers[8].updateParent(target);
            watchers[8].addChild(watchers[9]);
            watchers[8].addChild(watchers[19]);
            watchers[8].addChild(watchers[20]);
            watchers[8].addChild(watchers[21]);
            watchers[1].updateParent(target);
            watchers[10].updateParent(Context);
            watchers[11].parentWatcher = watchers[10];
            watchers[10].addChild(watchers[11]);
            watchers[11].addChild(watchers[12]);
            watchers[12].addChild(watchers[13]);
            watchers[4].updateParent(target);
        }


    }
}//package 

