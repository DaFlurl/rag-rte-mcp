// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_PlayerInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.PlayerInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_playerInfo_PlayerInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PlayerInfoWin.watcherSetupUtil = new (_view_module_playerInfo_PlayerInfoWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[35] = new PropertyWatcher("playerNewBuff", {"propertyChange":true}, [bindings[27]], propertyGetter);
            watchers[5] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[4]], null);
            watchers[6] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[4]], null);
            watchers[7] = new PropertyWatcher("changedFace", {"propertyChange":true}, [bindings[4]], null);
            watchers[25] = new PropertyWatcher("heroTotal", {"propertyChange":true}, [bindings[19]], propertyGetter);
            watchers[19] = new PropertyWatcher("totalPeople", {"propertyChange":true}, [bindings[15]], propertyGetter);
            watchers[21] = new PropertyWatcher("player", {"propertyChange":true}, [bindings[17]], propertyGetter);
            watchers[22] = new PropertyWatcher("castlesArray", {"propertyChange":true}, [bindings[17]], null);
            watchers[23] = new PropertyWatcher("length", {"collectionChange":true}, [bindings[17]], null);
            watchers[33] = new PropertyWatcher("playerPeaceBuff", {"propertyChange":true}, [bindings[27]], propertyGetter);
            watchers[1] = new PropertyWatcher("heroList", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[2] = new PropertyWatcher("playerInfoBean", {"propertyChange":true}, [bindings[2], bindings[13], bindings[30], bindings[9], bindings[23], bindings[21], bindings[11], bindings[6], bindings[25]], propertyGetter);
            watchers[31] = new PropertyWatcher("honor", {"propertyChange":true}, [bindings[25]], null);
            watchers[9] = new PropertyWatcher("userName", {"propertyChange":true}, [bindings[6]], null);
            watchers[17] = new PropertyWatcher("titleId", {"propertyChange":true}, [bindings[13]], null);
            watchers[14] = new PropertyWatcher("office", {"propertyChange":true}, [bindings[11]], null);
            watchers[3] = new PropertyWatcher("faceUrl", {"propertyChange":true}, [bindings[2]], null);
            watchers[29] = new PropertyWatcher("prestige", {"propertyChange":true}, [bindings[23]], null);
            watchers[40] = new PropertyWatcher("flag", {"propertyChange":true}, [bindings[30]], null);
            watchers[12] = new PropertyWatcher("alliance", {"propertyChange":true}, [bindings[9]], null);
            watchers[27] = new PropertyWatcher("ranking", {"propertyChange":true}, [bindings[21]], null);
            watchers[35].updateParent(target);
            watchers[5].updateParent(Context);
            watchers[6].parentWatcher = watchers[5];
            watchers[5].addChild(watchers[6]);
            watchers[6].addChild(watchers[7]);
            watchers[25].updateParent(target);
            watchers[19].updateParent(target);
            watchers[21].updateParent(target);
            watchers[21].addChild(watchers[22]);
            watchers[22].addChild(watchers[23]);
            watchers[33].updateParent(target);
            watchers[1].updateParent(target);
            watchers[2].updateParent(target);
            watchers[2].addChild(watchers[31]);
            watchers[2].addChild(watchers[9]);
            watchers[2].addChild(watchers[17]);
            watchers[2].addChild(watchers[14]);
            watchers[2].addChild(watchers[3]);
            watchers[2].addChild(watchers[29]);
            watchers[2].addChild(watchers[40]);
            watchers[2].addChild(watchers[12]);
            watchers[2].addChild(watchers[27]);
        }


    }
}//package 

