// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//EvonyClient

package 
{
    import mx.core.Application;
    import flash.events.EventDispatcher;
    import mx.controls.TextArea;
    import mx.core.UIComponent;
    import view.MainWin;
    import view.ui.BackgroundProgressBar;
    import flash.ui.ContextMenu;
    import view.CreatPlayerPanel;
    import view.LoginPanel;
    import com.evony.net.client.GameClient;
    import mx.containers.Canvas;
    import flash.display.MovieClip;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import com.evony.util.DemandPreLoader;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.MsgDispacther;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.MouseManager;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.external.ExternalInterface;
    import com.evony.Context;
    import view.ui.TargetCount;
    import com.evony.common.constants.CommonConstants;
    import com.evony.common.server.events.RegisterResponse;
    import com.adobe.crypto.SHA1;
    import com.adobe.crypto.MD5;
    import com.evony.net.client.GameClientEvent;
    import com.evony.util.UIUtil;
    import com.evony.GameConfig;
    import flash.system.Security;
    import view.ui.DemandProgressBar;
    import mx.events.FlexEvent;
    import com.evony.util.JSUtil;
    import view.castle.MainFrame;
    import mx.managers.BrowserManager;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import com.evony.util.MinePopupManager;
    import flash.utils.setTimeout;
    import mx.events.ResizeEvent;
    import flash.events.TimerEvent;
    import flash.net.SharedObject;
    import com.evony.common.server.events.LoginResponse;
    import com.evony.client.action.ActionFactory;
    import view.ui.HolidayTips;
    import com.evony.Lang;
    import com.evony.net.client.ErrorVersionEvent;
    import flash.display.BitmapData;
    import flash.net.URLVariables;
    import mx.graphics.codec.JPEGEncoder;
    import flash.utils.ByteArray;
    import flash.net.URLRequestMethod;
    import flash.events.ContextMenuEvent;
    import com.evony.common.server.events.ConnectionLost;
    import flash.net.LocalConnection;
    import flash.display.DisplayObject;
    import com.evony.events.TryGameEvent;
    import flash.ui.ContextMenuItem;
    import mx.styles.StyleManager;
    import com.evony.events.RegisterEvent;
    import flash.events.ProgressEvent;
    import com.evony.events.MainWinInitEnd;
    import com.evony.common.module.common.CreatePlayerResponse;
    import com.evony.events.LoginEvent;
    import com.evony.util.ResourceLoader;
    import flash.media.SoundMixer;
    import com.evony.common.beans.PlayerBean;
    import flash.ui.ContextMenuBuiltInItems;
    import com.evony.common.server.events.UnregisteredCreatePlayerResponse;
    import com.evony.client.response.ResponseDispatcher;
    import view.module.guide.GuideStep;
    import com.evony.EvonyVersion;
    import com.evony.SenderImpl;
    import com.evony.events.ReplayEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class EvonyClient extends Application 
    {

        private static const MAXWIDTH:Number = 1920;
        private static const MAXHEIGHT:Number = 1200;
        private static const MINWIDTH:Number = 0x0400;
        private static const MINHEIGHT:Number = 600;
        private static const GetFriendTime:Number = 5000;
        public static const EVENT_DISCONNECT:String = "EvonyClient.disconnent";
        private static const FUNCTION_REFRESH:String = ((("document.insertScript = function ()" + "{ ") + "window.location.reload();") + "}");
        public static var password:String;
        private static var _1625418852isTryUser:Boolean = false;
        public static var isTryGame:Boolean = false;
        public static var newComer:Boolean = false;
        mx_internal static var _EvonyClient_StylesInit_done:Boolean = false;
        private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();

        private var _197617279debuginfo:TextArea;
        private var _1394968007miniLoadingUI:UIComponent;
        public var isOutLogin:Boolean;
        private var mainWinComp:MainWin;
        private var userInfo:String;
        public var friendFbuid:String;
        private var ip:String;
        private var disconnectFlag:Boolean = false;
        private var faceVisitObj:Object = null;
        private var _2062065512backgroundProgressBar:BackgroundProgressBar;
        private var isConnectLosted:Boolean;
        private var iReconnCount:int = 0;
        private var faceObj:Object = null;
        private var miniLoadingSwf:*;
        private var isLogin:Boolean;
        private var myContextMenu:ContextMenu;
        private var sex:int = 0;
        public var iLoginError:int = 0;
        public var iLoginOk:int = 0;
        private var iPortReconnCount:int = 0;
        private var newLoginObj:Object = null;
        public var bLoginPtFlag:Boolean = false;
        private var createPlayerComp:CreatPlayerPanel;
        private var kingName:String;
        private var loginPanelComp:LoginPanel;
        private var client:GameClient;
        private var username:String;
        private var ip2:String;
        private var isRegister:Boolean;
        private var strEncryptParam:String;
        private var _1411081733appWin:Canvas;
        private var miniLoginMovie:MovieClip;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Application,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"appWin",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "percentWidth":100,
                                "percentHeight":100,
                                "x":0,
                                "y":0
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":BackgroundProgressBar,
                        "id":"backgroundProgressBar",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"visible":false});
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"debuginfo",
                        "stylesFactory":function ():void
                        {
                            this.fontFamily = "Arial";
                            this.textAlign = "left";
                            this.fontSize = 10;
                            this.fontStyle = "normal";
                            this.color = 0xFF0000;
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":400,
                                "height":40,
                                "alpha":0.1,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":UIComponent,
                        "id":"miniLoadingUI",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        }
                    })]});
            }
        });
        private var _1606231269Miniloading:Class = EvonyClient_Miniloading;
        private var portTimer:Timer = new Timer(15000, 0);
        private var delayInitTimer:Timer = new Timer(100);
        private var preLoader:DemandPreLoader = new DemandPreLoader();

        public function EvonyClient()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundGradientColors = [2207438, 1523567];
                this.backgroundColor = 1523567;
                this.modalTransparencyColor = 0;
                this.modalTransparency = 0.25;
            };
            (mx_internal::_EvonyClient_StylesInit());
            this.layout = "absolute";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.styleName = "myfont";
            this.historyManagementEnabled = false;
            this.addEventListener("creationComplete", ___EvonyClient_Application1_creationComplete);
            this.addEventListener("resize", ___EvonyClient_Application1_resize);
        }

        public static function logout():void
        {
            MsgDispacther.getInstance().dispatchEvent(new Event(EVENT_DISCONNECT));
        }

        public static function get staticEventDispatcher():IEventDispatcher
        {
            return (_staticBindingEventDispatcher);
        }

        [Bindable(event="propertyChange")]
        public static function get isTryUser():Boolean
        {
            return (EvonyClient._1625418852isTryUser);
        }

        public static function set isTryUser(_arg_1:Boolean):void
        {
            var _local_3:IEventDispatcher;
            var _local_2:Object = EvonyClient._1625418852isTryUser;
            if (_local_2 !== _arg_1)
            {
                EvonyClient._1625418852isTryUser = _arg_1;
                _local_3 = EvonyClient.staticEventDispatcher;
                if (_local_3 != null)
                {
                    _local_3.dispatchEvent(PropertyChangeEvent.createUpdateEvent(EvonyClient, "isTryUser", _local_2, _arg_1));
                };
            };
        }


        private function onRegisterResponse(_arg_1:RegisterResponse):void
        {
            var _local_2:String;
            var _local_3:Object;
            MouseManager.setNormal();
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.stopLoginMovie();
                trace(_arg_1.errorMsg);
                AlertWin.show(_arg_1.errorMsg);
                client.disconnection();
                iLoginError = 1;
                return;
            };
            iLoginError = 0;
            if (ExternalInterface.available)
            {
                _local_2 = this.username;
                Context.getInstance().userName = this.username;
                Context.getInstance().password = password;
                _local_3 = {
                    "txn":(new Date().valueOf() + Math.random()),
                    "exts":(("" + _local_2) + ";ingame")
                };
                ExternalInterface.call("adt_log", "evony", null, _local_3);
            };
            TargetCount.clickCount(TargetCount.REGISTER_LOGIN_OWNER);
            if (!isOutLogin)
            {
                this.loginOrRegister(CommonConstants.LOGIN_CMD);
                isOutLogin = false;
            }
            else
            {
                this.loginOrRegister(CommonConstants.LOGIN_CMD);
                isOutLogin = true;
            };
            trace("register success and login");
        }

        private function loginOrRegister(_arg_1:String):void
        {
            var _local_2:Object = new Object();
            _local_2[CommonConstants.LOGIN_PARAM_USER] = this.username;
            Context.getInstance().userName = this.username;
            if (_arg_1 == CommonConstants.LOGIN_CMD)
            {
                if (bLoginPtFlag)
                {
                    _local_2[CommonConstants.LOGIN_PARAM_PASSWORD] = password;
                }
                else
                {
                    _local_2[CommonConstants.LOGIN_PARAM_PASSWORD] = SHA1.hash(password);
                };
            };
            if (_arg_1 == CommonConstants.REGISTER)
            {
                if (bLoginPtFlag)
                {
                    _local_2[CommonConstants.LOGIN_PARAM_PASSWORD] = ((password + "=") + password);
                }
                else
                {
                    _local_2[CommonConstants.LOGIN_PARAM_PASSWORD] = ((SHA1.hash(password) + "=") + MD5.hash(password));
                };
                MouseManager.setBusy();
            };
            client.sendMessage(_arg_1, _local_2);
        }

        public function set debuginfo(_arg_1:TextArea):void
        {
            var _local_2:Object = this._197617279debuginfo;
            if (_local_2 !== _arg_1)
            {
                this._197617279debuginfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "debuginfo", _local_2, _arg_1));
            };
        }

        private function initOnErrorListener():void
        {
            var onError:Function;
            onError = function (_arg_1:GameClientEvent):void
            {
                MouseManager.setNormal();
                if (iLoginError == 0)
                {
                    OnSocketError();
                };
                stopLinking();
                stopLoginMovie();
            };
            client.addEventListener(GameClientEvent.ON_ERROR, onError);
        }

        private function OnSocketError():void
        {
            UIUtil.loadFile(GameConfig.instance.CheckServerStateUrl, loadOk, loadError);
        }

        private function init():void
        {
            miniLoadingSwf = new Miniloading();
            miniLoginMovie = (miniLoadingSwf as MovieClip);
            miniLoadingUI.addChild(miniLoginMovie);
            this.playLoginMovie();
            Security.allowDomain("*.evony.com");
            DemandProgressBar.singleton().addEventListener(FlexEvent.CREATION_COMPLETE, onDemandProgressBarCreateComplete);
            this.addChild(DemandProgressBar.singleton());
            JSUtil.getInstance().AddFbDataCallback();
        }

        private function removeLoginPnel():Boolean
        {
            var _local_1:Boolean;
            if (ExternalInterface.available)
            {
                _local_1 = ExternalInterface.call("isShowFlashLogin");
            };
            return (_local_1);
        }

        private function setTitle():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("SetIeTitle", "Evony-Free forever");
            };
        }

        private function onDemandLoad():void
        {
            this.initMainPanel(Context.getInstance().getPlayerBean());
        }

        private function onUpdateMapVisible():void
        {
            if (((!(MainFrame.instance == null)) && (!(MainFrame.instance.mapWin == null))))
            {
                if ((((MainFrame.instance.mapWin.initialized == true) && (MainFrame.instance.mapWin == MainFrame.instance.currentView)) && (MainFrame.instance.mapWin.visible == true)))
                {
                    if (((!(MainFrame.instance.mapWin.worldMap == null)) && (MainFrame.instance.mapWin.worldMap.initialized == true)))
                    {
                        MainFrame.instance.mapWin.worldMap.updateVisibleTiles();
                    };
                };
            };
        }

        private function setupConfig(_arg_1:Object):void
        {
            GameConfig.instance.config(_arg_1);
            this.calls();
            if (this.getOutVariable())
            {
                this.outLoginStart();
                return;
            };
            this.flshIsReady();
            var _local_2:* = "";
            if (ExternalInterface.available)
            {
                _local_2 = ExternalInterface.call("getPageUrl");
            };
            if (_local_2 == null)
            {
                _local_2 = ("" + BrowserManager.getInstance().url);
            };
            var _local_3:String = getParamByName(_local_2, "loginid");
            if (((!(_local_3 == null)) && (!(_local_3.length == 0))))
            {
                trace(("strParam:" + _local_3));
                onHomePageLogin(_local_3, false);
                return;
            };
            _local_3 = getParamByName(_local_2, "reconn");
            if (((!(_local_3 == null)) && (!(_local_3.length == 0))))
            {
                onHomePageLogin(_local_3, true);
                return;
            };
            if (!this.removeLoginPnel())
            {
                if (GameConfig.instance.debugMode)
                {
                    trace("call addLoginPanel");
                    this.addLoginPanel();
                }
                else
                {
                    navigateToURL(new URLRequest(GameConfig.instance.homePage), "_parent");
                };
            };
        }

        private function loadConfigError():void
        {
            throw (new Error("unable load config2.xml"));
        }

        public function errorHandler(_arg_1:IOErrorEvent):void
        {
            trace(("IOErrorEvent" + _arg_1));
        }

        private function MICHandler(_arg_1:Event):void
        {
            trace("初始化成功!");
            stopLoginMovie();
        }

        private function onAppResize(_arg_1:ResizeEvent):void
        {
            if (((this.createPlayerComp) && (createPlayerComp.visible)))
            {
                this.panelResize(createPlayerComp);
            };
            if (((this.mainWinComp) && (mainWinComp.visible)))
            {
                doResizeLimited();
                mainWinComp.recalcPopupCenter();
            };
            MinePopupManager.instance.onAppResize();
            setTimeout(onUpdateMapVisible, 1000);
        }

        private function initConnectionLostListener():void
        {
            var onConnectionLost:Function;
            onConnectionLost = function (_arg_1:GameClientEvent):void
            {
                var _local_2:Timer;
                MinePopupManager.instance.removePopup();
                if (!disconnectFlag)
                {
                    if (!isConnectLosted)
                    {
                        _local_2 = new Timer(60000, 0);
                        _local_2.addEventListener(TimerEvent.TIMER, ReconnectTimeHandle);
                        _local_2.start();
                        if (iLoginError == 0)
                        {
                            OnSocketError();
                        };
                    }
                    else
                    {
                        isConnectLosted = false;
                    };
                }
                else
                {
                    afterConnectLost(true);
                };
                disconnectFlag = false;
                stopLinking();
            };
            client.addEventListener(GameClientEvent.ON_CONNECTION_LOST, onConnectionLost);
        }

        private function onLoginResponse(_arg_1:LoginResponse):void
        {
            var _local_2:SharedObject;
            var _local_3:Array;
            trace((" loginResponse:ok=" + _arg_1.ok));
            MouseManager.setNormal();
            iLoginError = 0;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = SharedObject.getLocal("userInfo", "/");
                _local_2.data.OneAccountRecorded = "true";
                TargetCount.clickCount(TargetCount.LOGIN_OWNER);
                Context.getInstance().setPlayerBean(_arg_1.player);
                preLoader.forceDemandLoaded(onDemandLoad);
                iLoginOk = 1;
                iLoginError = 2;
            }
            else
            {
                if (_arg_1.ok == LoginResponse.LOGIN_RESULT_NEED_CREATE_PLAYER)
                {
                    newComer = true;
                    if (this.isOutLogin != true)
                    {
                        this.kingName = "liangzhixian_dany";
                    };
                    if (this.sex == 0)
                    {
                        ActionFactory.getInstance().getCommonCommands().createNewPlayer(this.kingName, this.sex, "images/icon/player/faceA8.jpg", "Flag", "City Name", int((Math.random() * 15)), friendFbuid);
                    }
                    else
                    {
                        ActionFactory.getInstance().getCommonCommands().createNewPlayer(this.kingName, this.sex, "images/icon/player/faceB1.jpg", "Flag", "City Name", int((Math.random() * 15)), friendFbuid);
                    };
                    return;
                };
                if (_arg_1.ok == -100)
                {
                    this.stopLoginMovie();
                    HolidayTips.show(this);
                    _local_3 = new Array();
                    _local_3 = _arg_1.msg.split(",");
                    HolidayTips.instance.setRemainTime(_local_3[0], _local_3[1], _local_3[2]);
                }
                else
                {
                    this.stopLoginMovie();
                    AlertWin.show(_arg_1.errorMsg, onLoginErrorClick);
                    iLoginError = 1;
                };
            };
        }

        private function onErrorVersion(event:ErrorVersionEvent):void
        {
            var onOk:Function;
            onOk = function (_arg_1:Boolean):void
            {
                refreshPage();
            };
            MouseManager.setNormal();
            AlertWin.show(Lang.msg("版本低的提示"), onOk, "Ok", null);
            stopLoginMovie();
            this.disconnectFlag = true;
        }

        public function set backgroundProgressBar(_arg_1:BackgroundProgressBar):void
        {
            var _local_2:Object = this._2062065512backgroundProgressBar;
            if (_local_2 !== _arg_1)
            {
                this._2062065512backgroundProgressBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundProgressBar", _local_2, _arg_1));
            };
        }

        private function onConnection(_arg_1:GameClientEvent):void
        {
            var _local_2:Object;
            if (this.faceObj != null)
            {
                client.sendMessage(CommonConstants.LOGIN_FB_CMD, faceObj);
            }
            else
            {
                if (faceVisitObj != null)
                {
                    client.sendMessage(CommonConstants.LOGIN_VISITOR, faceVisitObj);
                }
                else
                {
                    if (newLoginObj != null)
                    {
                        client.sendMessage(CommonConstants.LOGIN_NEW_CMD, newLoginObj);
                    }
                    else
                    {
                        if (isLogin)
                        {
                            loginOrRegister(CommonConstants.LOGIN_CMD);
                            isLogin = false;
                            trace("is login");
                        }
                        else
                        {
                            if (isRegister)
                            {
                                loginOrRegister(CommonConstants.REGISTER);
                                isRegister = false;
                                trace("is register");
                            }
                            else
                            {
                                if (isTryGame)
                                {
                                    trace("is trygame");
                                    _local_2 = new Object();
                                    client.sendMessage(CommonConstants.LOGIN_PLAY_WITHOUT_RIGISTRATION_CMD, _local_2);
                                }
                                else
                                {
                                    outLogin();
                                    trace("is outLogin");
                                };
                            };
                        };
                    };
                };
            };
        }

        private function Reconnect(_arg_1:Boolean):void
        {
            var _local_2:String;
            var _local_3:String;
            if (_arg_1 == false)
            {
                refreshPage();
            }
            else
            {
                _local_2 = (("document.insertScript = function ()" + "{ if(self.location.href.indexOf('?reconn=')==-1){") + "window.location=self.location.href");
                if (username.length > 0)
                {
                    _local_2 = (_local_2 + "+'?reconn=");
                    _local_3 = "username=";
                    _local_3 = ((_local_3 + username) + "&password=");
                    _local_3 = ((_local_3 + password) + "&ip=");
                    _local_3 = (_local_3 + ip);
                    trace(_local_3);
                    EncryptParam(_local_3);
                    trace(strEncryptParam);
                    _local_2 = (_local_2 + strEncryptParam);
                    _local_2 = (_local_2 + "'}else{window.location=self.location.href}}");
                    trace(_local_2);
                };
                if (ExternalInterface.available)
                {
                    ExternalInterface.call(_local_2);
                }
                else
                {
                    addLoginPanel();
                };
            };
        }

        public function getParamByName(_arg_1:String, _arg_2:String):String
        {
            var _local_5:int;
            var _local_3:* = (_arg_2 + "=");
            var _local_4:int = _arg_1.indexOf(_local_3, 0);
            if (_local_4 >= 0)
            {
                if (_local_4 > 0)
                {
                    if (((!(_arg_1.charAt((_local_4 - 1)) == "&")) && (!(_arg_1.charAt((_local_4 - 1)) == "?"))))
                    {
                        if (_arg_1.indexOf(_local_3, (_local_4 + 1)) > 0)
                        {
                            return (getParamByName(_arg_1.substr((_local_4 + 1)), _arg_2));
                        };
                        return ("");
                    };
                };
                _local_4 = (_local_4 + _local_3.length);
                _local_5 = _arg_1.indexOf("&", _local_4);
                if (_local_5 < 0)
                {
                    _local_5 = _arg_1.length;
                };
                return (_arg_1.substr(_local_4, (_local_5 - _local_4)));
            };
            return ("");
        }

        private function Submitbug(_arg_1:ContextMenuEvent):void
        {
            if (MainWin.instance.fbBar.visible)
            {
                MainWin.instance.fbBar.visible = false;
                MainWin.instance.removeChild(MainWin.instance.fbBar);
            };
            var _local_2:BitmapData = new BitmapData(EvonyClient(Application.application).width, EvonyClient(Application.application).height, false);
            _local_2.draw(EvonyClient(Application.application));
            var _local_3:URLVariables = new URLVariables();
            var _local_4:JPEGEncoder = new JPEGEncoder();
            var _local_5:ByteArray = new ByteArray();
            _local_5 = _local_4.encode(_local_2);
            var _local_6:* = "";
            var _local_7:int;
            while (_local_7 < _local_5.length)
            {
                if (int(_local_5[_local_7]) < 16)
                {
                    _local_6 = (_local_6 + "0");
                };
                _local_6 = (_local_6 + _local_5[_local_7].toString(16));
                _local_7++;
            };
            _local_3.bmpdata = _local_6;
            var _local_8:URLRequest = new URLRequest();
            _local_8.url = ((("http://helpspot.evony.com/bugReport.php?SID=" + GameConfig.instance.serverID) + "&UID=") + Context.getInstance().userName);
            _local_8.method = URLRequestMethod.POST;
            _local_8.data = _local_3;
            navigateToURL(_local_8, "_blank");
        }

        private function addCreatePlayer():void
        {
            this.clearAllComp();
            if (this.createPlayerComp == null)
            {
                this.createPlayerComp = new CreatPlayerPanel();
                createPlayerComp.addEventListener(FlexEvent.CREATION_COMPLETE, panelCreated);
            };
            this.appWin.addChild(this.createPlayerComp);
            stopLoginMovie();
        }

        [Bindable(event="propertyChange")]
        public function get miniLoadingUI():UIComponent
        {
            return (this._1394968007miniLoadingUI);
        }

        private function onConnectionLostResponse(_arg_1:ConnectionLost):void
        {
            this.isConnectLosted = true;
            if (_arg_1.reasonCode == ConnectionLost.KICK_BY_OTHER)
            {
                AlertWin.show(Lang.msg("被人挤下线"), afterConnectLost, "Ok", null);
            }
            else
            {
                if (_arg_1.reasonCode == ConnectionLost.KICK_BY_SERVER)
                {
                    AlertWin.show(Lang.msg("被服务器踢下线"), afterConnectLost, "Ok", null);
                }
                else
                {
                    if (_arg_1.reasonCode == ConnectionLost.SERVER_MAINTAIN)
                    {
                        AlertWin.show(Lang.msg("服务器维护"), afterConnectLost, "Ok", null);
                    }
                    else
                    {
                        if (_arg_1.reasonCode == ConnectionLost.SERVER_SHUTDOWN)
                        {
                            AlertWin.show(Lang.msg("服务器正在关闭"), afterConnectLost, "Ok", null);
                        }
                        else
                        {
                            if (_arg_1.reasonCode == ConnectionLost.SERVER_START)
                            {
                                AlertWin.show(Lang.msg("服务器正在启动"), afterConnectLost, "Ok", null);
                            }
                            else
                            {
                                AlertWin.show(_arg_1.msg, afterConnectLost, "Ok", null);
                            };
                        };
                    };
                };
            };
            stopLinking();
            stopLoginMovie();
        }

        private function stopLinking():void
        {
            Context.getInstance().isLink = false;
        }

        private function EncryptParam(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:int;
            strEncryptParam = "";
            while (_local_3 < _arg_1.length)
            {
                _local_2 = _arg_1.charCodeAt(_local_3);
                strEncryptParam = (strEncryptParam + _local_2.toString(16));
                _local_3++;
            };
        }

        private function clearAllComp():void
        {
            if (this.mainWinComp != null)
            {
                this.appWin.removeChild(mainWinComp);
                this.mainWinComp = null;
            };
            if (this.loginPanelComp != null)
            {
                this.appWin.removeChild(loginPanelComp);
                this.loginPanelComp = null;
            };
            if (this.createPlayerComp != null)
            {
                this.appWin.removeChild(createPlayerComp);
                this.createPlayerComp = null;
            };
            try
            {
                new LocalConnection().connect("evony");
                new LocalConnection().connect("evony");
            }
            catch(e)
            {
            };
        }

        private function panelCreated(_arg_1:FlexEvent):void
        {
            _arg_1.currentTarget.removeEventListener(FlexEvent.CREATION_COMPLETE, panelCreated);
            panelResize((_arg_1.currentTarget as DisplayObject));
        }

        public function ___EvonyClient_Application1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function tryGame(_arg_1:TryGameEvent):void
        {
            resetLoading();
            this.ip = _arg_1.ip;
            this.ip2 = _arg_1.ip;
            isTryGame = _arg_1.isTryGame;
            GameConfig.instance.serverIp = _arg_1.ip;
            trace(("EvonyClient.tryGame(): ServerIP=" + _arg_1.ip));
            client.connection(_arg_1.ip, GameConfig.instance.serverPort);
        }

        private function addCustomMenuItems():void
        {
            var _local_1:ContextMenuItem = new ContextMenuItem(Lang.msg("收藏夹"));
            myContextMenu.customItems.push(_local_1);
            _local_1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, selectHandler);
            var _local_2:ContextMenuItem = new ContextMenuItem("Submit Comments with screen capture highlighting mouse pointer location!");
            myContextMenu.customItems.push(_local_2);
            _local_2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Submitbug);
        }

        mx_internal function _EvonyClient_StylesInit():void
        {
            var _local_1:CSSStyleDeclaration;
            var _local_2:Array;
            if (mx_internal::_EvonyClient_StylesInit_done)
            {
                return;
            };
            mx_internal::_EvonyClient_StylesInit_done = true;
            var _local_3:* = StyleManager;
            (_local_3.mx_internal::initProtoChainRoots());
        }

        private function doRegister(_arg_1:RegisterEvent):void
        {
            this.username = _arg_1.username;
            password = _arg_1.password;
            this.isRegister = _arg_1.register;
            Context.getInstance().userName = _arg_1.username;
            Context.getInstance().password = _arg_1.password;
            if (!this.client.isConnectioned())
            {
                trace(("evonyClient.doLogin(): ServerIP=" + _arg_1.ip));
                client.connection(_arg_1.ip, GameConfig.instance.serverPort);
            }
            else
            {
                this.loginOrRegister(CommonConstants.REGISTER);
            };
        }

        private function sendToPage(_arg_1:String):void
        {
            this.userInfo = _arg_1;
            if (!this.client.isConnectioned())
            {
                trace(("evonyClient.doOutLogin(): ServerIP=" + GameConfig.instance.serverIp));
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
            }
            else
            {
                outLogin();
            };
        }

        private function onHomePageLogin(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String;
            var _local_13:String;
            var _local_14:String;
            var _local_15:Object;
            var _local_16:String;
            var _local_17:String;
            var _local_18:String;
            var _local_19:String;
            playLoginMovie();
            trace(("strParam:" + _arg_1));
            var _local_3:String = DecryptUrl(_arg_1);
            trace(("strDecryptParam:" + _local_3));
            Context.getInstance().fbUrl = _local_3;
            MouseManager.setBusy();
            if (_local_3.indexOf("&pt=1") != -1)
            {
                bLoginPtFlag = true;
            };
            var _local_4:String = getParamByName(_local_3, "type");
            trace(("param:" + _local_3));
            if (((_local_4 == "facebook") || (_local_4 == "fbUprising")))
            {
                _local_5 = getParamByName(_local_3, "fbuid");
                _local_6 = getParamByName(_local_3, "expires");
                _local_7 = getParamByName(_local_3, "session_key");
                _local_8 = getParamByName(_local_3, "ss");
                _local_9 = getParamByName(_local_3, "user");
                _local_10 = getParamByName(_local_3, "uid");
                _local_11 = getParamByName(_local_3, "secret");
                this.sex = int(getParamByName(_local_3, "sex"));
                _local_12 = getParamByName(_local_3, "fb_sig");
                Context.getInstance().fbType = _local_4;
                Context.getInstance().taskId = getParamByName(_local_3, "QuestID");
                Context.getInstance().taskXY = getParamByName(_local_3, "Coordinate");
                Context.getInstance().voteUserName = getParamByName(_local_3, "VLord");
                friendFbuid = getParamByName(_local_3, "FriendFbuid");
                _local_13 = getParamByName(_local_3, "access_token");
                _local_14 = getParamByName(_local_3, "base_domain");
                this.isLogin = false;
                this.username = _local_5;
                _local_15 = new Object();
                _local_15[CommonConstants.LOGIN_PARAM_USER] = this.username;
                _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = ("expires=" + _local_6);
                if (((!(_local_11 == null)) && (_local_11.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_15[CommonConstants.LOGIN_PARAM_PASSWORD] + ("secret=" + _local_11));
                };
                _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_15[CommonConstants.LOGIN_PARAM_PASSWORD] + ("session_key=" + _local_7));
                if (((!(_local_8 == null)) && (_local_8.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_15[CommonConstants.LOGIN_PARAM_PASSWORD] + ("ss=" + _local_8));
                };
                if (((!(_local_9 == null)) && (_local_9.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_15[CommonConstants.LOGIN_PARAM_PASSWORD] + ("user=" + _local_9));
                };
                trace(("uid=" + _local_10));
                if (((!(_local_10 == null)) && (_local_10.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (_local_15[CommonConstants.LOGIN_PARAM_PASSWORD] + ("uid=" + _local_10));
                };
                if (((!(_local_14 == null)) && (_local_14.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (("base_domain=" + _local_14) + _local_15[CommonConstants.LOGIN_PARAM_PASSWORD]);
                };
                if (((!(_local_13 == null)) && (_local_13.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = (("access_token=" + _local_13) + _local_15[CommonConstants.LOGIN_PARAM_PASSWORD]);
                };
                _local_15[CommonConstants.LOGIN_SSO_PARAM] = _local_12;
                trace(("user:" + _local_15[CommonConstants.LOGIN_PARAM_USER]));
                trace(("pwd:" + _local_15[CommonConstants.LOGIN_PARAM_PASSWORD]));
                trace(("fbsig:" + _local_15[CommonConstants.LOGIN_SSO_PARAM]));
                Context.getInstance().facebookNickName = getParamByName(_local_3, "fbname");
                if (Context.getInstance().facebookNickName == "")
                {
                    if (ExternalInterface.available)
                    {
                        Context.getInstance().facebookNickName = ExternalInterface.call("facebook.fb_getUserName");
                    };
                };
                Context.getInstance().userName = this.username;
                faceObj = _local_15;
                Context.getInstance().facebookUser = true;
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
                return;
            };
            if (_local_4 == "fbVisit")
            {
                Context.getInstance().bVisitor = true;
                _local_5 = getParamByName(_local_3, "fbuid");
                _local_6 = getParamByName(_local_3, "expires");
                _local_7 = getParamByName(_local_3, "session_key");
                _local_8 = getParamByName(_local_3, "ss");
                _local_9 = getParamByName(_local_3, "user");
                _local_10 = getParamByName(_local_3, "uid");
                _local_11 = getParamByName(_local_3, "secret");
                _local_12 = getParamByName(_local_3, "fb_sig");
                _local_16 = getParamByName(_local_3, "TargetFbuid");
                Context.getInstance().TargetFbuid = _local_16;
                Context.getInstance().bVisitHostName = getParamByName(_local_3, "TargetFbUserName");
                Context.getInstance().VisitSelfSID = getParamByName(_local_3, "FromServer");
                _local_13 = getParamByName(_local_3, "access_token");
                _local_14 = getParamByName(_local_3, "base_domain");
                this.isLogin = false;
                this.username = _local_5;
                _local_15 = new Object();
                _local_15[CommonConstants.LOGIN_PARAM_VISITOR_ID] = this.username;
                _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = ("expires=" + _local_6);
                if (((!(_local_11 == null)) && (_local_11.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (_local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] + ("secret=" + _local_11));
                };
                _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (_local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] + ("session_key=" + _local_7));
                if (((!(_local_8 == null)) && (_local_8.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (_local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] + ("ss=" + _local_8));
                };
                if (((!(_local_9 == null)) && (_local_9.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (_local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] + ("user=" + _local_9));
                };
                if (((!(_local_10 == null)) && (_local_10.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (_local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] + ("uid=" + _local_10));
                };
                if (((!(_local_14 == null)) && (_local_14.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (("base_domain=" + _local_14) + _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD]);
                };
                if (((!(_local_13 == null)) && (_local_13.length > 0)))
                {
                    _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD] = (("access_token=" + _local_13) + _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD]);
                };
                _local_15[CommonConstants.LOGIN_PARAM_VISITOR_SIG] = _local_12;
                _local_15[CommonConstants.LOGIN_PARAM_HOST_ID] = _local_16;
                trace(("user:" + _local_15[CommonConstants.LOGIN_PARAM_VISITOR_ID]));
                trace(("pwd:" + _local_15[CommonConstants.LOGIN_PARAM_VISITOR_PWD]));
                trace(("fbsig:" + _local_15[CommonConstants.LOGIN_PARAM_VISITOR_SIG]));
                Context.getInstance().facebookNickName = getParamByName(_local_3, "fbname");
                if (Context.getInstance().facebookNickName == "")
                {
                    if (ExternalInterface.available)
                    {
                        Context.getInstance().facebookNickName = ExternalInterface.call("facebook.fb_getUserName");
                    };
                };
                Context.getInstance().userName = this.username;
                faceVisitObj = _local_15;
                Context.getInstance().facebookUser = true;
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
                return;
            };
            if (_local_4 == "newLogin")
            {
                _local_17 = getParamByName(_local_3, "account");
                _local_5 = getParamByName(_local_3, "fbuid");
                _local_6 = getParamByName(_local_3, "expires");
                _local_7 = getParamByName(_local_3, "session_key");
                _local_8 = getParamByName(_local_3, "ss");
                _local_9 = getParamByName(_local_3, "user");
                _local_10 = getParamByName(_local_3, "uid");
                _local_11 = getParamByName(_local_3, "secret");
                _local_12 = getParamByName(_local_3, "sig");
                _local_18 = getParamByName(_local_3, "isfacebook");
                _local_19 = getParamByName(_local_3, "choose");
                _local_13 = getParamByName(_local_3, "access_token");
                _local_14 = getParamByName(_local_3, "base_domain");
                this.isLogin = false;
                this.username = _local_17;
                if (_local_17 == "")
                {
                    this.username = _local_5;
                };
                _local_15 = new Object();
                _local_15[CommonConstants.LOGIN_PARAM_USER] = _local_17;
                _local_15[CommonConstants.LOGIN_PARAM_FBUID] = _local_5;
                _local_15[CommonConstants.LOGIN_PARAM_PASSWORD] = _local_3;
                _local_15[CommonConstants.LOGIN_PARAM_SIG] = _local_12;
                trace(("user:" + _local_15[CommonConstants.LOGIN_PARAM_USER]));
                trace(("pwd:" + _local_15[CommonConstants.LOGIN_PARAM_PASSWORD]));
                trace(("fbsig:" + _local_15[CommonConstants.LOGIN_PARAM_SIG]));
                Context.getInstance().facebookNickName = getParamByName(_local_3, "fbname");
                if (Context.getInstance().facebookNickName == "")
                {
                    if (ExternalInterface.available)
                    {
                        Context.getInstance().facebookNickName = ExternalInterface.call("facebook.fb_getUserName");
                    };
                };
                Context.getInstance().userName = this.username;
                newLoginObj = _local_15;
                if (((!(_local_5 == null)) && (!(_local_5 == ""))))
                {
                    Context.getInstance().facebookUser = true;
                };
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
                return;
            };
            if (_local_4 == "tryGame")
            {
                isTryGame = true;
                resetLoading();
                this.ip = GameConfig.instance.serverIp;
                this.ip2 = GameConfig.instance.serverIp;
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
                return;
            };
            this.username = getParamByName(_local_3, "username");
            password = getParamByName(_local_3, "password");
            this.ip = GameConfig.instance.serverIp;
            if (_arg_2)
            {
                this.ip = getParamByName(_local_3, "ip");
            };
            this.isLogin = true;
            Context.getInstance().userName = this.username;
            this.clearAllComp();
            if (_local_3.indexOf("&reg=1") > 0)
            {
                this.isRegister = true;
                this.isLogin = false;
            };
            client.connection(this.ip, GameConfig.instance.serverPort);
        }

        private function refreshPage():void
        {
            if (GameConfig.instance.debugMode == false)
            {
                navigateToURL(new URLRequest(GameConfig.instance.homePage), "_parent");
                return;
            };
            if (ExternalInterface.available)
            {
                ExternalInterface.call(FUNCTION_REFRESH);
            }
            else
            {
                addLoginPanel();
            };
        }

        public function progressHandler(_arg_1:ProgressEvent):void
        {
            trace(((("ProgressEvent" + _arg_1.bytesLoaded) + ":") + _arg_1.bytesTotal));
        }

        private function outLoginStart():void
        {
            playLoginMovie();
            if (!this.client.isConnectioned())
            {
                trace(("evonyClient.doOutLogin(): ServerIP=" + GameConfig.instance.serverIp));
                client.connection(GameConfig.instance.serverIp, GameConfig.instance.serverPort);
            }
            else
            {
                this.outLogin();
            };
        }

        private function loadOk(_arg_1:Object):void
        {
            var _local_2:String = _arg_1.toString();
            if (_local_2 == "E01")
            {
                AlertWin.show(Lang.msg("掉线的提示"), onLoginErrorClick, "Ok", "Cancel", null);
            }
            else
            {
                AlertWin.show(Lang.msg("服务器维护"), onLoginErrorClick, "Ok", "Cancel", null);
            };
        }

        public function set miniLoadingUI(_arg_1:UIComponent):void
        {
            var _local_2:Object = this._1394968007miniLoadingUI;
            if (_local_2 !== _arg_1)
            {
                this._1394968007miniLoadingUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "miniLoadingUI", _local_2, _arg_1));
            };
        }

        private function onResize(_arg_1:Event):void
        {
            doResizeLimited();
        }

        private function replayGame(_arg_1:Event):void
        {
            refreshPage();
        }

        public function doResizeLimited():void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_1:Number = mainWinComp.scaleX;
            if (!(((this.height < MINHEIGHT) || (this.width < MINWIDTH)) || ((this.width > MAXWIDTH) && (this.height > MAXHEIGHT))))
            {
                traceErrorMessage(((("scale this " + this.width) + " x ") + this.height));
                trace(((("scale this " + this.width) + " x ") + this.height));
                mainWinComp.scaleX = (mainWinComp.scaleY = 1);
                mainWinComp.width = this.width;
                mainWinComp.height = this.height;
                if (mainWinComp.width > MAXWIDTH)
                {
                    mainWinComp.width = MAXWIDTH;
                };
                if (mainWinComp.height > MAXHEIGHT)
                {
                    mainWinComp.height = MAXHEIGHT;
                };
            }
            else
            {
                traceErrorMessage(((("zoom this " + this.width) + " x ") + this.height));
                trace(((("zoom this " + this.width) + " x ") + this.height));
                _local_2 = (this.width / this.height);
                if (_local_2 > (MAXWIDTH / MINHEIGHT))
                {
                    _local_2 = (MAXWIDTH / MINHEIGHT);
                };
                if (_local_2 < (MINWIDTH / MAXHEIGHT))
                {
                    _local_2 = (MINWIDTH / MAXHEIGHT);
                };
                if (((this.width < MINWIDTH) || (this.height < MINHEIGHT)))
                {
                    if ((MINWIDTH / _local_2) >= MINHEIGHT)
                    {
                        _local_3 = MINWIDTH;
                        _local_4 = (MINWIDTH / _local_2);
                    }
                    else
                    {
                        _local_4 = MINHEIGHT;
                        _local_3 = (MINHEIGHT * _local_2);
                    };
                }
                else
                {
                    if ((MAXWIDTH / _local_2) <= MAXHEIGHT)
                    {
                        _local_3 = MAXWIDTH;
                        _local_4 = (MAXWIDTH / _local_2);
                    }
                    else
                    {
                        _local_4 = MAXHEIGHT;
                        _local_3 = (MAXHEIGHT * _local_2);
                    };
                };
                _local_5 = (this.width / _local_3);
                _local_6 = (this.height / _local_4);
                if (_local_6 < _local_5)
                {
                    _local_5 = _local_6;
                };
                trace(("scale1: " + _local_5));
                mainWinComp.scaleX = (mainWinComp.scaleY = _local_5);
                mainWinComp.width = (_local_3 * _local_5);
                mainWinComp.height = (_local_4 * _local_5);
                trace(((((((("resize: lwr:" + _local_2) + " lwrr") + ((MAXWIDTH / _local_2) > MAXHEIGHT)) + " width:") + mainWinComp.width) + " height:") + mainWinComp.height));
            };
            mainWinComp.width = ((mainWinComp.width / mainWinComp.scaleX) * _local_1);
            mainWinComp.height = ((mainWinComp.height / mainWinComp.scaleX) * _local_1);
        }

        private function flshIsReady():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("setFlashIsReady", true);
            };
        }

        private function doScale():void
        {
            var _local_1:Number = (this.width / this.height);
            if (_local_1 > (MAXWIDTH / MINHEIGHT))
            {
                _local_1 = (MAXWIDTH / MINHEIGHT);
            };
            if (_local_1 < (MINWIDTH / MAXHEIGHT))
            {
                _local_1 = (MINWIDTH / MAXHEIGHT);
            };
            if (((this.width < MINWIDTH) || (this.height < MINHEIGHT)))
            {
                if ((MINWIDTH / _local_1) >= MINHEIGHT)
                {
                    mainWinComp.width = MINWIDTH;
                    mainWinComp.height = (MINWIDTH / _local_1);
                }
                else
                {
                    mainWinComp.height = MINHEIGHT;
                    mainWinComp.width = (MINHEIGHT * _local_1);
                };
            }
            else
            {
                if ((MAXWIDTH / _local_1) <= MAXHEIGHT)
                {
                    mainWinComp.width = MAXWIDTH;
                    mainWinComp.height = (MAXWIDTH / _local_1);
                }
                else
                {
                    mainWinComp.height = MAXHEIGHT;
                    mainWinComp.width = (MAXHEIGHT * _local_1);
                };
            };
            var _local_2:Number = (this.width / mainWinComp.width);
            var _local_3:Number = (this.height / mainWinComp.height);
            if (_local_3 < _local_2)
            {
                _local_2 = _local_3;
            };
            trace(("scale: " + _local_2));
            mainWinComp.width = (mainWinComp.width * _local_2);
            mainWinComp.height = (mainWinComp.height * _local_2);
            mainWinComp.autoLayout = true;
        }

        [Bindable(event="propertyChange")]
        public function get debuginfo():TextArea
        {
            return (this._197617279debuginfo);
        }

        private function addMainWin():void
        {
            this.clearAllComp();
            if (this.mainWinComp == null)
            {
                this.mainWinComp = new MainWin();
            };
            this.appWin.addChild(this.mainWinComp);
            this.mainWinComp.addEventListener(MainWinInitEnd.INIT_COMP, MICHandler);
            var _local_1:int = Context.getInstance().getPlayerBean().playerInfo.userId;
            if ((((Context.getInstance().facebookUser) && ((_local_1 % 10) == 3)) && ((_local_1 % 100) >= 50)))
            {
                GetFbFriendList();
            };
        }

        private function onCreatePlayer(_arg_1:CreatePlayerResponse):void
        {
            var _local_2:int = _arg_1.ok;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                TargetCount.clickCount(TargetCount.REGISTER_LOGIN_OWNER);
                TargetCount.clickCount(TargetCount.CREATE_PLAYER_COUNT);
                Context.getInstance().userIsFirstLogin = true;
                Context.getInstance().setPlayerBean(_arg_1.player);
                preLoader.forceDemandLoaded(onDemandLoad);
            }
            else
            {
                if (_arg_1.ok == CreatePlayerResponse.CREATE_RESULT_HAVE_CREATED)
                {
                    AlertWin.show(Lang.msg("创建新玩家等待进入提示"));
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function doRestore():void
        {
            if (!(((this.height < MINHEIGHT) || (this.width < MINWIDTH)) || ((this.width > MAXWIDTH) && (this.height > MAXHEIGHT))))
            {
                mainWinComp.width = this.width;
                mainWinComp.height = this.height;
                if (mainWinComp.width > MAXWIDTH)
                {
                    mainWinComp.width = MAXWIDTH;
                };
                if (mainWinComp.height > MAXHEIGHT)
                {
                    mainWinComp.height = MAXHEIGHT;
                };
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function checkNeedQuestGuide():void
        {
            if (GameConfig.instance.strAbTestFlag == "false")
            {
                Context.getInstance().need_QuestGuid = true;
                return;
            };
            if ((((Context.getInstance().getPlayerBean().playerInfo.userId > 0) && ((Context.getInstance().getPlayerBean().playerInfo.userId % 10) == 5)) && ((Context.getInstance().getPlayerBean().playerInfo.userId % 100) >= 50)))
            {
                Context.getInstance().need_QuestGuid = true;
            };
        }

        private function onChangeName():void
        {
        }

        public function playLoginMovie():void
        {
            if (miniLoginMovie)
            {
                miniLoginMovie.gotoAndPlay(1);
                miniLoginMovie.visible = true;
            };
        }

        private function addLoginPanel():void
        {
            stopLoginMovie();
            this.clearAllComp();
            if (this.loginPanelComp == null)
            {
                this.loginPanelComp = new LoginPanel();
                loginPanelComp.addEventListener(TryGameEvent.TRYGAME, tryGame);
                loginPanelComp.addEventListener(LoginEvent.EVENT_NAME, doLogin);
                loginPanelComp.addEventListener(RegisterEvent.EVENT_NAME, doRegister);
                loginPanelComp.addEventListener(FlexEvent.CREATION_COMPLETE, panelCreated);
            };
            this.appWin.addChild(loginPanelComp);
            loginPanelComp.playLoginMovie();
        }

        public function uploadCompleteHandler(_arg_1:Event):void
        {
        }

        public function restartGame():void
        {
            var _local_2:String;
            var _local_1:* = (("document.insertScript = function ()" + "{ ") + "window.location=self.location.href");
            if (username.length > 0)
            {
                _local_1 = (_local_1 + "+'?reconn=");
                _local_2 = "username=";
                _local_2 = ((_local_2 + username) + "&password=");
                _local_2 = ((_local_2 + password) + "&ip=");
                _local_2 = (_local_2 + this.ip2);
                _local_2 = (_local_2 + "&reg=1");
                trace(_local_2);
                EncryptParam(_local_2);
                trace(strEncryptParam);
                _local_1 = (_local_1 + strEncryptParam);
                _local_1 = (_local_1 + "'}");
                trace(_local_1);
            };
            if (ExternalInterface.available)
            {
                ExternalInterface.call(_local_1);
            }
            else
            {
                addLoginPanel();
            };
        }

        private function initMainPanel(_arg_1:PlayerBean):void
        {
            var _local_2:String;
            ResourceLoader.loadResource("fla/dynamic/ui234.swf", "", null, ResourceLoader.LOAD_DEMAND);
            if (loginPanelComp != null)
            {
                loginPanelComp.stopLoginMovie();
            };
            Context.getInstance().setPlayerBean(_arg_1);
            checkNeedGuide();
            checkNeedQuestGuide();
            checkBuildWithHelp();
            if ((((Context.getInstance().getPlayerBean().playerInfo.userId % 10) == 5) && ((Context.getInstance().getPlayerBean().playerInfo.userId % 100) < 50)))
            {
                ExternalInterface.call("loadUPScript");
            };
            if (Context.getInstance().getCurCastle() == null)
            {
                AlertWin.show("castle data error.");
            }
            else
            {
                delayInitTimer.addEventListener(TimerEvent.TIMER, delayStartHandler);
                _local_2 = ExternalInterface.call("getClientSize");
                if (_local_2 == "1-1")
                {
                    ExternalInterface.call("_FLL", "size:1-1");
                    delayInitTimer.start();
                }
                else
                {
                    ExternalInterface.call("_FLL", "size:normal");
                    this.addMainWin();
                };
            };
            SoundMixer.stopAll();
            Context.getInstance().isLink = true;
        }

        private function removeDefaultItems():void
        {
            myContextMenu.hideBuiltInItems();
            var _local_1:ContextMenuBuiltInItems = myContextMenu.builtInItems;
            _local_1.print = false;
        }

        private function doLogin(_arg_1:LoginEvent):void
        {
            resetLoading();
            playLoginMovie();
            MouseManager.setBusy();
            this.username = _arg_1.username;
            password = _arg_1.password;
            this.ip = _arg_1.ip;
            this.ip2 = _arg_1.ip;
            this.isLogin = _arg_1.isLogin;
            Context.getInstance().userName = _arg_1.username;
            Context.getInstance().password = _arg_1.password;
            GameConfig.instance.serverIp = _arg_1.ip;
            trace(("EvonyClient.doLogin(): ServerIP=" + _arg_1.ip));
            client.connection(_arg_1.ip, GameConfig.instance.serverPort);
        }

        private function initConnectListener():void
        {
            client.addEventListener(GameClientEvent.ON_CONNECTION, onConnection);
        }

        [Bindable(event="propertyChange")]
        public function get backgroundProgressBar():BackgroundProgressBar
        {
            return (this._2062065512backgroundProgressBar);
        }

        private function delayStartHandler(_arg_1:TimerEvent):void
        {
            var _local_2:String = ExternalInterface.call("getClientSize");
            if (GameConfig.instance.debugMode)
            {
                _local_2 = "100%-100%";
            };
            if (_local_2 == "100%-100%")
            {
                ExternalInterface.call("_FLL", "size:100%-100%");
                this.addMainWin();
                delayInitTimer.stop();
            };
        }

        private function selectHandler(_arg_1:ContextMenuEvent):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("addFavorite");
            };
        }

        private function checkBuildWithHelp():void
        {
            if (Context.getInstance().needUserGuide)
            {
                return;
            };
            if (GameConfig.instance.strAbTestFlag == "false")
            {
                Context.getInstance().isBuildHelp = true;
                return;
            };
            var _local_1:int = Context.getInstance().getPlayerBean().playerInfo.userId;
            if (Context.getInstance().facebookUser)
            {
                if ((((_local_1 > 0) && ((_local_1 % 10) == 6)) && ((_local_1 % 100) >= 50)))
                {
                    Context.getInstance().isBuildHelp = true;
                    return;
                };
            };
        }

        private function initLogoutListener():void
        {
            var onLogout:Function;
            onLogout = function (_arg_1:Event):void
            {
                disconnectFlag = true;
                client.disconnection();
                stopLinking();
            };
            MsgDispacther.getInstance().addEventListener(EVENT_DISCONNECT, onLogout);
        }

        private function onDemandProgressBarCreateComplete(_arg_1:Event):void
        {
            if (this.contains(DemandProgressBar.singleton()))
            {
                this.removeChild(DemandProgressBar.singleton());
            };
            ResourceLoader.onDemandBackgroundProgressFunc = this.backgroundProgressBar.updateProgress;
            ResourceLoader.onDemandProgressFunc = DemandProgressBar.singleton().updateProgress;
            preLoader.addEventListener(Event.COMPLETE, onPreLoaderComplete);
            preLoader.load();
        }

        private function afterConnectLost(_arg_1:Boolean):void
        {
            refreshPage();
        }

        [Bindable(event="propertyChange")]
        private function get Miniloading():Class
        {
            return (this._1606231269Miniloading);
        }

        private function onCreatTryPlayer(_arg_1:UnregisteredCreatePlayerResponse):void
        {
            playLoginMovie();
            isTryUser = true;
            JSUtil.getInstance().exitGameSet(true);
            JSUtil.getInstance().AddExitGameCallback();
            var _local_2:int = _arg_1.ok;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().userIsFirstLogin = true;
                Context.getInstance().setPlayerBean(_arg_1.player);
                preLoader.forceDemandLoaded(onDemandLoad);
            }
            else
            {
                if (_arg_1.ok == CreatePlayerResponse.CREATE_RESULT_HAVE_CREATED)
                {
                    AlertWin.show(Lang.msg("创建新玩家等待进入提示"));
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function initSockerDataListener():void
        {
            var onExtensionResponseHandle:Function;
            onExtensionResponseHandle = function (_arg_1:GameClientEvent):void
            {
                ResponseDispatcher.getInstance().dispatch(_arg_1.cmd, _arg_1.data);
            };
            client.addEventListener(GameClientEvent.ON_EXTENSION_RESPONSE, onExtensionResponseHandle);
        }

        private function getOutVariable():String
        {
            if (ExternalInterface.available)
            {
                this.userInfo = ExternalInterface.call("getGuid");
                if (userInfo == null)
                {
                    return (this.userInfo);
                };
            };
            return (this.userInfo);
        }

        private function GetFbFriendList():void
        {
            var _local_1:* = "";
            if (ExternalInterface.available)
            {
                _local_1 = ExternalInterface.call("getFbFriendListByJs");
                if (_local_1 == "nofriendlistyet")
                {
                    setTimeout(GetFbFriendList, GetFriendTime);
                }
                else
                {
                    if (_local_1 == "connection timeout")
                    {
                        return;
                    };
                    this.splistFbList(_local_1);
                };
            };
        }

        public function ___EvonyClient_Application1_resize(_arg_1:ResizeEvent):void
        {
            onAppResize(_arg_1);
        }

        private function DecryptUrl(_arg_1:String):String
        {
            var _local_2:int;
            var _local_3:int;
            var _local_6:int;
            var _local_4:* = "";
            var _local_5:ByteArray = new ByteArray();
            while (_local_6 < (_arg_1.length / 2))
            {
                if (((_arg_1.charAt((2 * _local_6)) == "#") || (_arg_1.charAt((2 * _local_6)) == "&"))) break;
                if (((_arg_1.charAt((2 * _local_6)) >= "0") && (_arg_1.charAt((2 * _local_6)) <= "9")))
                {
                    _local_2 = Number(_arg_1.substr((2 * _local_6), 1));
                }
                else
                {
                    if (((_arg_1.charAt((2 * _local_6)) == "a") || (_arg_1.charAt((2 * _local_6)) == "A")))
                    {
                        _local_2 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt((2 * _local_6)) == "b") || (_arg_1.charAt((2 * _local_6)) == "B")))
                        {
                            _local_2 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt((2 * _local_6)) == "c") || (_arg_1.charAt((2 * _local_6)) == "C")))
                            {
                                _local_2 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt((2 * _local_6)) == "d") || (_arg_1.charAt((2 * _local_6)) == "D")))
                                {
                                    _local_2 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt((2 * _local_6)) == "e") || (_arg_1.charAt((2 * _local_6)) == "E")))
                                    {
                                        _local_2 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt((2 * _local_6)) == "f") || (_arg_1.charAt((2 * _local_6)) == "F")))
                                        {
                                            _local_2 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                if (((_arg_1.charAt(((2 * _local_6) + 1)) >= "0") && (_arg_1.charAt(((2 * _local_6) + 1)) <= "9")))
                {
                    _local_3 = Number(_arg_1.substr(((2 * _local_6) + 1), 1));
                }
                else
                {
                    if (((_arg_1.charAt(((2 * _local_6) + 1)) == "a") || (_arg_1.charAt(((2 * _local_6) + 1)) == "A")))
                    {
                        _local_3 = 10;
                    }
                    else
                    {
                        if (((_arg_1.charAt(((2 * _local_6) + 1)) == "b") || (_arg_1.charAt(((2 * _local_6) + 1)) == "B")))
                        {
                            _local_3 = 11;
                        }
                        else
                        {
                            if (((_arg_1.charAt(((2 * _local_6) + 1)) == "c") || (_arg_1.charAt(((2 * _local_6) + 1)) == "C")))
                            {
                                _local_3 = 12;
                            }
                            else
                            {
                                if (((_arg_1.charAt(((2 * _local_6) + 1)) == "d") || (_arg_1.charAt(((2 * _local_6) + 1)) == "D")))
                                {
                                    _local_3 = 13;
                                }
                                else
                                {
                                    if (((_arg_1.charAt(((2 * _local_6) + 1)) == "e") || (_arg_1.charAt(((2 * _local_6) + 1)) == "E")))
                                    {
                                        _local_3 = 14;
                                    }
                                    else
                                    {
                                        if (((_arg_1.charAt(((2 * _local_6) + 1)) == "f") || (_arg_1.charAt(((2 * _local_6) + 1)) == "F")))
                                        {
                                            _local_3 = 15;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                _local_5[_local_6] = ((_local_2 * 16) + _local_3);
                _local_6++;
            };
            _local_4 = _local_5.toString();
            trace(_local_4);
            return (_local_4);
        }

        private function onConnectLost(_arg_1:Event):void
        {
            navigateToURL(new URLRequest(GameConfig.instance.homePage), "_parent");
        }

        private function onLoginErrorClick(_arg_1:Boolean):void
        {
            if (GameConfig.instance.debugMode == false)
            {
                navigateToURL(new URLRequest(GameConfig.instance.homePage), "_parent");
            };
        }

        public function traceErrorMessage(_arg_1:String):void
        {
            if (this.debuginfo != null)
            {
                this.debuginfo.text = (_arg_1 + "\n");
            };
        }

        private function splistFbList(_arg_1:String):void
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:Object;
            var _local_2:int;
            _local_4 = new Array();
            if (_arg_1 != null)
            {
                _local_3 = new Array();
                _local_3 = _arg_1.split(";");
            };
            for each (_local_5 in _local_3)
            {
                _local_6 = new Object();
                _local_4 = _local_5.split(",");
                _local_6.name = _local_4[1];
                _local_6.id = _local_4[0];
                Context.getInstance().FbFriendArr[_local_2] = _local_6;
                _local_2++;
            };
        }

        private function onPreLoaderComplete(_arg_1:Event):void
        {
            PostInit();
        }

        private function panelResize(_arg_1:DisplayObject):void
        {
            var _local_2:Number = (this.width / 1200);
            var _local_3:Number = (this.height / 700);
            if (_local_2 >= _local_3)
            {
                _arg_1.scaleX = _local_3;
                _arg_1.scaleY = _local_3;
            }
            else
            {
                _arg_1.scaleX = _local_2;
                _arg_1.scaleY = _local_2;
            };
        }

        private function set Miniloading(_arg_1:Class):void
        {
            var _local_2:Object = this._1606231269Miniloading;
            if (_local_2 !== _arg_1)
            {
                this._1606231269Miniloading = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Miniloading", _local_2, _arg_1));
            };
        }

        public function refresh():void
        {
            refreshPage();
        }

        private function calls():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("onLogin", sendToPage);
            };
        }

        private function checkNeedGuide():void
        {
            if (Context.getInstance().bVisitor)
            {
                Context.getInstance().needUserGuide = false;
                return;
            };
            if (Context.getInstance().userIsFirstLogin)
            {
                Context.getInstance().getPlayerBean().tutorialStepId = 1000;
                GuideStep.getInstance().setCurrentStep(1000);
            };
            if (((!(Context.getInstance().getPlayerBean().tutorialStepId == 999)) && (!(Context.getInstance().getPlayerBean().tutorialStepId == 0))))
            {
                Context.getInstance().needUserGuide = true;
            };
        }

        private function loadError():void
        {
        }

        private function outLogin():void
        {
            var _local_4:int;
            var _local_5:int;
            trace(("--user.variable--" + this.userInfo));
            this.isOutLogin = true;
            var _local_1:String = DecryptUrl(this.userInfo);
            var _local_2:Array = _local_1.split(/[=&]/);
            MouseManager.setBusy();
            this.username = _local_2[1].toString();
            password = _local_2[3].toString();
            this.kingName = _local_2[7].toString();
            this.sex = int(_local_2[9].toString());
            Context.getInstance().userName = this.username;
            if (_local_2[6].toString() != "king")
            {
                _local_4 = _local_1.indexOf("&pwd=");
                _local_5 = _local_1.indexOf("&subtime=");
                password = _local_1.substring((_local_4 + 5), (_local_5 - 1));
            };
            var _local_3:Object = new Object();
            _local_3[CommonConstants.LOGIN_PARAM_USER] = this.username;
            if (_local_1.indexOf("&pt=1") != -1)
            {
                _local_3[CommonConstants.LOGIN_PARAM_PASSWORD] = ((password + "=") + password);
            }
            else
            {
                _local_3[CommonConstants.LOGIN_PARAM_PASSWORD] = ((SHA1.hash(password) + "=") + MD5.hash(password));
            };
            Context.getInstance().userName = this.username;
            client.sendMessage(CommonConstants.REGISTER, _local_3);
            this.userInfo = null;
        }

        public function stopLoginMovie():void
        {
            if (miniLoginMovie)
            {
                miniLoginMovie.gotoAndStop(1);
                miniLoginMovie.visible = false;
            };
        }

        private function onStageChange(_arg_1:Event):void
        {
            var _local_2:int = 1;
        }

        private function PostInit():void
        {
            client = new GameClient();
            client.setVersion(EvonyVersion.VERSION);
            ActionFactory.getInstance().setSender(new SenderImpl(client));
            client.addEventListener(ErrorVersionEvent.ERROR_VERSION, onErrorVersion);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_CREATE_NEW_PLAYER, onCreatePlayer);
            ResponseDispatcher.getInstance().onLoginResponse = onLoginResponse;
            ResponseDispatcher.getInstance().onRegisterResponse = onRegisterResponse;
            ResponseDispatcher.getInstance().onConnectionLost = onConnectionLostResponse;
            ResponseDispatcher.getInstance().addEventListener(ReplayEvent.REPLAYGAME, replayGame);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_UNREGISTERED_CREATE_PLAYER_RESPONSE, onCreatTryPlayer);
            this.initLogoutListener();
            this.initOnErrorListener();
            this.initSockerDataListener();
            this.initConnectionLostListener();
            this.initConnectListener();
            this.regFunctionCloseWeb();
            UIUtil.loadFile("config2.xml", setupConfig, loadConfigError);
            this.systemManager.stage.addEventListener(Event.RESIZE, onStageChange);
            setTitle();
            myContextMenu = new ContextMenu();
            removeDefaultItems();
            addCustomMenuItems();
            this.contextMenu = myContextMenu;
            if (GameConfig.instance.securityCross != null)
            {
                Security.loadPolicyFile(GameConfig.instance.securityCross);
            };
        }

        private function ReconnectTimeHandle(_arg_1:TimerEvent):void
        {
            Reconnect(true);
        }

        private function resetLoading():void
        {
        }

        private function Javascript_IsFirstLogin():Boolean
        {
            if (Context.getInstance().isLink)
            {
                return (Context.getInstance().userIsFirstLogin);
            };
            return (false);
        }

        private function regFunctionCloseWeb():void
        {
            if (ExternalInterface.available)
            {
                try
                {
                    ExternalInterface.addCallback("As_IsFirstLogin", Javascript_IsFirstLogin);
                }
                catch(e:Error)
                {
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get appWin():Canvas
        {
            return (this._1411081733appWin);
        }

        public function set appWin(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1411081733appWin;
            if (_local_2 !== _arg_1)
            {
                this._1411081733appWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "appWin", _local_2, _arg_1));
            };
        }


    }
}//package 

