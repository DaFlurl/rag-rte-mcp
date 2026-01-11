// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_playerInfo_UseGoodWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.playerInfo.UseGoodWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import view.module.guide.GuideStep;

    public class _view_module_playerInfo_UseGoodWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            UseGoodWin.watcherSetupUtil = new (_view_module_playerInfo_UseGoodWinWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[3] = new PropertyWatcher("itemEum", {"propertyChange":true}, [bindings[4], bindings[7], bindings[5]], propertyGetter);
            watchers[5] = new PropertyWatcher("iconUrl", {"propertyChange":true}, [bindings[5]], null);
            watchers[7] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[7]], null);
            watchers[4] = new PropertyWatcher("desc", {"propertyChange":true}, [bindings[4]], null);
            watchers[13] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[18]], null);
            watchers[14] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[18]], null);
            watchers[15] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[19]], null);
            watchers[16] = new PropertyWatcher("currentStep", {"propertyChange":true}, [bindings[19]], null);
            watchers[11] = new PropertyWatcher("isNameVisible", {"propertyChange":true}, [bindings[13], bindings[12]], propertyGetter);
            watchers[9] = new PropertyWatcher("isTrue", {"propertyChange":true}, [bindings[9], bindings[10]], propertyGetter);
            watchers[12] = new PropertyWatcher("isLoveVisible", {"propertyChange":true}, [bindings[17], bindings[15], bindings[16], bindings[14]], propertyGetter);
            watchers[10] = new PropertyWatcher("initNum", {"propertyChange":true}, [bindings[11]], propertyGetter);
            watchers[1] = new PropertyWatcher("itemCanUse", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[2] = new PropertyWatcher("isGate", {"propertyChange":true}, [bindings[2], bindings[3]], propertyGetter);
            watchers[3].updateParent(target);
            watchers[3].addChild(watchers[5]);
            watchers[3].addChild(watchers[7]);
            watchers[3].addChild(watchers[4]);
            watchers[13].updateParent(GuideStep);
            watchers[13].addChild(watchers[14]);
            watchers[15].updateParent(GuideStep);
            watchers[15].addChild(watchers[16]);
            watchers[11].updateParent(target);
            watchers[9].updateParent(target);
            watchers[12].updateParent(target);
            watchers[10].updateParent(target);
            watchers[1].updateParent(target);
            watchers[2].updateParent(target);
        }


    }
}//package 

