// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_helpWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.help;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.ArrayElementWatcher;

    public class _view_ui_helpWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            help.watcherSetupUtil = new (_view_ui_helpWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[7] = new PropertyWatcher("totalPage", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[2] = new PropertyWatcher("helpInfo", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[3] = new ArrayElementWatcher(target, function ():*
            {
                return (0);
            }, [bindings[2]]);
            watchers[5] = new PropertyWatcher("label", null, [bindings[2]], null);
            watchers[0] = new PropertyWatcher("helpData", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[6] = new PropertyWatcher("pageNo", {"propertyChange":true}, [bindings[3]], propertyGetter);
            watchers[7].updateParent(target);
            watchers[2].updateParent(target);
            watchers[3].arrayWatcher = watchers[2];
            watchers[2].addChild(watchers[3]);
            watchers[3].addChild(watchers[5]);
            watchers[0].updateParent(target);
            watchers[6].updateParent(target);
        }


    }
}//package 

