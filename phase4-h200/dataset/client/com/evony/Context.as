// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.Context

package com.evony
{
    import flash.events.IEventDispatcher;
    import com.evony.common.beans.CastleBean;
    import flash.events.EventDispatcher;
    import com.evony.net.client.GameClient;
    import com.evony.common.beans.PlayerBean;
    import flash.utils.Timer;
    import mx.collections.ArrayCollection;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.beans.BuildingBean;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.common.CommonUtil;
    import com.evony.events.BuildnewCastleEvent;
    import com.evony.common.server.events.SelfArmysUpdate;
    import flash.events.Event;
    import com.evony.common.server.events.FortificationsUpdate;
    import com.evony.common.beans.ItemBean;
    import com.evony.util.UIUtil;
    import com.evony.events.BuildingChangeEvent;
    import view.castle.TownView;
    import view.castle.CityView;
    import view.MainWin;
    import view.ChatFrame;
    import view.questWizard.Questwizard;
    import view.castle._BottomToolBar;
    import view.module.guide.GuideStep;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.common.beans.CastleResourceBean;
    import view.RandomEventWin;
    import flash.events.TimerEvent;
    import com.evony.common.beans.FieldBean;
    import com.evony.common.constants.CommonConstants;
    import com.evony.common.server.events.CastleFieldUpdate;
    import view.castleList.AllCastleFrame;
    import view.AllWindows;
    import com.evony.common.beans.TransingTradeBean;
    import com.evony.common.server.events.TransingTradeUpdate;
    import com.evony.common.server.events.FriendArmysUpdate;
    import com.evony.common.server.events.TroopUpdate;
    import view.module.office.ModifyCastleNameView;
    import com.evony.util.MinePopupManager;
    import com.evony.common.server.events.CastleUpdate;
    import flash.external.ExternalInterface;
    import com.evony.common.server.events.MercenaryUpdate;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.common.server.events.BuildingQueueUpdate;
    import com.evony.common.server.events.EnemyArmysUpdate;
    import com.evony.common.server.events.ResourceUpdate;
    import com.evony.common.beans.BuffBean;
    import com.evony.factory.BuffManager;
    import com.evony.common.server.events.PlayerBuffUpdate;
    import com.evony.common.beans.TradeBean;
    import com.evony.common.server.events.TradesUpdate;
    import mx.utils.UIDUtil;
    import view.ui.TargetCount;
    import com.evony.common.server.events.PlayerInfoUpdate;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.server.events.HeroUpdate;
    import com.evony.common.server.events.ColonyUpdate;
    import com.evony.common.server.events.ItemUpdate;
    import flash.events.*;
    import flash.utils.*;
    import flash.external.*;

    public class Context implements IEventDispatcher 
    {

        private static var instance:Context = new (Context)();
        public static const INNER_BUILDING_POSITION:int = 100;
        public static const EVENT_CASTLE_MOVE:String = "Context.curCastleMove";
        public static const EVENT_CASTLE_CHANGE:String = "Context.curCastleChange";
        public static const EVENT_PLAYER_LOGIN:String = "Context.login";
        public static const EVENT_PLAYINFO_UPDATE:String = "Context.PlayerInfoUpdate";
        public static var mapSizeX:int = 800;
        public static var mapSizeY:int = 800;
        public static var gameSpeed:int = 1;

        public var iDemolishedPosId:int = -100;
        private var _633161435noAccountProtection:Boolean = true;
        public var bCostSure:Boolean = true;
        public var saveGame:Boolean = false;
        public var fbUrl:String;
        public var fbType:String;
        private var _984278523needUserGuide:Boolean = false;
        private var loginDateTime:Date;
        private var LoginPrestigeValue:int = -1;
        private var _1128135084bVisitor:Boolean = false;
        public var isSpeedType:int = 0;
        private var _866650764facebookNickName:String = "";
        public var positionId:int;
        public var VisitSelfSID:String;
        private var _363649103facebookUser:Boolean = false;
        public var isLink:Boolean;
        public var iDigiTypeId:int;
        public var taskXY:String;
        public var bVictor:Boolean = false;
        public var iDigiQuestId:int;
        public var need_speedSound:Boolean = false;
        private var _1826408047serverDate:int;
        private var curCastle:CastleBean = null;
        private var _1778134832voteToName:String;
        public var iPicId:int = 0;
        public var bVote:Boolean = false;
        public var iFbStep:int = 0;
        private var timeDiff:Number;
        public var iBuildFinish:int = -1;
        public var bVisitHostName:String = "";
        private var _1061693952voteUserName:String;
        public var army_RedCount:uint;
        public var taskId:String;
        public var bSaveGame:Boolean = false;
        private var _779961972serverHours:int;
        public var army_BlueCount:uint;
        public var password:String = "";
        private var _2040226844serverMinutes:int;
        private var _222927675isBuildHelp:Boolean = false;
        public var iAnimalPlayFlag:int = 3;
        private var _1963568934selectServerId:String;
        public var iCurrentBuilding:int = -1;
        private var _2113784044bLoginSecurityCode:Boolean = false;
        private var _231948802need_QuestGuid:Boolean = false;
        private var _bindingEventDispatcher:EventDispatcher;
        public var iXcState:int = 0;
        private var _1610857705bCancelSecurityCode:Boolean = false;
        public var client:GameClient;
        public var userIsFirstLogin:Boolean = false;
        public var buidwithhelpLevel:String;
        public var blueCount:uint;
        public var isResearchHelp:Boolean = false;
        public var buidwithhelpName:String;
        private var player:PlayerBean;
        private var _1825779168serverYear:int;
        private var _775351043serverMonth:int;
        public var TargetFbuid:String = "";
        public var userName:String = "";
        private var myTimer:Timer;

        public var equipTechArr:ArrayCollection = new ArrayCollection();
        public var FbFriendArr:Array = new Array();

        public function Context()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onBuildComplete);
            _local_1.addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, onHeroUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, onResourceUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, onPlayerInfoUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, onItemUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, onSelfArmysUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, onEnemyArmysUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, onFriendArmysUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, onTroopUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, onFortiFicationsUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, onCastleFieldUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_TRADES_UPDATE, onTradesUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_TRANSING_TRADE_UPDATE, onTransingTradeUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_PLAYER_BUFF_UPDATE, onPlayerBuffUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, onCastleUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_COLONY_UPDATE, onColonyUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_MERCENARY_UPDATE, onMercenaryUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_BUILDING_QUEUE_UPDATE, onBuildingQueueUpdate);
        }

        public static function getInstance():Context
        {
            return (instance);
        }


        [Bindable(event="propertyChange")]
        public function get needUserGuide():Boolean
        {
            return (this._984278523needUserGuide);
        }

        public function getBuildingObjByType(_arg_1:int):BuildingBean
        {
            var _local_3:BuildingBean;
            var _local_2:CastleBean = this.getCurCastle();
            for each (_local_3 in _local_2.buildingsArray)
            {
                if (_local_3.typeId == _arg_1)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        [Bindable(event="propertyChange")]
        public function get need_QuestGuid():Boolean
        {
            return (this._231948802need_QuestGuid);
        }

        public function set facebookNickName(_arg_1:String):void
        {
            var _local_2:Object = this._866650764facebookNickName;
            if (_local_2 !== _arg_1)
            {
                this._866650764facebookNickName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebookNickName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverMonth():int
        {
            return (this._775351043serverMonth);
        }

        public function isBuildingQueued(_arg_1:int):Boolean
        {
            var _local_2:BuildingQueueBean;
            for each (_local_2 in this.getCurCastle().buildingQueuesArray)
            {
                if (_local_2.positionId == _arg_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        private function onSelfArmysUpdate(_arg_1:SelfArmysUpdate):void
        {
            CommonUtil.arrayCopy(_arg_1.armysArray, player.selfArmysArray);
            MsgDispacther.getInstance().dispatchEvent(new BuildnewCastleEvent(_arg_1.armysArray));
        }

        public function set serverHours(_arg_1:int):void
        {
            var _local_2:Object = this._779961972serverHours;
            if (_local_2 !== _arg_1)
            {
                this._779961972serverHours = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverHours", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get bLoginSecurityCode():Boolean
        {
            return (this._2113784044bLoginSecurityCode);
        }

        public function set need_QuestGuid(_arg_1:Boolean):void
        {
            var _local_2:Object = this._231948802need_QuestGuid;
            if (_local_2 !== _arg_1)
            {
                this._231948802need_QuestGuid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "need_QuestGuid", _local_2, _arg_1));
            };
        }

        public function setCurCastle(_arg_1:CastleBean):void
        {
            if (((this.curCastle == null) || (!(_arg_1.id == this.curCastle.id))))
            {
                trace(("Context.setCurCastle(): curCastle change to " + _arg_1.id));
                this.curCastle = _arg_1;
                MsgDispacther.getInstance().dispatchEvent(new Event(EVENT_CASTLE_CHANGE));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverYear():int
        {
            return (this._1825779168serverYear);
        }

        [Bindable(event="propertyChange")]
        public function get serverMinutes():int
        {
            return (this._2040226844serverMinutes);
        }

        public function getPlayerBean():PlayerBean
        {
            return (this.player);
        }

        private function onFortiFicationsUpdate(_arg_1:FortificationsUpdate):void
        {
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                _arg_1.fortification.copyTo(_local_2.fortification);
            };
        }

        [Bindable(event="propertyChange")]
        public function get voteToName():String
        {
            return (this._1778134832voteToName);
        }

        public function isItemEnough(_arg_1:String, _arg_2:int=1):Boolean
        {
            var _local_4:ItemBean;
            var _local_3:int;
            while (_local_3 < this.player.itemsArray.length)
            {
                _local_4 = this.player.getItems(_local_3);
                if (((_local_4.id == _arg_1) && (_local_4.count >= _arg_2)))
                {
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        [Bindable(event="propertyChange")]
        public function get voteUserName():String
        {
            return (this._1061693952voteUserName);
        }

        public function set serverMinutes(_arg_1:int):void
        {
            var _local_2:Object = this._2040226844serverMinutes;
            if (_local_2 !== _arg_1)
            {
                this._2040226844serverMinutes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverMinutes", _local_2, _arg_1));
            };
        }

        private function onBuildComplete(_arg_1:BuildComplate):void
        {
            var _local_3:Boolean;
            var _local_4:int;
            var _local_5:BuildingBean;
            var _local_6:String;
            trace("Context.onBuildComplete.");
            var _local_2:CastleBean = getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                _local_3 = false;
                _local_4 = 0;
                while (_local_4 < _local_2.buildingsArray.length)
                {
                    _local_5 = _local_2.getBuildings(_local_4);
                    if (_local_5.positionId == _arg_1.buildingBean.positionId)
                    {
                        if (UIUtil.isBuildingDestroy(_arg_1.buildingBean))
                        {
                            trace(((("Context.onBuildComplete():castleId=" + _local_2.id) + " delete from array id=") + _local_4));
                            _local_2.buildingsArray.removeItemAt(_local_4);
                            if (Context.getInstance().getCurCastle().id == _arg_1.castleId)
                            {
                                if (UIUtil.isInnerBuilding(_arg_1.buildingBean.positionId))
                                {
                                    MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_DESTROY, _arg_1.buildingBean));
                                }
                                else
                                {
                                    MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_DESTROY, _arg_1.buildingBean));
                                };
                            };
                        }
                        else
                        {
                            if (BuildingBean(_local_2.buildingsArray[_local_4]).status != _arg_1.buildingBean.status)
                            {
                                if (BuildingBean(_local_2.buildingsArray[_local_4]).level < _arg_1.buildingBean.level)
                                {
                                };
                                _arg_1.buildingBean.copyTo(_local_2.buildingsArray[_local_4]);
                                trace(((("Context.onBuildComplete():castleId=" + _local_2.id) + " update buildingBean to Array, ArrayId=") + _local_4));
                                if (Context.getInstance().getCurCastle().id == _arg_1.castleId)
                                {
                                    if (UIUtil.isInnerBuilding(_arg_1.buildingBean.positionId))
                                    {
                                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_COMPLETE, _arg_1.buildingBean));
                                    }
                                    else
                                    {
                                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_COMPLETE, _arg_1.buildingBean));
                                    };
                                };
                                if (_arg_1.buildingBean.status == 0)
                                {
                                    if (_arg_1.buildingBean.positionId == iDemolishedPosId)
                                    {
                                        _local_6 = ((((((("<FONT COLOR='#FF0000'>" + _local_2.name) + "</FONT>") + "'s ") + "<FONT COLOR='#0066FF'>") + _arg_1.buildingBean.name) + "</FONT>") + " demolished successfully!");
                                    }
                                    else
                                    {
                                        if (_arg_1.buildingBean.level != 1)
                                        {
                                            _local_6 = (((((((((((("<FONT COLOR='#FF0000'>" + _local_2.name) + "</FONT>") + "'s ") + "<FONT COLOR='#0066FF'>") + _arg_1.buildingBean.name) + "</FONT>") + " upgrade to ") + "<FONT COLOR='#FF0000'>") + "LV ") + _arg_1.buildingBean.level) + "</FONT>") + " successfully！");
                                        }
                                        else
                                        {
                                            _local_6 = ((((((("<FONT COLOR='#FF0000'>" + _local_2.name) + "</FONT>") + "'s ") + "<FONT COLOR='#0066FF'>") + _arg_1.buildingBean.name) + "</FONT>") + " build successfully！");
                                        };
                                    };
                                    MainWin.instance.onFinishInfoMsg(_local_6);
                                    ChatFrame.instance.onFinishInfoMSg(_local_6);
                                    if (Context.getInstance().need_QuestGuid)
                                    {
                                        Questwizard.instance.GetQuestList();
                                    };
                                };
                            }
                            else
                            {
                                _arg_1.buildingBean.copyTo(_local_2.buildingsArray[_local_4]);
                            };
                        };
                        _local_3 = true;
                    };
                    _local_4++;
                };
                if (!_local_3)
                {
                    this.curCastle.buildingsArray.addItem(_arg_1.buildingBean);
                    if (Context.getInstance().getCurCastle().id == _arg_1.castleId)
                    {
                        if (UIUtil.isInnerBuilding(_arg_1.buildingBean.positionId))
                        {
                            MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_CREATED, _arg_1.buildingBean));
                        }
                        else
                        {
                            MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_CREATED, _arg_1.buildingBean));
                        };
                    };
                };
                if (Context.getInstance().getCurCastle().id == _arg_1.castleId)
                {
                    if (UIUtil.isInnerBuilding(_arg_1.buildingBean.positionId))
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_UPDATE, _arg_1.buildingBean));
                    }
                    else
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_UPDATE, _arg_1.buildingBean));
                    };
                };
                _BottomToolBar.buildingUpdate(_arg_1);
                GuideStep.getInstance().checkStepBuilding();
            };
        }

        [Bindable(event="propertyChange")]
        public function get noAccountProtection():Boolean
        {
            return (this._633161435noAccountProtection);
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            var _local_7:CastleBean;
            var _local_8:CastleResourceBean;
            var _local_2:Array = this.player.currentDateTime.toString().split(" ");
            var _local_3:Array = _local_2[0].toString().split(".");
            var _local_4:Array = _local_2[1].toString().split(".");
            var _local_5:Date = new Date(_local_3[0], (_local_3[1] - 1), _local_3[2], _local_4[0], _local_4[1], _local_4[2]);
            var _local_6:Date = new Date(((_local_5.valueOf() + new Date().valueOf()) - this.loginDateTime.valueOf()));
            serverHours = _local_6.getHours();
            serverMinutes = _local_6.getMinutes();
            serverYear = _local_6.getFullYear();
            serverMonth = (_local_6.getMonth() + 1);
            serverDate = _local_6.getDate();
            if (!bVote)
            {
                if (((serverHours == 0) && (serverMinutes == 30)))
                {
                    bVote = true;
                    if (((GameConfig.instance.serverID == "beta") || (GameConfig.instance.serverID == "NA3")))
                    {
                        RandomEventWin.show(8);
                    };
                };
            };
            for each (_local_7 in this.player.castlesArray)
            {
                _local_8 = _local_7.resource;
                if (_local_8.food.amount < _local_8.food.max)
                {
                    _local_8.food.amount = (_local_8.food.amount + ((((_local_8.food.increaseRate - _local_8.troopCostFood) + Context.getInstance().getCurCastle().resource.colonyFood) + Context.getInstance().getCurCastle().resource.supplyFood) / 3600));
                    if (_local_8.food.amount < 0)
                    {
                        _local_8.food.amount = 0;
                    };
                }
                else
                {
                    if (((_local_8.food.increaseRate - _local_8.troopCostFood) / 3600) < 0)
                    {
                        _local_8.food.amount = (_local_8.food.amount + ((_local_8.food.increaseRate - _local_8.troopCostFood) / 3600));
                    };
                };
                if (_local_8.wood.amount < _local_8.wood.max)
                {
                    _local_8.wood.amount = (_local_8.wood.amount + (_local_8.wood.increaseRate / 3600));
                    if (_local_8.wood.amount < 0)
                    {
                        _local_8.wood.amount = 0;
                    };
                };
                if (_local_8.stone.amount < _local_8.stone.max)
                {
                    _local_8.stone.amount = (_local_8.stone.amount + (_local_8.stone.increaseRate / 3600));
                    if (_local_8.stone.amount < 0)
                    {
                        _local_8.stone.amount = 0;
                    };
                };
                if (_local_8.iron.amount < _local_8.iron.max)
                {
                    _local_8.iron.amount = (_local_8.iron.amount + (_local_8.iron.increaseRate / 3600));
                    if (_local_8.iron.amount < 0)
                    {
                        _local_8.iron.amount = 0;
                    };
                };
            };
        }

        private function onCastleFieldUpdate(_arg_1:CastleFieldUpdate):void
        {
            var _local_3:int;
            var _local_4:FieldBean;
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                {
                    _local_2.fieldsArray.addItem(_arg_1.bean);
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < _local_2.fieldsArray.length)
                    {
                        _local_4 = (_local_2.fieldsArray[_local_3] as FieldBean);
                        if (_local_4.id == _arg_1.bean.id)
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                            {
                                _local_2.fieldsArray.removeItemAt(_local_3);
                            }
                            else
                            {
                                _arg_1.bean.copyTo(_local_4);
                            };
                            return;
                        };
                        _local_3++;
                    };
                };
            };
        }

        public function setPlayerBean(_arg_1:PlayerBean):void
        {
            mapSizeX = _arg_1.mapSizeX;
            mapSizeY = _arg_1.mapSizeY;
            trace("Context.setPlayerBean()");
            this.player = _arg_1;
            this.setCurCastle(this.findFirstCastle());
            MsgDispacther.getInstance().dispatchEvent(new Event(AllCastleFrame.EVENT_REFRESH));
            AllWindows.closeAll();
            if (myTimer == null)
            {
                myTimer = new Timer(1000, 0);
                myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                myTimer.start();
            };
            var _local_2:Date = new Date();
            this.timeDiff = (_local_2.valueOf() - _arg_1.currentTime);
            this.loginDateTime = _local_2;
            MsgDispacther.getInstance().dispatchEvent(new Event(EVENT_PLAYER_LOGIN));
        }

        private function findFirstCastle():CastleBean
        {
            var _local_2:CastleBean;
            var _local_1:CastleBean;
            for each (_local_2 in player.castlesArray)
            {
                if (_local_1 == null)
                {
                    _local_1 = _local_2;
                }
                else
                {
                    if (_local_1.id > _local_2.id)
                    {
                        _local_1 = _local_2;
                    };
                };
            };
            return (_local_1);
        }

        public function set bVisitor(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1128135084bVisitor;
            if (_local_2 !== _arg_1)
            {
                this._1128135084bVisitor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bVisitor", _local_2, _arg_1));
            };
        }

        public function set bLoginSecurityCode(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2113784044bLoginSecurityCode;
            if (_local_2 !== _arg_1)
            {
                this._2113784044bLoginSecurityCode = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bLoginSecurityCode", _local_2, _arg_1));
            };
        }

        private function onTransingTradeUpdate(_arg_1:TransingTradeUpdate):void
        {
            var _local_3:int;
            var _local_4:TransingTradeBean;
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                {
                    _local_2.transingTradesArray.addItem(_arg_1.bean);
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < _local_2.transingTradesArray.length)
                    {
                        _local_4 = (_local_2.transingTradesArray[_local_3] as TransingTradeBean);
                        if (_local_4.id == _arg_1.bean.id)
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                            {
                                _local_2.transingTradesArray.removeItemAt(_local_3);
                            }
                            else
                            {
                                _arg_1.bean.copyTo(_local_4);
                            };
                            return;
                        };
                        _local_3++;
                    };
                };
            };
        }

        private function onFriendArmysUpdate(_arg_1:FriendArmysUpdate):void
        {
            CommonUtil.arrayCopy(_arg_1.armysArray, player.friendArmysArray);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set serverDate(_arg_1:int):void
        {
            var _local_2:Object = this._1826408047serverDate;
            if (_local_2 !== _arg_1)
            {
                this._1826408047serverDate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverDate", _local_2, _arg_1));
            };
        }

        public function EncryptParam(_arg_1:String):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:* = "";
            while (_local_4 < _arg_1.length)
            {
                _local_3 = _arg_1.charCodeAt(_local_4);
                _local_2 = (_local_2 + _local_3.toString(16));
                _local_4++;
            };
            return (_local_2);
        }

        private function onTroopUpdate(_arg_1:TroopUpdate):void
        {
            var _local_2:CastleBean = this.getCastleById(_arg_1.caslteId);
            if (_local_2 != null)
            {
                _arg_1.troop.copyTo(_local_2.troop);
            };
        }

        public function set serverYear(_arg_1:int):void
        {
            var _local_2:Object = this._1825779168serverYear;
            if (_local_2 !== _arg_1)
            {
                this._1825779168serverYear = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverYear", _local_2, _arg_1));
            };
        }

        private function onCastleUpdate(_arg_1:CastleUpdate):void
        {
            var _local_2:int;
            var _local_3:CastleBean;
            trace(("event.updateType-----------------:" + _arg_1.updateType));
            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
            {
                this.player.castlesArray.addItem(_arg_1.castleBean);
                MsgDispacther.getInstance().dispatchEvent(new Event(AllCastleFrame.EVENT_REFRESH));
                if (_arg_1.castleBean.powerlevel >= 4)
                {
                    ModifyCastleNameView.show(_arg_1.castleBean);
                };
            }
            else
            {
                _local_2 = 0;
                while (_local_2 < this.player.castlesArray.length)
                {
                    _local_3 = (this.player.castlesArray[_local_2] as CastleBean);
                    if (_local_3.id == _arg_1.castleBean.id)
                    {
                        if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                            {
                                this.player.castlesArray.removeItemAt(_local_2);
                                MsgDispacther.getInstance().dispatchEvent(new Event(AllCastleFrame.EVENT_REFRESH));
                            }
                            else
                            {
                                _local_3.fieldId = _arg_1.castleBean.fieldId;
                                _local_3.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = _arg_1.castleBean.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
                            };
                            if (_arg_1.castleBean.id == curCastle.id)
                            {
                                MinePopupManager.instance.removePopup();
                                AllWindows.closeAll();
                                this.setCurCastle(this.findFirstCastle());
                            };
                        }
                        else
                        {
                            _local_3.fieldId = _arg_1.castleBean.fieldId;
                            _local_3.usePACIFY_SUCCOUR_OR_PACIFY_PRAY = _arg_1.castleBean.usePACIFY_SUCCOUR_OR_PACIFY_PRAY;
                        };
                        return;
                    };
                    _local_2++;
                };
            };
        }

        public function fbPublish(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("facebook.fb_streamPublish", "", _arg_1, _arg_2, "", "", _arg_3, _arg_4, _arg_5, facebookNickName);
            };
        }

        public function set voteUserName(_arg_1:String):void
        {
            var _local_2:Object = this._1061693952voteUserName;
            if (_local_2 !== _arg_1)
            {
                this._1061693952voteUserName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteUserName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get facebookNickName():String
        {
            return (this._866650764facebookNickName);
        }

        public function set noAccountProtection(_arg_1:Boolean):void
        {
            var _local_2:Object = this._633161435noAccountProtection;
            if (_local_2 !== _arg_1)
            {
                this._633161435noAccountProtection = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAccountProtection", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set voteToName(_arg_1:String):void
        {
            var _local_2:Object = this._1778134832voteToName;
            if (_local_2 !== _arg_1)
            {
                this._1778134832voteToName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteToName", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set facebookUser(_arg_1:Boolean):void
        {
            var _local_2:Object = this._363649103facebookUser;
            if (_local_2 !== _arg_1)
            {
                this._363649103facebookUser = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebookUser", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function getBuildingObjByPosision(_arg_1:int):BuildingBean
        {
            var _local_3:BuildingBean;
            var _local_2:CastleBean = this.getCurCastle();
            for each (_local_3 in _local_2.buildingsArray)
            {
                if (_local_3.positionId == _arg_1)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        private function onMercenaryUpdate(_arg_1:MercenaryUpdate):void
        {
            var _local_3:int;
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                if (_arg_1.mercenaryBean.status == 1)
                {
                    _local_2.mercenaryBeansArray.addItem(_arg_1.mercenaryBean);
                }
                else
                {
                    while (_local_3 < _local_2.mercenaryBeansArray.length)
                    {
                        if (_arg_1.mercenaryBean.castleId == _local_2.mercenaryBeansArray[_local_3].castleId)
                        {
                            _local_2.mercenaryBeansArray.removeItemAt(_local_3);
                            break;
                        };
                        _local_3++;
                    };
                };
            };
            if (_arg_1.castleId == Context.getInstance().getCurCastle().id)
            {
                MsgDispacther.getInstance().dispatchEvent(new Event(_BottomToolBar.EVENT_REFRESHSELFARMYS));
            };
        }

        private function onBuildingQueueUpdate(_arg_1:BuildingQueueUpdate):void
        {
            var _local_3:int;
            var _local_4:BuildingQueueBean;
            var _local_5:String;
            var _local_2:CastleBean = getCastleById(_arg_1.castleId);
            if (_local_2 == null)
            {
                return;
            };
            switch (_arg_1.buildingQueueBean.status)
            {
                case BuildingConstants.STATUS_QUEUE_ADD:
                    _local_2.buildingQueuesArray.addItem(_arg_1.buildingQueueBean);
                    break;
                case BuildingConstants.STATUS_QUEUE_UPDATE:
                    _local_3 = 0;
                    while (_local_3 < _local_2.buildingQueuesArray.length)
                    {
                        _local_4 = _local_2.getBuildingQueues(_local_3);
                        if (_local_4.id == _arg_1.buildingQueueBean.id)
                        {
                            _local_2.setBuildingQueues(_arg_1.buildingQueueBean, _local_3);
                            break;
                        };
                        _local_3++;
                    };
                    break;
                case BuildingConstants.STATUS_QUEUE_REMOVE:
                case BuildingConstants.STATUS_QUEUE_REMOVED_WITHOUT_BUILD:
                    _local_3 = 0;
                    while (_local_3 < _local_2.buildingQueuesArray.length)
                    {
                        _local_4 = _local_2.getBuildingQueues(_local_3);
                        if (_local_4.id == _arg_1.buildingQueueBean.id)
                        {
                            _local_2.buildingQueuesArray.removeItemAt(_local_3);
                            break;
                        };
                        _local_3++;
                    };
                    break;
            };
            if (Context.getInstance().getCurCastle().id == _arg_1.castleId)
            {
                if (UIUtil.isInnerBuilding(_arg_1.buildingQueueBean.positionId))
                {
                    if (((_arg_1.buildingQueueBean.status == BuildingConstants.STATUS_QUEUE_ADD) || (_arg_1.buildingQueueBean.status == BuildingConstants.STATUS_QUEUE_UPDATE)))
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_QUEUE_UPDATE, null, _arg_1.castleId, _arg_1.buildingQueueBean));
                    }
                    else
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(TownView.EVENT_BUILDING_QUEUE_REMOVED, null, _arg_1.castleId, _arg_1.buildingQueueBean));
                    };
                }
                else
                {
                    if (((_arg_1.buildingQueueBean.status == BuildingConstants.STATUS_QUEUE_ADD) || (_arg_1.buildingQueueBean.status == BuildingConstants.STATUS_QUEUE_UPDATE)))
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_QUEUE_UPDATE, null, _arg_1.castleId, _arg_1.buildingQueueBean));
                    }
                    else
                    {
                        MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(CityView.EVENT_BUILDING_QUEUE_REMOVED, null, _arg_1.castleId, _arg_1.buildingQueueBean));
                    };
                };
            };
            _BottomToolBar.buildingQueueUpdate(_arg_1);
            if (_arg_1.buildingQueueBean.status == BuildingConstants.STATUS_QUEUE_REMOVED_WITHOUT_BUILD)
            {
                _local_5 = ((((((((((("<FONT COLOR='#FF0000'>" + _local_2.name) + "</FONT>") + "'s ") + "<FONT COLOR='#0066FF'>") + _arg_1.buildingQueueBean.name) + "</FONT>") + "<FONT COLOR='#FF0000'>") + " LV.") + _arg_1.buildingQueueBean.level) + " building queue canceled for requirement not met！") + "</FONT>");
                MainWin.instance.onFinishInfoMsg(_local_5);
                ChatFrame.instance.onFinishInfoMSg(_local_5);
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverDate():int
        {
            return (this._1826408047serverDate);
        }

        [Bindable(event="propertyChange")]
        public function get bCancelSecurityCode():Boolean
        {
            return (this._1610857705bCancelSecurityCode);
        }

        public function getBuildingQueueMaxLevel(_arg_1:int):int
        {
            var _local_3:BuildingQueueBean;
            if (this.getCurCastle().buildingQueuesArray == null)
            {
                return (-1);
            };
            var _local_2:int = -1;
            for each (_local_3 in this.getCurCastle().buildingQueuesArray)
            {
                if ((((_local_3.positionId == _arg_1) && (_local_3.queueType == BuildingConstants.BUILDING_QUEUE_UPGRADING)) && (_local_3.level > _local_2)))
                {
                    _local_2 = _local_3.level;
                };
            };
            return (_local_2);
        }

        private function onEnemyArmysUpdate(_arg_1:EnemyArmysUpdate):void
        {
            CommonUtil.arrayCopy(_arg_1.armysArray, player.enemyArmysArray);
        }

        [Bindable(event="propertyChange")]
        public function get bVisitor():Boolean
        {
            return (this._1128135084bVisitor);
        }

        public function set selectServerId(_arg_1:String):void
        {
            var _local_2:Object = this._1963568934selectServerId;
            if (_local_2 !== _arg_1)
            {
                this._1963568934selectServerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectServerId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverHours():int
        {
            return (this._779961972serverHours);
        }

        private function onResourceUpdate(_arg_1:ResourceUpdate):void
        {
            trace("Context.onResourceUpdate.");
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                _arg_1.resource.copyTo(_local_2.resource);
            };
        }

        private function onPlayerBuffUpdate(_arg_1:PlayerBuffUpdate):void
        {
            var _local_2:int;
            var _local_3:BuffBean;
            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
            {
                this.player.buffsArray.addItem(_arg_1.buffBean);
            }
            else
            {
                _local_2 = 0;
                while (_local_2 < this.player.buffsArray.length)
                {
                    _local_3 = (this.player.buffsArray[_local_2] as BuffBean);
                    if (_local_3.typeId == _arg_1.buffBean.typeId)
                    {
                        if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                        {
                            this.player.buffsArray.removeItemAt(_local_2);
                        }
                        else
                        {
                            _arg_1.buffBean.copyTo(_local_3);
                        };
                        break;
                    };
                    _local_2++;
                };
            };
            BuffManager.sortBuffArray(this.player.buffsArray);
            MsgDispacther.getInstance().dispatchEvent(new Event("refreshBuff"));
        }

        private function onTradesUpdate(_arg_1:TradesUpdate):void
        {
            var _local_3:int;
            var _local_4:TradeBean;
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                {
                    _local_2.tradesArray.addItem(_arg_1.tradeBean);
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < _local_2.tradesArray.length)
                    {
                        _local_4 = (_local_2.tradesArray[_local_3] as TradeBean);
                        if (_local_4.id == _arg_1.tradeBean.id)
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                            {
                                _local_2.tradesArray.removeItemAt(_local_3);
                            }
                            else
                            {
                                _arg_1.tradeBean.copyTo(_local_4);
                            };
                            return;
                        };
                        _local_3++;
                    };
                };
            };
        }

        public function set isBuildHelp(_arg_1:Boolean):void
        {
            var _local_2:Object = this._222927675isBuildHelp;
            if (_local_2 !== _arg_1)
            {
                this._222927675isBuildHelp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBuildHelp", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isBuildHelp():Boolean
        {
            return (this._222927675isBuildHelp);
        }

        [Bindable(event="propertyChange")]
        public function get facebookUser():Boolean
        {
            return (this._363649103facebookUser);
        }

        public function GetGuidStr():String
        {
            return (UIDUtil.createUID());
        }

        private function onPlayerInfoUpdate(_arg_1:PlayerInfoUpdate):void
        {
            _arg_1.playerInfo.copyTo(this.player.playerInfo);
            if (this.LoginPrestigeValue == -1)
            {
                this.LoginPrestigeValue = this.player.playerInfo.prestige;
            }
            else
            {
                if (this.LoginPrestigeValue < 100)
                {
                    if (this.player.playerInfo.prestige >= 100)
                    {
                        TargetCount.clickCount(TargetCount.IngameReach100Prestige);
                        this.LoginPrestigeValue = this.player.playerInfo.prestige;
                    };
                };
            };
            MsgDispacther.getInstance().dispatchEvent(new Event(Context.EVENT_PLAYINFO_UPDATE));
        }

        public function set bCancelSecurityCode(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1610857705bCancelSecurityCode;
            if (_local_2 !== _arg_1)
            {
                this._1610857705bCancelSecurityCode = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bCancelSecurityCode", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get selectServerId():String
        {
            return (this._1963568934selectServerId);
        }

        private function onHeroUpdate(_arg_1:HeroUpdate):void
        {
            var _local_3:int;
            var _local_4:HeroBean;
            trace("Context.onHeroUpdate.");
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                {
                    if (_arg_1.hero.isHero == CommonConstants.HERO_KING_QUEEN)
                    {
                        _local_2.herosArray.addItemAt(_arg_1.hero, 0);
                    }
                    else
                    {
                        _local_2.herosArray.addItem(_arg_1.hero);
                    };
                }
                else
                {
                    _local_3 = 0;
                    while (_local_3 < _local_2.herosArray.length)
                    {
                        _local_4 = _local_2.getHeros(_local_3);
                        if (_local_4.id == _arg_1.hero.id)
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
                            {
                                _arg_1.hero.copyTo(_local_2.herosArray[_local_3]);
                            }
                            else
                            {
                                _local_2.herosArray.removeItemAt(_local_3);
                            };
                            return;
                        };
                        _local_3++;
                    };
                };
            };
        }

        public function getDemolishQueueMinLevel(_arg_1:int):int
        {
            var _local_3:BuildingQueueBean;
            if (this.getCurCastle().buildingQueuesArray == null)
            {
                return (100);
            };
            var _local_2:int = 100;
            for each (_local_3 in this.getCurCastle().buildingQueuesArray)
            {
                if ((((_local_3.positionId == _arg_1) && (_local_3.queueType == BuildingConstants.BUILDING_QUEUE_DEMOLISHING)) && (_local_3.level < _local_2)))
                {
                    _local_2 = _local_3.level;
                };
            };
            return (_local_2);
        }

        public function getCurCastle():CastleBean
        {
            return (this.curCastle);
        }

        private function onColonyUpdate(_arg_1:ColonyUpdate):void
        {
            var _local_2:CastleBean = this.getCastleById(_arg_1.castleId);
            if (_local_2 != null)
            {
                CommonUtil.arrayCopy(_arg_1.colonyBeansArray, _local_2.colonyBeansArray);
            };
            if (_arg_1.castleId == Context.getInstance().getCurCastle().id)
            {
                MsgDispacther.getInstance().dispatchEvent(new Event(_BottomToolBar.EVENT_REFRESHSELFARMYS));
            };
            MsgDispacther.getInstance().dispatchEvent(new Event(AllCastleFrame.EVENT_REFRESH));
        }

        private function getCastleById(_arg_1:int):CastleBean
        {
            var _local_2:CastleBean;
            if (player !== null)
            {
                for each (_local_2 in player.castlesArray)
                {
                    if (_local_2.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function fbPublishEx(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("facebook.fb_streamPublish", "", _arg_1, _arg_2, _arg_6, "", _arg_3, _arg_4, _arg_5, facebookNickName);
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function getTimeDiff():Number
        {
            return (this.timeDiff);
        }

        public function set serverMonth(_arg_1:int):void
        {
            var _local_2:Object = this._775351043serverMonth;
            if (_local_2 !== _arg_1)
            {
                this._775351043serverMonth = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverMonth", _local_2, _arg_1));
            };
        }

        private function onItemUpdate(_arg_1:ItemUpdate):void
        {
            var _local_3:ItemBean;
            var _local_4:int;
            var _local_5:ItemBean;
            var _local_2:Boolean;
            if (player == null)
            {
                return;
            };
            for each (_local_3 in _arg_1.itemsArray)
            {
                _local_2 = false;
                _local_4 = 0;
                while (_local_4 < player.itemsArray.length)
                {
                    _local_5 = player.itemsArray[_local_4];
                    if (_local_5.id == _local_3.id)
                    {
                        _local_2 = true;
                        _local_5.count = _local_3.count;
                    };
                    _local_4++;
                };
                if (!_local_2)
                {
                    player.itemsArray.addItem(_local_3);
                };
            };
        }

        public function set needUserGuide(_arg_1:Boolean):void
        {
            var _local_2:Object = this._984278523needUserGuide;
            if (_local_2 !== _arg_1)
            {
                this._984278523needUserGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needUserGuide", _local_2, _arg_1));
            };
        }


    }
}//package com.evony

