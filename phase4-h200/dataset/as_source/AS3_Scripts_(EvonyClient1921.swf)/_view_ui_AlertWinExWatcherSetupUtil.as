// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_AlertWinExWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.AlertWinEx;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_AlertWinExWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AlertWinEx.watcherSetupUtil = new (_view_ui_AlertWinExWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("noTxt", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[4] = new PropertyWatcher("title", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[3] = new PropertyWatcher("hasNoBtn", {"propertyChange":true}, [_arg_3[4], _arg_3[3]], _arg_2);
            _arg_4[1] = new PropertyWatcher("yesTxt", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
        }


    }
}//package 

