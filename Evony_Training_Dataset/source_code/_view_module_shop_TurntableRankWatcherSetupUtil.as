// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_shop_TurntableRankWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.shop.TurntableRank;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_shop_TurntableRankWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            TurntableRank.watcherSetupUtil = new (_view_module_shop_TurntableRankWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[9] = new PropertyWatcher("curSelectRankIndex", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[7] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[1] = new PropertyWatcher("questTypeArray", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[6] = new PropertyWatcher("pageNo", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
        }


    }
}//package 

