// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.MemberInfoWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MemberInfoWin.watcherSetupUtil = new (_autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("memberInfoBean", {"propertyChange":true}, [_arg_3[2], _arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[9], _arg_3[10], _arg_3[11], _arg_3[12], _arg_3[13], _arg_3[15]], _arg_2);
            _arg_4[6] = new PropertyWatcher("office", null, [_arg_3[5]], null);
            _arg_4[4] = new PropertyWatcher("alliance", null, [_arg_3[3]], null);
            _arg_4[5] = new PropertyWatcher("allianceLevel", null, [_arg_3[4], _arg_3[13]], null);
            _arg_4[16] = new PropertyWatcher("prestige", null, [_arg_3[11]], null);
            _arg_4[9] = new PropertyWatcher("faceUrl", null, [_arg_3[7]], null);
            _arg_4[19] = new PropertyWatcher("levelId", null, [_arg_3[15]], null);
            _arg_4[18] = new PropertyWatcher("honor", null, [_arg_3[12]], null);
            _arg_4[7] = new PropertyWatcher("titleStr", null, [_arg_3[6]], null);
            _arg_4[3] = new PropertyWatcher("userName", null, [_arg_3[2]], null);
            _arg_4[14] = new PropertyWatcher("castleCount", null, [_arg_3[10]], null);
            _arg_4[13] = new PropertyWatcher("ranking", null, [_arg_3[9]], null);
            _arg_4[11] = new PropertyWatcher("population", null, [_arg_3[8]], null);
            _arg_4[21] = new PropertyWatcher("isOwner", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[1] = new PropertyWatcher("canChangePower", {"propertyChange":true}, [_arg_3[1], _arg_3[14]], _arg_2);
            _arg_4[0] = new PropertyWatcher("dataPCB", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[6]);
            _arg_4[2].addChild(_arg_4[4]);
            _arg_4[2].addChild(_arg_4[5]);
            _arg_4[2].addChild(_arg_4[16]);
            _arg_4[2].addChild(_arg_4[9]);
            _arg_4[2].addChild(_arg_4[19]);
            _arg_4[2].addChild(_arg_4[18]);
            _arg_4[2].addChild(_arg_4[7]);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[2].addChild(_arg_4[14]);
            _arg_4[2].addChild(_arg_4[13]);
            _arg_4[2].addChild(_arg_4[11]);
            _arg_4[21].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

