// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_AmountInputUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.AmountInputUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;
    import com.evony.Context;

    public class _view_ui_AmountInputUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AmountInputUI.watcherSetupUtil = new (_view_ui_AmountInputUIWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[0] = new PropertyWatcher("itemEum", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[1] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[0]], null);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[14] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[8]], null);
            watchers[3] = new PropertyWatcher("initNum", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[7] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[8] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[9] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[6]], null);
            watchers[10] = new PropertyWatcher("medal", {"propertyChange":true}, [bindings[6]], null);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[7]], null);
            watchers[12] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[7]], null);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[1]);
            watchers[13].updateParent(GuideStep);
            watchers[13].addChild(watchers[14]);
            watchers[3].updateParent(target);
            watchers[7].updateParent(Context);
            watchers[8].parentWatcher = watchers[7];
            watchers[7].addChild(watchers[8]);
            watchers[8].addChild(watchers[9]);
            watchers[9].addChild(watchers[10]);
            watchers[11].updateParent(GuideStep);
            watchers[11].addChild(watchers[12]);
        }


    }
}//package 

