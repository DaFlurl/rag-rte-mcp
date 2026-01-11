// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_VotePreWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.VotePreWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_VotePreWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            VotePreWin.watcherSetupUtil = new (_view_module_rank_VotePreWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[38] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[40], _arg_3[39]], _arg_2);
            _arg_4[1] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[0] = new PropertyWatcher("votePeriod", {"propertyChange":true}, [_arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[11] = new PropertyWatcher("allianceRankArray", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[28] = new PropertyWatcher("castleRankArray", {"propertyChange":true}, [_arg_3[29]], _arg_2);
            _arg_4[2] = new PropertyWatcher("playerRankArray", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[20] = new PropertyWatcher("heroRankArray", {"propertyChange":true}, [_arg_3[21]], _arg_2);
            _arg_4[39] = new PropertyWatcher("pageNo", {"propertyChange":true}, [_arg_3[40]], _arg_2);
            _arg_4[38].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[20].updateParent(_arg_1);
            _arg_4[39].updateParent(_arg_1);
        }


    }
}//package 

