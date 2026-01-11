// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_ArmyMovementBarWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.ArmyMovementBar;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_ArmyMovementBarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ArmyMovementBar.watcherSetupUtil = new (_view_ui_ArmyMovementBarWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("_armyBean", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[4] = new PropertyWatcher("targetPosName", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[2] = new PropertyWatcher("typeStr", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[5] = new PropertyWatcher("targetX", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[0] = new PropertyWatcher("typePb", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[6] = new PropertyWatcher("targetY", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[1] = new PropertyWatcher("percent", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[8] = new PropertyWatcher("spaceTime", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[9] = new PropertyWatcher("typeIcon", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
        }


    }
}//package 

