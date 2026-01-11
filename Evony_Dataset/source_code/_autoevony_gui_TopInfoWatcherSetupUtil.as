// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_TopInfoWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.TopInfo;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_TopInfoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TopInfo.watcherSetupUtil = new (_autoevony_gui_TopInfoWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[3] = new PropertyWatcher("office", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[1] = new PropertyWatcher("alliance", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[6] = new PropertyWatcher("allianceLvLArr", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[12] = new PropertyWatcher("gift", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[11] = new PropertyWatcher("title", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[2] = new PropertyWatcher("prestige", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[8] = new PropertyWatcher("roleImg", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[10] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[4] = new PropertyWatcher("gameCoins", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[9] = new PropertyWatcher("role", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[0] = new PropertyWatcher("server", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[5] = new PropertyWatcher("ranking", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[12].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
        }


    }
}//package 

