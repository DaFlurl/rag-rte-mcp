// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_mail_MailWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.mail.MailWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_mail_MailWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            MailWin.watcherSetupUtil = new (_view_module_mail_MailWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[7] = new PropertyWatcher("dataP", {"propertyChange":true}, [_arg_3[6]], _arg_2);
            _arg_4[6] = new PropertyWatcher("totalPage", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[20] = new PropertyWatcher("_bean", {"propertyChange":true}, [_arg_3[19], _arg_3[21], _arg_3[31], _arg_3[20], _arg_3[22]], _arg_2);
            _arg_4[21] = new PropertyWatcher("receiver", {"propertyChange":true}, [_arg_3[19]], null);
            _arg_4[23] = new PropertyWatcher("title", {"propertyChange":true}, [_arg_3[21], _arg_3[31]], null);
            _arg_4[22] = new PropertyWatcher("sender", {"propertyChange":true}, [_arg_3[20]], null);
            _arg_4[24] = new PropertyWatcher("receiveTime", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[9] = new PropertyWatcher("titleStr", {"propertyChange":true}, [_arg_3[8]], _arg_2);
            _arg_4[25] = new PropertyWatcher("mailContent", {"propertyChange":true}, [_arg_3[23]], _arg_2);
            _arg_4[5] = new PropertyWatcher("curPage", {"propertyChange":true}, [_arg_3[5]], _arg_2);
            _arg_4[37] = new PropertyWatcher("inboxCount", {"propertyChange":true}, [_arg_3[36], _arg_3[35], _arg_3[37]], _arg_2);
            _arg_4[27] = new PropertyWatcher("replyBtnVisible", {"propertyChange":true}, [_arg_3[25]], _arg_2);
            _arg_4[38] = new PropertyWatcher("sysMailCount", {"propertyChange":true}, [_arg_3[40], _arg_3[38], _arg_3[39]], _arg_2);
            _arg_4[31] = new PropertyWatcher("replyUserName", {"propertyChange":true}, [_arg_3[29]], _arg_2);
            _arg_4[13] = new PropertyWatcher("markShow", {"propertyChange":true}, [_arg_3[12]], _arg_2);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[6].updateParent(_arg_1);
            _arg_4[20].updateParent(_arg_1);
            _arg_4[20].addChild(_arg_4[21]);
            _arg_4[20].addChild(_arg_4[23]);
            _arg_4[20].addChild(_arg_4[22]);
            _arg_4[20].addChild(_arg_4[24]);
            _arg_4[9].updateParent(_arg_1);
            _arg_4[25].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[37].updateParent(_arg_1);
            _arg_4[27].updateParent(_arg_1);
            _arg_4[38].updateParent(_arg_1);
            _arg_4[31].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
        }


    }
}//package 

