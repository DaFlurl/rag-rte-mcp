// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_market_NewTradeWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.market.NewTradeWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_market_NewTradeWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            NewTradeWin.watcherSetupUtil = new (_view_module_market_NewTradeWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[13] = new PropertyWatcher("priceStr", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[2] = new PropertyWatcher("resInfo", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[6] = new PropertyWatcher("resourceBean", {"propertyChange":true}, [_arg_3[3]], _arg_2);
            _arg_4[7] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[21] = new PropertyWatcher("total", {"propertyChange":true}, [_arg_3[13]], _arg_2);
            _arg_4[0] = new PropertyWatcher("resName", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[11] = new PropertyWatcher("amount", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[24] = new PropertyWatcher("canPost", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[17] = new PropertyWatcher("commission", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[7]);
            _arg_4[21].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[24].updateParent(_arg_1);
            _arg_4[17].updateParent(_arg_1);
        }


    }
}//package 

