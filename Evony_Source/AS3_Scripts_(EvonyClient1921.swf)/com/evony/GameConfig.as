// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.GameConfig

package com.evony
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class GameConfig implements IEventDispatcher 
    {

        private static var _555127957instance:GameConfig = new (GameConfig)();
        private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();

        private var _1826037148serverPort:int = 443;
        private var _1216985755password:String;
        private var _2005151600strAbTestFlag:String = "true";
        private var _70271664VisitEmpireUrl:String;
        private var _541314402TurnTable_RunSeconds:uint = 5;
        private var _1379103690serverIp:String = "70.84.59.180";
        private var _146201516strMovingText:String = "";
        private var _3198785help:String;
        private var _82094SID:String = "";
        private var _514826721MiniFavorable:String;
        private var _1778977671RecentActivitiesUrl:String;
        private var _537725256strFbMovingText:String = "";
        private var _1379103646serverID:String = "";
        private var _1426530861accountProtectUrl:String;
        private var _1995620587iFrameCount:int = 300;
        private var _1770758827strOffer:String = "";
        private var _1108743715FbActionUrl:String;
        private var _1846107775newsRSS:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1423088306acount:String;
        private var _1044354196iScaleTownHall:Number = 0;
        private var _485734875FbEventActionUrl:String;
        private var _1570636294enableBuildingQueue:Boolean = false;
        private var _250327323strAttackFlag:String = "false";
        private var _99927745iScaleHouse:Number = 0;
        private var _1735232622FbUprisingUrl:String;
        private var _967673960FbLinkAccountUrl:String;
        private var _1042937001strLanguage:String = "English";
        private var _1431797079SendGiftUrl:String;
        private var _1068081332strEvony3Url:String;
        private var _125535153multiLanguage:Boolean = false;
        private var _189419996AddNeighborUrl:String;
        private var _97619233forum:String;
        private var _198450538debugMode:Boolean = false;
        private var _1129072657iEvonyPage:String;
        private var _730089248securityCross:String;
        private var _935677444strserverAlias:String = "";
        private var _1759953732strCoord:String = "";
        private var _1148987642addFund:String;
        private var _27389711giftKey:String;
        private var _1756209366allianceForum:String;
        private var _300126565preminumRewardPage:String;
        private var _1761451657CheckServerStateUrl:String;
        private var _1943368226ButtonFlag:Boolean = true;
        private var _1951939149proclamation:String;
        private var _795343889iFbFlag:int = 0;
        private var _898195182ServerState:String;
        private var _486325234homePage:String;
        private var _1687892095NeighborListUrl:String;

        public function GameConfig()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public static function get staticEventDispatcher():IEventDispatcher
        {
            return (_staticBindingEventDispatcher);
        }

        [Bindable(event="propertyChange")]
        public static function get instance():GameConfig
        {
            return (GameConfig._555127957instance);
        }

        public static function set instance(_arg_1:GameConfig):void
        {
            var _local_3:IEventDispatcher;
            var _local_2:Object = GameConfig._555127957instance;
            if (_local_2 !== _arg_1)
            {
                GameConfig._555127957instance = _arg_1;
                _local_3 = GameConfig.staticEventDispatcher;
                if (_local_3 != null)
                {
                    _local_3.dispatchEvent(PropertyChangeEvent.createUpdateEvent(GameConfig, "instance", _local_2, _arg_1));
                };
            };
        }


        public function set addFund(_arg_1:String):void
        {
            var _local_2:Object = this._1148987642addFund;
            if (_local_2 !== _arg_1)
            {
                this._1148987642addFund = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addFund", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get homePage():String
        {
            return (this._486325234homePage);
        }

        [Bindable(event="propertyChange")]
        public function get iFbFlag():int
        {
            return (this._795343889iFbFlag);
        }

        public function set homePage(_arg_1:String):void
        {
            var _local_2:Object = this._486325234homePage;
            if (_local_2 !== _arg_1)
            {
                this._486325234homePage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "homePage", _local_2, _arg_1));
            };
        }

        private function setupConfig(_arg_1:Object):void
        {
            config(_arg_1);
        }

        public function set iFbFlag(_arg_1:int):void
        {
            var _local_2:Object = this._795343889iFbFlag;
            if (_local_2 !== _arg_1)
            {
                this._795343889iFbFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iFbFlag", _local_2, _arg_1));
            };
        }

        public function set giftKey(_arg_1:String):void
        {
            var _local_2:Object = this._27389711giftKey;
            if (_local_2 !== _arg_1)
            {
                this._27389711giftKey = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giftKey", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get accountProtectUrl():String
        {
            return (this._1426530861accountProtectUrl);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set forum(_arg_1:String):void
        {
            var _local_2:Object = this._97619233forum;
            if (_local_2 !== _arg_1)
            {
                this._97619233forum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forum", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set allianceForum(_arg_1:String):void
        {
            var _local_2:Object = this._1756209366allianceForum;
            if (_local_2 !== _arg_1)
            {
                this._1756209366allianceForum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceForum", _local_2, _arg_1));
            };
        }

        public function set accountProtectUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1426530861accountProtectUrl;
            if (_local_2 !== _arg_1)
            {
                this._1426530861accountProtectUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accountProtectUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverPort():int
        {
            return (this._1826037148serverPort);
        }

        public function set iScaleHouse(_arg_1:Number):void
        {
            var _local_2:Object = this._99927745iScaleHouse;
            if (_local_2 !== _arg_1)
            {
                this._99927745iScaleHouse = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iScaleHouse", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newsRSS():String
        {
            return (this._1846107775newsRSS);
        }

        public function set help(_arg_1:String):void
        {
            var _local_2:Object = this._3198785help;
            if (_local_2 !== _arg_1)
            {
                this._3198785help = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "help", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get NeighborListUrl():String
        {
            return (this._1687892095NeighborListUrl);
        }

        [Bindable(event="propertyChange")]
        public function get CheckServerStateUrl():String
        {
            return (this._1761451657CheckServerStateUrl);
        }

        public function set strCoord(_arg_1:String):void
        {
            var _local_2:Object = this._1759953732strCoord;
            if (_local_2 !== _arg_1)
            {
                this._1759953732strCoord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strCoord", _local_2, _arg_1));
            };
        }

        public function set strFbMovingText(_arg_1:String):void
        {
            var _local_2:Object = this._537725256strFbMovingText;
            if (_local_2 !== _arg_1)
            {
                this._537725256strFbMovingText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strFbMovingText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get debugMode():Boolean
        {
            return (this._198450538debugMode);
        }

        [Bindable(event="propertyChange")]
        public function get password():String
        {
            return (this._1216985755password);
        }

        public function set acount(_arg_1:String):void
        {
            var _local_2:Object = this._1423088306acount;
            if (_local_2 !== _arg_1)
            {
                this._1423088306acount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "acount", _local_2, _arg_1));
            };
        }

        public function set VisitEmpireUrl(_arg_1:String):void
        {
            var _local_2:Object = this._70271664VisitEmpireUrl;
            if (_local_2 !== _arg_1)
            {
                this._70271664VisitEmpireUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "VisitEmpireUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get strLanguage():String
        {
            return (this._1042937001strLanguage);
        }

        [Bindable(event="propertyChange")]
        public function get strOffer():String
        {
            return (this._1770758827strOffer);
        }

        [Bindable(event="propertyChange")]
        public function get SID():String
        {
            return (this._82094SID);
        }

        [Bindable(event="propertyChange")]
        public function get strEvony3Url():String
        {
            return (this._1068081332strEvony3Url);
        }

        public function set SendGiftUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1431797079SendGiftUrl;
            if (_local_2 !== _arg_1)
            {
                this._1431797079SendGiftUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SendGiftUrl", _local_2, _arg_1));
            };
        }

        public function set serverPort(_arg_1:int):void
        {
            var _local_2:Object = this._1826037148serverPort;
            if (_local_2 !== _arg_1)
            {
                this._1826037148serverPort = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverPort", _local_2, _arg_1));
            };
        }

        public function set preminumRewardPage(_arg_1:String):void
        {
            var _local_2:Object = this._300126565preminumRewardPage;
            if (_local_2 !== _arg_1)
            {
                this._300126565preminumRewardPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "preminumRewardPage", _local_2, _arg_1));
            };
        }

        public function set TurnTable_RunSeconds(_arg_1:uint):void
        {
            var _local_2:Object = this._541314402TurnTable_RunSeconds;
            if (_local_2 !== _arg_1)
            {
                this._541314402TurnTable_RunSeconds = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TurnTable_RunSeconds", _local_2, _arg_1));
            };
        }

        public function set iScaleTownHall(_arg_1:Number):void
        {
            var _local_2:Object = this._1044354196iScaleTownHall;
            if (_local_2 !== _arg_1)
            {
                this._1044354196iScaleTownHall = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iScaleTownHall", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get securityCross():String
        {
            return (this._730089248securityCross);
        }

        [Bindable(event="propertyChange")]
        public function get strAttackFlag():String
        {
            return (this._250327323strAttackFlag);
        }

        public function set strAbTestFlag(_arg_1:String):void
        {
            var _local_2:Object = this._2005151600strAbTestFlag;
            if (_local_2 !== _arg_1)
            {
                this._2005151600strAbTestFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strAbTestFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iFrameCount():int
        {
            return (this._1995620587iFrameCount);
        }

        [Bindable(event="propertyChange")]
        public function get ServerState():String
        {
            return (this._898195182ServerState);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set NeighborListUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1687892095NeighborListUrl;
            if (_local_2 !== _arg_1)
            {
                this._1687892095NeighborListUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "NeighborListUrl", _local_2, _arg_1));
            };
        }

        public function set newsRSS(_arg_1:String):void
        {
            var _local_2:Object = this._1846107775newsRSS;
            if (_local_2 !== _arg_1)
            {
                this._1846107775newsRSS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newsRSS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get addFund():String
        {
            return (this._1148987642addFund);
        }

        public function set RecentActivitiesUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1778977671RecentActivitiesUrl;
            if (_local_2 !== _arg_1)
            {
                this._1778977671RecentActivitiesUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "RecentActivitiesUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get giftKey():String
        {
            return (this._27389711giftKey);
        }

        public function set CheckServerStateUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1761451657CheckServerStateUrl;
            if (_local_2 !== _arg_1)
            {
                this._1761451657CheckServerStateUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "CheckServerStateUrl", _local_2, _arg_1));
            };
        }

        private function loadConfigError():void
        {
            throw (new Error("unable load config.xml"));
        }

        [Bindable(event="propertyChange")]
        public function get forum():String
        {
            return (this._97619233forum);
        }

        public function set FbUprisingUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1735232622FbUprisingUrl;
            if (_local_2 !== _arg_1)
            {
                this._1735232622FbUprisingUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "FbUprisingUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceForum():String
        {
            return (this._1756209366allianceForum);
        }

        public function set debugMode(_arg_1:Boolean):void
        {
            var _local_2:Object = this._198450538debugMode;
            if (_local_2 !== _arg_1)
            {
                this._198450538debugMode = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "debugMode", _local_2, _arg_1));
            };
        }

        public function set FbLinkAccountUrl(_arg_1:String):void
        {
            var _local_2:Object = this._967673960FbLinkAccountUrl;
            if (_local_2 !== _arg_1)
            {
                this._967673960FbLinkAccountUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "FbLinkAccountUrl", _local_2, _arg_1));
            };
        }

        public function set password(_arg_1:String):void
        {
            var _local_2:Object = this._1216985755password;
            if (_local_2 !== _arg_1)
            {
                this._1216985755password = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "password", _local_2, _arg_1));
            };
        }

        public function set serverID(_arg_1:String):void
        {
            var _local_2:Object = this._1379103646serverID;
            if (_local_2 !== _arg_1)
            {
                this._1379103646serverID = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverID", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iScaleHouse():Number
        {
            return (this._99927745iScaleHouse);
        }

        [Bindable(event="propertyChange")]
        public function get help():String
        {
            return (this._3198785help);
        }

        public function config(obj:Object):void
        {
            var xml:XML;
            try
            {
                xml = XML(obj);
                debugMode = ("true" == xml.debugMode);
                if (xml.serverID)
                {
                    serverID = xml.serverID;
                };
                if (xml.server)
                {
                    serverIp = xml.server;
                };
                if (xml.port)
                {
                    serverPort = xml.port;
                };
                if (xml.acount)
                {
                    acount = xml.acount;
                };
                if (xml.homePage)
                {
                    homePage = xml.homePage;
                };
                if (xml.password)
                {
                    password = xml.password;
                };
                if (xml.addFund)
                {
                    addFund = xml.addFund;
                };
                if (xml.GiftKey)
                {
                    giftKey = xml.GiftKey;
                };
                if (xml.forum)
                {
                    forum = xml.forum;
                };
                if (xml.allianceForum)
                {
                    allianceForum = xml.allianceForum;
                };
                if (xml.help)
                {
                    help = xml.help;
                };
                if (xml.proclamation)
                {
                    proclamation = xml.proclamation;
                };
                if (xml.ServerState)
                {
                    ServerState = xml.ServerState;
                    trace(("ServerState:" + ServerState));
                };
                if (xml.security)
                {
                    securityCross = xml.security;
                };
                if (xml.NewsRSS)
                {
                    newsRSS = xml.NewsRSS;
                };
                if (xml.MultiLanguage)
                {
                    multiLanguage = (xml.MultiLanguage == "true");
                };
                if (xml.RunSeconds)
                {
                    TurnTable_RunSeconds = uint(xml.RunSeconds);
                };
                if (xml.AccountProtect)
                {
                    accountProtectUrl = xml.AccountProtect;
                };
                if (xml.PreminumRewardPage)
                {
                    preminumRewardPage = xml.PreminumRewardPage;
                };
                if (xml.IEvonyPage)
                {
                    this.iEvonyPage = xml.IEvonyPage;
                };
                if (xml.ButtonFlag)
                {
                    this.ButtonFlag = (xml.ButtonFlag == "true");
                };
                if (xml.Language)
                {
                    this.strLanguage = xml.Language;
                };
                if (xml.FrameCount)
                {
                    this.iFrameCount = xml.FrameCount;
                };
                if (xml.Coord)
                {
                    this.strCoord = xml.Coord;
                };
                if (xml.ScaleHouse)
                {
                    this.iScaleHouse = xml.ScaleHouse;
                };
                if (xml.ScaleTownHall)
                {
                    this.iScaleTownHall = xml.ScaleTownHall;
                };
                if (xml.Facebook)
                {
                    this.iFbFlag = xml.Facebook;
                };
                if (xml.SendGift)
                {
                    this.SendGiftUrl = xml.SendGift;
                };
                if (xml.AddNeighbor)
                {
                    this.AddNeighborUrl = xml.AddNeighbor;
                };
                if (xml.VisitEmpire)
                {
                    this.VisitEmpireUrl = xml.VisitEmpire;
                };
                if (xml.NeighborList)
                {
                    this.NeighborListUrl = xml.NeighborList;
                };
                if (xml.RecentActivities)
                {
                    this.RecentActivitiesUrl = xml.RecentActivities;
                };
                if (xml.FbAction)
                {
                    this.FbActionUrl = xml.FbAction;
                };
                if (xml.FbEventAction)
                {
                    this.FbEventActionUrl = xml.FbEventAction;
                };
                if (xml.FbLinkAccount)
                {
                    this.FbLinkAccountUrl = xml.FbLinkAccount;
                };
                if (xml.FbUprisingUrl)
                {
                    this.FbUprisingUrl = xml.FbUprisingUrl;
                };
                if (xml.CheckServerState)
                {
                    this.CheckServerStateUrl = xml.CheckServerState;
                };
                if (xml.AbTestFlag)
                {
                    this.strAbTestFlag = xml.AbTestFlag;
                };
                if (xml.movingText)
                {
                    this.strMovingText = xml.movingText;
                };
                if (xml.movingTxt)
                {
                    this.strFbMovingText = xml.movingTxt;
                };
                if (xml.AttackFlag)
                {
                    this.strAttackFlag = xml.AttackFlag;
                };
                if (xml.serverAlias)
                {
                    this.strserverAlias = xml.serverAlias;
                };
                if (strserverAlias == "")
                {
                    strserverAlias = serverID;
                };
                if (xml.SID)
                {
                    this.SID = xml.SID;
                };
                if (xml.BuildingQueueFlag)
                {
                    this.enableBuildingQueue = (xml.BuildingQueueFlag == "true");
                    if (!this.enableBuildingQueue)
                    {
                        if ((((this.serverID.toLowerCase() == "na20") || (this.serverID.toLowerCase() == "na21")) || (this.serverID.toLowerCase() == "na22")))
                        {
                            this.enableBuildingQueue = true;
                        };
                    };
                };
                if (xml.Offer)
                {
                    this.strOffer = xml.Offer;
                };
                if (xml.MiniFavorable)
                {
                    MiniFavorable = xml.MiniFavorable;
                };
                if (xml.coeRegUrl)
                {
                    strEvony3Url = xml.coeRegUrl;
                };
            }
            catch(error:Error)
            {
                trace(error);
            };
        }

        [Bindable(event="propertyChange")]
        public function get strFbMovingText():String
        {
            return (this._537725256strFbMovingText);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get strCoord():String
        {
            return (this._1759953732strCoord);
        }

        public function set strLanguage(_arg_1:String):void
        {
            var _local_2:Object = this._1042937001strLanguage;
            if (_local_2 !== _arg_1)
            {
                this._1042937001strLanguage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strLanguage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get acount():String
        {
            return (this._1423088306acount);
        }

        public function set strOffer(_arg_1:String):void
        {
            var _local_2:Object = this._1770758827strOffer;
            if (_local_2 !== _arg_1)
            {
                this._1770758827strOffer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strOffer", _local_2, _arg_1));
            };
        }

        public function set SID(_arg_1:String):void
        {
            var _local_2:Object = this._82094SID;
            if (_local_2 !== _arg_1)
            {
                this._82094SID = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SID", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get SendGiftUrl():String
        {
            return (this._1431797079SendGiftUrl);
        }

        [Bindable(event="propertyChange")]
        public function get preminumRewardPage():String
        {
            return (this._300126565preminumRewardPage);
        }

        public function set strMovingText(_arg_1:String):void
        {
            var _local_2:Object = this._146201516strMovingText;
            if (_local_2 !== _arg_1)
            {
                this._146201516strMovingText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strMovingText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iScaleTownHall():Number
        {
            return (this._1044354196iScaleTownHall);
        }

        public function set proclamation(_arg_1:String):void
        {
            var _local_2:Object = this._1951939149proclamation;
            if (_local_2 !== _arg_1)
            {
                this._1951939149proclamation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "proclamation", _local_2, _arg_1));
            };
        }

        public function set strEvony3Url(_arg_1:String):void
        {
            var _local_2:Object = this._1068081332strEvony3Url;
            if (_local_2 !== _arg_1)
            {
                this._1068081332strEvony3Url = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strEvony3Url", _local_2, _arg_1));
            };
        }

        public function set multiLanguage(_arg_1:Boolean):void
        {
            var _local_2:Object = this._125535153multiLanguage;
            if (_local_2 !== _arg_1)
            {
                this._125535153multiLanguage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "multiLanguage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get VisitEmpireUrl():String
        {
            return (this._70271664VisitEmpireUrl);
        }

        [Bindable(event="propertyChange")]
        public function get strAbTestFlag():String
        {
            return (this._2005151600strAbTestFlag);
        }

        [Bindable(event="propertyChange")]
        public function get TurnTable_RunSeconds():uint
        {
            return (this._541314402TurnTable_RunSeconds);
        }

        public function LoadConfigFile():void
        {
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get RecentActivitiesUrl():String
        {
            return (this._1778977671RecentActivitiesUrl);
        }

        [Bindable(event="propertyChange")]
        public function get FbUprisingUrl():String
        {
            return (this._1735232622FbUprisingUrl);
        }

        public function set serverIp(_arg_1:String):void
        {
            var _local_2:Object = this._1379103690serverIp;
            if (_local_2 !== _arg_1)
            {
                this._1379103690serverIp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverIp", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get FbLinkAccountUrl():String
        {
            return (this._967673960FbLinkAccountUrl);
        }

        [Bindable(event="propertyChange")]
        public function get serverID():String
        {
            return (this._1379103646serverID);
        }

        [Bindable(event="propertyChange")]
        public function get multiLanguage():Boolean
        {
            return (this._125535153multiLanguage);
        }

        [Bindable(event="propertyChange")]
        public function get proclamation():String
        {
            return (this._1951939149proclamation);
        }

        public function set FbEventActionUrl(_arg_1:String):void
        {
            var _local_2:Object = this._485734875FbEventActionUrl;
            if (_local_2 !== _arg_1)
            {
                this._485734875FbEventActionUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "FbEventActionUrl", _local_2, _arg_1));
            };
        }

        public function set FbActionUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1108743715FbActionUrl;
            if (_local_2 !== _arg_1)
            {
                this._1108743715FbActionUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "FbActionUrl", _local_2, _arg_1));
            };
        }

        public function set AddNeighborUrl(_arg_1:String):void
        {
            var _local_2:Object = this._189419996AddNeighborUrl;
            if (_local_2 !== _arg_1)
            {
                this._189419996AddNeighborUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AddNeighborUrl", _local_2, _arg_1));
            };
        }

        public function set securityCross(_arg_1:String):void
        {
            var _local_2:Object = this._730089248securityCross;
            if (_local_2 !== _arg_1)
            {
                this._730089248securityCross = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "securityCross", _local_2, _arg_1));
            };
        }

        public function set ButtonFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1943368226ButtonFlag;
            if (_local_2 !== _arg_1)
            {
                this._1943368226ButtonFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ButtonFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get strMovingText():String
        {
            return (this._146201516strMovingText);
        }

        public function set MiniFavorable(_arg_1:String):void
        {
            var _local_2:Object = this._514826721MiniFavorable;
            if (_local_2 !== _arg_1)
            {
                this._514826721MiniFavorable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "MiniFavorable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverIp():String
        {
            return (this._1379103690serverIp);
        }

        public function set strAttackFlag(_arg_1:String):void
        {
            var _local_2:Object = this._250327323strAttackFlag;
            if (_local_2 !== _arg_1)
            {
                this._250327323strAttackFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strAttackFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get FbEventActionUrl():String
        {
            return (this._485734875FbEventActionUrl);
        }

        [Bindable(event="propertyChange")]
        public function get AddNeighborUrl():String
        {
            return (this._189419996AddNeighborUrl);
        }

        public function set iFrameCount(_arg_1:int):void
        {
            var _local_2:Object = this._1995620587iFrameCount;
            if (_local_2 !== _arg_1)
            {
                this._1995620587iFrameCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iFrameCount", _local_2, _arg_1));
            };
        }

        public function set ServerState(_arg_1:String):void
        {
            var _local_2:Object = this._898195182ServerState;
            if (_local_2 !== _arg_1)
            {
                this._898195182ServerState = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ServerState", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get FbActionUrl():String
        {
            return (this._1108743715FbActionUrl);
        }

        public function set iEvonyPage(_arg_1:String):void
        {
            var _local_2:Object = this._1129072657iEvonyPage;
            if (_local_2 !== _arg_1)
            {
                this._1129072657iEvonyPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iEvonyPage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get MiniFavorable():String
        {
            return (this._514826721MiniFavorable);
        }

        [Bindable(event="propertyChange")]
        public function get ButtonFlag():Boolean
        {
            return (this._1943368226ButtonFlag);
        }

        [Bindable(event="propertyChange")]
        public function get iEvonyPage():String
        {
            return (this._1129072657iEvonyPage);
        }

        public function set enableBuildingQueue(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1570636294enableBuildingQueue;
            if (_local_2 !== _arg_1)
            {
                this._1570636294enableBuildingQueue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enableBuildingQueue", _local_2, _arg_1));
            };
        }

        public function set strserverAlias(_arg_1:String):void
        {
            var _local_2:Object = this._935677444strserverAlias;
            if (_local_2 !== _arg_1)
            {
                this._935677444strserverAlias = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strserverAlias", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get enableBuildingQueue():Boolean
        {
            return (this._1570636294enableBuildingQueue);
        }

        [Bindable(event="propertyChange")]
        public function get strserverAlias():String
        {
            return (this._935677444strserverAlias);
        }


    }
}//package com.evony

