// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_shop_TurntableWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.shop.Turntable;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_shop_TurntableWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Turntable.watcherSetupUtil = new (_view_module_shop_TurntableWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[7] = new PropertyWatcher("stopBtnEnabld", {"propertyChange":true}, [_arg_3[4]], _arg_2);
            _arg_4[2] = new PropertyWatcher("itemAmount", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[9] = new PropertyWatcher("btnEnabled", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[10] = new PropertyWatcher("closeBtnEnabled", {"propertyChange":true}, [_arg_3[7]], _arg_2);
            _arg_4[3] = new PropertyWatcher("player", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[4] = new PropertyWatcher("playerInfo", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[5] = new PropertyWatcher("medal", {"propertyChange":true}, [_arg_3[2]], null);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[3].addChild(_arg_4[4]);
            _arg_4[4].addChild(_arg_4[5]);
        }


    }
}//package 

