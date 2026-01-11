// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.PlayerInfo

package view.module.rank
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.controls.Image;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import mx.managers.PopUpManager;
    import mx.events.FlexEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.friend.FriendResponse;
    import view.module.mail.MailWin;
    import flash.events.MouseEvent;
    import com.evony.factory.PlayerInfoTypeManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import view.ui.OtherPlayerHero;
    import com.evony.common.module.hero.HeroListResponse;
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

    public class PlayerInfo extends Canvas implements IBindingClient 
    {

        public static var instance:PlayerInfo;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _354045452isDeleteEnabled:Boolean;
        private var _1379292085declaredWarToolTip:String;
        public var _PlayerInfo_Label1:Label;
        public var _PlayerInfo_Label2:Label;
        public var _PlayerInfo_Label6:Label;
        public var _PlayerInfo_Label8:Label;
        public var _PlayerInfo_Label3:Label;
        public var _PlayerInfo_Label4:Label;
        public var _PlayerInfo_Label7:Label;
        public var _PlayerInfo_Label9:Label;
        public var _PlayerInfo_Label5:Label;
        private var addType:String = "";
        public var _PlayerInfo_Label11:Label;
        public var _PlayerInfo_Label12:Label;
        public var _PlayerInfo_Label13:Label;
        public var _PlayerInfo_Label14:Label;
        public var _PlayerInfo_Label15:Label;
        public var _PlayerInfo_Label16:Label;
        public var _PlayerInfo_Label10:Label;
        public var _PlayerInfo_Label18:Label;
        public var _PlayerInfo_Label17:Label;
        public var _PlayerInfo_Label19:Label;
        private var _1341487512memberInfo:PlayerInfoBean;
        private var _149494237isDeclaredWarEnabled:Boolean;
        public var _PlayerInfo_Image1:Image;
        public var _PlayerInfo_Button1:Button;
        public var _PlayerInfo_Button2:Button;
        public var _PlayerInfo_Button4:Button;
        public var _PlayerInfo_Button3:Button;
        private var _1825054678isAddEnabled:Boolean;
        private var userName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":314,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_PlayerInfo_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":121,
                                "y":7,
                                "width":194,
                                "height":30,
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "18";
                            this.right = "20";
                            this.horizontalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_PlayerInfo_Button1",
                                    "events":{"click":"___PlayerInfo_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_PlayerInfo_Button2",
                                    "events":{"click":"___PlayerInfo_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_PlayerInfo_Button3",
                                    "events":{"click":"___PlayerInfo_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_PlayerInfo_Button4",
                                    "events":{"click":"___PlayerInfo_Button4_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b75",
                                            "width":75
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "163";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":91,
                                "width":400,
                                "x":20,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "height":20,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "height":20,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "height":20,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "height":20,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":90,
                                                                    "height":20,
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "width":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_PlayerInfo_Image1",
                        "events":{"complete":"___PlayerInfo_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":115,
                                "height":115
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "140";
                            this.right = "20";
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":115,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "-15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":115,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":110
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":115,
                                                                    "selectable":false,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label14",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":110
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label15",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":115,
                                                                    "selectable":false,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label16",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":110
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label17",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":115,
                                                                    "selectable":false,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label18",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "width":110
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PlayerInfo_Label19",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":115,
                                                                    "selectable":false,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___PlayerInfo_Button5_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PlayerInfo()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 314;
            this.addEventListener("creationComplete", ___PlayerInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerInfo._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:PlayerInfoBean=null):void
        {
            if (instance == null)
            {
                instance = new (PlayerInfo)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.memberInfo = _arg_1;
            ActionFactory.getInstance().getCommonCommands().getRelationship(instance.memberInfo.id);
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
            var _local_3:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
        }


        private function closeWindow():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        private function get isDeleteEnabled():Boolean
        {
            return (this._354045452isDeleteEnabled);
        }

        public function ___PlayerInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_FRIEND, onFriendAddFriendResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FRIEND_ADD_BLOCK, onFriendAddBlockResponse);
        }

        private function set isDeleteEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._354045452isDeleteEnabled;
            if (_local_2 !== _arg_1)
            {
                this._354045452isDeleteEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isDeleteEnabled", _local_2, _arg_1));
            };
        }

        private function onIsSure(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (addType == "addBlock")
                {
                    ActionFactory.getInstance().getFriendCommands().deleteFriend(memberInfo.userName, onDeleteFriend);
                }
                else
                {
                    if (addType == "addFriend")
                    {
                        ActionFactory.getInstance().getFriendCommands().deleteBlock(memberInfo.userName, onDeleteFriend);
                    };
                };
                closeWindow();
            };
        }

        private function checkHero():void
        {
            ActionFactory.getInstance().getHeroCommand().ShowPlayerHerosByUserName(memberInfo.userName, showHeroResponse);
        }

        private function onFriendAddFriendResponse(_arg_1:FriendResponse):void
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

        private function writeMessage():void
        {
            MailWin.writeMailToPlayer(memberInfo.userName);
            this.closeWindow();
        }

        [Bindable(event="propertyChange")]
        private function get isAddEnabled():Boolean
        {
            return (this._1825054678isAddEnabled);
        }

        public function ___PlayerInfo_Button2_click(_arg_1:MouseEvent):void
        {
            addHandler("addFriend");
        }

        private function _PlayerInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("玩家信息");
            _local_1 = Lang.msg("显示英雄");
            _local_1 = Lang.msg("好友列表");
            _local_1 = Lang.msg("加为好友");
            _local_1 = Lang.msg("黑名单");
            _local_1 = Lang.msg("加入黑名单");
            _local_1 = Lang.msg("写信");
            _local_1 = (Lang.msg("人口") + ": ");
            _local_1 = this.memberInfo.population;
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = this.memberInfo.prestige;
            _local_1 = (Lang.msg("城池数") + ": ");
            _local_1 = this.memberInfo.castleCount;
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = this.memberInfo.honor;
            _local_1 = (Lang.msg("爵位") + ": ");
            _local_1 = PlayerInfoTypeManager.getTitle(this.memberInfo.titleId);
            _local_1 = this.memberInfo.faceUrl;
            _local_1 = (Lang.msg("君主") + ": ");
            _local_1 = this.memberInfo.userName;
            _local_1 = (Lang.msg("所属联盟") + ": ");
            _local_1 = this.memberInfo.alliance;
            _local_1 = (Lang.msg("联盟职位") + ": ");
            _local_1 = this.memberInfo.office;
            _local_1 = (Lang.msg("排名") + ": ");
            _local_1 = this.memberInfo.ranking;
        }

        private function onDeclaredWarAgainstPlayer(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("宣战成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onFriendAddBlockResponse(_arg_1:FriendResponse):void
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

        private function set isAddEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1825054678isAddEnabled;
            if (_local_2 !== _arg_1)
            {
                this._1825054678isAddEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isAddEnabled", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get memberInfo():PlayerInfoBean
        {
            return (this._1341487512memberInfo);
        }

        private function addHandler(_arg_1:String):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            if (memberInfo.userName == Context.getInstance().getPlayerBean().playerInfo.userName)
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
                    if (PlayerInfoBean(_local_2[_local_5]).userName == memberInfo.userName)
                    {
                        AlertWin.show(Lang.msg("玩家已经在列表中"));
                        return;
                    };
                    _local_5++;
                };
                _local_6 = 0;
                while (_local_6 < _local_3.length)
                {
                    if (PlayerInfoBean(_local_3[_local_6]).userName == memberInfo.userName)
                    {
                        AlertWin.show(Lang.msg("从黑名单到好友"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                        return;
                    };
                    _local_6++;
                };
                ActionFactory.getInstance().getFriendCommands().addFriend(memberInfo.userName);
                closeWindow();
            }
            else
            {
                if (_arg_1 == "addBlock")
                {
                    addType = _arg_1;
                    _local_7 = 0;
                    while (_local_7 < _local_3.length)
                    {
                        if (PlayerInfoBean(_local_3[_local_7]).userName == memberInfo.userName)
                        {
                            AlertWin.show(Lang.msg("玩家已经在列表中"));
                            return;
                        };
                        _local_7++;
                    };
                    _local_8 = 0;
                    while (_local_8 < _local_2.length)
                    {
                        if (PlayerInfoBean(_local_2[_local_8]).userName == memberInfo.userName)
                        {
                            AlertWin.show(Lang.msg("从好友到黑名单"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                            return;
                        };
                        _local_8++;
                    };
                    ActionFactory.getInstance().getFriendCommands().addBlock(memberInfo.userName);
                    closeWindow();
                };
            };
        }

        private function set declaredWarToolTip(_arg_1:String):void
        {
            var _local_2:Object = this._1379292085declaredWarToolTip;
            if (_local_2 !== _arg_1)
            {
                this._1379292085declaredWarToolTip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declaredWarToolTip", _local_2, _arg_1));
            };
        }

        public function ___PlayerInfo_Button3_click(_arg_1:MouseEvent):void
        {
            addHandler("addBlock");
        }

        override public function initialize():void
        {
            var target:PlayerInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_PlayerInfoWatcherSetupUtil");
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
        private function get declaredWarToolTip():String
        {
            return (this._1379292085declaredWarToolTip);
        }

        private function onDeleteFriend(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (addType == "addBlock")
                {
                    Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                    ActionFactory.getInstance().getFriendCommands().addBlock(memberInfo.userName);
                }
                else
                {
                    if (addType == "addFriend")
                    {
                        Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                        ActionFactory.getInstance().getFriendCommands().addFriend(memberInfo.userName);
                    };
                };
            };
        }

        public function ___PlayerInfo_Button4_click(_arg_1:MouseEvent):void
        {
            writeMessage();
        }

        private function set isDeclaredWarEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._149494237isDeclaredWarEnabled;
            if (_local_2 !== _arg_1)
            {
                this._149494237isDeclaredWarEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isDeclaredWarEnabled", _local_2, _arg_1));
            };
        }

        private function set memberInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._1341487512memberInfo;
            if (_local_2 !== _arg_1)
            {
                this._1341487512memberInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberInfo", _local_2, _arg_1));
            };
        }

        public function ___PlayerInfo_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get isDeclaredWarEnabled():Boolean
        {
            return (this._149494237isDeclaredWarEnabled);
        }

        private function onDeclaredWar():void
        {
            ActionFactory.getInstance().getCommonCommands().declaredWarAgainstPlayer(memberInfo.id, onDeclaredWarAgainstPlayer);
        }

        public function ___PlayerInfo_Button1_click(_arg_1:MouseEvent):void
        {
            checkHero();
        }

        private function showHeroResponse(_arg_1:HeroListResponse):void
        {
            var _local_2:OtherPlayerHero;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (_arg_1.herosArray.length > 0)
                {
                    _local_2 = new OtherPlayerHero();
                    if (!_local_2.isPopUp)
                    {
                        PopUpManager.addPopUp(_local_2, MainFrame.instance, false);
                    }
                    else
                    {
                        PopUpManager.bringToFront(_local_2);
                    };
                    _local_2.setHeroList(_arg_1.herosArray);
                }
                else
                {
                    AlertWin.show(Lang.msg("未设置显示英雄"));
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___PlayerInfo_Button5_click(_arg_1:MouseEvent):void
        {
            closeWindow();
        }

        private function _PlayerInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label1.text = _arg_1;
            }, "_PlayerInfo_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("显示英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button1.label = _arg_1;
            }, "_PlayerInfo_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("好友列表");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button2.label = _arg_1;
            }, "_PlayerInfo_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("加为好友");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button2.toolTip = _arg_1;
            }, "_PlayerInfo_Button2.toolTip");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("黑名单");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button3.label = _arg_1;
            }, "_PlayerInfo_Button3.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("加入黑名单");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button3.toolTip = _arg_1;
            }, "_PlayerInfo_Button3.toolTip");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("写信");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Button4.label = _arg_1;
            }, "_PlayerInfo_Button4.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label2.text = _arg_1;
            }, "_PlayerInfo_Label2.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.population;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label3.text = _arg_1;
            }, "_PlayerInfo_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label4.text = _arg_1;
            }, "_PlayerInfo_Label4.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label5.text = _arg_1;
            }, "_PlayerInfo_Label5.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label6.text = _arg_1;
            }, "_PlayerInfo_Label6.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.castleCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label7.text = _arg_1;
            }, "_PlayerInfo_Label7.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label8.text = _arg_1;
            }, "_PlayerInfo_Label8.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label9.text = _arg_1;
            }, "_PlayerInfo_Label9.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("爵位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label10.text = _arg_1;
            }, "_PlayerInfo_Label10.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = PlayerInfoTypeManager.getTitle(this.memberInfo.titleId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label11.text = _arg_1;
            }, "_PlayerInfo_Label11.text");
            result[16] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.memberInfo.faceUrl);
            }, function (_arg_1:Object):void
            {
                _PlayerInfo_Image1.source = _arg_1;
            }, "_PlayerInfo_Image1.source");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label12.text = _arg_1;
            }, "_PlayerInfo_Label12.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label13.text = _arg_1;
            }, "_PlayerInfo_Label13.text");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所属联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label14.text = _arg_1;
            }, "_PlayerInfo_Label14.text");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label15.text = _arg_1;
            }, "_PlayerInfo_Label15.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟职位") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label16.text = _arg_1;
            }, "_PlayerInfo_Label16.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label17.text = _arg_1;
            }, "_PlayerInfo_Label17.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("排名") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label18.text = _arg_1;
            }, "_PlayerInfo_Label18.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfo.ranking;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerInfo_Label19.text = _arg_1;
            }, "_PlayerInfo_Label19.text");
            result[25] = binding;
            return (result);
        }


    }
}//package view.module.rank

