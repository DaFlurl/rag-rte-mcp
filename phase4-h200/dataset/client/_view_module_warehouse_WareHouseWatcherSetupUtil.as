// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_warehouse_WareHouseWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.warehouse.WareHouse;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_warehouse_WareHouseWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            WareHouse.watcherSetupUtil = new (_view_module_warehouse_WareHouseWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[20] = new PropertyWatcher("storage", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[15] = new PropertyWatcher("ironBean", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[16] = new PropertyWatcher("storePercent", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[18] = new PropertyWatcher("wareHouseNum", {"propertyChange":true}, [_arg_3[14]], _arg_2);
            _arg_4[13] = new PropertyWatcher("stoneBean", {"propertyChange":true}, [_arg_3[11]], _arg_2);
            _arg_4[14] = new PropertyWatcher("storePercent", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[11] = new PropertyWatcher("woodBean", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[12] = new PropertyWatcher("storePercent", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[0] = new PropertyWatcher("dataArr", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[22] = new PropertyWatcher("idleSpace", {"propertyChange":true}, [_arg_3[18]], _arg_2);
            _arg_4[9] = new PropertyWatcher("foodBean", {"propertyChange":true}, [_arg_3[9]], _arg_2);
            _arg_4[10] = new PropertyWatcher("storePercent", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[20].updateParent(_arg_1);
            _arg_4[15].updateParent(_arg_1);
            _arg_4[15].addChild(_arg_4[16]);
            _arg_4[18].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[13].addChild(_arg_4[14]);
            _arg_4[11].updateParent(_arg_1);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[22].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[9].addChild(_arg_4[10]);
        }


    }
}//package 

