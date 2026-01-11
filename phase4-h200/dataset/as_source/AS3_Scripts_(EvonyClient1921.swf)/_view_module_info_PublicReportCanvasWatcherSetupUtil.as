// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_info_PublicReportCanvasWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.PublicReportCanvas;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.Context;

    public class _view_module_info_PublicReportCanvasWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PublicReportCanvas.watcherSetupUtil = new (_view_module_info_PublicReportCanvasWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[3] = new PropertyWatcher("reportBeanArray", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[20] = new PropertyWatcher("curRepoet", {"propertyChange":true}, [bindings[17]], propertyGetter);
            watchers[15] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[14]], null);
            watchers[16] = new FunctionReturnWatcher("getPlayerBean", target, function ():Array
            {
                return ([]);
            }, null, [bindings[14]], null);
            watchers[17] = new PropertyWatcher("returnReport", {"propertyChange":true}, [bindings[14]], null);
            watchers[2] = new PropertyWatcher("totalPage", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[8] = new PropertyWatcher("targetPosName", {"propertyChange":true}, [bindings[7]], propertyGetter);
            watchers[21] = new FunctionReturnWatcher("getInstance", target, function ():Array
            {
                return ([]);
            }, null, [bindings[18]], null);
            watchers[22] = new PropertyWatcher("facebookUser", {"propertyChange":true}, [bindings[18]], null);
            watchers[1] = new PropertyWatcher("curPage", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[0] = new PropertyWatcher("viewstackSelectIndex", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[7] = new PropertyWatcher("startPosVisible", {"propertyChange":true}, [bindings[6]], propertyGetter);
            watchers[3].updateParent(target);
            watchers[20].updateParent(target);
            watchers[15].updateParent(Context);
            watchers[16].parentWatcher = watchers[15];
            watchers[15].addChild(watchers[16]);
            watchers[16].addChild(watchers[17]);
            watchers[2].updateParent(target);
            watchers[8].updateParent(target);
            watchers[21].updateParent(Context);
            watchers[21].addChild(watchers[22]);
            watchers[1].updateParent(target);
            watchers[0].updateParent(target);
            watchers[7].updateParent(target);
        }


    }
}//package 

