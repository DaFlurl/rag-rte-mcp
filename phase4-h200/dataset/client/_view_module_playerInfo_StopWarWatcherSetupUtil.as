// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_StopWarWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.StopWar;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_StopWarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            StopWar.watcherSetupUtil = new (_view_module_playerInfo_StopWarWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[0] = new PropertyWatcher("itemEum", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[1] = new PropertyWatcher("itemDesc", {"propertyChange":true}, [bindings[0]], null);
            watchers[3] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[4] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[2]], null);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[1]);
            watchers[3].updateParent(Context);
            watchers[3].addChild(watchers[4]);
        }


    }
}//package 

