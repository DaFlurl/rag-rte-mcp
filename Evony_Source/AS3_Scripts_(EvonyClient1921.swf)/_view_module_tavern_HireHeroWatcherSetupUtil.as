// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_tavern_HireHeroWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.tavern.HireHero;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_tavern_HireHeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HireHero.watcherSetupUtil = new (_view_module_tavern_HireHeroWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[16] = new PropertyWatcher("dataP", {"propertyChange":true}, [bindings[16]], propertyGetter);
            watchers[1] = new PropertyWatcher("heroMes", {"propertyChange":true}, [bindings[15], bindings[2], bindings[13], bindings[9], bindings[11], bindings[1], bindings[7], bindings[5]], propertyGetter);
            watchers[6] = new PropertyWatcher("level", {"propertyChange":true}, [bindings[11], bindings[5]], null);
            watchers[15] = new PropertyWatcher("loyalty", {"propertyChange":true}, [bindings[15]], null);
            watchers[13] = new PropertyWatcher("power", {"propertyChange":true}, [bindings[13]], null);
            watchers[2] = new PropertyWatcher("logoUrl", {"propertyChange":true}, [bindings[1]], null);
            watchers[8] = new PropertyWatcher("management", {"propertyChange":true}, [bindings[7]], null);
            watchers[3] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[2]], null);
            watchers[10] = new PropertyWatcher("stratagem", {"propertyChange":true}, [bindings[9]], null);
            watchers[23] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[22]], null);
            watchers[24] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[22]], null);
            watchers[21] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[21]], null);
            watchers[22] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[21]], null);
            watchers[16].updateParent(target);
            watchers[1].updateParent(target);
            watchers[1].addChild(watchers[6]);
            watchers[1].addChild(watchers[15]);
            watchers[1].addChild(watchers[13]);
            watchers[1].addChild(watchers[2]);
            watchers[1].addChild(watchers[8]);
            watchers[1].addChild(watchers[3]);
            watchers[1].addChild(watchers[10]);
            watchers[23].updateParent(GuideStep);
            watchers[23].addChild(watchers[24]);
            watchers[21].updateParent(GuideStep);
            watchers[21].addChild(watchers[22]);
        }


    }
}//package 

