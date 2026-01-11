// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_GoldTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.GoldTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_GoldTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            GoldTooltip.watcherSetupUtil = new (_view_module_playerInfo_GoldTooltipWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[7] = new PropertyWatcher("incomeStyle", {"propertyChange":true}, [bindings[13], bindings[3]], propertyGetter);
            watchers[5] = new PropertyWatcher("bean", {"propertyChange":true}, [bindings[2], bindings[7], bindings[12], bindings[5]], propertyGetter);
            watchers[23] = new PropertyWatcher("herosSalary", {"propertyChange":true}, [bindings[12]], null);
            watchers[16] = new PropertyWatcher("colonyGold", {"propertyChange":true}, [bindings[7], bindings[12]], null);
            watchers[10] = new PropertyWatcher("taxIncome", {"propertyChange":true}, [bindings[12], bindings[5]], null);
            watchers[6] = new PropertyWatcher("gold", {"propertyChange":true}, [bindings[2]], null);
            watchers[20] = new PropertyWatcher("heroSalaryStyle", {"propertyChange":true}, [bindings[10]], propertyGetter);
            watchers[19] = new PropertyWatcher("heroSalary", {"propertyChange":true}, [bindings[9]], propertyGetter);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[12] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[13] = new PropertyWatcher("colonization", {"propertyChange":true}, [bindings[6]], null);
            watchers[7].updateParent(target);
            watchers[5].updateParent(target);
            watchers[5].addChild(watchers[23]);
            watchers[5].addChild(watchers[16]);
            watchers[5].addChild(watchers[10]);
            watchers[5].addChild(watchers[6]);
            watchers[20].updateParent(target);
            watchers[19].updateParent(target);
            watchers[11].updateParent(Context);
            watchers[12].parentWatcher = watchers[11];
            watchers[11].addChild(watchers[12]);
            watchers[12].addChild(watchers[13]);
        }


    }
}//package 

