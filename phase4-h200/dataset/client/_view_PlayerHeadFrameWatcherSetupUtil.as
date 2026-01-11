// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_PlayerHeadFrameWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.PlayerHeadFrame;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.Context;
    import com.evony.GameConfig;

    public class _view_PlayerHeadFrameWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PlayerHeadFrame.watcherSetupUtil = new (_view_PlayerHeadFrameWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[8] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[9] = new PropertyWatcher("serverMinutes", {"propertyChange":true}, [bindings[2]], null);
            watchers[2] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("strserverAlias", {"propertyChange":true}, [bindings[1]], null);
            watchers[0] = new PropertyWatcher("playerInfoBean", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[1] = new PropertyWatcher("faceUrl", {"propertyChange":true}, [bindings[0]], null);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[6] = new PropertyWatcher("serverHours", {"propertyChange":true}, [bindings[2]], null);
            watchers[8].updateParent(Context);
            watchers[8].addChild(watchers[9]);
            watchers[2].updateParent(GameConfig);
            watchers[2].addChild(watchers[3]);
            watchers[0].updateParent(target);
            watchers[0].addChild(watchers[1]);
            watchers[5].updateParent(Context);
            watchers[5].addChild(watchers[6]);
        }


    }
}//package 

