// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_AddEmailWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.AddEmail;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_AddEmailWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AddEmail.watcherSetupUtil = new (_view_AddEmailWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[2] = new PropertyWatcher("emailAddress", {"propertyChange":true}, [bindings[0]], null);
            watchers[0].updateParent(Context);
            watchers[1].parentWatcher = watchers[0];
            watchers[0].addChild(watchers[1]);
            watchers[1].addChild(watchers[2]);
        }


    }
}//package 

