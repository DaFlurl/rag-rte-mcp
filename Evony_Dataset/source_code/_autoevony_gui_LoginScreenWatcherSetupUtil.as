// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_LoginScreenWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.LoginScreen;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_LoginScreenWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            LoginScreen.watcherSetupUtil = new (_autoevony_gui_LoginScreenWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("proxySelectInfo", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[2] = new PropertyWatcher("_proxySelect", {"propertyChange":true}, [_arg_3[2], _arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[9]], _arg_2);
            _arg_4[3] = new PropertyWatcher("selectedIndex", {
                "valueCommit":true,
                "collectionChange":true,
                "change":true
            }, [_arg_3[2], _arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[9]], null);
            _arg_4[4] = new PropertyWatcher("_skypeUnInput", {"propertyChange":true}, [_arg_3[10]], _arg_2);
            _arg_4[5] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[10]], null);
            _arg_4[10] = new PropertyWatcher("themeSelectInfo", {"propertyChange":true}, [_arg_3[13]], _arg_2);
            _arg_4[0] = new PropertyWatcher("loginTypeSelectInfo", {"propertyChange":true}, [_arg_3[0]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
        }


    }
}//package 

