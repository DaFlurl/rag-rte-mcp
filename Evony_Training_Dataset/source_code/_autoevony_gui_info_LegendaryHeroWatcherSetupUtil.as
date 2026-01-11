// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_LegendaryHeroWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.LegendaryHero;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_LegendaryHeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            LegendaryHero.watcherSetupUtil = new (_autoevony_gui_info_LegendaryHeroWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[6] = new PropertyWatcher("faceSource", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[0] = new PropertyWatcher("randomHeroBean", {"propertyChange":true}, [_arg_3[0], _arg_3[1], _arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[4] = new PropertyWatcher("resetcount", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[3] = new PropertyWatcher("stratagem", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[2] = new PropertyWatcher("power", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[1] = new PropertyWatcher("management", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[3]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

