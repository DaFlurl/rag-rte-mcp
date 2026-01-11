// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.AllWindows

package view
{
    import mx.containers.Canvas;
    import view.module.info.InfoWin;
    import view.castle.BuildingInfoWin;
    import view.module.rank.VoteHisWin;
    import view.module.playerInfo.MyTreasure;
    import view.module.friendList.DisappearHeroList;
    import view.module.immediateNotice.DayMessageRss;
    import view.module.rank.VoteCurWin;
    import view.module.gift.GiftFrame;
    import view.module.immediateNotice.NoticeWin;
    import view.castle.NewOutsideBuilding;
    import view.module.playerInfo.PlayerInfoWin;
    import mx.containers.ViewStack;
    import view.module.rank.RankWin;
    import view.module.trainningField.StowLists;
    import view.module.mail.MailWin;
    import view.module.trainningField.NewArmyWin;
    import view.module.alliance.AllianceWin;
    import view.ui.BaseWindow;
    import view.castle.NewInnerBuilding;
    import view.module.tavern.TavernNewsWin;
    import view.module.rank.VoteWin;
    import view.module.quest.QuestWin;
    import view.module.friendList.FriendList;
    import view.module.shop.ShopWin;
    import view.module.rank.VotePreWin;
    import view.module.trainningField.Maneuver;
    import view.module.shop.TurntableRank;
    import view.castle.NewWallBuilding;
    import mx.core.UIComponentDescriptor;
    import com.evony.MsgDispacther;
    import mx.core.mx_internal;
    import com.evony.data.ClickBuildDate;
    import com.evony.common.beans.BuildingBean;
    import com.evony.events.WindowChangeEvent;
    import mx.events.PropertyChangeEvent;
    import view.castle.BaseNewBuildingWin;
    import com.evony.util.MinePopupManager;
    import mx.managers.PopUpManager;
    import com.evony.factory.UIFactory;
    import view.ui.AlertWin;
    import com.evony.util.EnterKeyDispatcher;
    import view.castle.TownView;
    import view.castle.MainFrame;
    import view.castle.CityView;
    import com.evony.events.OpenNewBuildingWindowEvent;
    import com.evony.Context;
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
    import view.module.tavern.*;
    import view.module.trainningField.*;
    import view.module.office.*;
    import flash.xml.*;
    import view.module.barrack.*;
    import view.module.embassy.*;
    import view.module.herosMansion.*;
    import view.module.technology.*;
    import view.module.wall.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class AllWindows extends Canvas 
    {

        public static const EVENT_CHANGE:String = "AllWindows.change";
        public static var instance:AllWindows;

        private var _1223931819infoWinVs:InfoWin;
        private var _471213023buildingInfoVs:BuildingInfoWin;
        private var _1430136436voteHisWin:VoteHisWin;
        private var _1488650088myTreasureVs:MyTreasure;
        private var _1442465880DisappearHeroListVS:DisappearHeroList;
        private var _237724936DayMessageVs:DayMessageRss;
        private var _1298043142voteCurWin:VoteCurWin;
        private var _1246042131giftVS:GiftFrame;
        private var _1585269653noticeVS:NoticeWin;
        private var _610619990newOutsideBuildingVs:NewOutsideBuilding;
        private var _544401844playerInfoVs:PlayerInfoWin;
        private var _946505330viewstack1:ViewStack;
        private var _649408787rankWinVs:RankWin;
        private var _357963108stowListVs:StowLists;
        private var _315993022mailWinVs:MailWin;
        private var _1113012486newArmyVs:NewArmyWin;
        private var _1306698068allianceVs:AllianceWin;
        public var currentWin:BaseWindow;
        private var _1273401newInnerBuildingVs:NewInnerBuilding;
        private var _1847560152TavernNewsVS:TavernNewsWin;
        private var _639312018voteWin:VoteWin;
        private var _342115685qusetWinVs:QuestWin;
        private var _303536071FriendListVS:FriendList;
        private var _2111443357shopWinVs:ShopWin;
        private var _1667064259votePreWin:VotePreWin;
        private var _2128652170maneuverVs:Maneuver;
        private var _1207797914TurntableRankVS:TurntableRank;
        private var _498913305newWallVs:NewWallBuilding;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":QuestWin,
                                    "id":"qusetWinVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":819,
                                            "height":505,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DayMessageRss,
                                                "id":"DayMessageVs",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "150";
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":BuildingInfoWin,
                                    "id":"buildingInfoVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NewWallBuilding,
                                    "id":"newWallVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NewInnerBuilding,
                                    "id":"newInnerBuildingVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllianceWin,
                                    "id":"allianceVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NewOutsideBuilding,
                                    "id":"newOutsideBuildingVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":PlayerInfoWin,
                                    "id":"playerInfoVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyTreasure,
                                    "id":"myTreasureVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ShopWin,
                                    "id":"shopWinVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":InfoWin,
                                    "id":"infoWinVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MailWin,
                                    "id":"mailWinVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RankWin,
                                    "id":"rankWinVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VoteWin,
                                    "id":"voteWin",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VoteCurWin,
                                    "id":"voteCurWin",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VotePreWin,
                                    "id":"votePreWin",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VoteHisWin,
                                    "id":"voteHisWin",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NewArmyWin,
                                    "id":"newArmyVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Maneuver,
                                    "id":"maneuverVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":StowLists,
                                    "id":"stowListVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":GiftFrame,
                                    "id":"giftVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NoticeWin,
                                    "id":"noticeVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FriendList,
                                    "id":"FriendListVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DisappearHeroList,
                                    "id":"DisappearHeroListVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TavernNewsWin,
                                    "id":"TavernNewsVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TurntableRank,
                                    "id":"TurntableRankVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":819,
                                            "height":505
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var winMap:Array = [];
        private var dispatcher:MsgDispacther = MsgDispacther.getInstance();

        public function AllWindows()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllWindows_Canvas1_creationComplete);
        }

        public static function switchToBuildingWindow(_arg_1:String, _arg_2:BuildingBean):void
        {
            switchToFuncWindow(BuildingInfoWin.EVENT_SHOW, new ClickBuildDate(_arg_2, _arg_1));
        }

        public static function closeAll():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            ChatFrame.onOtherWinCall();
        }

        public static function switchToFuncWindow(_arg_1:String, _arg_2:Object=null):void
        {
            MainWin.instance.addMoneyPic.visible = false;
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(_arg_1, _arg_2));
            MainWin.instance.showNotice = false;
        }


        [Bindable(event="propertyChange")]
        public function get rankWinVs():RankWin
        {
            return (this._649408787rankWinVs);
        }

        [Bindable(event="propertyChange")]
        public function get voteCurWin():VoteCurWin
        {
            return (this._1298043142voteCurWin);
        }

        [Bindable(event="propertyChange")]
        public function get DayMessageVs():DayMessageRss
        {
            return (this._237724936DayMessageVs);
        }

        public function set voteCurWin(_arg_1:VoteCurWin):void
        {
            var _local_2:Object = this._1298043142voteCurWin;
            if (_local_2 !== _arg_1)
            {
                this._1298043142voteCurWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteCurWin", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            instance = this;
            trace((this.className + ".init()"));
            winMap[AllianceWin.EVENT_SHOW] = this.allianceVs;
            winMap[ShopWin.EVENT_SHOW] = this.shopWinVs;
            winMap[InfoWin.EVENT_SHOW] = this.infoWinVs;
            winMap[PlayerInfoWin.EVENT_SHOW] = this.playerInfoVs;
            winMap[MyTreasure.EVENT_SHOW] = this.myTreasureVs;
            winMap[MailWin.EVENT_SHOW] = this.mailWinVs;
            winMap[QuestWin.EVENT_SHOW] = this.qusetWinVs;
            winMap[RankWin.EVENT_SHOW] = this.rankWinVs;
            winMap[NewInnerBuilding.EVENT_SHOW] = this.newInnerBuildingVs;
            winMap[NewOutsideBuilding.EVENT_SHOW] = this.newOutsideBuildingVs;
            winMap[NewWallBuilding.EVENT_SHOW] = this.newWallVs;
            winMap[NewArmyWin.EVENT_SHOW] = this.newArmyVs;
            winMap[Maneuver.EVENT_SHOW] = this.maneuverVs;
            winMap[StowLists.EVENT_SHOW] = this.stowListVs;
            winMap[BuildingInfoWin.EVENT_SHOW] = this.buildingInfoVs;
            winMap[GiftFrame.EVENT_SHOW] = this.giftVS;
            winMap[NoticeWin.EVENT_SHOW] = this.noticeVS;
            winMap[NoticeWin.EVENT_SHOW] = this.noticeVS;
            winMap[FriendList.EVENT_SHOW] = this.FriendListVS;
            winMap[DayMessageRss.EVENT_SHOW] = this.DayMessageVs;
            winMap[TavernNewsWin.EVENT_SHOW] = this.TavernNewsVS;
            winMap[TurntableRank.EVENT_SHOW] = this.TurntableRankVS;
            winMap[VoteWin.EVENT_SHOW] = this.voteWin;
            winMap[VoteCurWin.EVENT_SHOW] = this.voteCurWin;
            winMap[VotePreWin.EVENT_SHOW] = this.votePreWin;
            winMap[VoteHisWin.EVENT_SHOW] = this.voteHisWin;
            winMap[DisappearHeroList.EVENT_SHOW] = this.DisappearHeroListVS;
            dispatcher.addEventListener(EVENT_CHANGE, onWindowChange);
            this.createComponents();
        }

        public function set DayMessageVs(_arg_1:DayMessageRss):void
        {
            var _local_2:Object = this._237724936DayMessageVs;
            if (_local_2 !== _arg_1)
            {
                this._237724936DayMessageVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DayMessageVs", _local_2, _arg_1));
            };
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function set voteWin(_arg_1:VoteWin):void
        {
            var _local_2:Object = this._639312018voteWin;
            if (_local_2 !== _arg_1)
            {
                this._639312018voteWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteWin", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get TavernNewsVS():TavernNewsWin
        {
            return (this._1847560152TavernNewsVS);
        }

        public function set noticeVS(_arg_1:NoticeWin):void
        {
            var _local_2:Object = this._1585269653noticeVS;
            if (_local_2 !== _arg_1)
            {
                this._1585269653noticeVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noticeVS", _local_2, _arg_1));
            };
        }

        public function set TurntableRankVS(_arg_1:TurntableRank):void
        {
            var _local_2:Object = this._1207797914TurntableRankVS;
            if (_local_2 !== _arg_1)
            {
                this._1207797914TurntableRankVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TurntableRankVS", _local_2, _arg_1));
            };
        }

        private function createComponents():void
        {
            this.buildingInfoVs.createComponentsFromDescriptors();
        }

        public function set qusetWinVs(_arg_1:QuestWin):void
        {
            var _local_2:Object = this._342115685qusetWinVs;
            if (_local_2 !== _arg_1)
            {
                this._342115685qusetWinVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "qusetWinVs", _local_2, _arg_1));
            };
        }

        private function onWindowChange(_arg_1:WindowChangeEvent):void
        {
            var _local_2:BaseNewBuildingWin;
            MinePopupManager.instance.removePopup();
            PopUpManager.removePopUp(UIFactory.getInstance().getBuildingTooltip());
            AlertWin.close();
            if (_arg_1.getId() == WindowChangeEvent.ID_CLOSE)
            {
                EnterKeyDispatcher.instance.onEnterKeyEvent();
                if (this.currentWin != null)
                {
                    this.currentWin.destroy();
                };
                this.visible = false;
                if (((!(TownView.instance == null)) && (TownView.instance.isShow)))
                {
                    TownView.singleton().restorePlayAll();
                };
                if (MainFrame.instance != null)
                {
                    if (((!(MainFrame.instance.cityView == null)) && (MainFrame.instance.cityView.isShow)))
                    {
                        CityView.singleton().restorePlayAll();
                    };
                    if (((!(MainFrame.instance.mapWin == null)) && (MainFrame.instance.mapWin.isShow)))
                    {
                        MainFrame.instance.mapWin.restorePlayAll();
                    };
                };
                if (((!(MainWin == null)) && (!(MainWin.instance == null))))
                {
                    MainWin.instance.guidLadyBottom = 140;
                };
            }
            else
            {
                if (this.currentWin != null)
                {
                    this.currentWin.destroy();
                };
                if (TownView.instance != null)
                {
                    TownView.instance.stopPlayAll();
                };
                if (MainFrame.instance.cityView != null)
                {
                    CityView.singleton().stopPlayAll();
                };
                if (MainFrame.instance.mapWin != null)
                {
                    MainFrame.instance.mapWin.stopPlayAll();
                };
                trace(("AllWindows.onWindowChange(): event=" + _arg_1.getId()));
                if (((_arg_1.getId() == MailWin.EVENT_SHOW) || (_arg_1.getId() == AllianceWin.EVENT_SHOW)))
                {
                    EnterKeyDispatcher.instance.offEnterKeyEvent();
                };
                this.currentWin = (this.winMap[_arg_1.getId()] as BaseWindow);
                if (currentWin != null)
                {
                    this.visible = true;
                    this.viewstack1.selectedChild = currentWin;
                    if ((currentWin is BaseNewBuildingWin))
                    {
                        _local_2 = (currentWin as BaseNewBuildingWin);
                        if (_arg_1.getId() != NewWallBuilding.EVENT_SHOW)
                        {
                            _local_2.setSpace((_arg_1 as OpenNewBuildingWindowEvent).getSpace());
                        };
                    }
                    else
                    {
                        this.currentWin.eventData = (_arg_1 as WindowChangeEvent).getEventData();
                    };
                    this.currentWin.onShowEvent();
                    if (((((_arg_1.getId() == QuestWin.EVENT_SHOW) && (Context.getInstance().needUserGuide)) && (!(MainWin.instance == null))) && (MainWin.instance.height < 800)))
                    {
                        MainWin.instance.guidLadyBottom = 0;
                    };
                }
                else
                {
                    trace(("AllWindows.onWindowChange(): Window not found! event=" + _arg_1.getId()));
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get mailWinVs():MailWin
        {
            return (this._315993022mailWinVs);
        }

        [Bindable(event="propertyChange")]
        public function get FriendListVS():FriendList
        {
            return (this._303536071FriendListVS);
        }

        [Bindable(event="propertyChange")]
        public function get playerInfoVs():PlayerInfoWin
        {
            return (this._544401844playerInfoVs);
        }

        public function set myTreasureVs(_arg_1:MyTreasure):void
        {
            var _local_2:Object = this._1488650088myTreasureVs;
            if (_local_2 !== _arg_1)
            {
                this._1488650088myTreasureVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTreasureVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newOutsideBuildingVs():NewOutsideBuilding
        {
            return (this._610619990newOutsideBuildingVs);
        }

        public function set TavernNewsVS(_arg_1:TavernNewsWin):void
        {
            var _local_2:Object = this._1847560152TavernNewsVS;
            if (_local_2 !== _arg_1)
            {
                this._1847560152TavernNewsVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TavernNewsVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get DisappearHeroListVS():DisappearHeroList
        {
            return (this._1442465880DisappearHeroListVS);
        }

        [Bindable(event="propertyChange")]
        public function get allianceVs():AllianceWin
        {
            return (this._1306698068allianceVs);
        }

        public function set infoWinVs(_arg_1:InfoWin):void
        {
            var _local_2:Object = this._1223931819infoWinVs;
            if (_local_2 !== _arg_1)
            {
                this._1223931819infoWinVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoWinVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get shopWinVs():ShopWin
        {
            return (this._2111443357shopWinVs);
        }

        [Bindable(event="propertyChange")]
        public function get stowListVs():StowLists
        {
            return (this._357963108stowListVs);
        }

        public function set FriendListVS(_arg_1:FriendList):void
        {
            var _local_2:Object = this._303536071FriendListVS;
            if (_local_2 !== _arg_1)
            {
                this._303536071FriendListVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "FriendListVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get voteHisWin():VoteHisWin
        {
            return (this._1430136436voteHisWin);
        }

        [Bindable(event="propertyChange")]
        public function get maneuverVs():Maneuver
        {
            return (this._2128652170maneuverVs);
        }

        public function set mailWinVs(_arg_1:MailWin):void
        {
            var _local_2:Object = this._315993022mailWinVs;
            if (_local_2 !== _arg_1)
            {
                this._315993022mailWinVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailWinVs", _local_2, _arg_1));
            };
        }

        public function set votePreWin(_arg_1:VotePreWin):void
        {
            var _local_2:Object = this._1667064259votePreWin;
            if (_local_2 !== _arg_1)
            {
                this._1667064259votePreWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "votePreWin", _local_2, _arg_1));
            };
        }

        public function set newInnerBuildingVs(_arg_1:NewInnerBuilding):void
        {
            var _local_2:Object = this._1273401newInnerBuildingVs;
            if (_local_2 !== _arg_1)
            {
                this._1273401newInnerBuildingVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newInnerBuildingVs", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get voteWin():VoteWin
        {
            return (this._639312018voteWin);
        }

        [Bindable(event="propertyChange")]
        public function get noticeVS():NoticeWin
        {
            return (this._1585269653noticeVS);
        }

        [Bindable(event="propertyChange")]
        public function get TurntableRankVS():TurntableRank
        {
            return (this._1207797914TurntableRankVS);
        }

        [Bindable(event="propertyChange")]
        public function get qusetWinVs():QuestWin
        {
            return (this._342115685qusetWinVs);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        [Bindable(event="propertyChange")]
        public function get infoWinVs():InfoWin
        {
            return (this._1223931819infoWinVs);
        }

        public function set newOutsideBuildingVs(_arg_1:NewOutsideBuilding):void
        {
            var _local_2:Object = this._610619990newOutsideBuildingVs;
            if (_local_2 !== _arg_1)
            {
                this._610619990newOutsideBuildingVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newOutsideBuildingVs", _local_2, _arg_1));
            };
        }

        public function set allianceVs(_arg_1:AllianceWin):void
        {
            var _local_2:Object = this._1306698068allianceVs;
            if (_local_2 !== _arg_1)
            {
                this._1306698068allianceVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceVs", _local_2, _arg_1));
            };
        }

        public function set DisappearHeroListVS(_arg_1:DisappearHeroList):void
        {
            var _local_2:Object = this._1442465880DisappearHeroListVS;
            if (_local_2 !== _arg_1)
            {
                this._1442465880DisappearHeroListVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DisappearHeroListVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myTreasureVs():MyTreasure
        {
            return (this._1488650088myTreasureVs);
        }

        public function set buildingInfoVs(_arg_1:BuildingInfoWin):void
        {
            var _local_2:Object = this._471213023buildingInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._471213023buildingInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingInfoVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get votePreWin():VotePreWin
        {
            return (this._1667064259votePreWin);
        }

        public function set playerInfoVs(_arg_1:PlayerInfoWin):void
        {
            var _local_2:Object = this._544401844playerInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._544401844playerInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfoVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newInnerBuildingVs():NewInnerBuilding
        {
            return (this._1273401newInnerBuildingVs);
        }

        public function set stowListVs(_arg_1:StowLists):void
        {
            var _local_2:Object = this._357963108stowListVs;
            if (_local_2 !== _arg_1)
            {
                this._357963108stowListVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stowListVs", _local_2, _arg_1));
            };
        }

        public function set shopWinVs(_arg_1:ShopWin):void
        {
            var _local_2:Object = this._2111443357shopWinVs;
            if (_local_2 !== _arg_1)
            {
                this._2111443357shopWinVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shopWinVs", _local_2, _arg_1));
            };
        }

        public function set newWallVs(_arg_1:NewWallBuilding):void
        {
            var _local_2:Object = this._498913305newWallVs;
            if (_local_2 !== _arg_1)
            {
                this._498913305newWallVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newWallVs", _local_2, _arg_1));
            };
        }

        public function set giftVS(_arg_1:GiftFrame):void
        {
            var _local_2:Object = this._1246042131giftVS;
            if (_local_2 !== _arg_1)
            {
                this._1246042131giftVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giftVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingInfoVs():BuildingInfoWin
        {
            return (this._471213023buildingInfoVs);
        }

        public function set rankWinVs(_arg_1:RankWin):void
        {
            var _local_2:Object = this._649408787rankWinVs;
            if (_local_2 !== _arg_1)
            {
                this._649408787rankWinVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rankWinVs", _local_2, _arg_1));
            };
        }

        public function set voteHisWin(_arg_1:VoteHisWin):void
        {
            var _local_2:Object = this._1430136436voteHisWin;
            if (_local_2 !== _arg_1)
            {
                this._1430136436voteHisWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteHisWin", _local_2, _arg_1));
            };
        }

        public function set maneuverVs(_arg_1:Maneuver):void
        {
            var _local_2:Object = this._2128652170maneuverVs;
            if (_local_2 !== _arg_1)
            {
                this._2128652170maneuverVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maneuverVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get giftVS():GiftFrame
        {
            return (this._1246042131giftVS);
        }

        public function set newArmyVs(_arg_1:NewArmyWin):void
        {
            var _local_2:Object = this._1113012486newArmyVs;
            if (_local_2 !== _arg_1)
            {
                this._1113012486newArmyVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newArmyVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newArmyVs():NewArmyWin
        {
            return (this._1113012486newArmyVs);
        }

        public function ___AllWindows_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get newWallVs():NewWallBuilding
        {
            return (this._498913305newWallVs);
        }


    }
}//package view

