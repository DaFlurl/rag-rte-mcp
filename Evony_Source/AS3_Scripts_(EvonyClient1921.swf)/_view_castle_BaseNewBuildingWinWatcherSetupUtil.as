// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_BaseNewBuildingWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.BaseNewBuildingWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import view.module.guide.GuideStep;

    public class _view_castle_BaseNewBuildingWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BaseNewBuildingWin.watcherSetupUtil = new (_view_castle_BaseNewBuildingWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[17] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[18] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[6]], null);
            watchers[3] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[4] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[0]], null);
            watchers[15] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[5]], null);
            watchers[16] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[5]], null);
            watchers[23] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[9]], null);
            watchers[24] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[9]], null);
            watchers[2] = new PropertyWatcher("className", null, [bindings[2], bindings[4], bindings[9], bindings[8], bindings[11], bindings[6], bindings[1], bindings[3], bindings[10], bindings[7], bindings[5], bindings[0]], propertyGetter);
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[0]], null);
            watchers[7] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[8] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[1]], null);
            watchers[27] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[11]], null);
            watchers[28] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[11]], null);
            watchers[19] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[7]], null);
            watchers[20] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[7]], null);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[4]], null);
            watchers[14] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[4]], null);
            watchers[21] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[22] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[8]], null);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[6] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[1]], null);
            watchers[11] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[12] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[3]], null);
            watchers[9] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[10] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[2]], null);
            watchers[25] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[26] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[10]], null);
            watchers[17].updateParent(GuideStep);
            watchers[17].addChild(watchers[18]);
            watchers[3].updateParent(GuideStep);
            watchers[3].addChild(watchers[4]);
            watchers[15].updateParent(GuideStep);
            watchers[15].addChild(watchers[16]);
            watchers[23].updateParent(GuideStep);
            watchers[23].addChild(watchers[24]);
            watchers[2].updateParent(target);
            watchers[0].updateParent(GuideStep);
            watchers[0].addChild(watchers[1]);
            watchers[7].updateParent(GuideStep);
            watchers[7].addChild(watchers[8]);
            watchers[27].updateParent(GuideStep);
            watchers[27].addChild(watchers[28]);
            watchers[19].updateParent(GuideStep);
            watchers[19].addChild(watchers[20]);
            watchers[13].updateParent(GuideStep);
            watchers[13].addChild(watchers[14]);
            watchers[21].updateParent(GuideStep);
            watchers[21].addChild(watchers[22]);
            watchers[5].updateParent(GuideStep);
            watchers[5].addChild(watchers[6]);
            watchers[11].updateParent(GuideStep);
            watchers[11].addChild(watchers[12]);
            watchers[9].updateParent(GuideStep);
            watchers[9].addChild(watchers[10]);
            watchers[25].updateParent(GuideStep);
            watchers[25].addChild(watchers[26]);
        }


    }
}//package 

