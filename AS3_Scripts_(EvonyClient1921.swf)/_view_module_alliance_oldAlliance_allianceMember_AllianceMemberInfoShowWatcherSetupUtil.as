// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_oldAlliance_allianceMember_AllianceMemberInfoShowWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceMember.AllianceMemberInfoShow;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_module_alliance_oldAlliance_allianceMember_AllianceMemberInfoShowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceMemberInfoShow.watcherSetupUtil = new (_view_module_alliance_oldAlliance_allianceMember_AllianceMemberInfoShowWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[30] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[29]], null);
            watchers[31] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[29]], null);
            watchers[32] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [bindings[29]], null);
            watchers[33] = new PropertyWatcher("levelId", {"propertyChange":true}, [bindings[29]], null);
            watchers[1] = new PropertyWatcher("dataPCB", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[4] = new PropertyWatcher("memberInfoBean", {"propertyChange":true}, [bindings[15], bindings[4], bindings[19], bindings[8], bindings[23], bindings[12], bindings[17], bindings[13], bindings[21], bindings[6], bindings[29], bindings[25], bindings[10]], propertyGetter);
            watchers[25] = new PropertyWatcher("honor", {"propertyChange":true}, [bindings[23]], null);
            watchers[5] = new PropertyWatcher("userName", {"propertyChange":true}, [bindings[4]], null);
            watchers[29] = new PropertyWatcher("levelId", {"propertyChange":true}, [bindings[29]], null);
            watchers[14] = new PropertyWatcher("titleId", {"propertyChange":true}, [bindings[12]], null);
            watchers[15] = new PropertyWatcher("faceUrl", {"propertyChange":true}, [bindings[13]], null);
            watchers[11] = new PropertyWatcher("office", {"propertyChange":true}, [bindings[10]], null);
            watchers[23] = new PropertyWatcher("prestige", {"propertyChange":true}, [bindings[21]], null);
            watchers[9] = new PropertyWatcher("allianceLevel", {"propertyChange":true}, [bindings[8], bindings[25]], null);
            watchers[21] = new PropertyWatcher("castleCount", {"propertyChange":true}, [bindings[19]], null);
            watchers[17] = new PropertyWatcher("population", {"propertyChange":true}, [bindings[15]], null);
            watchers[7] = new PropertyWatcher("alliance", {"propertyChange":true}, [bindings[6]], null);
            watchers[19] = new PropertyWatcher("ranking", {"propertyChange":true}, [bindings[17]], null);
            watchers[2] = new PropertyWatcher("canChangePower", {"propertyChange":true}, [bindings[2], bindings[27]], propertyGetter);
            watchers[35] = new PropertyWatcher("isOwner", {"propertyChange":true}, [bindings[32], bindings[31]], propertyGetter);
            watchers[30].updateParent(Context);
            watchers[31].parentWatcher = watchers[30];
            watchers[30].addChild(watchers[31]);
            watchers[31].addChild(watchers[32]);
            watchers[32].addChild(watchers[33]);
            watchers[1].updateParent(target);
            watchers[4].updateParent(target);
            watchers[4].addChild(watchers[25]);
            watchers[4].addChild(watchers[5]);
            watchers[4].addChild(watchers[29]);
            watchers[4].addChild(watchers[14]);
            watchers[4].addChild(watchers[15]);
            watchers[4].addChild(watchers[11]);
            watchers[4].addChild(watchers[23]);
            watchers[4].addChild(watchers[9]);
            watchers[4].addChild(watchers[21]);
            watchers[4].addChild(watchers[17]);
            watchers[4].addChild(watchers[7]);
            watchers[4].addChild(watchers[19]);
            watchers[2].updateParent(target);
            watchers[35].updateParent(target);
        }


    }
}//package 

