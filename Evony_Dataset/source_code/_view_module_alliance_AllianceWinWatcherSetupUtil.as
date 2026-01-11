// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_alliance_AllianceWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.AllianceWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_alliance_AllianceWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            AllianceWin.watcherSetupUtil = new (_view_module_alliance_AllianceWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[7] = new PropertyWatcher("allianceList", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[6] = new PropertyWatcher("allianceExist", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[5] = new PropertyWatcher("allianceMemberList", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3] = new PropertyWatcher("allianceWarInfo", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[15] = new PropertyWatcher("indexAllianceInfoBean", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[4] = new PropertyWatcher("allianceHappening", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[1] = new PropertyWatcher("viewstack1", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("selectedChild", {
                "valueCommit":true,
                "creationComplete":true
            }, [_arg_3[1]], null);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[2]);
        }


    }
}//package 

