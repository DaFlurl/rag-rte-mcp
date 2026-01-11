// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_VoteWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.VoteWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_VoteWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            VoteWin.watcherSetupUtil = new (_view_module_rank_VoteWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[15] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[15], _arg_3[16]], _arg_2);
            _arg_4[1] = new PropertyWatcher("selectedIndex", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[11] = new PropertyWatcher("dataAry", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[2] = new PropertyWatcher("playerRankArray", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[16] = new PropertyWatcher("pageNo", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[16].updateParent(_arg_1);
        }


    }
}//package 

