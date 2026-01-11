// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_AccomplishBuffItemWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.AccomplishBuffItem;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.ArrayElementWatcher;
    import mx.binding.FunctionReturnWatcher;

    public class _view_ui_AccomplishBuffItemWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AccomplishBuffItem.watcherSetupUtil = new (_view_ui_AccomplishBuffItemWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[3] = new PropertyWatcher("tooltips", {"propertyChange":true}, [bindings[9], bindings[11], bindings[3], bindings[7], bindings[5]], propertyGetter);
            watchers[15] = new PropertyWatcher("pointArr", {"propertyChange":true}, [bindings[17], bindings[15], bindings[13], bindings[16], bindings[14]], propertyGetter);
            watchers[16] = new ArrayElementWatcher(target, function ():*
            {
                return (0);
            }, [bindings[13]]);
            watchers[18] = new ArrayElementWatcher(target, function ():*
            {
                return (1);
            }, [bindings[14]]);
            watchers[20] = new ArrayElementWatcher(target, function ():*
            {
                return (2);
            }, [bindings[15]]);
            watchers[24] = new ArrayElementWatcher(target, function ():*
            {
                return (4);
            }, [bindings[17]]);
            watchers[22] = new ArrayElementWatcher(target, function ():*
            {
                return (3);
            }, [bindings[16]]);
            watchers[4] = new PropertyWatcher("img", {"propertyChange":true}, [bindings[4], bindings[8], bindings[6], bindings[10], bindings[12]], propertyGetter);
            watchers[13] = new FunctionReturnWatcher("getItemAt", target, function ():Array
            {
                return ([4]);
            }, {"collectionChange":true}, [bindings[12]], null);
            watchers[14] = new PropertyWatcher("path", null, [bindings[12]], null);
            watchers[9] = new FunctionReturnWatcher("getItemAt", target, function ():Array
            {
                return ([2]);
            }, {"collectionChange":true}, [bindings[8]], null);
            watchers[10] = new PropertyWatcher("path", null, [bindings[8]], null);
            watchers[11] = new FunctionReturnWatcher("getItemAt", target, function ():Array
            {
                return ([3]);
            }, {"collectionChange":true}, [bindings[10]], null);
            watchers[12] = new PropertyWatcher("path", null, [bindings[10]], null);
            watchers[7] = new FunctionReturnWatcher("getItemAt", target, function ():Array
            {
                return ([1]);
            }, {"collectionChange":true}, [bindings[6]], null);
            watchers[8] = new PropertyWatcher("path", null, [bindings[6]], null);
            watchers[5] = new FunctionReturnWatcher("getItemAt", target, function ():Array
            {
                return ([0]);
            }, {"collectionChange":true}, [bindings[4]], null);
            watchers[6] = new PropertyWatcher("path", null, [bindings[4]], null);
            watchers[2] = new PropertyWatcher("finishPointValue", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[0] = new PropertyWatcher("buffname", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[1] = new PropertyWatcher("curDes", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[3].updateParent(target);
            watchers[15].updateParent(target);
            watchers[16].arrayWatcher = watchers[15];
            watchers[15].addChild(watchers[16]);
            watchers[18].arrayWatcher = watchers[15];
            watchers[15].addChild(watchers[18]);
            watchers[20].arrayWatcher = watchers[15];
            watchers[15].addChild(watchers[20]);
            watchers[24].arrayWatcher = watchers[15];
            watchers[15].addChild(watchers[24]);
            watchers[22].arrayWatcher = watchers[15];
            watchers[15].addChild(watchers[22]);
            watchers[4].updateParent(target);
            watchers[13].parentWatcher = watchers[4];
            watchers[4].addChild(watchers[13]);
            watchers[13].addChild(watchers[14]);
            watchers[9].parentWatcher = watchers[4];
            watchers[4].addChild(watchers[9]);
            watchers[9].addChild(watchers[10]);
            watchers[11].parentWatcher = watchers[4];
            watchers[4].addChild(watchers[11]);
            watchers[11].addChild(watchers[12]);
            watchers[7].parentWatcher = watchers[4];
            watchers[4].addChild(watchers[7]);
            watchers[7].addChild(watchers[8]);
            watchers[5].parentWatcher = watchers[4];
            watchers[4].addChild(watchers[5]);
            watchers[5].addChild(watchers[6]);
            watchers[2].updateParent(target);
            watchers[0].updateParent(target);
            watchers[1].updateParent(target);
        }


    }
}//package 

