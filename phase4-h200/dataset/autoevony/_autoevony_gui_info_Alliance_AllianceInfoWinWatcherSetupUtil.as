// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.AllianceInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceInfoWin.watcherSetupUtil = new (_autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("officalLevel", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[7] = new PropertyWatcher("curRank", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[3] = new PropertyWatcher("allianceBean", {"propertyChange":true}, [_arg_3[2], _arg_3[3], _arg_3[4], _arg_3[6], _arg_3[7], _arg_3[8]], _arg_2);
            _arg_4[9] = new PropertyWatcher("honor", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[4] = new PropertyWatcher("leader", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[11] = new PropertyWatcher("prestigeCount", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[6] = new PropertyWatcher("memberCount", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[12] = new PropertyWatcher("allinaceInfo", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[5] = new PropertyWatcher("creator", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[0] = new PropertyWatcher("allianceName", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[13] = new PropertyWatcher("isShow", {"propertyChange":true}, [_arg_3[9], _arg_3[10], _arg_3[11], _arg_3[12], _arg_3[13], _arg_3[14]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[9]);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[3].addChild(_arg_4[11]);
            _arg_4[3].addChild(_arg_4[6]);
            _arg_4[3].addChild(_arg_4[12]);
            _arg_4[3].addChild(_arg_4[5]);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
        }


    }
}//package 

