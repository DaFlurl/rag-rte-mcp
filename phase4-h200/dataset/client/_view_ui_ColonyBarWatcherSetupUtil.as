// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_ColonyBarWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ColonyBar;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_ColonyBarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ColonyBar.watcherSetupUtil = new (_view_ui_ColonyBarWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("typeStr", {"propertyChange":true}, [_arg_3[2], _arg_3[9], _arg_3[8], _arg_3[11], _arg_3[10]], _arg_2);
            _arg_4[0] = new PropertyWatcher("typePb", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("_colonyBean", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[5] = new PropertyWatcher("position", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[4] = new PropertyWatcher("cityName", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[1] = new PropertyWatcher("percent", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[7] = new PropertyWatcher("spaceTime", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[5]);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
        }


    }
}//package 

