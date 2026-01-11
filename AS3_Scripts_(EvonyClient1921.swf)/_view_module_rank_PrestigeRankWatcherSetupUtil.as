// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_rank_PrestigeRankWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.rank.PrestigeRank;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_rank_PrestigeRankWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            PrestigeRank.watcherSetupUtil = new (_view_module_rank_PrestigeRankWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[6] = new PropertyWatcher("questTypeArray", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[2] = new PropertyWatcher("strArg", {"propertyChange":true}, [_arg_3[2], _arg_3[4], _arg_3[1], _arg_3[3]], _arg_2);
            _arg_4[0] = new PropertyWatcher("curSelectRankIndex", {"propertyChange":true}, [_arg_3[13], _arg_3[7], _arg_3[0]], _arg_2);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

