// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_shop_ShopWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.shop.ShopWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;
    import mx.binding.StaticPropertyWatcher;
    import com.evony.GameConfig;

    public class _view_module_shop_ShopWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ShopWin.watcherSetupUtil = new (_view_module_shop_ShopWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[2], _arg_3[1]], _arg_2);
            _arg_4[16] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [_arg_3[15]], _arg_2);
            _arg_4[17] = new PropertyWatcher("medal", {"propertyChange":true}, [_arg_3[15]], null);
            _arg_4[2] = new PropertyWatcher("curPage", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[12] = new StaticPropertyWatcher("instance", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[13] = new PropertyWatcher("ButtonFlag", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[16].addChild(_arg_4[17]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[12].updateParent(GameConfig);
            _arg_4[12].addChild(_arg_4[13]);
        }


    }
}//package 

