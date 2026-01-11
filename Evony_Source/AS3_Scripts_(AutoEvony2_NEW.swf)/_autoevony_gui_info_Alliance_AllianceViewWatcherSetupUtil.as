// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Alliance.AllianceView;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceView.watcherSetupUtil = new (_autoevony_gui_info_Alliance_AllianceViewWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("showInAlliance", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[3] = new PropertyWatcher("allianceAddPlayerByLeaderInfoBeanListArray", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[1] = new PropertyWatcher("allianceWanted", {"propertyChange":true}, [_arg_3[1], _arg_3[2]], _arg_2);
            _arg_4[6] = new PropertyWatcher("memberLevel", {"propertyChange":true}, [_arg_3[9], _arg_3[11]], _arg_2);
            _arg_4[4] = new PropertyWatcher("indexAllianceInfoBean", {"propertyChange":true}, [_arg_3[5], _arg_3[8], _arg_3[10]], _arg_2);
            _arg_4[9] = new PropertyWatcher("allianceNote", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[5] = new PropertyWatcher("allianceInfo", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[9]);
            _arg_4[4].addChild(_arg_4[5]);
        }


    }
}//package 

