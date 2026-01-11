// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_CastleChiefWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.CastleChief;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_herosMansion_CastleChiefWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleChief.watcherSetupUtil = new (_view_module_herosMansion_CastleChiefWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[3] = new PropertyWatcher("heroFreeList", {"propertyChange":true}, [bindings[3], bindings[7]], propertyGetter);
            watchers[4] = new PropertyWatcher("length", {"collectionChange":true}, [bindings[3]], null);
            watchers[7] = new PropertyWatcher("heroMes", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[8] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[6]], null);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[12] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[9]], null);
            watchers[9] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[10] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[8]], null);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[4]);
            watchers[7].updateParent(target);
            watchers[7].addChild(watchers[8]);
            watchers[11].updateParent(GuideStep);
            watchers[11].addChild(watchers[12]);
            watchers[9].updateParent(GuideStep);
            watchers[9].addChild(watchers[10]);
        }


    }
}//package 

