// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_StageChangeWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.StageChangeWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_StageChangeWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            StageChangeWin.watcherSetupUtil = new (_view_module_playerInfo_StageChangeWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[10] = new PropertyWatcher("choiseArr", {"propertyChange":true}, [bindings[8]], propertyGetter);
            watchers[2] = new PropertyWatcher("edtDays", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[4] = new PropertyWatcher("_currState", {"propertyChange":true}, [bindings[4]], propertyGetter);
            watchers[6] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[7] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[6]], null);
            watchers[10].updateParent(target);
            watchers[2].updateParent(target);
            watchers[4].updateParent(target);
            watchers[6].updateParent(Context);
            watchers[6].addChild(watchers[7]);
        }


    }
}//package 

