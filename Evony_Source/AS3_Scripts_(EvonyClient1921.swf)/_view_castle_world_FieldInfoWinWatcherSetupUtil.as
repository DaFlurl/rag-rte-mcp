// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_world_FieldInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.world.FieldInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.Context;
    import com.evony.GameConfig;

    public class _view_castle_world_FieldInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            FieldInfoWin.watcherSetupUtil = new (_view_castle_world_FieldInfoWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[57] = new PropertyWatcher("xuanzhanTooltip", {"propertyChange":true}, [bindings[41]], propertyGetter);
            watchers[47] = new PropertyWatcher("attackTooltip", {"propertyChange":true}, [bindings[29], bindings[52]], propertyGetter);
            watchers[32] = new PropertyWatcher("isMineCastle", {"propertyChange":true}, [bindings[32], bindings[21], bindings[35], bindings[27]], propertyGetter);
            watchers[30] = new PropertyWatcher("isCurField", {"propertyChange":true}, [bindings[21], bindings[27]], propertyGetter);
            watchers[75] = new PropertyWatcher("isBuildVisible", {"propertyChange":true}, [bindings[58], bindings[54]], propertyGetter);
            watchers[49] = new PropertyWatcher("isCanSend", {"propertyChange":true}, [bindings[31]], propertyGetter);
            watchers[69] = new PropertyWatcher("attackBtn", {"propertyChange":true}, [bindings[51]], propertyGetter);
            watchers[70] = new PropertyWatcher("visible", {
                "show":true,
                "hide":true
            }, [bindings[51]], null);
            watchers[76] = new PropertyWatcher("isCanBuild", {"propertyChange":true}, [bindings[55]], propertyGetter);
            watchers[3] = new PropertyWatcher("tile", {"propertyChange":true}, [bindings[4], bindings[19], bindings[58], bindings[3]], propertyGetter);
            watchers[4] = new PropertyWatcher("fieldType", null, [bindings[4], bindings[19], bindings[58], bindings[3]], null);
            watchers[53] = new PropertyWatcher("declareWarVisible", {"propertyChange":true}, [bindings[39]], propertyGetter);
            watchers[36] = new PropertyWatcher("hasTrainingFieldTooltip", {"propertyChange":true}, [bindings[65], bindings[33], bindings[48], bindings[37], bindings[25]], propertyGetter);
            watchers[27] = new PropertyWatcher("castleLevelName", {"propertyChange":true}, [bindings[19]], propertyGetter);
            watchers[65] = new PropertyWatcher("colonyBtnVisible", {"propertyChange":true}, [bindings[50]], propertyGetter);
            watchers[66] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[51]], null);
            watchers[67] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[51]], null);
            watchers[68] = new PropertyWatcher("colonization", {"propertyChange":true}, [bindings[51]], null);
            watchers[85] = new PropertyWatcher("isCanAddcl", {"propertyChange":true}, [bindings[64]], propertyGetter);
            watchers[63] = new PropertyWatcher("isCanPolicies", {"propertyChange":true}, [bindings[47], bindings[48], bindings[46]], propertyGetter);
            watchers[1] = new PropertyWatcher("imgSrc", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[2] = new PropertyWatcher("fieldDesc", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[46] = new PropertyWatcher("attackBtnEnabled", {"propertyChange":true}, [bindings[51], bindings[28]], propertyGetter);
            watchers[31] = new PropertyWatcher("isMineField", {"propertyChange":true}, [bindings[21], bindings[27]], propertyGetter);
            watchers[35] = new PropertyWatcher("hasTrainingField", {"propertyChange":true}, [bindings[32], bindings[36], bindings[24]], propertyGetter);
            watchers[0] = new PropertyWatcher("fieldName", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[7] = new PropertyWatcher("bean", {"propertyChange":true}, [bindings[8], bindings[23], bindings[40], bindings[43], bindings[16], bindings[18], bindings[39], bindings[12], bindings[27], bindings[44], bindings[6], bindings[14], bindings[10]], propertyGetter);
            watchers[60] = new PropertyWatcher("colonialStatus", {"propertyChange":true}, [bindings[44]], null);
            watchers[14] = new PropertyWatcher("honor", {"propertyChange":true}, [bindings[12]], null);
            watchers[54] = new PropertyWatcher("colonialRelation", {"propertyChange":true}, [bindings[43], bindings[39]], null);
            watchers[8] = new PropertyWatcher("userName", {"propertyChange":true}, [bindings[6]], null);
            watchers[56] = new PropertyWatcher("canDeclaredWar", {"propertyChange":true}, [bindings[40]], null);
            watchers[34] = new PropertyWatcher("canScout", {"propertyChange":true}, [bindings[23]], null);
            watchers[39] = new PropertyWatcher("declaredWarStatus", {"propertyChange":true}, [bindings[27]], null);
            watchers[44] = new PropertyWatcher("type", {"propertyChange":true}, [bindings[27]], null);
            watchers[21] = new PropertyWatcher("zoneName", {"propertyChange":true}, [bindings[18]], null);
            watchers[38] = new PropertyWatcher("canOccupy", {"propertyChange":true}, [bindings[27]], null);
            watchers[12] = new PropertyWatcher("prestige", {"propertyChange":true}, [bindings[10]], null);
            watchers[10] = new PropertyWatcher("suzerain", {"propertyChange":true}, [bindings[8]], null);
            watchers[19] = new PropertyWatcher("state", {"propertyChange":true}, [bindings[16]], null);
            watchers[16] = new PropertyWatcher("allianceName", {"propertyChange":true}, [bindings[14]], null);
            watchers[45] = new PropertyWatcher("powerLevel", {"propertyChange":true}, [bindings[27]], null);
            watchers[77] = new PropertyWatcher("buildBtn", {"propertyChange":true}, [bindings[56]], propertyGetter);
            watchers[78] = new PropertyWatcher("enabled", {"enabledChanged":true}, [bindings[56]], null);
            watchers[41] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [bindings[27]], null);
            watchers[42] = new PropertyWatcher("serverID", {"propertyChange":true}, [bindings[27]], null);
            watchers[43] = new PropertyWatcher("strAttackFlag", {"propertyChange":true}, [bindings[27]], null);
            watchers[51] = new PropertyWatcher("isCanTrans", {"propertyChange":true}, [bindings[35]], propertyGetter);
            watchers[82] = new PropertyWatcher("isCanSendMail", {"propertyChange":true}, [bindings[62], bindings[60]], propertyGetter);
            watchers[71] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[52]], null);
            watchers[72] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[52]], null);
            watchers[73] = new PropertyWatcher("colonization", {"propertyChange":true}, [bindings[52]], null);
            watchers[57].updateParent(target);
            watchers[47].updateParent(target);
            watchers[32].updateParent(target);
            watchers[30].updateParent(target);
            watchers[75].updateParent(target);
            watchers[49].updateParent(target);
            watchers[69].updateParent(target);
            watchers[69].addChild(watchers[70]);
            watchers[76].updateParent(target);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[4]);
            watchers[53].updateParent(target);
            watchers[36].updateParent(target);
            watchers[27].updateParent(target);
            watchers[65].updateParent(target);
            watchers[66].updateParent(Context);
            watchers[67].parentWatcher = watchers[66];
            watchers[66].addChild(watchers[67]);
            watchers[67].addChild(watchers[68]);
            watchers[85].updateParent(target);
            watchers[63].updateParent(target);
            watchers[1].updateParent(target);
            watchers[2].updateParent(target);
            watchers[46].updateParent(target);
            watchers[31].updateParent(target);
            watchers[35].updateParent(target);
            watchers[0].updateParent(target);
            watchers[7].updateParent(target);
            watchers[7].addChild(watchers[60]);
            watchers[7].addChild(watchers[14]);
            watchers[7].addChild(watchers[54]);
            watchers[7].addChild(watchers[8]);
            watchers[7].addChild(watchers[56]);
            watchers[7].addChild(watchers[34]);
            watchers[7].addChild(watchers[39]);
            watchers[7].addChild(watchers[44]);
            watchers[7].addChild(watchers[21]);
            watchers[7].addChild(watchers[38]);
            watchers[7].addChild(watchers[12]);
            watchers[7].addChild(watchers[10]);
            watchers[7].addChild(watchers[19]);
            watchers[7].addChild(watchers[16]);
            watchers[7].addChild(watchers[45]);
            watchers[77].updateParent(target);
            watchers[77].addChild(watchers[78]);
            watchers[41].updateParent(GameConfig);
            watchers[41].addChild(watchers[42]);
            watchers[41].addChild(watchers[43]);
            watchers[51].updateParent(target);
            watchers[82].updateParent(target);
            watchers[71].updateParent(Context);
            watchers[72].parentWatcher = watchers[71];
            watchers[71].addChild(watchers[72]);
            watchers[72].addChild(watchers[73]);
        }


    }
}//package 

