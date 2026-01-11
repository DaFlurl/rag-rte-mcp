// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_GiveupCastleWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.GiveupCastle;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_module_office_GiveupCastleWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            GiveupCastle.watcherSetupUtil = new (_view_module_office_GiveupCastleWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[3]], null);
            watchers[5] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[3]], null);
            watchers[3] = new PropertyWatcher("castleName", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[4].updateParent(Context);
            watchers[4].addChild(watchers[5]);
            watchers[3].updateParent(target);
        }


    }
}//package 

