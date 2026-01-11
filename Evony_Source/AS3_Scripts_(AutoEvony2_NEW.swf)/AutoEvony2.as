// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//AutoEvony2

package 
{
    import mx.core.Application;
    import autoevony.gui.MainScreen;
    import autoevony.gui.controls.popup.PopUpWinManager;
    import autoevony.gui.LoginScreen;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.system.Security;
    import flash.net.SharedObject;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.player.LoginHelper;
    import com.evony.common.server.events.LoginResponse;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import autoevony.net.Connection;
    import autoevony.event.OnLoginEvent;
    import autoevony.event.OnLoggedOutEvent;
    import mx.rpc.http.HTTPService;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import autoevony.common.Utils;
    import mx.styles.StyleManager;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AutoEvony2 extends Application 
    {

        private static var domainsAllowed:Boolean = allowDomains();
        mx_internal static var _AutoEvony2_StylesInit_done:Boolean = false;

        private var m_serverIp:String = "";
        private var m_queueJobs:MainScreen = null;
        private var m_winMan:PopUpWinManager = null;
        private var m_loginForm:LoginScreen = null;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Application});
        private var _embed__font_DejaVu_Sans_bold_italic_653331763:Class = AutoEvony2__embed__font_DejaVu_Sans_bold_italic_653331763;
        private var _embed__font_DejaVu_Sans_bold_normal_1092898251:Class = AutoEvony2__embed__font_DejaVu_Sans_bold_normal_1092898251;
        private var _embed__font_DejaVu_Sans_medium_italic_83311012:Class = AutoEvony2__embed__font_DejaVu_Sans_medium_italic_83311012;
        private var _embed__font_DejaVu_Sans_medium_normal_356255468:Class = AutoEvony2__embed__font_DejaVu_Sans_medium_normal_356255468;

        public function AutoEvony2()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundColor = 6513767;
                this.backgroundGradientAlphas = [0, 0];
                this.paddingLeft = 0;
                this.paddingTop = 0;
                this.paddingRight = 0;
                this.paddingBottom = 0;
                this.horizontalGap = 0;
                this.verticalGap = 0;
                this.modalTransparency = 0.3;
                this.modalTransparencyBlur = 1;
                this.modalTransparencyColor = 2105893;
                this.modalTransparencyDuration = 100;
            };
            (mx_internal::_AutoEvony2_StylesInit());
            this.minWidth = 710;
            this.minHeight = 550;
            this.layout = "absolute";
            this.addEventListener("creationComplete", this.___AutoEvony2_Application1_creationComplete);
        }

        private static function allowDomains():Boolean
        {
            if (Security.sandboxType != "application")
            {
                Security.allowDomain("*");
            };
            return (true);
        }


        public function onLogin(_arg_1:LoginResponse):void
        {
            var _local_2:SharedObject;
            if (_arg_1.ok != 1)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, this.onLogin);
                _local_2 = SharedObject.getLocal("config");
                _local_2.data.now = LoginHelper.getInstance();
                _local_2.flush();
            };
        }

        public function ___AutoEvony2_Application1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function init():void
        {
            ActionFactory.getInstance().setSender(Connection.getInstance());
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, this.onLogin);
            this.addEventListener(OnLoginEvent.ON_LOGIN_EVENT, this.onServerLoginEvent);
            this.addEventListener(OnLoggedOutEvent.ON_LOGOUT_EVENT, this.onServerLogoutEvent);
            if (this.m_winMan == null)
            {
                this.m_winMan = new PopUpWinManager(this);
            };
            this.addEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW, this.newPopUpWin);
            dispatchEvent(new OnLoggedOutEvent());
        }

        public function onJobQueue():void
        {
            this.setupConfig();
            this.m_queueJobs = new MainScreen();
            this.removeAllChildren();
            this.addChild(this.m_queueJobs);
            this.m_loginForm = null;
        }

        private function onServerLogoutEvent(_arg_1:OnLoggedOutEvent=null):void
        {
            this.m_loginForm = new LoginScreen();
            this.m_loginForm.percentWidth = 100;
            this.m_loginForm.percentHeight = 100;
            this.removeAllChildren();
            this.addChild(this.m_loginForm);
            this.m_queueJobs = null;
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        private function onServerLoginEvent(_arg_1:OnLoginEvent=null):void
        {
            if (_arg_1.loginType == OnLoginEvent.LOGIN_TYPE_FB)
            {
                if (Version.isTraceOn())
                {
                    trace("**********  attempt fb connect code  ***********");
                };
            }
            else
            {
                if (_arg_1.loginType == OnLoginEvent.LOGIN_TYPE_EV)
                {
                    if (Version.isTraceOn())
                    {
                        trace("**********  attempt default connect code  ***********");
                    };
                }
                else
                {
                    if (Version.isTraceOn())
                    {
                        trace("**********  unrcognized login type, attempt default connect code  ***********");
                    };
                    _arg_1.loginType = 0;
                };
            };
            this.connect(_arg_1.loginType);
        }

        private function setupConfig():void
        {
            var _local_1:LoginHelper = LoginHelper.getInstance();
            _local_1.loginType = this.m_loginForm._loginTypeSelect.selectedItem.data;
            _local_1.username = this.m_loginForm.username.text;
            _local_1.password = this.m_loginForm.password.text;
            _local_1.secCode = this.m_loginForm.secCode.text;
            _local_1.server = this.m_loginForm.serverNumT.text;
            _local_1.serverIP = this.m_serverIp;
            _local_1.autoRun = this.m_loginForm.autoRun.selected;
            _local_1.autoScript = this.m_loginForm.autoScript.selected;
            _local_1.autoLogin = this.m_loginForm.autoLogin.selected;
            _local_1.autoLoginMinTime = this.m_loginForm.autoLoginMinTime.text;
            _local_1.autoLoginMaxTime = this.m_loginForm.autoLoginMaxTime.text;
            _local_1.proxyType = this.m_loginForm._proxySelect.selectedItem.data;
            _local_1.proxyPort = this.m_loginForm._proxyPortInput.text;
            _local_1.proxyHost = this.m_loginForm._proxyHostInput.text;
            _local_1.proxyUn = this.m_loginForm._proxyUnInput.text;
            _local_1.proxyPw = this.m_loginForm._proxyPwInput.text;
            _local_1.skypeUn = this.m_loginForm._skypeUnInput.text;
            _local_1.skypePw = this.m_loginForm._skypePwInput.text;
            _local_1.theme = this.m_loginForm._themeSelect.selectedItem.toString();
        }

        public function resetStage():void
        {
            if (((!(this.m_loginForm == null)) && (!(this.getChildIndex(this.m_loginForm) == -1))))
            {
                this.removeAllChildren();
                this.addChild(this.m_loginForm);
            }
            else
            {
                if (((!(this.m_queueJobs == null)) && (!(this.getChildIndex(this.m_queueJobs) == -1))))
                {
                    this.removeAllChildren();
                    this.addChild(this.m_queueJobs);
                };
            };
        }

        private function newPopUpWin(_arg_1:popUpWinShowEvent=null):void
        {
            this.m_winMan.newPopUpWin(_arg_1);
        }

        private function connect(loginType:int, attemptCount:int=0):void
        {
            var enteredServerId:String;
            var tarAddr:String;
            enteredServerId = this.m_loginForm.serverNumT.text.toUpperCase();
            this.m_loginForm.notice.text = ("Looking up ip address for server " + enteredServerId);
            tarAddr = (("http://" + enteredServerId.toLowerCase()) + ".evony.com/config.xml");
            var hlink:HTTPService = new HTTPService();
            hlink.url = tarAddr;
            hlink.method = "GET";
            hlink.resultFormat = HTTPService.RESULT_FORMAT_XML;
            hlink.contentType = HTTPService.CONTENT_TYPE_XML;
            hlink.addEventListener(ResultEvent.RESULT, function (_arg_1:ResultEvent):void
            {
                var _local_2:XML = new XML(_arg_1.message.body.toString());
                var _local_3:String = _local_2.serverID;
                var _local_4:String = _local_2.SID;
                m_serverIp = _local_2.server;
                if (_local_3 == "")
                {
                    m_loginForm.notice.text = ("Error fetching config file for " + enteredServerId);
                    m_loginForm.button.enabled = true;
                    m_loginForm.autoRun.enabled = true;
                }
                else
                {
                    if (enteredServerId != _local_3.toUpperCase())
                    {
                        m_loginForm.notice.text = ((("Abnormal config file for " + enteredServerId) + ", showing wrong server ") + _local_3);
                        m_loginForm.button.enabled = true;
                        m_loginForm.autoRun.enabled = true;
                    }
                    else
                    {
                        if (m_serverIp == "")
                        {
                            m_loginForm.notice.text = (("Could not find ip address of server " + enteredServerId) + " from config file");
                            m_loginForm.button.enabled = true;
                            m_loginForm.autoRun.enabled = true;
                        }
                        else
                        {
                            m_loginForm.notice.text = (((("Found server " + _local_3) + " at: ") + m_serverIp) + ". Attempting to connect...");
                            if (_local_2.serverAlias)
                            {
                                LoginHelper.getInstance().strserverAlias = _local_2.serverAlias;
                            };
                            LoginHelper.getInstance().server = _local_3;
                            LoginHelper.getInstance().sid = _local_4;
                            onJobQueue();
                        };
                    };
                };
            });
            hlink.addEventListener(FaultEvent.FAULT, function (_arg_1:FaultEvent):void
            {
                var _local_2:int;
                if (attemptCount >= 10)
                {
                    if (m_loginForm.autoLogin.selected)
                    {
                        _local_2 = Utils.getRandomInt(40, 120);
                        m_loginForm.notice.text = (((("Error: Unable to read " + tarAddr) + ". Next attemp in ") + _local_2) + "s...");
                        Utils.callLater((_local_2 * 1000), connect, [0]);
                    }
                    else
                    {
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (((("Error: Unable to read " + tarAddr) + " after ") + attemptCount) + " attemps. Aborting login process.")));
                        m_loginForm.button.enabled = true;
                        m_loginForm.autoRun.enabled = true;
                    };
                }
                else
                {
                    _local_2 = Utils.getRandomInt(3, 9);
                    m_loginForm.notice.text = (((("Error: Unable to read " + tarAddr) + ". Next attemp in ") + _local_2) + "s...");
                    Utils.callLater((_local_2 * 1000), connect, [++attemptCount]);
                };
            });
            hlink.send();
        }

        mx_internal function _AutoEvony2_StylesInit():void
        {
            var _local_1:CSSStyleDeclaration;
            var _local_2:Array;
            if (mx_internal::_AutoEvony2_StylesInit_done)
            {
                return;
            };
            mx_internal::_AutoEvony2_StylesInit_done = true;
            var _local_3:* = StyleManager;
            (_local_3.mx_internal::initProtoChainRoots());
        }


    }
}//package 

