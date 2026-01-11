// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_accouter_AccoutContainerWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.accouter.AccoutContainer;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_accouter_AccoutContainerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AccoutContainer.watcherSetupUtil = new (_view_module_accouter_AccoutContainerWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("itemImg", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[1] = new PropertyWatcher("showPanle", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[0] = new PropertyWatcher("itemClass", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

