// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ChatFrame

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import view.ui.CallPrivaterWin;
    import mx.containers.VBox;
    import view.ui.FlagSelectWin;
    import mx.core.UIComponentDescriptor;
    import com.evony.Context;
    import com.evony.GameConfig;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.MsgDispacther;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.server.events.PrivateChatMessage;
    import com.evony.data.ChatContentData;
    import flash.system.Capabilities;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.KeyboardEvent;
    import flash.events.TimerEvent;
    import com.evony.util.UIUtil;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.common.ChatResponse;
    import com.evony.common.server.events.AllianceChatMsg;
    import mx.controls.TextInput;
    import mx.events.ToolTipEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.events.FlagChangeEvent;
    import mx.core.IToolTip;
    import mx.managers.ToolTipManager;
    import mx.core.Application;
    import com.evony.common.server.events.ChannelChatMsg;
    import com.evony.common.constants.CommonConstants;
    import flash.utils.getDefinitionByName;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    import com.evony.common.beans.ItemBean;
    import view.ui.AlertWin;
    import flash.external.ExternalInterface;
    import mx.utils.StringUtil;
    import view.ui.AlertWinEx;
    import com.evony.common.server.events.SystemInfoMsg;
    import mx.events.FlexEvent;
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

    public class ChatFrame extends Canvas implements IBindingClient 
    {

        public static var instance:ChatFrame;
        private static const OTHER_WIN_CALL:String = "otherWinCall";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1221062641allianceContainUI:Button;
        private var _1914909430worldContainUI:Button;
        private var preWord:String;
        private var upOrDownCount:int = 0;
        private var _1248263182beginerContainUI:Button;
        private var _888791483isProtect:Boolean = true;
        private var _824765353callPrivateWin:CallPrivaterWin;
        private var _1613568517flagIcon:String;
        private var _2146551993chatBtnBox:VBox;
        private var eachTextHeight:int;
        private var lan:int = 0;
        private var _210036532flagSelectWin:FlagSelectWin;
        private var _1437412018chatType:String = "world";
        private var isCanReceive:Boolean = false;
        private var isTimeTooShort:Boolean = false;
        private var iSysMessCount:int = 0;
        private var _894276359isPrivate:Boolean = false;
        private var zoomSizeType:int = 1;
        private var isTheBottom:Boolean = true;
        private var _1774241829privateContainUI:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"chatBtnBox",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.bottom = "2";
                            this.verticalGap = 2;
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":26,
                                "height":150,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"privateContainUI",
                                    "events":{
                                        "click":"__privateContainUI_click",
                                        "toolTipShown":"__privateContainUI_toolTipShown"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ChatButton3"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"allianceContainUI",
                                    "events":{
                                        "click":"__allianceContainUI_click",
                                        "toolTipShown":"__allianceContainUI_toolTipShown"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ChatButton4"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"worldContainUI",
                                    "events":{
                                        "click":"__worldContainUI_click",
                                        "toolTipShown":"__worldContainUI_toolTipShown"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ChatButton5"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"beginerContainUI",
                                    "events":{
                                        "click":"__beginerContainUI_click",
                                        "toolTipShown":"__beginerContainUI_toolTipShown"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ChatButton6"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":CallPrivaterWin,
                        "id":"callPrivateWin",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":50,
                                "y":0,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":FlagSelectWin,
                        "id":"flagSelectWin",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "27";
                            this.left = "98";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"visible":false});
                        }
                    })]});
            }
        });
        private var _2095657228playerName:String = Context.getInstance().getPlayerBean().playerInfo.userName;
        private var _1844846000newHere:Boolean = Context.getInstance().userIsFirstLogin;
        private var _653794720multiLan:Boolean = GameConfig.instance.multiLanguage;
        private var _30202497isCanMute:int = Context.getInstance().getPlayerBean().playerInfo.bdenyotherplayer;
        private var _1651375127tellRecordArray:ArrayCollection = new ArrayCollection();
        private var _1605977137world_chatHtmlMsg:String = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
        private var _1428911122union_chatHtmlMsg:String = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
        private var _1429410654private_chatHtmlMsg:String = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
        private var _491443630starter_chatHtmlMsg:String = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
        private var _1405750475newHereTip:String = (("<b><font color='#0042e9'>" + Lang.msg("语言按钮")) + "</font></b>");
        private var _1801970088comboData:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("世界"),
            "data":"world"
        }, {
            "label":Lang.msg("联盟"),
            "data":"alliance"
        }]);
        private var _399699879TButtonBarDataP:ArrayCollection = new ArrayCollection([{"iconStr":"../images/EmbedImages/chat/WhispersNormal.gif"}, {"iconStr":"../images/EmbedImages/chat/UnionNormal.gif"}, {"iconStr":"../images/EmbedImages/chat/WorldNormal.png"}]);
        private var spaceSentTimer:Timer = new Timer(10000);
        private var saveTextStrTimer:Timer = new Timer(1000);
        private var beginnerNoticeTimer:Timer = new Timer(300000);
        private var scrollTimer:Timer = new Timer(10, 1);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ChatFrame()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 0;
            };
            this.autoLayout = true;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___ChatFrame_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ChatFrame._watcherSetupUtil = _arg_1;
        }

        public static function onOtherWinCall():void
        {
            MsgDispacther.getInstance().dispatchEvent(new Event(OTHER_WIN_CALL));
        }


        [Bindable(event="propertyChange")]
        private function get isPrivate():Boolean
        {
            return (this._894276359isPrivate);
        }

        public function set allianceContainUI(_arg_1:Button):void
        {
            var _local_2:Object = this._1221062641allianceContainUI;
            if (_local_2 !== _arg_1)
            {
                this._1221062641allianceContainUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceContainUI", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get flagIcon():String
        {
            return (this._1613568517flagIcon);
        }

        [Bindable(event="propertyChange")]
        private function get union_chatHtmlMsg():String
        {
            return (this._1428911122union_chatHtmlMsg);
        }

        private function onPrivateCharMsg(_arg_1:PrivateChatMessage):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:String;
            var _local_8:String;
            if (_arg_1.chatType == PrivateChatMessage.NORMAL_CHAT)
            {
                if (((!((_arg_1.fromUser as String) == playerName)) && (chatAcept(_arg_1.fromUser))))
                {
                    _local_2 = replaceString(_arg_1.fromUser);
                    _local_3 = _arg_1.ownitemid;
                    _local_4 = replaceString(_arg_1.msg);
                    _local_5 = new Date().getHours();
                    _local_6 = new Date().getMinutes();
                    _local_7 = ((((('[<u><b><a href="' + "event:") + _local_2) + '">') + _local_2) + "</a></b></u>] ");
                    if (_local_3 == 7)
                    {
                        _local_4 = ((((((("[Staff]&lt;" + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + Lang.msg("{0}对你说", _local_7)) + ": ") + _local_4);
                    }
                    else
                    {
                        _local_4 = ((((((("[Whisper]&lt;" + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + Lang.msg("{0}对你说", _local_7)) + ": ") + _local_4);
                    };
                    ChatContentData.instance._worldChatList = (("<font color='#ff00ea' >" + _local_4) + "</font>");
                    ChatContentData.instance._privateChatList = (("<font color='#ff00ea' >" + _local_4) + "</font>");
                    ChatContentData.instance._unionChatList = (("<font color='#ff00ea' >" + _local_4) + "</font>");
                    ChatContentData.instance._starterChatList = (("<font color='#ff00ea' >" + _local_4) + "</font>");
                    world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
                    private_chatHtmlMsg = ChatContentData.instance.privateChatList.toArray().join("\n");
                    union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
                    starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
                };
            };
            if (_arg_1.chatType == PrivateChatMessage.GM_CHAT)
            {
                _local_2 = replaceString(_arg_1.fromUser);
                _local_8 = ((("[<u><b><a>" + _local_2) + "</a></b></u>]: ") + _arg_1.msg);
                ChatContentData.instance._worldChatList = (("<font color='#ff0000' >" + _local_8) + "</font>");
                ChatContentData.instance._privateChatList = (("<font color='#ff0000' >" + _local_8) + "</font>");
                ChatContentData.instance._unionChatList = (("<font color='#ff0000' >" + _local_8) + "</font>");
                world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
                private_chatHtmlMsg = ChatContentData.instance.privateChatList.toArray().join("\n");
                union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
                ChatContentData.instance._starterChatList = (("<font color='#ff0000' >" + _local_8) + "</font>");
                starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            };
            showChatText();
        }

        private function set flagIcon(_arg_1:String):void
        {
            var _local_2:Object = this._1613568517flagIcon;
            if (_local_2 !== _arg_1)
            {
                this._1613568517flagIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get playerName():String
        {
            return (this._2095657228playerName);
        }

        private function set isCanMute(_arg_1:int):void
        {
            var _local_2:Object = this._30202497isCanMute;
            if (_local_2 !== _arg_1)
            {
                this._30202497isCanMute = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanMute", _local_2, _arg_1));
            };
        }

        private function autoSelectLan():void
        {
            this.changeFlag(Capabilities.language);
        }

        private function init():void
        {
            if (instance != null)
            {
                return;
            };
            instance = this;
            initClass();
            if (multiLan)
            {
                autoSelectLan();
            }
            else
            {
                this.lan = 0;
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_WORLD_CHAT_MSG, onWorldCharMsg);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_PRIVATE_CHAT_MESSAGE, onPrivateCharMsg);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ALLIANCE_CHAT_MSG, onAllianceCharMsg);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CHANNEL_CHAT_MSG, onChannelCharMsg);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG, onServerSystemInfoMsg);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_PRIVATE_CHAT, onPrivateCharMsgResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_ALLIANCE_CHAT, onAllianceCharMsgResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_WORLD_CHAT, onWorldCharMsgResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_CHANNEL_CHAT, onStartCharResponse);
            this.addEventListener(KeyboardEvent.KEY_DOWN, onSendMsg);
            this.flagSelectWin.addEventListener("FlagChangeEvent", onChangeFlag);
            MsgDispacther.getInstance().addEventListener(OTHER_WIN_CALL, onOtherWinCall);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_PLAYER_LOGIN, onPlayerLogin);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CITY_MODIFY_USER_NAME, onPlayerChangeName);
            tellRecordArray = ChatContentData.instance.tallRecordArr;
            spaceSentTimer.stop();
            spaceSentTimer.addEventListener(TimerEvent.TIMER, onCanSend);
            saveTextStrTimer.addEventListener(TimerEvent.TIMER, onSendTextStr);
            isProtect = ((!(UIUtil.checkOffice())) && (UIUtil.judgeTime() < 7));
            if (isProtect)
            {
                this.chatType = "starter";
            }
            else
            {
                this.chatType = "world";
            };
            beginnerNoticeTimer.addEventListener(TimerEvent.TIMER, onbeginnerNotice);
            beginnerNoticeTimer.start();
            scrollTimer.addEventListener(TimerEvent.TIMER, onScroll);
        }

        private function isWorldLimit(_arg_1:String):Boolean
        {
            if (((chatType == "world") || (chatType == "starter")))
            {
                return (true);
            };
            if (((chatType == "private") && (!(isPrivate))))
            {
                return (true);
            };
            return (false);
        }

        private function set isPrivate(_arg_1:Boolean):void
        {
            var _local_2:Object = this._894276359isPrivate;
            if (_local_2 !== _arg_1)
            {
                this._894276359isPrivate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isPrivate", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get tellRecordArray():ArrayCollection
        {
            return (this._1651375127tellRecordArray);
        }

        public function set playerName(_arg_1:String):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function set worldContainUI(_arg_1:Button):void
        {
            var _local_2:Object = this._1914909430worldContainUI;
            if (_local_2 !== _arg_1)
            {
                this._1914909430worldContainUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "worldContainUI", _local_2, _arg_1));
            };
        }

        private function onStartCharResponse(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.starterChatList, -1);
                ChatContentData.instance._starterChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            };
            showChatText();
        }

        private function onPlayerChangeName(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                playerName = Context.getInstance().getPlayerBean().playerInfo.userName;
                ChatContentData.instance.playerName = this.playerName;
            };
        }

        [Bindable(event="propertyChange")]
        public function get privateContainUI():Button
        {
            return (this._1774241829privateContainUI);
        }

        private function showUnSelectMC():void
        {
            beginerContainUI.enabled = true;
            privateContainUI.enabled = true;
            worldContainUI.enabled = true;
            allianceContainUI.enabled = true;
        }

        private function set tellRecordArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1651375127tellRecordArray;
            if (_local_2 !== _arg_1)
            {
                this._1651375127tellRecordArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tellRecordArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get world_chatHtmlMsg():String
        {
            return (this._1605977137world_chatHtmlMsg);
        }

        [Bindable(event="propertyChange")]
        public function get flagSelectWin():FlagSelectWin
        {
            return (this._210036532flagSelectWin);
        }

        private function onAllianceCharMsg(_arg_1:AllianceChatMsg):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:int;
            if (((!((_arg_1.fromUser as String) == playerName)) && (chatAcept(_arg_1.fromUser))))
            {
                _local_2 = replaceString(_arg_1.fromUser);
                _local_3 = replaceString(_arg_1.msg);
                _local_4 = new Date().getHours();
                _local_5 = new Date().getMinutes();
                _local_6 = _arg_1.ownitemid;
                if (_local_6 == 7)
                {
                    _local_3 = ((((((((((((("[Staff]" + ChatContentData.instance.getChatPic(_local_6)) + "&lt;") + ((_local_4 >= 10) ? _local_4.toString() : ("0" + _local_4.toString()))) + ":") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_2) + '">') + _local_2) + "</a></b></u>]: ") + _local_3);
                }
                else
                {
                    _local_3 = ((((((((((((("[Alliance]" + ChatContentData.instance.getChatPic(_local_6)) + "&lt;") + ((_local_4 >= 10) ? _local_4.toString() : ("0" + _local_4.toString()))) + ":") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_2) + '">') + _local_2) + "</a></b></u>]: ") + _local_3);
                };
                ChatContentData.instance._worldChatList = (("<font color='#0042e9' >" + _local_3) + "</font>");
                ChatContentData.instance._unionChatList = (("<font color='#0042e9' >" + _local_3) + "</font>");
                world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
                union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
                ChatContentData.instance._starterChatList = (("<font color='#0042e9' >" + _local_3) + "</font>");
                starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            };
            showChatText();
        }

        private function onWorldCharMsgResponse(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.worldChatList, -1);
                ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
            };
            showChatText();
        }

        public function onChatInput(_arg_1:Event):void
        {
            var _local_2:int;
            if (TextInput(_arg_1.currentTarget).text.substr(0, 1) == "/")
            {
                _local_2 = _arg_1.currentTarget.text.indexOf(" ", 1);
                if (_local_2 > -1)
                {
                    this.isPrivate = true;
                }
                else
                {
                    this.isPrivate = false;
                };
            }
            else
            {
                isPrivate = false;
            };
        }

        public function __beginerContainUI_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        private function changeFlag(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "fr":
                    this.flagIcon = "Fr";
                    this.lan = 1;
                    break;
                case "de":
                    this.flagIcon = "De";
                    this.lan = 2;
                    break;
                case "pt":
                    this.flagIcon = "Pt";
                    this.lan = 3;
                    break;
                case "es":
                    this.flagIcon = "Es";
                    this.lan = 4;
                    break;
                case "other":
                    this.flagIcon = "...";
                    this.lan = 5;
                    break;
                default:
                    this.flagIcon = "En";
                    this.lan = 0;
            };
            this.flagSelectWin.visible = false;
        }

        private function linkToName(_arg_1:String):void
        {
            MainWin.instance.text_input.text = (("/" + _arg_1) + " ");
            var _local_2:int = MainWin.instance.text_input.text.length;
            MainWin.instance.text_input.setSelection(_local_2, _local_2);
            this.focusManager.setFocus(MainWin.instance.text_input);
        }

        private function set private_chatHtmlMsg(_arg_1:String):void
        {
            var _local_2:Object = this._1429410654private_chatHtmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._1429410654private_chatHtmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "private_chatHtmlMsg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isProtect():Boolean
        {
            return (this._888791483isProtect);
        }

        [Bindable(event="propertyChange")]
        public function get chatBtnBox():VBox
        {
            return (this._2146551993chatBtnBox);
        }

        private function initClass():void
        {
        }

        public function setFocusForWrite():void
        {
            if (this.focusManager != null)
            {
                this.focusManager.setFocus(MainWin.instance.text_input);
            };
        }

        private function noMouseWheel():void
        {
        }

        public function set privateContainUI(_arg_1:Button):void
        {
            var _local_2:Object = this._1774241829privateContainUI;
            if (_local_2 !== _arg_1)
            {
                this._1774241829privateContainUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "privateContainUI", _local_2, _arg_1));
            };
        }

        public function __allianceContainUI_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get comboData():ArrayCollection
        {
            return (this._1801970088comboData);
        }

        private function set newHere(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1844846000newHere;
            if (_local_2 !== _arg_1)
            {
                this._1844846000newHere = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newHere", _local_2, _arg_1));
            };
        }

        public function onFinishInfoMSg(_arg_1:String):void
        {
            ChatContentData.instance._worldChatList = ((((("<font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + "</font>") + _arg_1);
            ChatContentData.instance._starterChatList = ((((("<font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + "</font>") + _arg_1);
            world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
            union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
            starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            showChatText();
        }

        private function tellRecord(_arg_1:String):void
        {
            if (tellRecordArray.length <= 0)
            {
                return;
            };
            var _local_2:* = "";
            if (_arg_1 == "up")
            {
                upOrDownCount--;
                if (upOrDownCount < 0)
                {
                    upOrDownCount = (tellRecordArray.length - 1);
                };
                _local_2 = tellRecordArray[upOrDownCount];
            }
            else
            {
                if (_arg_1 == "down")
                {
                    upOrDownCount++;
                    if (upOrDownCount > (tellRecordArray.length - 1))
                    {
                        upOrDownCount = 0;
                    };
                    _local_2 = tellRecordArray[upOrDownCount];
                };
            };
            var _local_3:int = _local_2.indexOf(" ", 1);
            if (_local_3 != -1)
            {
                MainWin.instance.text_input.text = _local_2;
                MainWin.instance.text_input.setSelection((_local_3 + 1), _local_2.length);
                this.focusManager.setFocus(MainWin.instance.text_input);
            }
            else
            {
                MainWin.instance.text_input.text = _local_2;
                MainWin.instance.text_input.setSelection(0, _local_2.length);
            };
        }

        private function set starter_chatHtmlMsg(_arg_1:String):void
        {
            var _local_2:Object = this._491443630starter_chatHtmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._491443630starter_chatHtmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starter_chatHtmlMsg", _local_2, _arg_1));
            };
        }

        private function set chatType(_arg_1:String):void
        {
            var _local_2:Object = this._1437412018chatType;
            if (_local_2 !== _arg_1)
            {
                this._1437412018chatType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatType", _local_2, _arg_1));
            };
        }

        private function chatAcept(_arg_1:String):Boolean
        {
            var _local_3:int;
            var _local_2:Boolean = true;
            if (Context.getInstance().getPlayerBean().blockBeansArray.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < Context.getInstance().getPlayerBean().blockBeansArray.length)
                {
                    if (_arg_1 == Context.getInstance().getPlayerBean().blockBeansArray[_local_3].userName)
                    {
                        _local_2 = false;
                        break;
                    };
                    _local_3++;
                };
            };
            return (_local_2);
        }

        private function onPrivateCharMsgResponse(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.unionChatList, -1);
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.worldChatList, -1);
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.privateChatList, -1);
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.starterChatList, -1);
                ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                ChatContentData.instance._unionChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                ChatContentData.instance._privateChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                ChatContentData.instance._starterChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
                union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
                private_chatHtmlMsg = ChatContentData.instance.privateChatList.toArray().join("\n");
                starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            };
            showChatText();
        }

        private function onbeginnerNotice(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            beginnerNoticeTimer.stop();
            if (!UIUtil.checkOffice())
            {
                _local_2 = "<b><FONT COLOR='#FF0000'>You can follow the quest to make your Kingdom grow faster and become more prosperous.</font></b>";
                onFinishInfoMSg(_local_2);
                beginnerNoticeTimer.start();
            };
        }

        public function onChange(_arg_1:MouseEvent):void
        {
            if (chatType == "world")
            {
                chatType = "alliance";
                MainWin.instance.chat_HtmlMsg = this.union_chatHtmlMsg;
            }
            else
            {
                if (chatType == "alliance")
                {
                    chatType = "world";
                    if (beginerContainUI.toggle)
                    {
                        chatType = "starter";
                        MainWin.instance.chat_HtmlMsg = this.starter_chatHtmlMsg;
                    }
                    else
                    {
                        MainWin.instance.chat_HtmlMsg = this.world_chatHtmlMsg;
                    };
                }
                else
                {
                    chatType = "world";
                    MainWin.instance.chat_HtmlMsg = this.world_chatHtmlMsg;
                };
            };
        }

        private function set world_chatHtmlMsg(_arg_1:String):void
        {
            var _local_2:Object = this._1605977137world_chatHtmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._1605977137world_chatHtmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "world_chatHtmlMsg", _local_2, _arg_1));
            };
        }

        private function _ChatFrame_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("密语聊天频道，此频道将显示您所有的密语聊天信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                privateContainUI.toolTip = _arg_1;
            }, "privateContainUI.toolTip");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟聊天频道，您可以使用此频道和你所在联盟的联盟成员聊天");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceContainUI.toolTip = _arg_1;
            }, "allianceContainUI.toolTip");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("世界聊天频道，您可以使用此频道和整个服务器的玩家聊天");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                worldContainUI.toolTip = _arg_1;
            }, "worldContainUI.toolTip");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("新手聊天频道，您可以使用此频道和整个服务器的新手玩家聊天");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                beginerContainUI.toolTip = _arg_1;
            }, "beginerContainUI.toolTip");
            result[3] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get callPrivateWin():CallPrivaterWin
        {
            return (this._824765353callPrivateWin);
        }

        private function onChangeFlag(_arg_1:FlagChangeEvent):void
        {
            this.changeFlag(_arg_1.flagStr);
        }

        private function onToolTipShown(_arg_1:ToolTipEvent):void
        {
            var _local_2:IToolTip;
            var _local_3:int;
            var _local_4:int;
            if (ToolTipManager.currentToolTip)
            {
                _local_2 = ToolTipManager.currentToolTip;
                _local_3 = Application.application.width;
                _local_4 = Application.application.height;
                if ((_local_2.x + _local_2.width) > _local_3)
                {
                    _local_2.x = (_local_3 - _local_2.width);
                };
                if ((_local_2.y + _local_2.height) > _local_4)
                {
                    _local_2.y = (_local_4 - _local_2.height);
                };
                if (((_local_2.x == (_local_3 - _local_2.width)) && (_local_2.y == (_local_4 - _local_2.height))))
                {
                    _local_2.x = (_local_2.width - 10);
                };
            };
        }

        private function onBeginnerChatMsg(_arg_1:ChannelChatMsg):void
        {
            var _local_2:String = replaceString(_arg_1.fromUser);
            var _local_3:String = replaceString(_arg_1.msg);
            var _local_4:int = _arg_1.ownitemid;
            var _local_5:Number = new Date().getHours();
            var _local_6:Number = new Date().getMinutes();
            if (_local_4 == 7)
            {
                _local_3 = ((((((((((((("[Staff]" + ChatContentData.instance.getChatPic(_local_4)) + "&lt;") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_2) + '">') + _local_2) + "</a></b></u>]: ") + _local_3);
            }
            else
            {
                _local_3 = ((((((((((((ChatContentData.instance.getChatPic(_local_4) + "&lt;") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_2) + '">') + _local_2) + "</a></b></u>]: ") + _local_3);
            };
            ChatContentData.instance._starterChatList = (("<font color='#000000' >" + _local_3) + "</font>");
            starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            showChatText();
        }

        public function set flagSelectWin(_arg_1:FlagSelectWin):void
        {
            var _local_2:Object = this._210036532flagSelectWin;
            if (_local_2 !== _arg_1)
            {
                this._210036532flagSelectWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagSelectWin", _local_2, _arg_1));
            };
        }

        private function set multiLan(_arg_1:Boolean):void
        {
            var _local_2:Object = this._653794720multiLan;
            if (_local_2 !== _arg_1)
            {
                this._653794720multiLan = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "multiLan", _local_2, _arg_1));
            };
        }

        private function onChannelCharMsg(_arg_1:ChannelChatMsg):void
        {
            if ((((_arg_1.channel == CommonConstants.CHAT_CHANNEL_BEGINNER) && (!((_arg_1.fromUser as String) == playerName))) && (chatAcept(_arg_1.fromUser))))
            {
                if (((Context.getInstance().getCurCastle().zoneId == _arg_1.languageType) || (_arg_1.languageType == 0)))
                {
                    onBeginnerChatMsg(_arg_1);
                };
            }
            else
            {
                if (_arg_1.channel == CommonConstants.CHAT_CHANNEL_WORLD)
                {
                    this.onWorldCharMsg(_arg_1);
                }
                else
                {
                    if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_ALLIANCE)
                    {
                        if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_TRADE)
                        {
                            if (_arg_1.channel == CommonConstants.CHAT_CHANNEL_ZONE)
                            {
                            };
                        };
                    };
                };
            };
        }

        private function set isProtect(_arg_1:Boolean):void
        {
            var _local_2:Object = this._888791483isProtect;
            if (_local_2 !== _arg_1)
            {
                this._888791483isProtect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isProtect", _local_2, _arg_1));
            };
        }

        private function onScroll(_arg_1:TimerEvent):void
        {
            MainWin.instance.text_chat.verticalScrollPosition = MainWin.instance.text_chat.maxVerticalScrollPosition;
        }

        public function set chatBtnBox(_arg_1:VBox):void
        {
            var _local_2:Object = this._2146551993chatBtnBox;
            if (_local_2 !== _arg_1)
            {
                this._2146551993chatBtnBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatBtnBox", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ChatFrame;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ChatFrame_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ChatFrameWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        private function get TButtonBarDataP():ArrayCollection
        {
            return (this._399699879TButtonBarDataP);
        }

        private function onAllianceCharMsgResponse(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.unionChatList, -1);
                ChatContentData.instance.removeIndexItem(ChatContentData.instance.worldChatList, -1);
                ChatContentData.instance._unionChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + _arg_1.errorMsg) + "</font></b>");
                world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
                union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
            };
            showChatText();
        }

        private function onCanSend(_arg_1:TimerEvent):void
        {
            spaceSentTimer.stop();
            isTimeTooShort = false;
        }

        [Bindable(event="propertyChange")]
        private function get private_chatHtmlMsg():String
        {
            return (this._1429410654private_chatHtmlMsg);
        }

        private function onTabBtnBarClickHandle(_arg_1:MouseEvent):void
        {
            showUnSelectMC();
            _arg_1.target.enabled = false;
            switch (_arg_1.target)
            {
                case this.beginerContainUI:
                    chatType = "starter";
                    MainWin.instance.chat_HtmlMsg = this.starter_chatHtmlMsg;
                    MainWin.instance.ChatWorld.selected = false;
                    break;
                case this.privateContainUI:
                    chatType = "private";
                    MainWin.instance.chat_HtmlMsg = this.private_chatHtmlMsg;
                    break;
                case this.allianceContainUI:
                    chatType = "alliance";
                    MainWin.instance.ChatWorld.selected = true;
                    MainWin.instance.chat_HtmlMsg = this.union_chatHtmlMsg;
                    break;
                case this.worldContainUI:
                    chatType = "world";
                    MainWin.instance.ChatWorld.selected = false;
                    MainWin.instance.chat_HtmlMsg = this.world_chatHtmlMsg;
                    break;
            };
            this.isTheBottom = true;
        }

        [Bindable(event="propertyChange")]
        private function get multiLan():Boolean
        {
            return (this._653794720multiLan);
        }

        private function onPlayerLogin(_arg_1:Event):void
        {
            tellRecordArray = new ArrayCollection();
            playerName = Context.getInstance().getPlayerBean().playerInfo.userName;
            ChatContentData.instance.playerName = this.playerName;
            ChatContentData.instance.clearTallList();
            this.world_chatHtmlMsg = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
            this.private_chatHtmlMsg = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
            this.union_chatHtmlMsg = ((((("<b><font color='#ff0000' >" + "[<u>") + Lang.msg("系统提示")) + "</u>]: ") + Lang.msg("提示私聊方法")) + "</font></b>");
            showChatText();
        }

        [Bindable(event="propertyChange")]
        private function get isCanMute():int
        {
            return (this._30202497isCanMute);
        }

        [Bindable(event="propertyChange")]
        private function get chatType():String
        {
            return (this._1437412018chatType);
        }

        public function set callPrivateWin(_arg_1:CallPrivaterWin):void
        {
            var _local_2:Object = this._824765353callPrivateWin;
            if (_local_2 !== _arg_1)
            {
                this._824765353callPrivateWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "callPrivateWin", _local_2, _arg_1));
            };
        }

        public function __worldContainUI_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        private function onOtherWinCall(_arg_1:Event):void
        {
            setFocusForWrite();
        }

        private function set TButtonBarDataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._399699879TButtonBarDataP;
            if (_local_2 !== _arg_1)
            {
                this._399699879TButtonBarDataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TButtonBarDataP", _local_2, _arg_1));
            };
        }

        private function set newHereTip(_arg_1:String):void
        {
            var _local_2:Object = this._1405750475newHereTip;
            if (_local_2 !== _arg_1)
            {
                this._1405750475newHereTip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newHereTip", _local_2, _arg_1));
            };
        }

        private function onSendTextStr(_arg_1:TimerEvent):void
        {
            saveTextStrTimer.stop();
            isCanReceive = false;
            world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
            starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            showChatText();
        }

        [Bindable(event="propertyChange")]
        private function get newHere():Boolean
        {
            return (this._1844846000newHere);
        }

        private function showChatText():void
        {
            switch (this.chatType)
            {
                case "trade":
                    MainWin.instance.chat_HtmlMsg = "";
                    break;
                case "area":
                    MainWin.instance.chat_HtmlMsg = "";
                    break;
                case "starter":
                    MainWin.instance.chat_HtmlMsg = this.starter_chatHtmlMsg;
                    break;
                case "private":
                    MainWin.instance.chat_HtmlMsg = this.private_chatHtmlMsg;
                    break;
                case "alliance":
                    MainWin.instance.chat_HtmlMsg = this.union_chatHtmlMsg;
                    break;
                case "world":
                    MainWin.instance.chat_HtmlMsg = this.world_chatHtmlMsg;
                    break;
            };
            MainWin.instance.text_chat.htmlText = MainWin.instance.chat_HtmlMsg;
            scrollTimer.start();
        }

        [Bindable(event="propertyChange")]
        private function get newHereTip():String
        {
            return (this._1405750475newHereTip);
        }

        public function sayTo(str:String):void
        {
            var l:int;
            var ids:uint;
            var setFocus_Function:Function;
            setFocus_Function = function ():void
            {
                MainWin.instance.text_input.setFocus();
                MainWin.instance.text_input.setSelection(l, l);
                clearTimeout(ids);
            };
            var iIndex:int = str.indexOf(" ");
            if (iIndex >= 0)
            {
                MainWin.instance.text_input.text = (("/'" + str) + "' ");
            }
            else
            {
                MainWin.instance.text_input.text = (("/" + str) + " ");
            };
            l = MainWin.instance.text_input.text.length;
            ids = setTimeout(setFocus_Function, 500);
        }

        private function changeLan():void
        {
            if (this.flagSelectWin.visible)
            {
                this.flagSelectWin.visible = false;
                return;
            };
            this.flagSelectWin.visible = true;
            this.flagSelectWin.dtsShow = true;
            this.flagSelectWin.eglShow = true;
            this.flagSelectWin.ptyShow = true;
            this.flagSelectWin.frcShow = true;
            this.flagSelectWin.espShow = true;
            this.flagSelectWin.otherShow = true;
            switch (this.lan)
            {
                case 1:
                    this.flagSelectWin.frcShow = false;
                    return;
                case 2:
                    this.flagSelectWin.dtsShow = false;
                    return;
                case 3:
                    this.flagSelectWin.ptyShow = false;
                    return;
                case 4:
                    this.flagSelectWin.espShow = false;
                    return;
                case 5:
                    this.flagSelectWin.otherShow = false;
                    return;
                case 0:
                    this.flagSelectWin.eglShow = false;
                    return;
            };
        }

        public function __privateContainUI_click(_arg_1:MouseEvent):void
        {
            onTabBtnBarClickHandle(_arg_1);
        }

        private function onWorldCharMsg(_arg_1:ChannelChatMsg):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:Number;
            if ((_arg_1.fromUser as String) != playerName)
            {
                _local_2 = "";
                if (chatAcept(_arg_1.fromUser))
                {
                    if (((this.lan == _arg_1.languageType) || (_arg_1.languageType == 0)))
                    {
                        _local_3 = replaceString(_arg_1.fromUser);
                        _local_2 = replaceString(_arg_1.msg);
                        _local_4 = _arg_1.ownitemid;
                        _local_5 = new Date().getHours();
                        _local_6 = new Date().getMinutes();
                        if (_local_4 == 7)
                        {
                            _local_2 = ((((((((((((("[Staff]" + ChatContentData.instance.getChatPic(_local_4)) + "&lt;") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_3) + '">') + _local_3) + "</a></b></u>]: ") + _local_2);
                        }
                        else
                        {
                            _local_2 = ((((((((((((("[World]" + ChatContentData.instance.getChatPic(_local_4)) + "&lt;") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_3) + '">') + _local_3) + "</a></b></u>]: ") + _local_2);
                        };
                        if (_arg_1.fromUser.indexOf("Gove") != -1)
                        {
                            ChatContentData.instance._worldChatList = (("<font color='#F05A00' >" + _local_2) + "</font>");
                            ChatContentData.instance._starterChatList = (("<font color='#F05A00' >" + _local_2) + "</font>");
                        }
                        else
                        {
                            if (_local_4 == 7)
                            {
                                ChatContentData.instance._worldChatList = (("<font color='#006600' >" + _local_2) + "</font>");
                                ChatContentData.instance._starterChatList = (("<font color='#006600' >" + _local_2) + "</font>");
                            }
                            else
                            {
                                ChatContentData.instance._worldChatList = (("<font color='#000000' >" + _local_2) + "</font>");
                                ChatContentData.instance._starterChatList = (("<font color='#000000' >" + _local_2) + "</font>");
                            };
                        };
                        if (_local_4 == 8)
                        {
                            _local_2 = ((((((((((((ChatContentData.instance.getChatPic(_local_4) + "&lt;") + ((_local_5 >= 10) ? _local_5.toString() : ("0" + _local_5.toString()))) + ":") + ((_local_6 >= 10) ? _local_6.toString() : ("0" + _local_6.toString()))) + "&gt;") + '[<u><b><a href="') + "event:") + _local_3) + '">') + _local_3) + "</a></b></u>]: ") + _local_2);
                            ChatContentData.instance._worldChatList = (("<font color='#00FF00' >[Staff]</font><font color='#F05A00' >" + _local_2) + "</font>");
                            ChatContentData.instance._starterChatList = (("<font color='#00FF00' >[Staff]</font><font color='#F05A00' >" + _local_2) + "</font>");
                        };
                    };
                };
                if (!isCanReceive)
                {
                    isCanReceive = true;
                    saveTextStrTimer.start();
                };
            };
        }

        public function sendMsg():void
        {
            var _local_2:ItemBean;
            var _local_3:Boolean;
            if (((chatType == "world") || (chatType == "starter")))
            {
                if (((!(isPrivate)) && (!(this.isCanMute == 1))))
                {
                    _local_2 = UIUtil.getItemBeanFromPlayer("consume.1.a");
                    if (((_local_2 == null) || (_local_2.count == 0)))
                    {
                        AlertWin.show(Lang.msg("您没有足够的喇叭在世界频道发言,请到商城购买喇叭."), null);
                        return;
                    };
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameUse", "consume.1.a", "Speaker", "宝物", 3);
                    };
                };
            };
            var _local_1:String = StringUtil.trim(MainWin.instance.text_input.text);
            if (_local_1.length < 1)
            {
                if (chatType == "alliance")
                {
                    ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                    ChatContentData.instance._unionChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                }
                else
                {
                    if (((chatType == "world") || (chatType == "private")))
                    {
                        ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                    }
                    else
                    {
                        if (chatType == "starter")
                        {
                            ChatContentData.instance._starterChatList = (("<b><font color='#848484' >" + Lang.msg("不允许发送空白或空格信息")) + "</font></b>");
                        };
                    };
                };
            }
            else
            {
                _local_3 = isWorldLimit(_local_1);
                if ((((_local_3) && (isTimeTooShort)) && (!(isPrivate))))
                {
                    if (chatType == "starter")
                    {
                        ChatContentData.instance._starterChatList = (("<b><font color='#848484' >" + Lang.msg("新手聊天发送间隔5秒")) + "</font></b>");
                    }
                    else
                    {
                        ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + Lang.msg("聊天发送间隔5秒")) + "</font></b>");
                    };
                }
                else
                {
                    if (((_local_3) && (preWord == _local_1)))
                    {
                        if (chatType == "starter")
                        {
                            ChatContentData.instance._starterChatList = (("<b><font color='#848484' >" + Lang.msg("新手频道聊天内容重复")) + "</font></b>");
                        }
                        else
                        {
                            ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + Lang.msg("聊天内容重复")) + "</font></b>");
                        };
                    }
                    else
                    {
                        if (((_local_3) && (!(isPrivate))))
                        {
                            spaceSentTimer.start();
                            isTimeTooShort = true;
                            preWord = _local_1;
                        };
                        isProtect = ((!(UIUtil.checkOffice())) && (UIUtil.judgeTime() < 7));
                        if (((isProtect) && (chatType == "world")))
                        {
                            ChatContentData.instance._worldChatList = (("<b><font color='#848484' >" + Lang.msg("新手不能在世界频道聊天")) + "</font></b>");
                        }
                        else
                        {
                            if (chatType == "starter")
                            {
                                ChatContentData.instance.sendMes(MainWin.instance.text_input.text, chatType, 0);
                            }
                            else
                            {
                                ChatContentData.instance.sendMes(MainWin.instance.text_input.text, chatType, 0);
                            };
                        };
                    };
                };
            };
            MainWin.instance.text_input.text = "";
            upOrDownCount = 0;
            world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
            union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
            private_chatHtmlMsg = ChatContentData.instance.privateChatList.toArray().join("\n");
            starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            showChatText();
        }

        public function __beginerContainUI_click(_arg_1:MouseEvent):void
        {
            onTabBtnBarClickHandle(_arg_1);
        }

        private function set comboData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1801970088comboData;
            if (_local_2 !== _arg_1)
            {
                this._1801970088comboData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "comboData", _local_2, _arg_1));
            };
        }

        private function onServerSystemInfoMsg(_arg_1:SystemInfoMsg):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_2:* = "";
            _local_2 = replaceString(_arg_1.msg);
            if (_arg_1.alliance)
            {
                _local_2 = ((("[<u>" + Lang.msg("联盟信息提示")) + "</u>]: ") + _local_2);
                ChatContentData.instance._worldChatList = (("<b><font color='#ec6941' >" + _local_2) + "</font></b>");
                ChatContentData.instance._unionChatList = (("<b><font color='#ec6941' >" + _local_2) + "</font></b>");
                ChatContentData.instance._starterChatList = (("<b><font color='#ec6941' >" + _local_2) + "</font></b>");
            }
            else
            {
                if (_arg_1.noSenderSystemInfo)
                {
                    _local_2 = _arg_1.msg;
                    if (((_local_2.indexOf(" Ritual of Pact") > 0) || (_local_2.indexOf(" Speaker") > 0)))
                    {
                        return;
                    };
                    ChatContentData.instance._worldChatList = (("<font color='#ff0000' >" + _local_2) + "</font></b>");
                    ChatContentData.instance._starterChatList = (("<font color='#ff0000' >" + _local_2) + "</font></b>");
                }
                else
                {
                    _local_2 = _arg_1.msg;
                    if (((_local_2.indexOf(" Ritual of Pact") > 0) || (_local_2.indexOf(" Speaker") > 0)))
                    {
                        return;
                    };
                    if (((_local_2.indexOf(" will be taken offline ") > 0) && (iSysMessCount == 0)))
                    {
                        iSysMessCount++;
                        _local_3 = _local_2.indexOf("ce on ");
                        _local_4 = _local_2.indexOf(", which is");
                        _local_5 = _local_2.indexOf(". In most");
                        _local_6 = _local_2.substring(0, (_local_3 + 6));
                        _local_7 = _local_2.substring((_local_3 + 6), _local_4);
                        _local_8 = ", which is due in ";
                        _local_9 = _local_2.substring((_local_4 + 18), _local_5);
                        _local_10 = _local_2.substring(_local_5);
                        _local_11 = ((((((((_local_6 + "<font color='#e40000'  >") + _local_7) + "</font>") + _local_8) + "<font color='#e40000'  >") + _local_9) + "</font>") + _local_10);
                        AlertWinEx.show(_local_11, null);
                    }
                    else
                    {
                        if (_local_2.indexOf("has declared war against alliance") > 0)
                        {
                            _local_2 = _local_2.replace("<", "&lt;");
                            _local_2 = _local_2.replace(">", "&gt;");
                        };
                    };
                    if (!_arg_1.tV)
                    {
                        _local_2 = ((("[<u>" + Lang.msg("系统提示")) + "</u>]: ") + _local_2);
                        ChatContentData.instance._worldChatList = (("<b><font color='#e10000' >" + _local_2) + "</font></b>");
                        ChatContentData.instance._unionChatList = (("<b><font color='#e10000' >" + _local_2) + "</font></b>");
                        ChatContentData.instance._starterChatList = (("<font color='#e10000' >" + _local_2) + "</font>");
                    };
                };
            };
            world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
            union_chatHtmlMsg = ChatContentData.instance.unionChatList.toArray().join("\n");
            starter_chatHtmlMsg = ChatContentData.instance.starterChatList.toArray().join("\n");
            showChatText();
        }

        private function set union_chatHtmlMsg(_arg_1:String):void
        {
            var _local_2:Object = this._1428911122union_chatHtmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._1428911122union_chatHtmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "union_chatHtmlMsg", _local_2, _arg_1));
            };
        }

        private function replaceString(_arg_1:String):String
        {
            return (_arg_1);
        }

        public function __worldContainUI_click(_arg_1:MouseEvent):void
        {
            onTabBtnBarClickHandle(_arg_1);
        }

        public function __privateContainUI_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function __allianceContainUI_click(_arg_1:MouseEvent):void
        {
            onTabBtnBarClickHandle(_arg_1);
        }

        public function set beginerContainUI(_arg_1:Button):void
        {
            var _local_2:Object = this._1248263182beginerContainUI;
            if (_local_2 !== _arg_1)
            {
                this._1248263182beginerContainUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "beginerContainUI", _local_2, _arg_1));
            };
        }

        private function _ChatFrame_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("密语聊天频道，此频道将显示您所有的密语聊天信息");
            _local_1 = Lang.msg("联盟聊天频道，您可以使用此频道和你所在联盟的联盟成员聊天");
            _local_1 = Lang.msg("世界聊天频道，您可以使用此频道和整个服务器的玩家聊天");
            _local_1 = Lang.msg("新手聊天频道，您可以使用此频道和整个服务器的新手玩家聊天");
        }

        [Bindable(event="propertyChange")]
        private function get starter_chatHtmlMsg():String
        {
            return (this._491443630starter_chatHtmlMsg);
        }

        [Bindable(event="propertyChange")]
        public function get allianceContainUI():Button
        {
            return (this._1221062641allianceContainUI);
        }

        [Bindable(event="propertyChange")]
        public function get beginerContainUI():Button
        {
            return (this._1248263182beginerContainUI);
        }

        public function onSendMsg(_arg_1:KeyboardEvent):void
        {
            switch (_arg_1.keyCode)
            {
                case 13:
                    sendMsg();
                    return;
                case 38:
                    tellRecord("up");
                    return;
                case 40:
                    tellRecord("down");
                    return;
            };
        }

        public function buildToDebugString(_arg_1:String):void
        {
            ChatContentData.instance._worldChatList = (("<b><font color='#652d00' >" + _arg_1) + "</font></b>");
            world_chatHtmlMsg = ChatContentData.instance.worldChatList.toArray().join("\n");
        }

        [Bindable(event="propertyChange")]
        public function get worldContainUI():Button
        {
            return (this._1914909430worldContainUI);
        }

        public function ___ChatFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view

