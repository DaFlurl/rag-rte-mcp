// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_LoginPanelWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.LoginPanel;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.GameConfig;
    import com.evony.MsgDispacther;

    public class _view_LoginPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            LoginPanel.watcherSetupUtil = new (_view_LoginPanelWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new PropertyWatcher("default_ip", {"propertyChange":true}, [bindings[4]], propertyGetter);
            watchers[14] = new PropertyWatcher("savePassSelected", {"propertyChange":true}, [bindings[13]], propertyGetter);
            watchers[7] = new PropertyWatcher("default_userName", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[12] = new PropertyWatcher("saveUserSelected", {"propertyChange":true}, [bindings[11]], propertyGetter);
            watchers[9] = new PropertyWatcher("default_password", {"propertyChange":true}, [bindings[8]], propertyGetter);
            watchers[0] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[3], bindings[0]], null);
            watchers[1] = new PropertyWatcher("debugMode", {"propertyChange":true}, [bindings[3], bindings[0]], null);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[5]], null);
            watchers[6] = new PropertyWatcher("useEnglish", {"propertyChange":true}, [bindings[5]], null);
            watchers[4].updateParent(target);
            watchers[14].updateParent(target);
            watchers[7].updateParent(target);
            watchers[12].updateParent(target);
            watchers[9].updateParent(target);
            watchers[0].updateParent(GameConfig);
            watchers[0].addChild(watchers[1]);
            watchers[5].updateParent(MsgDispacther);
            watchers[5].addChild(watchers[6]);
        }


    }
}//package 

