// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_shop_TurntableRank_inlineComponent4WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.shop.TurntableRank_inlineComponent4;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.ArrayElementWatcher;

    public class _view_module_shop_TurntableRank_inlineComponent4WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TurntableRank_inlineComponent4.watcherSetupUtil = new (_view_module_shop_TurntableRank_inlineComponent4WatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[2] = new PropertyWatcher("data", {"dataChange":true}, [bindings[1], bindings[0]], propertyGetter);
            watchers[3] = new PropertyWatcher("itemsBeansArray", null, [bindings[1], bindings[0]], null);
            watchers[4] = new ArrayElementWatcher(target, function ():*
            {
                return (0);
            }, [bindings[0]]);
            watchers[6] = new PropertyWatcher("id", null, [bindings[0]], null);
            watchers[8] = new ArrayElementWatcher(target, function ():*
            {
                return (0);
            }, [bindings[1]]);
            watchers[10] = new PropertyWatcher("id", null, [bindings[1]], null);
            watchers[0] = new PropertyWatcher("outerDocument", {"propertyChange":true}, [bindings[1], bindings[0]], propertyGetter);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[3]);
            watchers[4].arrayWatcher = watchers[3];
            watchers[3].addChild(watchers[4]);
            watchers[4].addChild(watchers[6]);
            watchers[8].arrayWatcher = watchers[3];
            watchers[3].addChild(watchers[8]);
            watchers[8].addChild(watchers[10]);
            watchers[0].updateParent(target);
        }


    }
}//package 

