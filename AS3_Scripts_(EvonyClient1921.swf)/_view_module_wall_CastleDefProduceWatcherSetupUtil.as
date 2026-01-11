// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_wall_CastleDefProduceWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.wall.CastleDefProduce;
    import mx.core.IFlexModuleFactory;
    import mx.binding.FunctionReturnWatcher;
    import mx.binding.PropertyWatcher;
    import com.evony.eum.FortificationEumDefine;

    public class _view_module_wall_CastleDefProduceWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CastleDefProduce.watcherSetupUtil = new (_view_module_wall_CastleDefProduceWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[16] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[9]], null);
            watchers[17] = new PropertyWatcher("space", {"propertyChange":true}, [bindings[9]], null);
            watchers[19] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[11]], null);
            watchers[20] = new PropertyWatcher("attack", {"propertyChange":true}, [bindings[11]], null);
            watchers[26] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[13]], null);
            watchers[27] = new PropertyWatcher("range", {"propertyChange":true}, [bindings[13]], null);
            watchers[31] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[15]], null);
            watchers[32] = new PropertyWatcher("defence", {"propertyChange":true}, [bindings[15]], null);
            watchers[8] = new PropertyWatcher("fortBean", {"propertyChange":true}, [bindings[15], bindings[13], bindings[9], bindings[11], bindings[7]], propertyGetter);
            watchers[9] = new PropertyWatcher("typeId", {"propertyChange":true}, [bindings[15], bindings[13], bindings[9], bindings[11], bindings[7]], null);
            watchers[29] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[15]], null);
            watchers[30] = new PropertyWatcher("defence", {"propertyChange":true}, [bindings[15]], null);
            watchers[40] = new PropertyWatcher("produceAllTime", {"propertyChange":true}, [bindings[24]], propertyGetter);
            watchers[34] = new PropertyWatcher("produceMaxNum", {"propertyChange":true}, [bindings[17], bindings[23]], propertyGetter);
            watchers[21] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[11]], null);
            watchers[22] = new PropertyWatcher("attack", {"propertyChange":true}, [bindings[11]], null);
            watchers[14] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[9]], null);
            watchers[15] = new PropertyWatcher("space", {"propertyChange":true}, [bindings[9]], null);
            watchers[41] = new PropertyWatcher("fortEum", {"propertyChange":true}, [bindings[26], bindings[25]], propertyGetter);
            watchers[43] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[26]], null);
            watchers[42] = new PropertyWatcher("desc", {"propertyChange":true}, [bindings[25]], null);
            watchers[24] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[13]], null);
            watchers[25] = new PropertyWatcher("range", {"propertyChange":true}, [bindings[13]], null);
            watchers[0] = new PropertyWatcher("imgSrc", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[7] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[7]], null);
            watchers[10] = new PropertyWatcher("life", {"propertyChange":true}, [bindings[7]], null);
            watchers[2] = new PropertyWatcher("dataAry", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[11] = new FunctionReturnWatcher("getFortificationEumByType", target, function ():Array
            {
                return ([target.fortBean.typeId]);
            }, null, [bindings[7]], null);
            watchers[12] = new PropertyWatcher("life", {"propertyChange":true}, [bindings[7]], null);
            watchers[39] = new PropertyWatcher("curAmount", {"propertyChange":true}, [bindings[22]], propertyGetter);
            watchers[16].updateParent(FortificationEumDefine);
            watchers[16].addChild(watchers[17]);
            watchers[19].updateParent(FortificationEumDefine);
            watchers[19].addChild(watchers[20]);
            watchers[26].updateParent(FortificationEumDefine);
            watchers[26].addChild(watchers[27]);
            watchers[31].updateParent(FortificationEumDefine);
            watchers[31].addChild(watchers[32]);
            watchers[8].updateParent(target);
            watchers[8].addChild(watchers[9]);
            watchers[29].updateParent(FortificationEumDefine);
            watchers[29].addChild(watchers[30]);
            watchers[40].updateParent(target);
            watchers[34].updateParent(target);
            watchers[21].updateParent(FortificationEumDefine);
            watchers[21].addChild(watchers[22]);
            watchers[14].updateParent(FortificationEumDefine);
            watchers[14].addChild(watchers[15]);
            watchers[41].updateParent(target);
            watchers[41].addChild(watchers[43]);
            watchers[41].addChild(watchers[42]);
            watchers[24].updateParent(FortificationEumDefine);
            watchers[24].addChild(watchers[25]);
            watchers[0].updateParent(target);
            watchers[7].updateParent(FortificationEumDefine);
            watchers[7].addChild(watchers[10]);
            watchers[2].updateParent(target);
            watchers[11].updateParent(FortificationEumDefine);
            watchers[11].addChild(watchers[12]);
            watchers[39].updateParent(target);
        }


    }
}//package 

