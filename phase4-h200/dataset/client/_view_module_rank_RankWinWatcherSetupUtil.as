// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_RankWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.RankWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_RankWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            RankWin.watcherSetupUtil = new (_view_module_rank_RankWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[45] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[47], _arg_3[48]], _arg_2);
            _arg_4[5] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [_arg_3[46], _arg_3[5], _arg_3[44]], _arg_2);
            _arg_4[16] = new PropertyWatcher("allianceRankArray", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[40] = new PropertyWatcher("dataAry", {"propertyChange":true}, [_arg_3[40]], _arg_2);
            _arg_4[33] = new PropertyWatcher("castleRankArray", {"propertyChange":true}, [_arg_3[33]], _arg_2);
            _arg_4[25] = new PropertyWatcher("heroRankArray", {"propertyChange":true}, [_arg_3[25]], _arg_2);
            _arg_4[6] = new PropertyWatcher("playerRankArray", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[46] = new PropertyWatcher("pageNo", {"propertyChange":true}, [_arg_3[48]], _arg_2);
            _arg_4[45].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[40].updateParent(_arg_1);
            _arg_4[33].updateParent(_arg_1);
            _arg_4[25].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[46].updateParent(_arg_1);
        }


    }
}//package 

