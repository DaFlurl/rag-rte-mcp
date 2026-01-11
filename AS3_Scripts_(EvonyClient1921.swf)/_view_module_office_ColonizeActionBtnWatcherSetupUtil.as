// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_office_ColonizeActionBtnWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.ColonizeActionBtn;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_office_ColonizeActionBtnWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonizeActionBtn.watcherSetupUtil = new (_view_module_office_ColonizeActionBtnWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("tooltips", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2] = new PropertyWatcher("spaceTime", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
        }


    }
}//package 

