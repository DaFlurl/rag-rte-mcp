// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_FoodTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.FoodTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_FoodTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            FoodTooltip.watcherSetupUtil = new (_view_module_playerInfo_FoodTooltipWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[12] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[13] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[14] = new PropertyWatcher("colonization", {"propertyChange":true}, [bindings[8]], null);
            watchers[26] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[11]], null);
            watchers[27] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[11]], null);
            watchers[28] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[11]], null);
            watchers[29] = new PropertyWatcher("supplyFood", {"propertyChange":true}, [bindings[11]], null);
            watchers[33] = new PropertyWatcher("armyColorStyle", {"propertyChange":true}, [bindings[14]], propertyGetter);
            watchers[37] = new PropertyWatcher("yieldColorStyle", {"propertyChange":true}, [bindings[17]], propertyGetter);
            watchers[36] = new PropertyWatcher("actualOutput", {"propertyChange":true}, [bindings[16]], propertyGetter);
            watchers[17] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[18] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[19] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[9]], null);
            watchers[20] = new PropertyWatcher("colonyFood", {"propertyChange":true}, [bindings[9]], null);
            watchers[5] = new PropertyWatcher("maxColorStyle", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[3] = new PropertyWatcher("bean", {"propertyChange":true}, [bindings[2], bindings[7], bindings[5]], propertyGetter);
            watchers[4] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[2]], null);
            watchers[11] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[7]], null);
            watchers[8] = new PropertyWatcher("max", {"propertyChange":true}, [bindings[5]], null);
            watchers[21] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[22] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[23] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[10]], null);
            watchers[24] = new PropertyWatcher("supplyFood", {"propertyChange":true}, [bindings[10]], null);
            watchers[32] = new PropertyWatcher("consumption", {"propertyChange":true}, [bindings[13]], propertyGetter);
            watchers[12].updateParent(Context);
            watchers[13].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[13]);
            watchers[13].addChild(watchers[14]);
            watchers[26].updateParent(Context);
            watchers[27].parentWatcher = watchers[26];
            watchers[26].addChild(watchers[27]);
            watchers[27].addChild(watchers[28]);
            watchers[28].addChild(watchers[29]);
            watchers[33].updateParent(target);
            watchers[37].updateParent(target);
            watchers[36].updateParent(target);
            watchers[17].updateParent(Context);
            watchers[18].parentWatcher = watchers[17];
            watchers[17].addChild(watchers[18]);
            watchers[18].addChild(watchers[19]);
            watchers[19].addChild(watchers[20]);
            watchers[5].updateParent(target);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[4]);
            watchers[3].addChild(watchers[11]);
            watchers[3].addChild(watchers[8]);
            watchers[21].updateParent(Context);
            watchers[22].parentWatcher = watchers[21];
            watchers[21].addChild(watchers[22]);
            watchers[22].addChild(watchers[23]);
            watchers[23].addChild(watchers[24]);
            watchers[32].updateParent(target);
        }


    }
}//package 

