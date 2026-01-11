// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_ResourceTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.ResourceTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_ResourceTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ResourceTooltip.watcherSetupUtil = new (_view_module_playerInfo_ResourceTooltipWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[5] = new PropertyWatcher("maxColorStyle", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[3] = new PropertyWatcher("bean", {"propertyChange":true}, [bindings[2], bindings[9], bindings[5]], propertyGetter);
            watchers[4] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[2]], null);
            watchers[17] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[9]], null);
            watchers[8] = new PropertyWatcher("max", {"propertyChange":true}, [bindings[5]], null);
            watchers[0] = new PropertyWatcher("typeName", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[14] = new PropertyWatcher("colonyValue", {"propertyChange":true}, [bindings[9], bindings[7]], propertyGetter);
            watchers[9] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[10] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[11] = new PropertyWatcher("colonization", {"propertyChange":true}, [bindings[6]], null);
            watchers[5].updateParent(target);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[4]);
            watchers[3].addChild(watchers[17]);
            watchers[3].addChild(watchers[8]);
            watchers[0].updateParent(target);
            watchers[14].updateParent(target);
            watchers[9].updateParent(Context);
            watchers[10].parentWatcher = watchers[9];
            watchers[9].addChild(watchers[10]);
            watchers[10].addChild(watchers[11]);
        }


    }
}//package 

