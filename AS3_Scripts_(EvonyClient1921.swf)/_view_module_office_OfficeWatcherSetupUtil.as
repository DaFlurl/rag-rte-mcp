// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_OfficeWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.Office;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_office_OfficeWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Office.watcherSetupUtil = new (_view_module_office_OfficeWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[1] = new PropertyWatcher("curCastle", {"propertyChange":true}, [bindings[17], bindings[1]], propertyGetter);
            watchers[17] = new PropertyWatcher("powerlevel", {"propertyChange":true}, [bindings[17]], null);
            watchers[20] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[19]], null);
            watchers[21] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[19]], null);
            watchers[0] = new PropertyWatcher("player", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[2] = new PropertyWatcher("buildingArr", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[18] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[18]], null);
            watchers[19] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[18]], null);
            watchers[1].updateParent(target);
            watchers[1].addChild(watchers[17]);
            watchers[20].updateParent(GuideStep);
            watchers[20].addChild(watchers[21]);
            watchers[0].updateParent(target);
            watchers[2].updateParent(target);
            watchers[18].updateParent(GuideStep);
            watchers[18].addChild(watchers[19]);
        }


    }
}//package 

