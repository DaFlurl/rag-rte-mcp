// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_BuildingInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.BuildingInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.Context;
    import view.module.guide.GuideStep;
    import com.evony.GameConfig;

    public class _view_castle_BuildingInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BuildingInfoWin.watcherSetupUtil = new (_view_castle_BuildingInfoWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[12] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[12]], null);
            watchers[13] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[12]], null);
            watchers[24] = new PropertyWatcher("totalPage", {"propertyChange":true}, [bindings[20]], propertyGetter);
            watchers[1] = new PropertyWatcher("buildingLevel", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[8] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[9] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[9]], null);
            watchers[6] = new PropertyWatcher("btnDestructVisible", {"propertyChange":true}, [bindings[7]], propertyGetter);
            watchers[10] = new PropertyWatcher("btnUpgradeEnable", {"propertyChange":true}, [bindings[13], bindings[10]], propertyGetter);
            watchers[27] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[22]], null);
            watchers[28] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[22]], null);
            watchers[3] = new PropertyWatcher("bean", {"propertyChange":true}, [bindings[6], bindings[16], bindings[3], bindings[5]], propertyGetter);
            watchers[17] = new PropertyWatcher("status", {"propertyChange":true}, [bindings[16]], null);
            watchers[4] = new PropertyWatcher("endTime", {"propertyChange":true}, [bindings[6], bindings[3], bindings[5]], null);
            watchers[0] = new PropertyWatcher("buildingName", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[2] = new PropertyWatcher("buildingDesc", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[20] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[18]], null);
            watchers[21] = new PropertyWatcher("enableBuildingQueue", {"propertyChange":true}, [bindings[18]], null);
            watchers[14] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[14]], null);
            watchers[15] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[14]], null);
            watchers[23] = new PropertyWatcher("currentPage", {"propertyChange":true}, [bindings[20]], propertyGetter);
            watchers[11] = new PropertyWatcher("btnUpgradeVisible", {"propertyChange":true}, [bindings[11], bindings[14]], propertyGetter);
            watchers[25] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[21]], null);
            watchers[26] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[21]], null);
            watchers[12].updateParent(Context);
            watchers[12].addChild(watchers[13]);
            watchers[24].updateParent(target);
            watchers[1].updateParent(target);
            watchers[8].updateParent(Context);
            watchers[8].addChild(watchers[9]);
            watchers[6].updateParent(target);
            watchers[10].updateParent(target);
            watchers[27].updateParent(GuideStep);
            watchers[27].addChild(watchers[28]);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[17]);
            watchers[3].addChild(watchers[4]);
            watchers[0].updateParent(target);
            watchers[2].updateParent(target);
            watchers[20].updateParent(GameConfig);
            watchers[20].addChild(watchers[21]);
            watchers[14].updateParent(Context);
            watchers[14].addChild(watchers[15]);
            watchers[23].updateParent(target);
            watchers[11].updateParent(target);
            watchers[25].updateParent(GuideStep);
            watchers[25].addChild(watchers[26]);
        }


    }
}//package 

