// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ServerItemWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ServerItem;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_ServerItemWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ServerItem.watcherSetupUtil = new (_view_ServerItemWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new PropertyWatcher("itemServerId", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[1] = new PropertyWatcher("itemTime", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[0] = new PropertyWatcher("itemServerName", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[2] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("selectServerId", {"propertyChange":true}, [bindings[1]], null);
            watchers[4].updateParent(target);
            watchers[1].updateParent(target);
            watchers[0].updateParent(target);
            watchers[2].updateParent(Context);
            watchers[2].addChild(watchers[3]);
        }


    }
}//package 

