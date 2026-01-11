// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castleList_ColonyList_inlineComponent1WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castleList.ColonyList_inlineComponent1;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import view.castleList.ColonyList;

    public class _view_castleList_ColonyList_inlineComponent1WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonyList_inlineComponent1.watcherSetupUtil = new (_view_castleList_ColonyList_inlineComponent1WatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[5] = new PropertyWatcher("colonyNum", {"propertyChange":true}, [bindings[2]], null);
            watchers[2] = new PropertyWatcher("data", {"dataChange":true}, [bindings[4], bindings[6], bindings[1], bindings[3], bindings[5]], propertyGetter);
            watchers[8] = new PropertyWatcher("castle", null, [bindings[6]], null);
            watchers[6] = new PropertyWatcher("cbean", null, [bindings[3], bindings[5]], null);
            watchers[7] = new PropertyWatcher("parent", null, [bindings[4]], null);
            watchers[3] = new PropertyWatcher("pageN", null, [bindings[1]], null);
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("itemArray", {"propertyChange":true}, [bindings[0]], null);
            watchers[4].updateParent(ColonyList);
            watchers[4].addChild(watchers[5]);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[8]);
            watchers[2].addChild(watchers[6]);
            watchers[2].addChild(watchers[7]);
            watchers[2].addChild(watchers[3]);
            watchers[0].updateParent(ColonyList);
            watchers[0].addChild(watchers[1]);
        }


    }
}//package 

