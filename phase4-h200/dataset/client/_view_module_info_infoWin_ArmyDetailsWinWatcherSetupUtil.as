// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_infoWin_ArmyDetailsWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.infoWin.ArmyDetailsWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;

    public class _view_module_info_infoWin_ArmyDetailsWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyDetailsWin.watcherSetupUtil = new (_view_module_info_infoWin_ArmyDetailsWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[12] = new PropertyWatcher("armyOb", {"propertyChange":true}, [bindings[15], bindings[13], bindings[14], bindings[12]], propertyGetter);
            watchers[17] = new FunctionReturnWatcher("hasOwnProperty", target, function ():Array
            {
                return (["heroName"]);
            }, {"propertyChange":true}, [bindings[14]], null);
            watchers[15] = new FunctionReturnWatcher("hasOwnProperty", target, function ():Array
            {
                return (["Alliance"]);
            }, {"propertyChange":true}, [bindings[13]], null);
            watchers[14] = new PropertyWatcher("Lord", {"propertyChange":true}, [bindings[12]], null);
            watchers[13] = new FunctionReturnWatcher("hasOwnProperty", target, function ():Array
            {
                return (["Lord"]);
            }, {"propertyChange":true}, [bindings[12]], null);
            watchers[19] = new FunctionReturnWatcher("hasOwnProperty", target, function ():Array
            {
                return (["heroLevel"]);
            }, {"propertyChange":true}, [bindings[15]], null);
            watchers[16] = new PropertyWatcher("Alliance", {"propertyChange":true}, [bindings[13]], null);
            watchers[18] = new PropertyWatcher("heroName", {"propertyChange":true}, [bindings[14]], null);
            watchers[20] = new PropertyWatcher("heroLevel", {"propertyChange":true}, [bindings[15]], null);
            watchers[1] = new PropertyWatcher("troops", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[4] = new PropertyWatcher("myResource", {"propertyChange":true}, [bindings[4]], propertyGetter);
            watchers[12].updateParent(target);
            watchers[17].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[17]);
            watchers[15].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[15]);
            watchers[12].addChild(watchers[14]);
            watchers[13].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[13]);
            watchers[19].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[19]);
            watchers[12].addChild(watchers[16]);
            watchers[12].addChild(watchers[18]);
            watchers[12].addChild(watchers[20]);
            watchers[1].updateParent(target);
            watchers[4].updateParent(target);
        }


    }
}//package 

