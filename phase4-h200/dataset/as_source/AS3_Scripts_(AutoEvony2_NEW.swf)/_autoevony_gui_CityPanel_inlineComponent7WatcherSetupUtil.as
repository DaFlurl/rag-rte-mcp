// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.CityPanel_inlineComponent7;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CityPanel_inlineComponent7.watcherSetupUtil = new (_autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2]], _arg_2);
            _arg_4[1] = new PropertyWatcher("col7", null, [_arg_3[0]], null);
            _arg_4[3] = new PropertyWatcher("col9", null, [_arg_3[2]], null);
            _arg_4[2] = new PropertyWatcher("col8", null, [_arg_3[1]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[2]);
        }


    }
}//package 

