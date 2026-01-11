// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_InfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.InfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_module_info_InfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            InfoWin.watcherSetupUtil = new (_view_module_info_InfoWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[8] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[9] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[10] = new PropertyWatcher("enemyArmysArray", {"propertyChange":true}, [bindings[8]], null);
            watchers[19] = new PropertyWatcher("tradeCount", {"propertyChange":true}, [bindings[17], bindings[19], bindings[18]], propertyGetter);
            watchers[20] = new PropertyWatcher("otherCount", {"propertyChange":true}, [bindings[21], bindings[20], bindings[22]], propertyGetter);
            watchers[18] = new PropertyWatcher("scoutCount", {"propertyChange":true}, [bindings[15], bindings[16], bindings[14]], propertyGetter);
            watchers[17] = new PropertyWatcher("armyCount", {"propertyChange":true}, [bindings[13], bindings[11], bindings[12]], propertyGetter);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[12] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[13] = new PropertyWatcher("selfArmysArray", {"propertyChange":true}, [bindings[9]], null);
            watchers[14] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[15] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[16] = new PropertyWatcher("friendArmysArray", {"propertyChange":true}, [bindings[10]], null);
            watchers[8].updateParent(Context);
            watchers[9].parentWatcher = watchers[8];
            watchers[8].addChild(watchers[9]);
            watchers[9].addChild(watchers[10]);
            watchers[19].updateParent(target);
            watchers[20].updateParent(target);
            watchers[18].updateParent(target);
            watchers[17].updateParent(target);
            watchers[11].updateParent(Context);
            watchers[12].parentWatcher = watchers[11];
            watchers[11].addChild(watchers[12]);
            watchers[12].addChild(watchers[13]);
            watchers[14].updateParent(Context);
            watchers[15].parentWatcher = watchers[14];
            watchers[14].addChild(watchers[15]);
            watchers[15].addChild(watchers[16]);
        }


    }
}//package 

