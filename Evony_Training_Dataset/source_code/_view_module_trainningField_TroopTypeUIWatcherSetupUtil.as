// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_trainningField_TroopTypeUIWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.trainningField.TroopTypeUI;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.FunctionReturnWatcher;
    import com.evony.eum.TroopEumDefine;

    public class _view_module_trainningField_TroopTypeUIWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TroopTypeUI.watcherSetupUtil = new (_view_module_trainningField_TroopTypeUIWatcherSetupUtil)();
        }


        public function setup(target:Object, propertyGetter:Function, bindings:Array, watchers:Array):void
        {
            watchers[4] = new PropertyWatcher("_amount", {"propertyChange":true}, [bindings[2]], propertyGetter);
            watchers[1] = new FunctionReturnWatcher("getTroopEumByType", target, function ():Array
            {
                return ([target.typeId]);
            }, null, [bindings[1]], null);
            watchers[3] = new PropertyWatcher("name", {"propertyChange":true}, [bindings[1]], null);
            watchers[2] = new PropertyWatcher("typeId", {"propertyChange":true}, [bindings[1]], propertyGetter);
            watchers[0] = new PropertyWatcher("_imgSrc", {"propertyChange":true}, [bindings[0]], propertyGetter);
            watchers[4].updateParent(target);
            watchers[1].updateParent(TroopEumDefine);
            watchers[1].addChild(watchers[3]);
            watchers[2].updateParent(target);
            watchers[0].updateParent(target);
        }


    }
}//package 

