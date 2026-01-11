// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_technology_TechReseachingUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.technology.TechReseachingUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_technology_TechReseachingUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TechReseachingUI.watcherSetupUtil = new (_view_module_technology_TechReseachingUIWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[0] = new PropertyWatcher("_bean", {"propertyChange":true}, [bindings[2], bindings[5], bindings[0]], propertyGetter);
            watchers[1] = new PropertyWatcher("castleId", {"propertyChange":true}, [bindings[2], bindings[0]], null);
            watchers[11] = new PropertyWatcher("endTime", {"propertyChange":true}, [bindings[5]], null);
            watchers[12] = new PropertyWatcher("callBack", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[6] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[7] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[8] = new PropertyWatcher("id", {"propertyChange":true}, [bindings[2]], null);
            watchers[5] = new PropertyWatcher("imageSource", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[9] = new PropertyWatcher("techName", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[2] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[3] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[4] = new PropertyWatcher("id", {"propertyChange":true}, [bindings[0]], null);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[1]);
            watchers[0].addChild(watchers[11]);
            watchers[12].updateParent(target);
            watchers[6].updateParent(Context);
            watchers[7].parentWatcher = watchers[6];
            watchers[6].addChild(watchers[7]);
            watchers[7].addChild(watchers[8]);
            watchers[5].updateParent(target);
            watchers[9].updateParent(target);
            watchers[2].updateParent(Context);
            watchers[3].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[3]);
            watchers[3].addChild(watchers[4]);
        }


    }
}//package 

