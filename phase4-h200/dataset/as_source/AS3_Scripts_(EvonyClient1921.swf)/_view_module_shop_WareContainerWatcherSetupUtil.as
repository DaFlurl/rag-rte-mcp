// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_shop_WareContainerWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.shop.WareContainer;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_shop_WareContainerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            WareContainer.watcherSetupUtil = new (_view_module_shop_WareContainerWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[0] = new PropertyWatcher("itemEum", {"propertyChange":true}, [_arg_3[8], _arg_3[11], _arg_3[6], _arg_3[3], _arg_3[10], _arg_3[7], _arg_3[0]], _arg_2);
            _arg_4[1] = new PropertyWatcher("iconUrl", {"propertyChange":true}, [_arg_3[0]], null);
            _arg_4[8] = new PropertyWatcher("price", {"propertyChange":true}, [_arg_3[8], _arg_3[11], _arg_3[6], _arg_3[10], _arg_3[7]], null);
            _arg_4[4] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[2] = new PropertyWatcher("sellStatus", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[6] = new PropertyWatcher("_itembean", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[7] = new PropertyWatcher("count", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
            _arg_4[0].addChild(_arg_4[8]);
            _arg_4[0].addChild(_arg_4[4]);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[6].addChild(_arg_4[7]);
        }


    }
}//package 

