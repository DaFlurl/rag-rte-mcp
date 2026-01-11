// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_ui_NeighborInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.NeighborInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_ui_NeighborInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            NeighborInfo.watcherSetupUtil = new (_view_ui_NeighborInfoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("info", {"propertyChange":true}, [_arg_3[1], _arg_3[3], _arg_3[7], _arg_3[5], _arg_3[0]], _arg_2);
            _arg_4[4] = new PropertyWatcher("title", null, [_arg_3[3]], null);
            _arg_4[6] = new PropertyWatcher("prestige", null, [_arg_3[5]], null);
            _arg_4[1] = new PropertyWatcher("image", null, [_arg_3[0]], null);
            _arg_4[8] = new PropertyWatcher("server", null, [_arg_3[7]], null);
            _arg_4[2] = new PropertyWatcher("name", null, [_arg_3[1]], null);
            _arg_4[9] = new PropertyWatcher("iNotReadCount", {"propertyChange":true}, [_arg_3[9], _arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[0].addChild(_arg_4[6]);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[2]);
            _arg_4[9].updateParent(_arg_1);
        }


    }
}//package 

