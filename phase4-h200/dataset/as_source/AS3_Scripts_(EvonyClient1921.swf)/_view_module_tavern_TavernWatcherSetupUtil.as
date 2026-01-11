// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_tavern_TavernWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.tavern.Tavern;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_tavern_TavernWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Tavern.watcherSetupUtil = new (_view_module_tavern_TavernWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[2] = new PropertyWatcher("dataP", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[12]], null);
            watchers[14] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[12]], null);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[11]], null);
            watchers[12] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[11]], null);
            watchers[2].updateParent(target);
            watchers[13].updateParent(GuideStep);
            watchers[13].addChild(watchers[14]);
            watchers[11].updateParent(GuideStep);
            watchers[11].addChild(watchers[12]);
        }


    }
}//package 

