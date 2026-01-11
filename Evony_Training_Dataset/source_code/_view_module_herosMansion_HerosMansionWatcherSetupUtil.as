// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_HerosMansionWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.HerosMansion;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_herosMansion_HerosMansionWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HerosMansion.watcherSetupUtil = new (_view_module_herosMansion_HerosMansionWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[0] = new PropertyWatcher("dataP", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[15] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[14]], null);
            watchers[16] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[14]], null);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[13]], null);
            watchers[14] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[13]], null);
            watchers[0].updateParent(target);
            watchers[15].updateParent(GuideStep);
            watchers[15].addChild(watchers[16]);
            watchers[13].updateParent(GuideStep);
            watchers[13].addChild(watchers[14]);
        }


    }
}//package 

