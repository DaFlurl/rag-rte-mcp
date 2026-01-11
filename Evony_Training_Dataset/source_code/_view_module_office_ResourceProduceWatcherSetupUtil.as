// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_ResourceProduceWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.ResourceProduce;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_office_ResourceProduceWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ResourceProduce.watcherSetupUtil = new (_view_module_office_ResourceProduceWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[18] = new PropertyWatcher("worker", {"propertyChange":true}, [bindings[26]], propertyGetter);
            watchers[34] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[36]], null);
            watchers[35] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[36]], null);
            watchers[42] = new PropertyWatcher("woodProduction", {"propertyChange":true}, [bindings[36]], propertyGetter);
            watchers[43] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [bindings[36]], null);
            watchers[44] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [bindings[36]], null);
            watchers[32] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[35]], null);
            watchers[33] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[35]], null);
            watchers[39] = new PropertyWatcher("stoneProduction", {"propertyChange":true}, [bindings[36]], propertyGetter);
            watchers[40] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [bindings[36]], null);
            watchers[41] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [bindings[36]], null);
            watchers[25] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[33]], null);
            watchers[26] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[33]], null);
            watchers[30] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[34]], null);
            watchers[31] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[34]], null);
            watchers[36] = new PropertyWatcher("ironProduction", {"propertyChange":true}, [bindings[36]], propertyGetter);
            watchers[37] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [bindings[36]], null);
            watchers[38] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [bindings[36]], null);
            watchers[27] = new PropertyWatcher("allProduction", {"propertyChange":true}, [bindings[34], bindings[36], bindings[33], bindings[35]], propertyGetter);
            watchers[28] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [bindings[34], bindings[36], bindings[33], bindings[35]], null);
            watchers[29] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [bindings[34], bindings[36], bindings[33], bindings[35]], null);
            watchers[22] = new PropertyWatcher("commenceDemandsNum", {"propertyChange":true}, [bindings[30]], propertyGetter);
            watchers[24] = new PropertyWatcher("productionEfficiencyHandleYet", {"propertyChange":true}, [bindings[32]], propertyGetter);
            watchers[45] = new PropertyWatcher("foodProduction", {"propertyChange":true}, [bindings[36]], propertyGetter);
            watchers[46] = new PropertyWatcher("myPercentage", {"propertyChange":true}, [bindings[36]], null);
            watchers[47] = new PropertyWatcher("value", {
                "valueCommit":true,
                "change":true
            }, [bindings[36]], null);
            watchers[20] = new PropertyWatcher("maxLabourNum", {"propertyChange":true}, [bindings[28]], propertyGetter);
            watchers[16] = new PropertyWatcher("productionEfficiency", {"propertyChange":true}, [bindings[16], bindings[18], bindings[20], bindings[24], bindings[22]], propertyGetter);
            watchers[18].updateParent(target);
            watchers[34].updateParent(GuideStep);
            watchers[34].addChild(watchers[35]);
            watchers[42].updateParent(target);
            watchers[42].addChild(watchers[43]);
            watchers[43].addChild(watchers[44]);
            watchers[32].updateParent(GuideStep);
            watchers[32].addChild(watchers[33]);
            watchers[39].updateParent(target);
            watchers[39].addChild(watchers[40]);
            watchers[40].addChild(watchers[41]);
            watchers[25].updateParent(GuideStep);
            watchers[25].addChild(watchers[26]);
            watchers[30].updateParent(GuideStep);
            watchers[30].addChild(watchers[31]);
            watchers[36].updateParent(target);
            watchers[36].addChild(watchers[37]);
            watchers[37].addChild(watchers[38]);
            watchers[27].updateParent(target);
            watchers[27].addChild(watchers[28]);
            watchers[28].addChild(watchers[29]);
            watchers[22].updateParent(target);
            watchers[24].updateParent(target);
            watchers[45].updateParent(target);
            watchers[45].addChild(watchers[46]);
            watchers[46].addChild(watchers[47]);
            watchers[20].updateParent(target);
            watchers[16].updateParent(target);
        }


    }
}//package 

