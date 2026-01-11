// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.FbUtil

package com.evony.util
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.utils.getTimer;
    import flash.external.ExternalInterface;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import view.ui.AlertWin;
    import flash.events.Event;
    import view.MainWin;
    import view.module.guide.SaveGameStep2Win;
    import mx.core.Application;
    import com.evony.client.action.ActionFactory;
    import flash.utils.*;

    public class FbUtil 
    {

        private static var instance:FbUtil;

        private var timer:Timer = new Timer(3000);
        private var checkStateStartTime:int = 0;
        private var timerCheckState:Timer = new Timer(3000);
        private var startTime:int = 0;
        private var sig:String = "";
        private var fbuid:String = "0";
        private var pwd:String = "";

        public function FbUtil()
        {
            timerCheckState.stop();
            timer.stop();
            timer.addEventListener(TimerEvent.TIMER, onTimerCheckFaceConnect);
            timerCheckState.addEventListener(TimerEvent.TIMER, onTimerCheckState);
        }

        public static function getInstance():FbUtil
        {
            if (instance == null)
            {
                instance = new (FbUtil)();
            };
            return (instance);
        }


        private function onFbLogoutAnswer(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (checkStateStartTime == 0)
                {
                    timerCheckState.stop();
                    checkStateStartTime = 0;
                };
                if (checkStateStartTime == 0)
                {
                    timerCheckState.start();
                    checkStateStartTime = getTimer();
                    ExternalInterface.call("facebook.fb_logout");
                };
            };
        }

        private function fbConnectResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().facebookUser = true;
                Context.getInstance().userName = this.fbuid;
                Context.getInstance().saveGame = true;
                EvonyClient.isTryUser = false;
                EvonyClient.isTryGame = false;
                JSUtil.getInstance().exitGameSet(false);
                AlertWin.show("Connect facebook successfully.", onFbConnectOk);
            }
            else
            {
                if (_arg_1.ok == -98)
                {
                    AlertWin.show("The current Facebook Account has created a player already. Try Another?", onFbLogoutAnswer, "Try Again", "Later");
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        public function connectRequst():void
        {
            if (((ExternalInterface.available) && (!(Context.getInstance().facebookUser))))
            {
                if (startTime != 0)
                {
                    timer.stop();
                    startTime = 0;
                };
                ExternalInterface.call("facebook.checkFB", true, Context.getInstance().userName);
                timer.start();
                startTime = getTimer();
            };
        }

        private function onTimerCheckFaceConnect(_arg_1:Event):void
        {
            var _local_2:String = ExternalInterface.call("getFbReturnValue");
            if (((_local_2 == null) || (_local_2.length < 15)))
            {
                if ((getTimer() - startTime) > (20 * 60000))
                {
                    timer.stop();
                    startTime = 0;
                };
            }
            else
            {
                startTime = 0;
                timer.stop();
                JSCallBack(_local_2);
            };
        }

        private function onFbConnectOk(_arg_1:Boolean):void
        {
            MainWin.instance.saveGameBtn.visible = false;
            Context.getInstance().saveGame = true;
            EvonyClient.isTryUser = false;
            SaveGameStep2Win.getInstance().show();
        }

        public function JSCallBack(_arg_1:String):void
        {
            this.fbuid = Application.application.getParamByName(_arg_1, "fbuid");
            var _local_2:String = Application.application.getParamByName(_arg_1, "expires");
            var _local_3:String = Application.application.getParamByName(_arg_1, "session_key");
            var _local_4:String = Application.application.getParamByName(_arg_1, "ss");
            var _local_5:String = Application.application.getParamByName(_arg_1, "user");
            var _local_6:String = Application.application.getParamByName(_arg_1, "uid");
            var _local_7:String = Application.application.getParamByName(_arg_1, "fb_sig");
            var _local_8:String = Application.application.getParamByName(_arg_1, "access_token");
            var _local_9:String = Application.application.getParamByName(_arg_1, "base_domain");
            var _local_10:String = Application.application.getParamByName(_arg_1, "secret");
            var _local_11:String = ("expires=" + _local_2);
            if (((!(_local_10 == null)) && (_local_10.length > 0)))
            {
                _local_11 = (_local_11 + ("secret=" + _local_10));
            };
            _local_11 = (_local_11 + ("session_key=" + _local_3));
            if (((!(_local_4 == null)) && (_local_4.length > 0)))
            {
                _local_11 = (_local_11 + ("ss=" + _local_4));
            };
            if (((!(_local_5 == null)) && (_local_5.length > 0)))
            {
                _local_11 = (_local_11 + ("user=" + _local_5));
            };
            if (((!(_local_6 == null)) && (_local_6.length > 0)))
            {
                _local_11 = (_local_11 + ("uid=" + _local_6));
            };
            if (((!(_local_9 == null)) && (_local_9.length > 0)))
            {
                _local_11 = (("base_domain=" + _local_9) + _local_11);
            };
            if (((!(_local_8 == null)) && (_local_8.length > 0)))
            {
                _local_11 = (("access_token=" + _local_8) + _local_11);
            };
            this.pwd = _local_11;
            this.sig = _local_7;
            ActionFactory.getInstance().getCommonCommands().facebookConnect(fbuid, _local_11, _local_7, fbConnectResponse);
        }

        private function onTimerCheckState(_arg_1:Event):void
        {
            var _local_2:int = int(ExternalInterface.call("facebook.getFacebookUid"));
            if (_local_2 == 0)
            {
                timerCheckState.stop();
                checkStateStartTime = 0;
                connectRequst();
            }
            else
            {
                if ((getTimer() - checkStateStartTime) > (3 * 60000))
                {
                    timerCheckState.stop();
                    checkStateStartTime = 0;
                };
            };
        }


    }
}//package com.evony.util

