// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CallPrivaterWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.collections.ArrayCollection;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.common.beans.PlayerInfoBean;
    import view.module.rank.PlayerInfo;
    import mx.events.FlexEvent;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import mx.managers.PopUpManager;
    import view.module.mail.MailWin;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.rank.RankPlayerResponse;
    import flash.utils.getDefinitionByName;
    import flash.system.System;
    import view.ChatFrame;
    import com.evony.common.module.friend.FriendResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class CallPrivaterWin extends Canvas implements IBindingClient 
    {

        public static var instance:CallPrivaterWin = new (CallPrivaterWin)();
        public static var blockPlayerArr:ArrayCollection = new ArrayCollection();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CallPrivaterWin_MyHRule1:MyHRule;
        private var _1216845469MuteBtn:Button;
        private var _203759525myBlockBtn:Button;
        public var _CallPrivaterWin_Button5:Button;
        private var _308570246whisperBtn:Button;
        private var _2095657228playerName:String = "";
        private var _953493159copyBtn:Button;
        private var addType:String = "";
        public var _CallPrivaterWin_Label1:Label;
        private var _1901031789inviteBtn:Button;
        private var _30202497isCanMute:int = 0;
        private var _2090283592viewCharacterBtn:Button;
        private var _1846497795writeBtn:Button;
        private var _509617461reportPlayer:Button;
        private var _1238581376blockBtnString:String;
        private var blockPlayer:Boolean = false;
        public var shieldingAble:Boolean = true;
        private var isCanClick:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "1";
                            this.top = "1";
                            this.right = "1";
                            this.bottom = "1";
                            this.verticalGap = 1.1;
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CallPrivaterWin_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0x652D00;
                                        this.fontSize = 14;
                                        this.fontWeight = "bold";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":100,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_CallPrivaterWin_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"MuteBtn",
                                    "events":{
                                        "click":"__MuteBtn_click",
                                        "mouseOver":"__MuteBtn_mouseOver",
                                        "mouseOut":"__MuteBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Mute",
                                            "alpha":0,
                                            "styleName":"chatPopupBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"whisperBtn",
                                    "events":{
                                        "click":"__whisperBtn_click",
                                        "mouseOver":"__whisperBtn_mouseOver",
                                        "mouseOut":"__whisperBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "alpha":0,
                                            "styleName":"chatPopupBtn",
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"viewCharacterBtn",
                                    "events":{
                                        "click":"__viewCharacterBtn_click",
                                        "mouseOver":"__viewCharacterBtn_mouseOver",
                                        "mouseOut":"__viewCharacterBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "alpha":0,
                                            "styleName":"chatPopupBtn",
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"copyBtn",
                                    "events":{
                                        "click":"__copyBtn_click",
                                        "mouseOver":"__copyBtn_mouseOver",
                                        "mouseOut":"__copyBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_CallPrivaterWin_Button5",
                                    "events":{
                                        "click":"___CallPrivaterWin_Button5_click",
                                        "mouseOver":"___CallPrivaterWin_Button5_mouseOver",
                                        "mouseOut":"___CallPrivaterWin_Button5_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "alpha":0,
                                            "styleName":"chatPopupBtn",
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"myBlockBtn",
                                    "events":{
                                        "mouseOver":"__myBlockBtn_mouseOver",
                                        "mouseOut":"__myBlockBtn_mouseOut",
                                        "click":"__myBlockBtn_click"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":28,
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"writeBtn",
                                    "events":{
                                        "mouseOver":"__writeBtn_mouseOver",
                                        "mouseOut":"__writeBtn_mouseOut",
                                        "click":"__writeBtn_click"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":28,
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"inviteBtn",
                                    "events":{
                                        "mouseOver":"__inviteBtn_mouseOver",
                                        "mouseOut":"__inviteBtn_mouseOut",
                                        "click":"__inviteBtn_click"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":28,
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"reportPlayer",
                                    "events":{
                                        "click":"__reportPlayer_click",
                                        "mouseOver":"__reportPlayer_mouseOver",
                                        "mouseOut":"__reportPlayer_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "alpha":0,
                                            "styleName":"chatPopupBtn",
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var playerRankArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CallPrivaterWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.styleName = "doubleLineBlue";
            this.addEventListener("creationComplete", ___CallPrivaterWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CallPrivaterWin._watcherSetupUtil = _arg_1;
        }


        private function _CallPrivaterWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = playerName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CallPrivaterWin_Label1.text = _arg_1;
            }, "_CallPrivaterWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.isCanMute == 1) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _CallPrivaterWin_MyHRule1.visible = _arg_1;
            }, "_CallPrivaterWin_MyHRule1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.isCanMute == 1) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                MuteBtn.visible = _arg_1;
            }, "MuteBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Number
            {
                return ("" + "119");
            }, function (_arg_1:Number):void
            {
                MuteBtn.width = _arg_1;
            }, "MuteBtn.width");
            result[3] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((this.isCanMute == 1) ? 22 : 0);
            }, function (_arg_1:Number):void
            {
                MuteBtn.height = _arg_1;
            }, "MuteBtn.height");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("悄悄话");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                whisperBtn.label = _arg_1;
            }, "whisperBtn.label");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看角色");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                viewCharacterBtn.label = _arg_1;
            }, "viewCharacterBtn.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("复制名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                copyBtn.label = _arg_1;
            }, "copyBtn.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("添加好友");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CallPrivaterWin_Button5.label = _arg_1;
            }, "_CallPrivaterWin_Button5.label");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("黑名单");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myBlockBtn.label = _arg_1;
            }, "myBlockBtn.label");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("写信");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                writeBtn.label = _arg_1;
            }, "writeBtn.label");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟邀请");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                inviteBtn.label = _arg_1;
            }, "inviteBtn.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("举报");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                reportPlayer.label = _arg_1;
            }, "reportPlayer.label");
            result[12] = binding;
            return (result);
        }

        public function show(_arg_1:String):void
        {
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, false);
            instance.playerName = _arg_1;
            instance.x = (MainFrame.instance.mouseX + 10);
            instance.y = (MainFrame.instance.mouseY - 160);
            instance.setBtnState(_arg_1);
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.FRIEND_ADD_FRIEND))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_FRIEND, onAddFriendResponse, false, 0, true);
            };
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE, onAddUserToAlliance, false, 0, true);
            };
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.FRIEND_ADD_BLOCK))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_BLOCK, onAddBlockResponse, false, 0, true);
            };
        }

        private function set blockBtnString(_arg_1:String):void
        {
            var _local_2:Object = this._1238581376blockBtnString;
            if (_local_2 !== _arg_1)
            {
                this._1238581376blockBtnString = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "blockBtnString", _local_2, _arg_1));
            };
        }

        private function onChatBtnOut(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 0;
            isCanClick = false;
        }

        private function showPlayerInfo():void
        {
            var _local_1:int;
            while (_local_1 < playerRankArray.length)
            {
                if (PlayerInfoBean(playerRankArray[_local_1]).userName == playerName)
                {
                    PlayerInfo.show(PlayerInfoBean(playerRankArray[_local_1]));
                };
                _local_1++;
            };
        }

        public function ___CallPrivaterWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _CallPrivaterWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = playerName;
            _local_1 = ((this.isCanMute == 1) ? true : false);
            _local_1 = ((this.isCanMute == 1) ? true : false);
            _local_1 = ("" + "119");
            _local_1 = ((this.isCanMute == 1) ? 22 : 0);
            _local_1 = Lang.msg("悄悄话");
            _local_1 = Lang.msg("查看角色");
            _local_1 = Lang.msg("复制名称");
            _local_1 = Lang.msg("添加好友");
            _local_1 = Lang.msg("黑名单");
            _local_1 = Lang.msg("写信");
            _local_1 = Lang.msg("联盟邀请");
            _local_1 = Lang.msg("举报");
        }

        [Bindable(event="propertyChange")]
        private function get playerName():String
        {
            return (this._2095657228playerName);
        }

        public function ___CallPrivaterWin_Button5_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function __myBlockBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function addBlockName(_arg_1:Boolean):void
        {
            if (_arg_1 == true)
            {
                blockPlayerArr.addItem(playerName);
            };
            onClose();
        }

        private function setBtnState(_arg_1:String):void
        {
            if (chatAcept(_arg_1))
            {
                myBlockBtn.label = Lang.msg("屏蔽");
                myBlockBtn.toolTip = Lang.msg("屏蔽功能说明");
            }
            else
            {
                myBlockBtn.label = Lang.msg("取消屏蔽");
                myBlockBtn.toolTip = "";
            };
        }

        private function init():void
        {
            this.isCanMute = Context.getInstance().getPlayerBean().playerInfo.bdenyotherplayer;
            stage.addEventListener(MouseEvent.MOUSE_DOWN, onOutMouseUp);
        }

        private function allianceInvite():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(playerName);
            onClose();
        }

        public function __viewCharacterBtn_click(_arg_1:MouseEvent):void
        {
            onSeeAboutPlayer();
        }

        private function onIsSure(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (addType == "addBlock")
                {
                    ActionFactory.getInstance().getFriendCommands().deleteFriend(playerName, onDeleteFriend);
                }
                else
                {
                    if (addType == "addFriend")
                    {
                        ActionFactory.getInstance().getFriendCommands().deleteBlock(playerName, onDeleteFriend);
                    };
                };
                onClose();
            };
        }

        public function set inviteBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1901031789inviteBtn;
            if (_local_2 !== _arg_1)
            {
                this._1901031789inviteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteBtn", _local_2, _arg_1));
            };
        }

        private function set playerName(_arg_1:String):void
        {
            var _local_2:Object = this._2095657228playerName;
            if (_local_2 !== _arg_1)
            {
                this._2095657228playerName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _local_2, _arg_1));
            };
        }

        public function __copyBtn_click(_arg_1:MouseEvent):void
        {
            onCopyName();
        }

        [Bindable(event="propertyChange")]
        public function get writeBtn():Button
        {
            return (this._1846497795writeBtn);
        }

        public function __viewCharacterBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onOutMouseUp(_arg_1:MouseEvent):void
        {
            if (instance != null)
            {
                if (!isCanClick)
                {
                    this.onClose();
                };
            };
        }

        public function __viewCharacterBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get reportPlayer():Button
        {
            return (this._509617461reportPlayer);
        }

        public function __writeBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function onSeeAboutPlayer():void
        {
            ActionFactory.getInstance().getRankCommands().getPlayerRank(playerName, 1, 10, 2, onGetPlayerRankResponse);
        }

        private function chatAcept(_arg_1:String):Boolean
        {
            var _local_3:int;
            var _local_2:Boolean = true;
            if (CallPrivaterWin.blockPlayerArr.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < CallPrivaterWin.blockPlayerArr.length)
                {
                    if (_arg_1 == CallPrivaterWin.blockPlayerArr[_local_3])
                    {
                        _local_2 = false;
                        break;
                    };
                    _local_3++;
                };
            };
            return (_local_2);
        }

        public function __reportPlayer_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function set copyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._953493159copyBtn;
            if (_local_2 !== _arg_1)
            {
                this._953493159copyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "copyBtn", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get myBlockBtn():Button
        {
            return (this._203759525myBlockBtn);
        }

        public function __MuteBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function __whisperBtn_click(_arg_1:MouseEvent):void
        {
            onWhisper();
        }

        private function addHandler(_arg_1:String):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            if (playerName == Context.getInstance().getPlayerBean().playerInfo.userName)
            {
                AlertWin.show(Lang.msg("不能添加自己"));
                return;
            };
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
            var _local_3:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
            var _local_4:Boolean;
            if (_arg_1 == "addFriend")
            {
                addType = _arg_1;
                _local_5 = 0;
                while (_local_5 < _local_2.length)
                {
                    if (PlayerInfoBean(_local_2[_local_5]).userName == playerName)
                    {
                        AlertWin.show(Lang.msg("玩家已经在列表中"));
                        return;
                    };
                    _local_5++;
                };
                _local_6 = 0;
                while (_local_6 < _local_3.length)
                {
                    if (PlayerInfoBean(_local_3[_local_6]).userName == playerName)
                    {
                        AlertWin.show(Lang.msg("从黑名单到好友"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                        return;
                    };
                    _local_6++;
                };
                ActionFactory.getInstance().getFriendCommands().addFriend(playerName);
                onClose();
            }
            else
            {
                if (_arg_1 == "addBlock")
                {
                    addType = _arg_1;
                    _local_7 = 0;
                    while (_local_7 < _local_3.length)
                    {
                        if (PlayerInfoBean(_local_3[_local_7]).userName == playerName)
                        {
                            AlertWin.show(Lang.msg("玩家已经在列表中"));
                            return;
                        };
                        _local_7++;
                    };
                    _local_8 = 0;
                    while (_local_8 < _local_2.length)
                    {
                        if (PlayerInfoBean(_local_2[_local_8]).userName == playerName)
                        {
                            AlertWin.show(Lang.msg("从好友到黑名单"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                            return;
                        };
                        _local_8++;
                    };
                    ActionFactory.getInstance().getFriendCommands().addBlock(playerName);
                    onClose();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get MuteBtn():Button
        {
            return (this._1216845469MuteBtn);
        }

        private function writeHandler():void
        {
            MailWin.writeMailToPlayer(playerName);
            onClose();
        }

        private function onGetPlayerRankResponse(_arg_1:RankPlayerResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (_arg_1.beansArray.length > 0)
                {
                    playerRankArray.removeAll();
                    this.playerRankArray = _arg_1.beansArray;
                    showPlayerInfo();
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __reportPlayer_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function set viewCharacterBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2090283592viewCharacterBtn;
            if (_local_2 !== _arg_1)
            {
                this._2090283592viewCharacterBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewCharacterBtn", _local_2, _arg_1));
            };
        }

        public function set reportPlayer(_arg_1:Button):void
        {
            var _local_2:Object = this._509617461reportPlayer;
            if (_local_2 !== _arg_1)
            {
                this._509617461reportPlayer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportPlayer", _local_2, _arg_1));
            };
        }

        public function __whisperBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function __inviteBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onChatBtnOver(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 1;
            isCanClick = true;
        }

        [Bindable(event="propertyChange")]
        public function get whisperBtn():Button
        {
            return (this._308570246whisperBtn);
        }

        [Bindable(event="propertyChange")]
        private function get isCanMute():int
        {
            return (this._30202497isCanMute);
        }

        public function __myBlockBtn_click(_arg_1:MouseEvent):void
        {
            addHandler("addBlock");
        }

        [Bindable(event="propertyChange")]
        private function get blockBtnString():String
        {
            return (this._1238581376blockBtnString);
        }

        public function __writeBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function __inviteBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        override public function initialize():void
        {
            var target:CallPrivaterWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CallPrivaterWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_CallPrivaterWinWatcherSetupUtil");
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

        private function onMute():void
        {
            ActionFactory.getInstance().getCommonCommands().denyPlayerSpeak(this.playerName, 30, onMuteResponse);
        }

        [Bindable(event="propertyChange")]
        public function get inviteBtn():Button
        {
            return (this._1901031789inviteBtn);
        }

        private function onCopyName():void
        {
            System.setClipboard(playerName);
            onClose();
        }

        private function onWhisper():void
        {
            onClose();
            ChatFrame.instance.sayTo(playerName);
        }

        public function __whisperBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onDeleteFriend(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (addType == "addBlock")
                {
                    Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                    ActionFactory.getInstance().getFriendCommands().addBlock(playerName);
                }
                else
                {
                    if (addType == "addFriend")
                    {
                        Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                        ActionFactory.getInstance().getFriendCommands().addFriend(playerName);
                    };
                };
            };
        }

        public function __copyBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function onReportPlayer():void
        {
            ReportPlayerWin.show();
        }

        public function __writeBtn_click(_arg_1:MouseEvent):void
        {
            writeHandler();
        }

        [Bindable(event="propertyChange")]
        public function get copyBtn():Button
        {
            return (this._953493159copyBtn);
        }

        public function __MuteBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get viewCharacterBtn():Button
        {
            return (this._2090283592viewCharacterBtn);
        }

        public function set myBlockBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._203759525myBlockBtn;
            if (_local_2 !== _arg_1)
            {
                this._203759525myBlockBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myBlockBtn", _local_2, _arg_1));
            };
        }

        private function onAddBlockResponse(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                AlertWin.show(Lang.msg("添加成功"));
            };
        }

        public function set MuteBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1216845469MuteBtn;
            if (_local_2 !== _arg_1)
            {
                this._1216845469MuteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "MuteBtn", _local_2, _arg_1));
            };
        }

        public function ___CallPrivaterWin_Button5_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function __MuteBtn_click(_arg_1:MouseEvent):void
        {
            onMute();
        }

        public function __reportPlayer_click(_arg_1:MouseEvent):void
        {
            onReportPlayer();
        }

        private function onAddUserToAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("邀请成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onAddFriendResponse(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                AlertWin.show(Lang.msg("添加成功"));
            };
        }

        public function __copyBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function ___CallPrivaterWin_Button5_click(_arg_1:MouseEvent):void
        {
            addHandler("addFriend");
        }

        public function __myBlockBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onMuteResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show((("You have muted " + this.playerName) + " for 30 mins."));
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set writeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1846497795writeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1846497795writeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "writeBtn", _local_2, _arg_1));
            };
        }

        public function set whisperBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._308570246whisperBtn;
            if (_local_2 !== _arg_1)
            {
                this._308570246whisperBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "whisperBtn", _local_2, _arg_1));
            };
        }

        public function __inviteBtn_click(_arg_1:MouseEvent):void
        {
            allianceInvite();
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


    }
}//package view.ui

