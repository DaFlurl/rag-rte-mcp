// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.ChatPanel

package autoevony.gui
{
    import mx.containers.VBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.TabBar;
    import autoevony.cmds.Commands;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.containers.Canvas;
    import mx.utils.ObjectProxy;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import autoevony.common.Utils;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import com.evony.client.response.ResponseDispatcher;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.server.events.ChannelChatMsg;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import autoevony.management.CityManager;
    import com.evony.common.server.events.SystemInfoMsg;
    import flash.events.TextEvent;
    import com.evony.client.action.ActionFactory;
    import mx.events.ItemClickEvent;
    import com.evony.common.constants.CommonConstants;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.server.events.PrivateChatMessage;
    import mx.controls.tabBarClasses.Tab;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.server.events.AllianceChatMsg;
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

    public class ChatPanel extends VBox implements IBindingClient 
    {

        public static var maintMin:int = -1;
        public static var maintMax:int = -1;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1437393061chatText:TextInput;
        private var _739104029chatTab:TabBar;
        private var commander:Commands = null;
        private var _739096780chatLog:TextArea;
        private var lastPrivateChatFromUser:String = "";
        private var _1659559965clearChatLogBtn:Button;
        private var currentHistory:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":603,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "bottom";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":22,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TabBar,
                                    "id":"chatTab",
                                    "events":{
                                        "creationComplete":"__chatTab_creationComplete",
                                        "itemClick":"__chatTab_itemClick"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.tabStyleName = "REtabBarTab";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"REtabBar"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "events":{
                            "rollOver":"___ChatPanel_Canvas1_rollOver",
                            "rollOut":"___ChatPanel_Canvas1_rollOut"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"chatLog",
                                    "events":{"link":"__chatLog_link"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.right = "0";
                                        this.top = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REchatBox",
                                            "editable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"clearChatLogBtn",
                                    "events":{"click":"__clearChatLogBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.right = "27";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"clearLogBtn",
                                            "visible":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                            this.verticalGap = 0;
                            this.horizontalGap = 3;
                            this.paddingLeft = 0;
                            this.paddingRight = 0;
                            this.paddingTop = 0;
                            this.paddingBottom = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":30,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"chatText",
                                    "events":{"keyUp":"__chatText_keyUp"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "editable":true,
                                            "maxChars":150,
                                            "styleName":"chatInput",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ChatPanel_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Send",
                                            "styleName":"REwinBtn"
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var chatHistory:Array = new Array("");
        private var _94416770cache:ObjectProxy = new ObjectProxy({
            "aChatText":"",
            "pChatText":"",
            "wChatText":"",
            "systemText":"",
            "commandText":"",
            "emptyStr":""
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ChatPanel()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
            this.width = 603;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", this.___ChatPanel_VBox1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ChatPanel._watcherSetupUtil = _arg_1;
        }


        public function getCommander():Commands
        {
            return (this.commander);
        }

        private function set cache(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._94416770cache;
            if (_local_2 !== _arg_1)
            {
                this._94416770cache = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cache", _local_2, _arg_1));
            };
        }

        private function setScrollPos(target:TextArea):void
        {
            Utils.callLater(50, function ():void
            {
                target.verticalScrollPosition = target.maxVerticalScrollPosition;
            });
        }

        public function __clearChatLogBtn_click(_arg_1:MouseEvent):void
        {
            this.clear(true, ["aChatText", "pChatText", "wChatText", "systemText", "commandText"][this.chatTab.selectedIndex], true);
        }

        public function ___ChatPanel_VBox1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function init():void
        {
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.addEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG, this.evtSystemInfoMsg);
            _local_1.addEventListener(ResponseDispatcher.SERVER_WORLD_CHAT_MSG, this.evtWorldChatMsg);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CHANNEL_CHAT_MSG, this.evtChannelChatMsg);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ALLIANCE_CHAT_MSG, this.evtAllianceChatMsg);
            _local_1.addEventListener(ResponseDispatcher.SERVER_PRIVATE_CHAT_MESSAGE, this.evtPrivateChatMessage);
            this.commander = new Commands(this.cmdLogMsg);
        }

        override public function initialize():void
        {
            var target:ChatPanel;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ChatPanel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_ChatPanelWatcherSetupUtil");
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

        public function ___ChatPanel_Canvas1_rollOut(_arg_1:MouseEvent):void
        {
            this.clearChatLogBtn.visible = false;
        }

        public function evtWorldChatMsg(_arg_1:ChannelChatMsg):void
        {
            var _local_2:* = "[World]";
            var _local_3:* = "#222222";
            if (((_arg_1.ownitemid == 7) || (_arg_1.ownitemid == 8)))
            {
                _local_2 = "[Staff]";
                _local_3 = "#156510";
            };
            if (_arg_1.fromUser.indexOf("Gove") > -1)
            {
                _local_3 = "#F05A00";
            };
            this.showNewMsg("wChatText", ((("[" + this._kh627(_arg_1.fromUser, _local_3)) + "]: ") + _arg_1.msg), _local_3, true, _local_2);
            if (this.chatTab.selectedIndex != 2)
            {
                this.chatTab.getChildren()[2].setStyle("fontStyle", "italic");
            };
        }

        public function showNewMsg(_arg_1:String, _arg_2:String, _arg_3:String="#000000", _arg_4:Boolean=false, _arg_5:String=""):void
        {
            var _local_7:int;
            this.cache[_arg_1] = (this.cache[_arg_1] + (((((((("<font color='" + ((_arg_3 != "#000000") ? _arg_3 : "#006666")) + "'>") + ((_arg_4) ? (((_arg_5 + "&lt;") + Utils.getChatTimeStr(Utils.getServerTime())) + "&gt;</font>") : (Utils.getLogTimeStr(Utils.getServerTime()) + "</font> "))) + "<font color='") + _arg_3) + "'>") + _arg_2.replace(/\r\n?|\n|<br>/gi, "\n")) + "</font>\n"));
            var _local_6:int = this.cache[_arg_1].length;
            if (((((((_arg_1 == "aChatText") || (_arg_1 == "pChatText")) || (_arg_1 == "wChatText")) && (_local_6 > 96000)) || ((_arg_1 == "systemText") && (_local_6 > 96000))) || ((_arg_1 == "commandText") && (_local_6 > 256000))))
            {
                this.cache[_arg_1] = this.cache[_arg_1].substr(this.cache[_arg_1].indexOf("\n", 8000));
            };
            if ((((((((_local_7 = this.chatTab.selectedIndex) == 0) && (_arg_1 == "aChatText")) || ((_local_7 == 1) && (_arg_1 == "pChatText"))) || ((_local_7 == 2) && (_arg_1 == "wChatText"))) || ((_local_7 == 3) && (_arg_1 == "systemText"))) || ((_local_7 == 4) && (_arg_1 == "commandText"))))
            {
                this.setScrollPos(this.chatLog);
            };
        }

        private function newKeyUpEvent(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Keyboard.ENTER) && (Utils.trim(this.chatText.text).length > 0)))
            {
                this.chatHistory[(this.chatHistory.length - 1)] = this.chatText.text;
                this.chatHistory.push("");
                this.currentHistory = (this.chatHistory.length - 1);
                this._os197();
            }
            else
            {
                if (((_arg_1.keyCode == Keyboard.UP) && (this.currentHistory >= 1)))
                {
                    this.chatHistory[this.currentHistory] = this.chatText.text;
                    this.currentHistory--;
                    this.chatText.text = this.chatHistory[this.currentHistory];
                    if (this.chatText.text.substr(0, 2) != "/'")
                    {
                        if (this.chatText.text.substr(0, 1) != "/")
                        {
                            this.chatText.selectionBeginIndex = 0;
                        }
                        else
                        {
                            this.chatText.selectionBeginIndex = (this.chatText.text.indexOf(" ", 1) + 1);
                        };
                    }
                    else
                    {
                        this.chatText.selectionBeginIndex = (this.chatText.text.indexOf("' ", 2) + 2);
                    };
                    this.chatText.selectionEndIndex = this.chatText.text.length;
                }
                else
                {
                    if (((_arg_1.keyCode == Keyboard.DOWN) && (this.currentHistory < (this.chatHistory.length - 1))))
                    {
                        this.chatHistory[this.currentHistory] = this.chatText.text;
                        this.currentHistory++;
                        this.chatText.text = this.chatHistory[this.currentHistory];
                        if (this.chatText.text.substr(0, 2) != "/'")
                        {
                            if (this.chatText.text.substr(0, 1) != "/")
                            {
                                this.chatText.selectionBeginIndex = 0;
                            }
                            else
                            {
                                this.chatText.selectionBeginIndex = (this.chatText.text.indexOf(" ", 1) + 1);
                            };
                        }
                        else
                        {
                            this.chatText.selectionBeginIndex = (this.chatText.text.indexOf("' ", 2) + 2);
                        };
                        this.chatText.selectionEndIndex = this.chatText.text.length;
                    };
                };
            };
        }

        public function evtSystemInfoMsg(_arg_1:SystemInfoMsg):void
        {
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            var _local_9:int;
            var _local_2:String = _arg_1.msg;
            _local_2 = _local_2.replace(new RegExp("<[^<]*>", "g"), "");
            _local_2 = _local_2.replace(new RegExp("<[^<]*>", "g"), "");
            _local_2 = _local_2.replace(new RegExp("<[^<]*>", "g"), "");
            var _local_3:Array = _local_2.split(" ");
            if (((_local_3.length > 1) && (((_local_3[1] == "Bid") || (_local_3[1] == "Offer")) || ((_local_3[1] == "Troops") && (_local_3[2] == "returned")))))
            {
                return;
            };
            if (((_local_3.length > 1) && (_local_3[1] == "Defeat")))
            {
                _local_3.splice(0, 1);
                parentDocument.logMsg(_local_3.join(" "));
                return;
            };
            var _local_4:Boolean = ((((_local_3.length >= 5) && ((_local_3[0] == "Lord") || (_local_3[0] == "Lady"))) && (_local_3[(_local_3.length - 2)] == "from")) && (_local_3[(_local_3.length - 1)] == "Amulet!"));
            var _local_5:Boolean = (((_local_3.length >= 8) && (_local_3[0] == "Hurrah!")) && (_local_3[(_local_3.length - 3)] == "equipment"));
            if ((((_local_4) || (_local_5)) && (_arg_1.tV)))
            {
                return;
            };
            this.showNewMsg("systemText", _local_2);
            if (this.chatTab.selectedIndex != 3)
            {
                this.chatTab.getChildren()[3].setStyle("fontStyle", "italic");
            };
            if (((_local_4) || ((_local_5) && (!((_local_3[(_local_3.length - 1)] == "Lv:14") || (_local_3[(_local_3.length - 1)] == "Lv:15"))))))
            {
                return;
            };
            if (_local_2.search(new RegExp("maintenance", "i")) > 0)
            {
                parentDocument.logMsg(("MAINTENANCE: " + _local_2));
                _local_6 = Utils.getStringBetween(_local_2, "due in ", " minutes");
                _local_7 = Utils.getStringBetween(_local_2, "minutes ", " seconds");
                if (((((!(_local_6 == null)) && (!(_local_7 == null))) && (Utils.hasValue(_local_6))) && (Utils.hasValue(_local_7))))
                {
                    CityManager.setEstMaintDownTime(((60 * int(_local_6)) + int(_local_7)));
                };
                if ((((!(_local_6 == null)) && (Utils.hasValue(_local_6))) && (int(_local_6) < 5)))
                {
                    if (parentDocument._dx1146(3600))
                    {
                        parentDocument.scheduleUnpauseTimer(Utils.rand((((int(_local_6) + 10) * 60) * 1000), (((int(_local_6) + 15) * 60) * 1000)));
                    }
                    else
                    {
                        _local_8 = ((maintMin == -1) ? 30 : maintMin);
                        _local_9 = ((maintMax == -1) ? 40 : maintMax);
                        parentDocument.scheduleUnpauseTimer(Utils.rand(((_local_8 * 60) * 1000), ((_local_9 * 60) * 1000)));
                    };
                    parentDocument.logMsg("Click on Resume to resume the program manually. Make sure you don't resume when the server is still down, though.");
                    CityManager.deletePlayerTiming("attack");
                };
            }
            else
            {
                this.showNewMsg("wChatText", ("SYSTEM: " + _local_2), "#4377F9");
                this.showNewMsg("aChatText", ("SYSTEM: " + _local_2), "#3F3F3F");
                if (this.chatTab.selectedIndex != 0)
                {
                    this.chatTab.getChildren()[0].setStyle("fontStyle", "italic");
                };
                if (this.chatTab.selectedIndex != 2)
                {
                    this.chatTab.getChildren()[2].setStyle("fontStyle", "italic");
                };
            };
        }

        private function handleLogLinkEvent(_arg_1:TextEvent):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:int;
            if (((_arg_1.currentTarget == this.chatLog) && (this.chatTab.selectedIndex < 4)))
            {
                _local_2 = _arg_1.text;
                if (_local_2.indexOf(" ") != -1)
                {
                    _local_2 = (("'" + _local_2) + "'");
                };
                _local_3 = Utils.trim(this.chatText.text);
                if (((_local_3.length == 0) || (!(_local_3.charAt(0) == "/"))))
                {
                    this.chatText.text = ((("/" + _local_2) + " ") + _local_3);
                    this.chatText.selectionBeginIndex = 0;
                    this.chatText.selectionEndIndex = (_local_2.length + 2);
                    this.chatText.setFocus();
                    return;
                };
                _local_4 = 0;
                if (((_local_3.length > 1) && (_local_3.charAt(1) == "'")))
                {
                    if ((_local_4 = (_local_3.indexOf("'", 2) + 1)) == 0)
                    {
                        _local_4 = 2;
                    };
                }
                else
                {
                    if ((_local_4 = (_local_3.indexOf(" ", 1) + 1)) == 0)
                    {
                        _local_4 = _local_3.length;
                    };
                };
                this.chatText.text = ((("/" + _local_2) + " ") + Utils.trim(_local_3.substring(_local_4)));
                this.chatText.selectionBeginIndex = 0;
                this.chatText.selectionEndIndex = (_local_2.length + 2);
                this.chatText.setFocus();
            };
        }

        [Bindable(event="propertyChange")]
        public function get chatText():TextInput
        {
            return (this._1437393061chatText);
        }

        public function __chatText_keyUp(_arg_1:KeyboardEvent):void
        {
            this.newKeyUpEvent(_arg_1);
        }

        private function uninit():void
        {
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.removeEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG, this.evtSystemInfoMsg);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_WORLD_CHAT_MSG, this.evtWorldChatMsg);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_CHANNEL_CHAT_MSG, this.evtChannelChatMsg);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_ALLIANCE_CHAT_MSG, this.evtAllianceChatMsg);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_PRIVATE_CHAT_MESSAGE, this.evtPrivateChatMessage);
            this.commander = null;
        }

        private function _ChatPanel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ["Alliance Chat", "Private Chat", "World Chat", "System", "Commands"];
            _local_1 = ((this.chatTab.selectedIndex == 0) ? this.cache.aChatText : ((this.chatTab.selectedIndex == 1) ? this.cache.pChatText : ((this.chatTab.selectedIndex == 2) ? this.cache.wChatText : ((this.chatTab.selectedIndex == 3) ? this.cache.systemText : ((this.chatTab.selectedIndex == 4) ? this.cache.commandText : this.cache.emtpyStr)))));
            _local_1 = (("Clear all entries from the " + ((this.chatTab.selectedIndex == 0) ? "Alliance Chat" : ((this.chatTab.selectedIndex == 1) ? "Private Chat" : ((this.chatTab.selectedIndex == 2) ? "World Chat" : ((this.chatTab.selectedIndex == 3) ? "System" : "Commands"))))) + " Log");
        }

        private function _os197():void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_1:String = Utils.trim(this.chatText.text);
            if (_local_1.length > 0)
            {
                if (_local_1.charAt(0) == "\\")
                {
                    this.commander.doCmd(Utils.trim(_local_1.substr(1)));
                }
                else
                {
                    if (_local_1.charAt(0) == "/")
                    {
                        _local_2 = null;
                        _local_3 = null;
                        if (_local_1.charAt(1) == "'")
                        {
                            _local_2 = _local_1.substr(2, (_local_1.indexOf("'", 2) - 2));
                            _local_3 = _local_1.substr((_local_2.length + 4), (_local_1.length - (_local_2.length + 4)));
                        }
                        else
                        {
                            if (_local_1.indexOf(" ", 1) != -1)
                            {
                                _local_2 = _local_1.substr(1, (_local_1.indexOf(" ", 1) - 1));
                                _local_3 = _local_1.substr((_local_2.length + 1), ((_local_1.length - 1) - _local_2.length));
                            }
                            else
                            {
                                _local_2 = _local_1.substr(1);
                                _local_3 = "";
                            };
                            if (_local_2 == "r")
                            {
                                _local_2 = this.lastPrivateChatFromUser;
                            };
                            if (_local_2 == "")
                            {
                                return;
                            };
                        };
                        if (_local_3 == "")
                        {
                            return;
                        };
                        this.lastPrivateChatFromUser = _local_2;
                        if (_local_3.charAt(0) == " ")
                        {
                            _local_3 = _local_3.slice(1);
                        };
                        ActionFactory.getInstance().getCommonCommands().privateChat(_local_2, _local_3);
                        this.showWhisperInChats(this.lastPrivateChatFromUser, _local_3, "To");
                    }
                    else
                    {
                        if (this.chatTab.selectedIndex == 2)
                        {
                            ActionFactory.getInstance().getCommonCommands().worldChat(this.chatText.text, 0);
                        }
                        else
                        {
                            if (this.chatTab.selectedIndex == 0)
                            {
                                ActionFactory.getInstance().getCommonCommands().allianceChat(this.chatText.text, 0);
                            };
                        };
                    };
                };
                this.chatText.text = "";
            };
        }

        [Bindable(event="propertyChange")]
        private function get cache():ObjectProxy
        {
            return (this._94416770cache);
        }

        public function set chatLog(_arg_1:TextArea):void
        {
            var _local_2:Object = this._739096780chatLog;
            if (_local_2 !== _arg_1)
            {
                this._739096780chatLog = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatLog", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get chatTab():TabBar
        {
            return (this._739104029chatTab);
        }

        public function ___ChatPanel_Button2_click(_arg_1:MouseEvent):void
        {
            this._os197();
        }

        private function _ChatPanel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (["Alliance Chat", "Private Chat", "World Chat", "System", "Commands"]);
            }, function (_arg_1:Object):void
            {
                chatTab.dataProvider = _arg_1;
            }, "chatTab.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.chatTab.selectedIndex == 0) ? this.cache.aChatText : ((this.chatTab.selectedIndex == 1) ? this.cache.pChatText : ((this.chatTab.selectedIndex == 2) ? this.cache.wChatText : ((this.chatTab.selectedIndex == 3) ? this.cache.systemText : ((this.chatTab.selectedIndex == 4) ? this.cache.commandText : this.cache.emtpyStr)))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                chatLog.htmlText = _arg_1;
            }, "chatLog.htmlText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("Clear all entries from the " + ((this.chatTab.selectedIndex == 0) ? "Alliance Chat" : ((this.chatTab.selectedIndex == 1) ? "Private Chat" : ((this.chatTab.selectedIndex == 2) ? "World Chat" : ((this.chatTab.selectedIndex == 3) ? "System" : "Commands"))))) + " Log");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                clearChatLogBtn.toolTip = _arg_1;
            }, "clearChatLogBtn.toolTip");
            result[2] = binding;
            return (result);
        }

        public function __chatTab_itemClick(_arg_1:ItemClickEvent):void
        {
            this.onLogTabClick(this.chatTab, _arg_1.relatedObject);
        }

        public function evtChannelChatMsg(_arg_1:ChannelChatMsg):void
        {
            var _local_2:* = "";
            var _local_3:* = "#333333";
            if (((_arg_1.channel == CommonConstants.CHAT_CHANNEL_BEGINNER) && (!((_arg_1.fromUser as String) == MainScreen.getPlayer().playerInfo.userName))))
            {
                _local_2 = "";
                _local_3 = "#333333";
                if (((_arg_1.ownitemid == 7) || (_arg_1.ownitemid == 8)))
                {
                    _local_2 = "[Staff]";
                    _local_3 = "#156510";
                };
                this.showNewMsg("wChatText", ((("[" + this._kh627(_arg_1.fromUser, _local_3)) + "]: ") + _arg_1.msg), _local_3, true, _local_2);
                if (this.chatTab.selectedIndex != 2)
                {
                    this.chatTab.getChildren()[2].setStyle("fontStyle", "italic");
                };
            }
            else
            {
                if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_WORLD)
                {
                    if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_ALLIANCE)
                    {
                        if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_TRADE)
                        {
                            if (_arg_1.channel != CommonConstants.CHAT_CHANNEL_ZONE)
                            {
                            };
                        };
                    };
                }
                else
                {
                    this.evtWorldChatMsg(_arg_1);
                };
            };
        }

        public function clear(_arg_1:Boolean, _arg_2:String, _arg_3:Boolean=false):void
        {
            if (!_arg_1)
            {
                return;
            };
            if (_arg_3)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Are you sure you want to clear this log window?", this.clear, "Clear Log", "Cancel", [_arg_2]));
                return;
            };
            this.cache[_arg_2] = "";
        }

        public function evtPrivateChatMessage(_arg_1:PrivateChatMessage):void
        {
            var _local_2:String;
            var _local_3:String;
            if (((!(_arg_1.fromUser == MainScreen.getPlayer().playerInfo.userName)) && (this.chatAcept(_arg_1.fromUser))))
            {
                this.lastPrivateChatFromUser = _arg_1.fromUser;
                _local_2 = "[Whisper]";
                _local_3 = "#6A44AF";
                if (((_arg_1.ownitemid == 7) || (_arg_1.ownitemid == 8)))
                {
                    _local_2 = "[Staff]";
                    _local_3 = "#156510";
                };
                if (_arg_1.chatType == PrivateChatMessage.GM_CHAT)
                {
                    _local_3 = "#FF0000";
                };
                this.showWhisperInChats(_arg_1.fromUser, _arg_1.msg, "From", true, _local_3, _local_2);
            };
        }

        public function set chatText(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1437393061chatText;
            if (_local_2 !== _arg_1)
            {
                this._1437393061chatText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatText", _local_2, _arg_1));
            };
        }

        public function set chatTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._739104029chatTab;
            if (_local_2 !== _arg_1)
            {
                this._739104029chatTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatTab", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get chatLog():TextArea
        {
            return (this._739096780chatLog);
        }

        public function set clearChatLogBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1659559965clearChatLogBtn;
            if (_local_2 !== _arg_1)
            {
                this._1659559965clearChatLogBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "clearChatLogBtn", _local_2, _arg_1));
            };
        }

        private function onTabBarComplete(_arg_1:TabBar):void
        {
            var _local_2:Tab;
            for each (_local_2 in _arg_1.getChildren())
            {
                if (_local_2.label == "Alliance Chat")
                {
                    _local_2.setStyle("themeColor", "#7AAAFF");
                    _local_2.setStyle("color", "#7AAAFF");
                    _local_2.setStyle("textRollOverColor", "#7AAAFF");
                }
                else
                {
                    if (_local_2.label == "Private Chat")
                    {
                        _local_2.setStyle("themeColor", "#B973FF");
                        _local_2.setStyle("color", "#B973FF");
                        _local_2.setStyle("textRollOverColor", "#B973FF");
                    }
                    else
                    {
                        if (_local_2.label == "System")
                        {
                            _local_2.setStyle("themeColor", "#EE5555");
                            _local_2.setStyle("color", "#EE5555");
                            _local_2.setStyle("textRollOverColor", "#EE5555");
                        }
                        else
                        {
                            if (_local_2.label == "Commands")
                            {
                                _local_2.setStyle("themeColor", "#00DA00");
                                _local_2.setStyle("color", "#00DA00");
                                _local_2.setStyle("textRollOverColor", "#00DA00");
                            }
                            else
                            {
                                _local_2.setStyle("themeColor", "#FFFFFF");
                                _local_2.setStyle("color", "#FFFFFF");
                                _local_2.setStyle("textRollOverColor", "#FFFFFF");
                            };
                        };
                    };
                };
            };
        }

        private function chatAcept(_arg_1:String):Boolean
        {
            var _local_2:PlayerInfoBean;
            if (MainScreen.getPlayer().blockBeansArray.length > 0)
            {
                for each (_local_2 in MainScreen.getPlayer().blockBeansArray)
                {
                    if (_arg_1 == _local_2.userName)
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        [Bindable(event="propertyChange")]
        public function get clearChatLogBtn():Button
        {
            return (this._1659559965clearChatLogBtn);
        }

        public function ___ChatPanel_Canvas1_rollOver(_arg_1:MouseEvent):void
        {
            this.clearChatLogBtn.visible = true;
        }

        public function __chatLog_link(_arg_1:TextEvent):void
        {
            this.handleLogLinkEvent(_arg_1);
        }

        public function evtAllianceChatMsg(_arg_1:AllianceChatMsg):void
        {
            var _local_2:* = "[Alliance]";
            var _local_3:* = "#4377F9";
            if (((_arg_1.ownitemid == 7) || (_arg_1.ownitemid == 8)))
            {
                _local_2 = "[Staff]";
                _local_3 = "#156510";
            };
            this.showNewMsg("aChatText", (((" [" + this._kh627(_arg_1.fromUser, _local_3)) + "]: ") + _arg_1.msg), _local_3, true, _local_2);
            if (this.chatTab.selectedIndex != 0)
            {
                this.chatTab.getChildren()[0].setStyle("fontStyle", "italic");
            };
        }

        public function showWhisperInChats(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Boolean=false, _arg_5:String="#6A44AF", _arg_6:String="[Whisper]"):void
        {
            _arg_2 = _arg_2.split(">").join("&gt;").split("<").join("&lt;");
            this.showNewMsg("pChatText", ((((_arg_3 + " [") + this._kh627(_arg_1, _arg_5)) + "]: ") + _arg_2), _arg_5, true, _arg_6);
            if (((_arg_4) && (!(this.chatTab.selectedIndex == 1))))
            {
                this.chatTab.getChildren()[1].setStyle("fontStyle", "italic");
            };
            this.showNewMsg("aChatText", ((((_arg_3 + " [") + this._kh627(_arg_1, _arg_5)) + "]: ") + _arg_2), _arg_5, true, _arg_6);
            this.showNewMsg("wChatText", ((((_arg_3 + " [") + this._kh627(_arg_1, _arg_5)) + "]: ") + _arg_2), _arg_5, true, _arg_6);
        }

        private function cmdLogMsg(_arg_1:String):void
        {
            this.showNewMsg("commandText", (" " + _arg_1), "#095E5D");
            if (this.chatTab.selectedIndex != 4)
            {
                this.chatTab.getChildren()[4].setStyle("fontStyle", "italic");
            };
        }

        private function onLogTabClick(_arg_1:TabBar, _arg_2:Object):void
        {
            var _local_3:Tab;
            for each (_local_3 in _arg_1.getChildren())
            {
                if (_local_3 == _arg_2)
                {
                    _local_3.setStyle("fontStyle", "normal");
                    _local_3.setStyle("fontWeight", "bold");
                }
                else
                {
                    _local_3.setStyle("fontWeight", "normal");
                };
            };
            this.setScrollPos(this.chatLog);
        }

        public function __chatTab_creationComplete(_arg_1:FlexEvent):void
        {
            this.onTabBarComplete(this.chatTab);
        }

        private function _kh627(_arg_1:String, _arg_2:String):String
        {
            return (Utils.formatUrl(_arg_1, _arg_1, _arg_2));
        }


    }
}//package autoevony.gui

