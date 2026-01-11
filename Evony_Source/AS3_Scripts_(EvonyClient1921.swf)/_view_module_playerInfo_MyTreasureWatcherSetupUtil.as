// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_MyTreasureWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.MyTreasure;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.StaticPropertyWatcher;
    import view.module.guide.GuideStep;
    import com.evony.Context;
    import com.evony.GameConfig;

    public class _view_module_playerInfo_MyTreasureWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MyTreasure.watcherSetupUtil = new (_view_module_playerInfo_MyTreasureWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[29] = new PropertyWatcher("buttonBar", {"propertyChange":true}, [bindings[17], bindings[18]], propertyGetter);
            watchers[30] = new PropertyWatcher("selectedIndex", {
                "valueCommit":true,
                "click":true
            }, [bindings[17], bindings[18]], null);
            watchers[23] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[15]], null);
            watchers[24] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[15]], null);
            watchers[31] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[18]], null);
            watchers[32] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[18]], null);
            watchers[27] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[17]], null);
            watchers[28] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[17]], null);
            watchers[20] = new PropertyWatcher("player", {"propertyChange":true}, [bindings[14]], propertyGetter);
            watchers[21] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[14]], null);
            watchers[22] = new PropertyWatcher("medal", {"propertyChange":true}, [bindings[14]], null);
            watchers[1] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[2] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[1]], null);
            watchers[4] = new PropertyWatcher("userId", {"propertyChange":true}, [bindings[1]], null);
            watchers[8] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[3]], null);
            watchers[9] = new PropertyWatcher("ButtonFlag", {"propertyChange":true}, [bindings[3]], null);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[25] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[16]], null);
            watchers[26] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[16]], null);
            watchers[29].updateParent(target);
            watchers[29].addChild(watchers[30]);
            watchers[23].updateParent(GuideStep);
            watchers[23].addChild(watchers[24]);
            watchers[31].updateParent(GuideStep);
            watchers[31].addChild(watchers[32]);
            watchers[27].updateParent(GuideStep);
            watchers[27].addChild(watchers[28]);
            watchers[20].updateParent(target);
            watchers[20].addChild(watchers[21]);
            watchers[21].addChild(watchers[22]);
            watchers[1].updateParent(Context);
            watchers[2].parentWatcher = watchers[1];
            watchers[1].addChild(watchers[2]);
            watchers[2].addChild(watchers[3]);
            watchers[3].addChild(watchers[4]);
            watchers[8].updateParent(GameConfig);
            watchers[8].addChild(watchers[9]);
            watchers[5].updateParent(Context);
            watchers[25].updateParent(GuideStep);
            watchers[25].addChild(watchers[26]);
        }


    }
}//package 

