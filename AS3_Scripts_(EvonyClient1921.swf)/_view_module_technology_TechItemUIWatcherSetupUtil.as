// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_technology_TechItemUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.technology.TechItemUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_technology_TechItemUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TechItemUI.watcherSetupUtil = new (_view_module_technology_TechItemUIWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[7] = new PropertyWatcher("_techBean", {"propertyChange":true}, [bindings[13], bindings[6]], propertyGetter);
            watchers[8] = new PropertyWatcher("level", {"propertyChange":true}, [bindings[13], bindings[6]], null);
            watchers[9] = new PropertyWatcher("avalevel", {"propertyChange":true}, [bindings[13], bindings[6]], null);
            watchers[6] = new PropertyWatcher("researchBtnVisable", {"propertyChange":true}, [bindings[10], bindings[12], bindings[5]], propertyGetter);
            watchers[5] = new PropertyWatcher("isCanResearch", {"propertyChange":true}, [bindings[4], bindings[9], bindings[11]], propertyGetter);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[12]], null);
            watchers[14] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[12]], null);
            watchers[10] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[7]], null);
            watchers[11] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[7]], null);
            watchers[1] = new PropertyWatcher("itemName", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[2] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[3] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[2]], null);
            watchers[0] = new PropertyWatcher("imgSource", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[7].updateParent(target);
            watchers[7].addChild(watchers[8]);
            watchers[7].addChild(watchers[9]);
            watchers[6].updateParent(target);
            watchers[5].updateParent(target);
            watchers[13].updateParent(Context);
            watchers[13].addChild(watchers[14]);
            watchers[10].updateParent(Context);
            watchers[10].addChild(watchers[11]);
            watchers[1].updateParent(target);
            watchers[2].updateParent(Context);
            watchers[2].addChild(watchers[3]);
            watchers[0].updateParent(target);
        }


    }
}//package 

