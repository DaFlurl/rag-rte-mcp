// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_AlertWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.AlertWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_AlertWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AlertWin.watcherSetupUtil = new (_autoevony_gui_AlertWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("showNoBtn", {"propertyChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2], _arg_3[3], _arg_3[4]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

