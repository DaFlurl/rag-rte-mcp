// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_CityPanel_inlineComponent4WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.CityPanel_inlineComponent4;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_CityPanel_inlineComponent4WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CityPanel_inlineComponent4.watcherSetupUtil = new (_autoevony_gui_CityPanel_inlineComponent4WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("col4", null, [_arg_3[0]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

