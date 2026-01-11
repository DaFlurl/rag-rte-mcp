// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_market_MarketWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.market.Market;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_market_MarketWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Market.watcherSetupUtil = new (_view_module_market_MarketWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[4] = new PropertyWatcher("sellArray", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[8] = new PropertyWatcher("buyArray", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
        }


    }
}//package 

