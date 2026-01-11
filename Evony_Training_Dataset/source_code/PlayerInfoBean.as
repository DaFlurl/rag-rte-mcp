// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.PlayerInfoBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class PlayerInfoBean implements IEventDispatcher 
    {

        private var _1019789636office:String;
        private var _764803337castleCount:int;
        private var _99462250honor:int;
        private var _103771895medal:int;
        private var _113766sex:int;
        private var _1092354606faceUrl:String;
        private var _978111542ranking:int;
        private var _3355id:int;
        private var _2023558323population:int;
        private var _2066382787bdenyotherplayer:int;
        private var _3076014date:String;
        private var _892483748starlv:int;
        private var _1971832828effortPoint:int;
        private var _266666762userName:String;
        private var _1307249261titleId:int;
        private var _1447054905historygetvotes:Number;
        private var _944908652topvotes:Number;
        private var _476980509createrTime:Number;
        private var _1887950739prweekvotes:Number;
        private var _69784511levelId:int;
        private var _865966680accountName:String;
        private var _1997775155getvotes:Number;
        private var _3556460term:String;
        private var _1000737409facebookId:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1750962803allianceLevel:String;
        private var _3145580flag:String;
        private var _1276224445prestige:int;
        private var _836030906userId:int;
        private var _781316064lastLoginTime:Number;
        private var _1806944311alliance:String;

        public function PlayerInfoBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.accountName != null)
                {
                    this.accountName = _arg_1.accountName;
                };
                if (_arg_1.alliance != null)
                {
                    this.alliance = _arg_1.alliance;
                };
                if (_arg_1.allianceLevel != null)
                {
                    this.allianceLevel = _arg_1.allianceLevel;
                };
                if (_arg_1.castleCount != null)
                {
                    this.castleCount = _arg_1.castleCount;
                };
                if (_arg_1.createrTime != null)
                {
                    this.createrTime = _arg_1.createrTime;
                };
                if (_arg_1.date != null)
                {
                    this.date = _arg_1.date;
                };
                if (_arg_1.effortPoint != null)
                {
                    this.effortPoint = _arg_1.effortPoint;
                };
                if (_arg_1.faceUrl != null)
                {
                    this.faceUrl = _arg_1.faceUrl;
                };
                if (_arg_1.facebookId != null)
                {
                    this.facebookId = _arg_1.facebookId;
                };
                if (_arg_1.flag != null)
                {
                    this.flag = _arg_1.flag;
                };
                if (_arg_1.getvotes != null)
                {
                    this.getvotes = _arg_1.getvotes;
                };
                if (_arg_1.historygetvotes != null)
                {
                    this.historygetvotes = _arg_1.historygetvotes;
                };
                if (_arg_1.honor != null)
                {
                    this.honor = _arg_1.honor;
                };
                if (_arg_1.id != null)
                {
                    this.id = _arg_1.id;
                };
                if (_arg_1.lastLoginTime != null)
                {
                    this.lastLoginTime = _arg_1.lastLoginTime;
                };
                if (_arg_1.levelId != null)
                {
                    this.levelId = _arg_1.levelId;
                };
                if (_arg_1.medal != null)
                {
                    this.medal = _arg_1.medal;
                };
                if (_arg_1.office != null)
                {
                    this.office = _arg_1.office;
                };
                if (_arg_1.population != null)
                {
                    this.population = _arg_1.population;
                };
                if (_arg_1.prestige != null)
                {
                    this.prestige = _arg_1.prestige;
                };
                if (_arg_1.prweekvotes != null)
                {
                    this.prweekvotes = _arg_1.prweekvotes;
                };
                if (_arg_1.ranking != null)
                {
                    this.ranking = _arg_1.ranking;
                };
                if (_arg_1.sex != null)
                {
                    this.sex = _arg_1.sex;
                };
                if (_arg_1.starlv != null)
                {
                    this.starlv = _arg_1.starlv;
                };
                if (_arg_1.term != null)
                {
                    this.term = _arg_1.term;
                };
                if (_arg_1.titleId != null)
                {
                    this.titleId = _arg_1.titleId;
                };
                if (_arg_1.topvotes != null)
                {
                    this.topvotes = _arg_1.topvotes;
                };
                if (_arg_1.userId != null)
                {
                    this.userId = _arg_1.userId;
                };
                if (_arg_1.userName != null)
                {
                    this.userName = _arg_1.userName;
                };
                if (_arg_1.bdenyotherplayer != null)
                {
                    this.bdenyotherplayer = _arg_1.bdenyotherplayer;
                };
            };
        }

        public function set facebookId(_arg_1:String):void
        {
            var _local_2:Object = this._1000737409facebookId;
            if (_local_2 !== _arg_1)
            {
                this._1000737409facebookId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebookId", _local_2, _arg_1));
            };
        }

        public function set effortPoint(_arg_1:int):void
        {
            var _local_2:Object = this._1971832828effortPoint;
            if (_local_2 !== _arg_1)
            {
                this._1971832828effortPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effortPoint", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get effortPoint():int
        {
            return (this._1971832828effortPoint);
        }

        public function set allianceLevel(_arg_1:String):void
        {
            var _local_2:Object = this._1750962803allianceLevel;
            if (_local_2 !== _arg_1)
            {
                this._1750962803allianceLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get id():int
        {
            return (this._3355id);
        }

        public function set titleId(_arg_1:int):void
        {
            var _local_2:Object = this._1307249261titleId;
            if (_local_2 !== _arg_1)
            {
                this._1307249261titleId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "titleId", _local_2, _arg_1));
            };
        }

        public function set topvotes(_arg_1:Number):void
        {
            var _local_2:Object = this._944908652topvotes;
            if (_local_2 !== _arg_1)
            {
                this._944908652topvotes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "topvotes", _local_2, _arg_1));
            };
        }

        public function set prweekvotes(_arg_1:Number):void
        {
            var _local_2:Object = this._1887950739prweekvotes;
            if (_local_2 !== _arg_1)
            {
                this._1887950739prweekvotes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prweekvotes", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get alliance():String
        {
            return (this._1806944311alliance);
        }

        [Bindable(event="propertyChange")]
        public function get ranking():int
        {
            return (this._978111542ranking);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get getvotes():Number
        {
            return (this._1997775155getvotes);
        }

        [Bindable(event="propertyChange")]
        public function get prestige():int
        {
            return (this._1276224445prestige);
        }

        public function set id(_arg_1:int):void
        {
            var _local_2:Object = this._3355id;
            if (_local_2 !== _arg_1)
            {
                this._3355id = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get population():int
        {
            return (this._2023558323population);
        }

        [Bindable(event="propertyChange")]
        public function get userId():int
        {
            return (this._836030906userId);
        }

        [Bindable(event="propertyChange")]
        public function get accountName():String
        {
            return (this._865966680accountName);
        }

        [Bindable(event="propertyChange")]
        public function get starlv():int
        {
            return (this._892483748starlv);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get sex():int
        {
            return (this._113766sex);
        }

        [Bindable(event="propertyChange")]
        public function get honor():int
        {
            return (this._99462250honor);
        }

        public function set date(_arg_1:String):void
        {
            var _local_2:Object = this._3076014date;
            if (_local_2 !== _arg_1)
            {
                this._3076014date = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "date", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get term():String
        {
            return (this._3556460term);
        }

        public function set alliance(_arg_1:String):void
        {
            var _local_2:Object = this._1806944311alliance;
            if (_local_2 !== _arg_1)
            {
                this._1806944311alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _local_2, _arg_1));
            };
        }

        public function set ranking(_arg_1:int):void
        {
            var _local_2:Object = this._978111542ranking;
            if (_local_2 !== _arg_1)
            {
                this._978111542ranking = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ranking", _local_2, _arg_1));
            };
        }

        public function set office(_arg_1:String):void
        {
            var _local_2:Object = this._1019789636office;
            if (_local_2 !== _arg_1)
            {
                this._1019789636office = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "office", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get flag():String
        {
            return (this._3145580flag);
        }

        public function set levelId(_arg_1:int):void
        {
            var _local_2:Object = this._69784511levelId;
            if (_local_2 !== _arg_1)
            {
                this._69784511levelId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levelId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get facebookId():String
        {
            return (this._1000737409facebookId);
        }

        public function set bdenyotherplayer(_arg_1:int):void
        {
            var _local_2:Object = this._2066382787bdenyotherplayer;
            if (_local_2 !== _arg_1)
            {
                this._2066382787bdenyotherplayer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bdenyotherplayer", _local_2, _arg_1));
            };
        }

        public function set getvotes(_arg_1:Number):void
        {
            var _local_2:Object = this._1997775155getvotes;
            if (_local_2 !== _arg_1)
            {
                this._1997775155getvotes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "getvotes", _local_2, _arg_1));
            };
        }

        public function set prestige(_arg_1:int):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get titleId():int
        {
            return (this._1307249261titleId);
        }

        [Bindable(event="propertyChange")]
        public function get topvotes():Number
        {
            return (this._944908652topvotes);
        }

        public function toObject():Object
        {
            return ({
                "accountName":this.accountName,
                "alliance":this.alliance,
                "allianceLevel":this.allianceLevel,
                "castleCount":this.castleCount,
                "createrTime":this.createrTime,
                "date":this.date,
                "effortPoint":this.effortPoint,
                "faceUrl":this.faceUrl,
                "facebookId":this.facebookId,
                "flag":this.flag,
                "getvotes":this.getvotes,
                "historygetvotes":this.historygetvotes,
                "honor":this.honor,
                "id":this.id,
                "lastLoginTime":this.lastLoginTime,
                "levelId":this.levelId,
                "medal":this.medal,
                "office":this.office,
                "population":this.population,
                "prestige":this.prestige,
                "prweekvotes":this.prweekvotes,
                "ranking":this.ranking,
                "sex":this.sex,
                "starlv":this.starlv,
                "term":this.term,
                "titleId":this.titleId,
                "topvotes":this.topvotes,
                "userId":this.userId,
                "userName":this.userName,
                "bdenyotherplayer":this.bdenyotherplayer
            });
        }

        [Bindable(event="propertyChange")]
        public function get allianceLevel():String
        {
            return (this._1750962803allianceLevel);
        }

        public function set historygetvotes(_arg_1:Number):void
        {
            var _local_2:Object = this._1447054905historygetvotes;
            if (_local_2 !== _arg_1)
            {
                this._1447054905historygetvotes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "historygetvotes", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function set population(_arg_1:int):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get prweekvotes():Number
        {
            return (this._1887950739prweekvotes);
        }

        public function set faceUrl(_arg_1:String):void
        {
            var _local_2:Object = this._1092354606faceUrl;
            if (_local_2 !== _arg_1)
            {
                this._1092354606faceUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get date():String
        {
            return (this._3076014date);
        }

        public function set accountName(_arg_1:String):void
        {
            var _local_2:Object = this._865966680accountName;
            if (_local_2 !== _arg_1)
            {
                this._865966680accountName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accountName", _local_2, _arg_1));
            };
        }

        public function set userId(_arg_1:int):void
        {
            var _local_2:Object = this._836030906userId;
            if (_local_2 !== _arg_1)
            {
                this._836030906userId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get office():String
        {
            return (this._1019789636office);
        }

        public function set lastLoginTime(_arg_1:Number):void
        {
            var _local_2:Object = this._781316064lastLoginTime;
            if (_local_2 !== _arg_1)
            {
                this._781316064lastLoginTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lastLoginTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get bdenyotherplayer():int
        {
            return (this._2066382787bdenyotherplayer);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((((((((((((((((((((((((_arg_1 + "accountName = ") + this.accountName) + "\n") + (((_arg_1 + "alliance = ") + this.alliance) + "\n")) + (((_arg_1 + "allianceLevel = ") + this.allianceLevel) + "\n")) + (((_arg_1 + "castleCount = ") + this.castleCount) + "\n")) + (((_arg_1 + "createrTime = ") + this.createrTime) + "\n")) + (((_arg_1 + "date = ") + this.date) + "\n")) + (((_arg_1 + "effortPoint = ") + this.effortPoint) + "\n")) + (((_arg_1 + "faceUrl = ") + this.faceUrl) + "\n")) + (((_arg_1 + "facebookId = ") + this.facebookId) + "\n")) + (((_arg_1 + "flag = ") + this.flag) + "\n")) + (((_arg_1 + "getvotes = ") + this.getvotes) + "\n")) + (((_arg_1 + "historygetvotes = ") + this.historygetvotes) + "\n")) + (((_arg_1 + "honor = ") + this.honor) + "\n")) + (((_arg_1 + "id = ") + this.id) + "\n")) + (((_arg_1 + "lastLoginTime = ") + this.lastLoginTime) + "\n")) + (((_arg_1 + "levelId = ") + this.levelId) + "\n")) + (((_arg_1 + "medal = ") + this.medal) + "\n")) + (((_arg_1 + "office = ") + this.office) + "\n")) + (((_arg_1 + "population = ") + this.population) + "\n")) + (((_arg_1 + "prestige = ") + this.prestige) + "\n")) + (((_arg_1 + "prweekvotes = ") + this.prweekvotes) + "\n")) + (((_arg_1 + "ranking = ") + this.ranking) + "\n")) + (((_arg_1 + "sex = ") + this.sex) + "\n")) + (((_arg_1 + "starlv = ") + this.starlv) + "\n")) + (((_arg_1 + "term = ") + this.term) + "\n")) + (((_arg_1 + "titleId = ") + this.titleId) + "\n")) + (((_arg_1 + "topvotes = ") + this.topvotes) + "\n")) + (((_arg_1 + "userId = ") + this.userId) + "\n")) + (((_arg_1 + "userName = ") + this.userName) + "\n")) + (((_arg_1 + "bdenyotherplayer = ") + this.bdenyotherplayer) + "\n"));
        }

        public function set createrTime(_arg_1:Number):void
        {
            var _local_2:Object = this._476980509createrTime;
            if (_local_2 !== _arg_1)
            {
                this._476980509createrTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createrTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get historygetvotes():Number
        {
            return (this._1447054905historygetvotes);
        }

        public function copyTo(_arg_1:PlayerInfoBean):void
        {
            _arg_1.accountName = this.accountName;
            _arg_1.alliance = this.alliance;
            _arg_1.allianceLevel = this.allianceLevel;
            _arg_1.castleCount = this.castleCount;
            _arg_1.createrTime = this.createrTime;
            _arg_1.date = this.date;
            _arg_1.effortPoint = this.effortPoint;
            _arg_1.faceUrl = this.faceUrl;
            _arg_1.facebookId = this.facebookId;
            _arg_1.flag = this.flag;
            _arg_1.getvotes = this.getvotes;
            _arg_1.historygetvotes = this.historygetvotes;
            _arg_1.honor = this.honor;
            _arg_1.id = this.id;
            _arg_1.lastLoginTime = this.lastLoginTime;
            _arg_1.levelId = this.levelId;
            _arg_1.medal = this.medal;
            _arg_1.office = this.office;
            _arg_1.population = this.population;
            _arg_1.prestige = this.prestige;
            _arg_1.prweekvotes = this.prweekvotes;
            _arg_1.ranking = this.ranking;
            _arg_1.sex = this.sex;
            _arg_1.starlv = this.starlv;
            _arg_1.term = this.term;
            _arg_1.titleId = this.titleId;
            _arg_1.topvotes = this.topvotes;
            _arg_1.userId = this.userId;
            _arg_1.userName = this.userName;
            _arg_1.bdenyotherplayer = this.bdenyotherplayer;
        }

        [Bindable(event="propertyChange")]
        public function get faceUrl():String
        {
            return (this._1092354606faceUrl);
        }

        public function set sex(_arg_1:int):void
        {
            var _local_2:Object = this._113766sex;
            if (_local_2 !== _arg_1)
            {
                this._113766sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sex", _local_2, _arg_1));
            };
        }

        public function set honor(_arg_1:int):void
        {
            var _local_2:Object = this._99462250honor;
            if (_local_2 !== _arg_1)
            {
                this._99462250honor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get levelId():int
        {
            return (this._69784511levelId);
        }

        public function set term(_arg_1:String):void
        {
            var _local_2:Object = this._3556460term;
            if (_local_2 !== _arg_1)
            {
                this._3556460term = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "term", _local_2, _arg_1));
            };
        }

        public function set starlv(_arg_1:int):void
        {
            var _local_2:Object = this._892483748starlv;
            if (_local_2 !== _arg_1)
            {
                this._892483748starlv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starlv", _local_2, _arg_1));
            };
        }

        public function set flag(_arg_1:String):void
        {
            var _local_2:Object = this._3145580flag;
            if (_local_2 !== _arg_1)
            {
                this._3145580flag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get lastLoginTime():Number
        {
            return (this._781316064lastLoginTime);
        }

        [Bindable(event="propertyChange")]
        public function get createrTime():Number
        {
            return (this._476980509createrTime);
        }

        public function set userName(_arg_1:String):void
        {
            var _local_2:Object = this._266666762userName;
            if (_local_2 !== _arg_1)
            {
                this._266666762userName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userName", _local_2, _arg_1));
            };
        }

        public function set medal(_arg_1:int):void
        {
            var _local_2:Object = this._103771895medal;
            if (_local_2 !== _arg_1)
            {
                this._103771895medal = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "medal", _local_2, _arg_1));
            };
        }

        public function set castleCount(_arg_1:int):void
        {
            var _local_2:Object = this._764803337castleCount;
            if (_local_2 !== _arg_1)
            {
                this._764803337castleCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get userName():String
        {
            return (this._266666762userName);
        }

        [Bindable(event="propertyChange")]
        public function get castleCount():int
        {
            return (this._764803337castleCount);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get medal():int
        {
            return (this._103771895medal);
        }


    }
}//package com.evony.common.beans

