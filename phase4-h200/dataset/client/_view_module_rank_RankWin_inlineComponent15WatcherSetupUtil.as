// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_RankWin_inlineComponent15WatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.RankWin_inlineComponent15;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_RankWin_inlineComponent15WatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            RankWin_inlineComponent15.watcherSetupUtil = new (_view_module_rank_RankWin_inlineComponent15WatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("data", {"dataChange":true}, [_arg_3[1], _arg_3[0]], _arg_2);
            _arg_4[7] = new PropertyWatcher("rank", null, [_arg_3[1]], null);
            _arg_4[2] = new PropertyWatcher("prestige", null, [_arg_3[0]], null);
            _arg_4[6] = new PropertyWatcher("name", null, [_arg_3[1]], null);
            _arg_4[3] = new PropertyWatcher("outerDocument", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[9] = new PropertyWatcher("normalColor", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[5] = new PropertyWatcher("isExactMatch", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[8] = new PropertyWatcher("focusColor", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[7]);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[6]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[9]);
            _arg_4[3].addChild(_arg_4[5]);
            _arg_4[3].addChild(_arg_4[8]);
        }


    }
}//package 

