// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_ChatPanelWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.ChatPanel;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_ChatPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            ChatPanel.watcherSetupUtil = new (_autoevony_gui_ChatPanelWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[2] = new PropertyWatcher("cache", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[3] = new PropertyWatcher("aChatText", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[7] = new PropertyWatcher("commandText", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[5] = new PropertyWatcher("wChatText", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[8] = new PropertyWatcher("emtpyStr", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[4] = new PropertyWatcher("pChatText", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[6] = new PropertyWatcher("systemText", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[0] = new PropertyWatcher("chatTab", {"propertyChange":true}, [_arg_3[1], _arg_3[2]], _arg_2);
            _arg_4[1] = new PropertyWatcher("selectedIndex", {
                "valueCommit":true,
                "click":true
            }, [_arg_3[1], _arg_3[2]], null);
            _arg_4[2].updateParent(_arg_1);
            _arg_4[2].addChild(_arg_4[3]);
            _arg_4[2].addChild(_arg_4[7]);
            _arg_4[2].addChild(_arg_4[5]);
            _arg_4[2].addChild(_arg_4[8]);
            _arg_4[2].addChild(_arg_4[4]);
            _arg_4[2].addChild(_arg_4[6]);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[1]);
        }


    }
}//package 

