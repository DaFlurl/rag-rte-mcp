// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_VoteCurWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.VoteCurWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_module_rank_VoteCurWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            VoteCurWin.watcherSetupUtil = new (_view_module_rank_VoteCurWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[3] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[2]], null);
            watchers[4] = new PropertyWatcher("voteToName", {"propertyChange":true}, [bindings[2]], null);
            watchers[20] = new PropertyWatcher("totalPage", {"propertyChange":true}, [bindings[19], bindings[18]], propertyGetter);
            watchers[5] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[19] = new PropertyWatcher("voteendtime", {"propertyChange":true}, [bindings[17]], propertyGetter);
            watchers[18] = new PropertyWatcher("votestoal", {"propertyChange":true}, [bindings[16]], propertyGetter);
            watchers[6] = new PropertyWatcher("playerRankArray", {"propertyChange":true}, [bindings[4]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[1]], null);
            watchers[2] = new PropertyWatcher("voteToName", {"propertyChange":true}, [bindings[1]], null);
            watchers[21] = new PropertyWatcher("pageNo", {"propertyChange":true}, [bindings[19]], propertyGetter);
            watchers[3].updateParent(Context);
            watchers[3].addChild(watchers[4]);
            watchers[20].updateParent(target);
            watchers[5].updateParent(target);
            watchers[19].updateParent(target);
            watchers[18].updateParent(target);
            watchers[6].updateParent(target);
            watchers[1].updateParent(Context);
            watchers[1].addChild(watchers[2]);
            watchers[21].updateParent(target);
        }


    }
}//package 

