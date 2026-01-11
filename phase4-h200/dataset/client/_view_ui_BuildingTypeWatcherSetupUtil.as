// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_BuildingTypeWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.BuildingType;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_ui_BuildingTypeWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BuildingType.watcherSetupUtil = new (_view_ui_BuildingTypeWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new PropertyWatcher("buildingType", {"propertyChange":true}, [bindings[2], bindings[8]], propertyGetter);
            watchers[14] = new PropertyWatcher("buildingName", {"propertyChange":true}, [bindings[12]], propertyGetter);
            watchers[12] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[11]], null);
            watchers[13] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[11]], null);
            watchers[6] = new PropertyWatcher("btnEnable", {"propertyChange":true}, [bindings[4], bindings[10], bindings[7]], propertyGetter);
            watchers[2] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[1]], null);
            watchers[7] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[5]], null);
            watchers[8] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[5]], null);
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[0]], null);
            watchers[9] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[10] = new PropertyWatcher("isBuildHelp", {"propertyChange":true}, [bindings[6]], null);
            watchers[4].updateParent(target);
            watchers[14].updateParent(target);
            watchers[12].updateParent(Context);
            watchers[12].addChild(watchers[13]);
            watchers[6].updateParent(target);
            watchers[2].updateParent(Context);
            watchers[2].addChild(watchers[3]);
            watchers[7].updateParent(Context);
            watchers[7].addChild(watchers[8]);
            watchers[0].updateParent(Context);
            watchers[0].addChild(watchers[1]);
            watchers[9].updateParent(Context);
            watchers[9].addChild(watchers[10]);
        }


    }
}//package 

