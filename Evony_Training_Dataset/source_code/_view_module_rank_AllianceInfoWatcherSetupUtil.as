// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_AllianceInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.AllianceInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_rank_AllianceInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceInfo.watcherSetupUtil = new (_view_module_rank_AllianceInfoWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[13] = new PropertyWatcher("_memberCount", {"propertyChange":true}, [bindings[9]], propertyGetter);
            watchers[17] = new PropertyWatcher("_prestigeCount", {"propertyChange":true}, [bindings[13]], propertyGetter);
            watchers[11] = new PropertyWatcher("_creater", {"propertyChange":true}, [bindings[7]], propertyGetter);
            watchers[9] = new PropertyWatcher("_leader", {"propertyChange":true}, [bindings[5]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[2] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[1]], null);
            watchers[4] = new PropertyWatcher("levelId", {"propertyChange":true}, [bindings[1]], null);
            watchers[6] = new PropertyWatcher("AllianceName", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[7] = new PropertyWatcher("_allianceInfo", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[15] = new PropertyWatcher("curRank", {"propertyChange":true}, [bindings[11]], propertyGetter);
            watchers[13].updateParent(target);
            watchers[17].updateParent(target);
            watchers[11].updateParent(target);
            watchers[9].updateParent(target);
            watchers[1].updateParent(Context);
            watchers[2].parentWatcher = watchers[1];
            watchers[1].addChild(watchers[2]);
            watchers[2].addChild(watchers[3]);
            watchers[3].addChild(watchers[4]);
            watchers[6].updateParent(target);
            watchers[7].updateParent(target);
            watchers[15].updateParent(target);
        }


    }
}//package 

