// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Items.BuyItemWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            BuyItemWin.watcherSetupUtil = new (_autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("itemData", {"propertyChange":true}, [_arg_3[1], _arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[2] = new PropertyWatcher("price", {"propertyChange":true}, [_arg_3[1], _arg_3[2], _arg_3[3]], null);
            _arg_4[4] = new PropertyWatcher("_buyCountInput1", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], _arg_2);
            _arg_4[5] = new PropertyWatcher("_useCountInput", {"propertyChange":true}, [_arg_3[2], _arg_3[3]], null);
            _arg_4[6] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[2], _arg_3[3]], null);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[5].addChild(_arg_4[6]);
        }


    }
}//package 

