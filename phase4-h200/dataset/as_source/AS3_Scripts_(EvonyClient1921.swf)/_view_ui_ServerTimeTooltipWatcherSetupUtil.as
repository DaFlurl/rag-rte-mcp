// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_ServerTimeTooltipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ServerTimeTooltip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.Context;
    import com.evony.GameConfig;

    public class _view_ui_ServerTimeTooltipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ServerTimeTooltip.watcherSetupUtil = new (_view_ui_ServerTimeTooltipWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[12] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[13] = new PropertyWatcher("serverHours", {"propertyChange":true}, [bindings[3]], null);
            watchers[15] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[16] = new PropertyWatcher("serverMinutes", {"propertyChange":true}, [bindings[3]], null);
            watchers[0] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[0]], null);
            watchers[2] = new PropertyWatcher("serverID", {"propertyChange":true}, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("strserverAlias", {"propertyChange":true}, [bindings[0]], null);
            watchers[7] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[8] = new PropertyWatcher("serverMonth", {"propertyChange":true}, [bindings[3]], null);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[6] = new PropertyWatcher("serverYear", {"propertyChange":true}, [bindings[3]], null);
            watchers[9] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[10] = new PropertyWatcher("serverDate", {"propertyChange":true}, [bindings[3]], null);
            watchers[12].updateParent(Context);
            watchers[12].addChild(watchers[13]);
            watchers[15].updateParent(Context);
            watchers[15].addChild(watchers[16]);
            watchers[0].updateParent(GameConfig);
            watchers[0].addChild(watchers[2]);
            watchers[0].addChild(watchers[1]);
            watchers[7].updateParent(Context);
            watchers[7].addChild(watchers[8]);
            watchers[5].updateParent(Context);
            watchers[5].addChild(watchers[6]);
            watchers[9].updateParent(Context);
            watchers[9].addChild(watchers[10]);
        }


    }
}//package 

