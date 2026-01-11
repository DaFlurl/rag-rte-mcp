// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_CastleInfoFrameWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.CastleInfoFrame;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.Context;

    public class _view_CastleInfoFrameWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleInfoFrame.watcherSetupUtil = new (_view_CastleInfoFrameWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[12] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[13] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[14] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[6]], null);
            watchers[15] = new PropertyWatcher("colonyFood", {"propertyChange":true}, [bindings[6]], null);
            watchers[74] = new PropertyWatcher("_fortifications", {"propertyChange":true}, [bindings[45], bindings[47], bindings[41], bindings[43], bindings[49]], propertyGetter);
            watchers[83] = new PropertyWatcher("rockfall", {"propertyChange":true}, [bindings[49]], null);
            watchers[79] = new PropertyWatcher("arrowTower", {"propertyChange":true}, [bindings[45]], null);
            watchers[75] = new PropertyWatcher("trap", {"propertyChange":true}, [bindings[41]], null);
            watchers[77] = new PropertyWatcher("abatis", {"propertyChange":true}, [bindings[43]], null);
            watchers[81] = new PropertyWatcher("rollingLogs", {"propertyChange":true}, [bindings[47]], null);
            watchers[40] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[12]], null);
            watchers[41] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[12]], null);
            watchers[42] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[12]], null);
            watchers[43] = new PropertyWatcher("colonyIron", {"propertyChange":true}, [bindings[12]], null);
            watchers[45] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[14]], null);
            watchers[46] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[14]], null);
            watchers[84] = new PropertyWatcher("_herosArray", {"propertyChange":true}, [bindings[50]], propertyGetter);
            watchers[32] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[33] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[10]], null);
            watchers[34] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[10]], null);
            watchers[35] = new PropertyWatcher("colonyStone", {"propertyChange":true}, [bindings[10]], null);
            watchers[24] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[25] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[8]], null);
            watchers[26] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[8]], null);
            watchers[27] = new PropertyWatcher("colonyWood", {"propertyChange":true}, [bindings[8]], null);
            watchers[6] = new PropertyWatcher("_resource", {"propertyChange":true}, [bindings[8], bindings[58], bindings[55], bindings[11], bindings[7], bindings[12], bindings[54], bindings[59], bindings[9], bindings[60], bindings[6], bindings[10], bindings[56], bindings[5]], propertyGetter);
            watchers[92] = new PropertyWatcher("buildPeople", {"propertyChange":true}, [bindings[56]], null);
            watchers[99] = new PropertyWatcher("herosSalary", {"propertyChange":true}, [bindings[60]], null);
            watchers[90] = new PropertyWatcher("complaint", {"propertyChange":true}, [bindings[54]], null);
            watchers[20] = new PropertyWatcher("wood", {"propertyChange":true}, [bindings[8], bindings[7]], null);
            watchers[21] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[7]], null);
            watchers[23] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[8]], null);
            watchers[7] = new PropertyWatcher("food", {"propertyChange":true}, [bindings[6], bindings[5]], null);
            watchers[8] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[5]], null);
            watchers[10] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[6]], null);
            watchers[95] = new PropertyWatcher("texRate", {"propertyChange":true}, [bindings[58]], null);
            watchers[36] = new PropertyWatcher("iron", {"propertyChange":true}, [bindings[11], bindings[12]], null);
            watchers[37] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[11]], null);
            watchers[39] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[12]], null);
            watchers[11] = new PropertyWatcher("troopCostFood", {"propertyChange":true}, [bindings[6]], null);
            watchers[93] = new PropertyWatcher("workPeople", {"propertyChange":true}, [bindings[56]], null);
            watchers[100] = new PropertyWatcher("colonyGold", {"propertyChange":true}, [bindings[60]], null);
            watchers[91] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [bindings[55], bindings[56]], null);
            watchers[98] = new PropertyWatcher("taxIncome", {"propertyChange":true}, [bindings[60]], null);
            watchers[28] = new PropertyWatcher("stone", {"propertyChange":true}, [bindings[9], bindings[10]], null);
            watchers[29] = new PropertyWatcher("amount", {"propertyChange":true}, [bindings[9]], null);
            watchers[31] = new PropertyWatcher("increaseRate", {"propertyChange":true}, [bindings[10]], null);
            watchers[97] = new PropertyWatcher("gold", {"propertyChange":true}, [bindings[59]], null);
            watchers[89] = new PropertyWatcher("support", {"propertyChange":true}, [bindings[54]], null);
            watchers[86] = new PropertyWatcher("curCastle", {"propertyChange":true}, [bindings[53], bindings[52]], propertyGetter);
            watchers[88] = new PropertyWatcher("fieldId", {"propertyChange":true}, [bindings[53]], null);
            watchers[87] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[52]], null);
            watchers[48] = new PropertyWatcher("_troops", {"propertyChange":true}, [bindings[34], bindings[32], bindings[36], bindings[30], bindings[26], bindings[38], bindings[28], bindings[16], bindings[18], bindings[20], bindings[24], bindings[22]], propertyGetter);
            watchers[51] = new PropertyWatcher("scouter", {"propertyChange":true}, [bindings[18]], null);
            watchers[67] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [bindings[34]], null);
            watchers[53] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [bindings[20]], null);
            watchers[69] = new PropertyWatcher("ballista", {"propertyChange":true}, [bindings[36]], null);
            watchers[59] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [bindings[26]], null);
            watchers[63] = new PropertyWatcher("pikemen", {"propertyChange":true}, [bindings[30]], null);
            watchers[71] = new PropertyWatcher("catapult", {"propertyChange":true}, [bindings[38]], null);
            watchers[65] = new PropertyWatcher("archer", {"propertyChange":true}, [bindings[32]], null);
            watchers[61] = new PropertyWatcher("militia", {"propertyChange":true}, [bindings[28]], null);
            watchers[57] = new PropertyWatcher("carriage", {"propertyChange":true}, [bindings[24]], null);
            watchers[55] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [bindings[22]], null);
            watchers[49] = new PropertyWatcher("peasants", {"propertyChange":true}, [bindings[16]], null);
            watchers[0] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[0]], null);
            watchers[1] = new PropertyWatcher("bVisitor", {"propertyChange":true}, [bindings[0]], null);
            watchers[16] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[17] = new FunctionReturnWatcher("getCurCastle", target, function ():Array
            {
                return ([]);
            }, null, [bindings[6]], null);
            watchers[18] = new PropertyWatcher("resource", {"propertyChange":true}, [bindings[6]], null);
            watchers[19] = new PropertyWatcher("supplyFood", {"propertyChange":true}, [bindings[6]], null);
            watchers[12].updateParent(Context);
            watchers[13].parentWatcher = watchers[12];
            watchers[12].addChild(watchers[13]);
            watchers[13].addChild(watchers[14]);
            watchers[14].addChild(watchers[15]);
            watchers[74].updateParent(target);
            watchers[74].addChild(watchers[83]);
            watchers[74].addChild(watchers[79]);
            watchers[74].addChild(watchers[75]);
            watchers[74].addChild(watchers[77]);
            watchers[74].addChild(watchers[81]);
            watchers[40].updateParent(Context);
            watchers[41].parentWatcher = watchers[40];
            watchers[40].addChild(watchers[41]);
            watchers[41].addChild(watchers[42]);
            watchers[42].addChild(watchers[43]);
            watchers[45].updateParent(Context);
            watchers[45].addChild(watchers[46]);
            watchers[84].updateParent(target);
            watchers[32].updateParent(Context);
            watchers[33].parentWatcher = watchers[32];
            watchers[32].addChild(watchers[33]);
            watchers[33].addChild(watchers[34]);
            watchers[34].addChild(watchers[35]);
            watchers[24].updateParent(Context);
            watchers[25].parentWatcher = watchers[24];
            watchers[24].addChild(watchers[25]);
            watchers[25].addChild(watchers[26]);
            watchers[26].addChild(watchers[27]);
            watchers[6].updateParent(target);
            watchers[6].addChild(watchers[92]);
            watchers[6].addChild(watchers[99]);
            watchers[6].addChild(watchers[90]);
            watchers[6].addChild(watchers[20]);
            watchers[20].addChild(watchers[21]);
            watchers[20].addChild(watchers[23]);
            watchers[6].addChild(watchers[7]);
            watchers[7].addChild(watchers[8]);
            watchers[7].addChild(watchers[10]);
            watchers[6].addChild(watchers[95]);
            watchers[6].addChild(watchers[36]);
            watchers[36].addChild(watchers[37]);
            watchers[36].addChild(watchers[39]);
            watchers[6].addChild(watchers[11]);
            watchers[6].addChild(watchers[93]);
            watchers[6].addChild(watchers[100]);
            watchers[6].addChild(watchers[91]);
            watchers[6].addChild(watchers[98]);
            watchers[6].addChild(watchers[28]);
            watchers[28].addChild(watchers[29]);
            watchers[28].addChild(watchers[31]);
            watchers[6].addChild(watchers[97]);
            watchers[6].addChild(watchers[89]);
            watchers[86].updateParent(target);
            watchers[86].addChild(watchers[88]);
            watchers[86].addChild(watchers[87]);
            watchers[48].updateParent(target);
            watchers[48].addChild(watchers[51]);
            watchers[48].addChild(watchers[67]);
            watchers[48].addChild(watchers[53]);
            watchers[48].addChild(watchers[69]);
            watchers[48].addChild(watchers[59]);
            watchers[48].addChild(watchers[63]);
            watchers[48].addChild(watchers[71]);
            watchers[48].addChild(watchers[65]);
            watchers[48].addChild(watchers[61]);
            watchers[48].addChild(watchers[57]);
            watchers[48].addChild(watchers[55]);
            watchers[48].addChild(watchers[49]);
            watchers[0].updateParent(Context);
            watchers[0].addChild(watchers[1]);
            watchers[16].updateParent(Context);
            watchers[17].parentWatcher = watchers[16];
            watchers[16].addChild(watchers[17]);
            watchers[17].addChild(watchers[18]);
            watchers[18].addChild(watchers[19]);
        }


    }
}//package 

