// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_world_WorldMapToolTipWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.world.WorldMapToolTip;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_castle_world_WorldMapToolTipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            WorldMapToolTip.watcherSetupUtil = new (_view_castle_world_WorldMapToolTipWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[10] = new PropertyWatcher("tile", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[11] = new PropertyWatcher("mapCastleBean", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[10]], null);
            _arg_4[12] = new PropertyWatcher("userName", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[13] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[14] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[3] = new PropertyWatcher("fieldDesc", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[0] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("position", {"propertyChange":true}, [_arg_3[4], _arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("fieldName", {"propertyChange":true}, [_arg_3[4], _arg_3[1]], _arg_2);
            _arg_4[5] = new PropertyWatcher("dist", {"propertyChange":true}, [_arg_3[11], _arg_3[3]], _arg_2);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[10].addChild(_arg_4[11]);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[11].addChild(_arg_4[13]);
            _arg_4[11].addChild(_arg_4[14]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
        }


    }
}//package 

