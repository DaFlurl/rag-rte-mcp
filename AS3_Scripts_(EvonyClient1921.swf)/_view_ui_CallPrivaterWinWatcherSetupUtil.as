// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_CallPrivaterWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.CallPrivaterWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_CallPrivaterWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CallPrivaterWin.watcherSetupUtil = new (_view_ui_CallPrivaterWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("isCanMute", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[1]], _arg_2);
            _arg_4[0] = new PropertyWatcher("playerName", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

