package com.evony.common.beans
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   
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
      
      private var _bindingEventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
      
      private var _1750962803allianceLevel:String;
      
      private var _3145580flag:String;
      
      private var _1276224445prestige:int;
      
      private var _836030906userId:int;
      
      private var _781316064lastLoginTime:Number;
      
      private var _1806944311alliance:String;
      
      public function PlayerInfoBean(param1:Object = null)
      {
         super();
         if(param1 != null)
         {
            if(param1.accountName != null)
            {
               this.accountName = param1.accountName;
            }
            if(param1.alliance != null)
            {
               this.alliance = param1.alliance;
            }
            if(param1.allianceLevel != null)
            {
               this.allianceLevel = param1.allianceLevel;
            }
            if(param1.castleCount != null)
            {
               this.castleCount = param1.castleCount;
            }
            if(param1.createrTime != null)
            {
               this.createrTime = param1.createrTime;
            }
            if(param1.date != null)
            {
               this.date = param1.date;
            }
            if(param1.effortPoint != null)
            {
               this.effortPoint = param1.effortPoint;
            }
            if(param1.faceUrl != null)
            {
               this.faceUrl = param1.faceUrl;
            }
            if(param1.facebookId != null)
            {
               this.facebookId = param1.facebookId;
            }
            if(param1.flag != null)
            {
               this.flag = param1.flag;
            }
            if(param1.getvotes != null)
            {
               this.getvotes = param1.getvotes;
            }
            if(param1.historygetvotes != null)
            {
               this.historygetvotes = param1.historygetvotes;
            }
            if(param1.honor != null)
            {
               this.honor = param1.honor;
            }
            if(param1.id != null)
            {
               this.id = param1.id;
            }
            if(param1.lastLoginTime != null)
            {
               this.lastLoginTime = param1.lastLoginTime;
            }
            if(param1.levelId != null)
            {
               this.levelId = param1.levelId;
            }
            if(param1.medal != null)
            {
               this.medal = param1.medal;
            }
            if(param1.office != null)
            {
               this.office = param1.office;
            }
            if(param1.population != null)
            {
               this.population = param1.population;
            }
            if(param1.prestige != null)
            {
               this.prestige = param1.prestige;
            }
            if(param1.prweekvotes != null)
            {
               this.prweekvotes = param1.prweekvotes;
            }
            if(param1.ranking != null)
            {
               this.ranking = param1.ranking;
            }
            if(param1.sex != null)
            {
               this.sex = param1.sex;
            }
            if(param1.starlv != null)
            {
               this.starlv = param1.starlv;
            }
            if(param1.term != null)
            {
               this.term = param1.term;
            }
            if(param1.titleId != null)
            {
               this.titleId = param1.titleId;
            }
            if(param1.topvotes != null)
            {
               this.topvotes = param1.topvotes;
            }
            if(param1.userId != null)
            {
               this.userId = param1.userId;
            }
            if(param1.userName != null)
            {
               this.userName = param1.userName;
            }
            if(param1.bdenyotherplayer != null)
            {
               this.bdenyotherplayer = param1.bdenyotherplayer;
            }
         }
      }
      
      public function set facebookId(param1:String) : void
      {
         var _loc2_:Object = this._1000737409facebookId;
         if(_loc2_ !== param1)
         {
            this._1000737409facebookId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"facebookId",_loc2_,param1));
         }
      }
      
      public function set effortPoint(param1:int) : void
      {
         var _loc2_:Object = this._1971832828effortPoint;
         if(_loc2_ !== param1)
         {
            this._1971832828effortPoint = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effortPoint",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get effortPoint() : int
      {
         return this._1971832828effortPoint;
      }
      
      public function set allianceLevel(param1:String) : void
      {
         var _loc2_:Object = this._1750962803allianceLevel;
         if(_loc2_ !== param1)
         {
            this._1750962803allianceLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceLevel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get id() : int
      {
         return this._3355id;
      }
      
      public function set titleId(param1:int) : void
      {
         var _loc2_:Object = this._1307249261titleId;
         if(_loc2_ !== param1)
         {
            this._1307249261titleId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"titleId",_loc2_,param1));
         }
      }
      
      public function set topvotes(param1:Number) : void
      {
         var _loc2_:Object = this._944908652topvotes;
         if(_loc2_ !== param1)
         {
            this._944908652topvotes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topvotes",_loc2_,param1));
         }
      }
      
      public function set prweekvotes(param1:Number) : void
      {
         var _loc2_:Object = this._1887950739prweekvotes;
         if(_loc2_ !== param1)
         {
            this._1887950739prweekvotes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prweekvotes",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get alliance() : String
      {
         return this._1806944311alliance;
      }
      
      [Bindable(event="propertyChange")]
      public function get ranking() : int
      {
         return this._978111542ranking;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get getvotes() : Number
      {
         return this._1997775155getvotes;
      }
      
      [Bindable(event="propertyChange")]
      public function get prestige() : int
      {
         return this._1276224445prestige;
      }
      
      public function set id(param1:int) : void
      {
         var _loc2_:Object = this._3355id;
         if(_loc2_ !== param1)
         {
            this._3355id = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"id",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      [Bindable(event="propertyChange")]
      public function get population() : int
      {
         return this._2023558323population;
      }
      
      [Bindable(event="propertyChange")]
      public function get userId() : int
      {
         return this._836030906userId;
      }
      
      [Bindable(event="propertyChange")]
      public function get accountName() : String
      {
         return this._865966680accountName;
      }
      
      [Bindable(event="propertyChange")]
      public function get starlv() : int
      {
         return this._892483748starlv;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      [Bindable(event="propertyChange")]
      public function get sex() : int
      {
         return this._113766sex;
      }
      
      [Bindable(event="propertyChange")]
      public function get honor() : int
      {
         return this._99462250honor;
      }
      
      public function set date(param1:String) : void
      {
         var _loc2_:Object = this._3076014date;
         if(_loc2_ !== param1)
         {
            this._3076014date = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"date",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get term() : String
      {
         return this._3556460term;
      }
      
      public function set alliance(param1:String) : void
      {
         var _loc2_:Object = this._1806944311alliance;
         if(_loc2_ !== param1)
         {
            this._1806944311alliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alliance",_loc2_,param1));
         }
      }
      
      public function set ranking(param1:int) : void
      {
         var _loc2_:Object = this._978111542ranking;
         if(_loc2_ !== param1)
         {
            this._978111542ranking = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ranking",_loc2_,param1));
         }
      }
      
      public function set office(param1:String) : void
      {
         var _loc2_:Object = this._1019789636office;
         if(_loc2_ !== param1)
         {
            this._1019789636office = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"office",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get flag() : String
      {
         return this._3145580flag;
      }
      
      public function set levelId(param1:int) : void
      {
         var _loc2_:Object = this._69784511levelId;
         if(_loc2_ !== param1)
         {
            this._69784511levelId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"levelId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get facebookId() : String
      {
         return this._1000737409facebookId;
      }
      
      public function set bdenyotherplayer(param1:int) : void
      {
         var _loc2_:Object = this._2066382787bdenyotherplayer;
         if(_loc2_ !== param1)
         {
            this._2066382787bdenyotherplayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bdenyotherplayer",_loc2_,param1));
         }
      }
      
      public function set getvotes(param1:Number) : void
      {
         var _loc2_:Object = this._1997775155getvotes;
         if(_loc2_ !== param1)
         {
            this._1997775155getvotes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"getvotes",_loc2_,param1));
         }
      }
      
      public function set prestige(param1:int) : void
      {
         var _loc2_:Object = this._1276224445prestige;
         if(_loc2_ !== param1)
         {
            this._1276224445prestige = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"prestige",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get titleId() : int
      {
         return this._1307249261titleId;
      }
      
      [Bindable(event="propertyChange")]
      public function get topvotes() : Number
      {
         return this._944908652topvotes;
      }
      
      public function toObject() : Object
      {
         return {
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
         };
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceLevel() : String
      {
         return this._1750962803allianceLevel;
      }
      
      public function set historygetvotes(param1:Number) : void
      {
         var _loc2_:Object = this._1447054905historygetvotes;
         if(_loc2_ !== param1)
         {
            this._1447054905historygetvotes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"historygetvotes",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set population(param1:int) : void
      {
         var _loc2_:Object = this._2023558323population;
         if(_loc2_ !== param1)
         {
            this._2023558323population = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"population",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get prweekvotes() : Number
      {
         return this._1887950739prweekvotes;
      }
      
      public function set faceUrl(param1:String) : void
      {
         var _loc2_:Object = this._1092354606faceUrl;
         if(_loc2_ !== param1)
         {
            this._1092354606faceUrl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"faceUrl",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get date() : String
      {
         return this._3076014date;
      }
      
      public function set accountName(param1:String) : void
      {
         var _loc2_:Object = this._865966680accountName;
         if(_loc2_ !== param1)
         {
            this._865966680accountName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"accountName",_loc2_,param1));
         }
      }
      
      public function set userId(param1:int) : void
      {
         var _loc2_:Object = this._836030906userId;
         if(_loc2_ !== param1)
         {
            this._836030906userId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userId",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get office() : String
      {
         return this._1019789636office;
      }
      
      public function set lastLoginTime(param1:Number) : void
      {
         var _loc2_:Object = this._781316064lastLoginTime;
         if(_loc2_ !== param1)
         {
            this._781316064lastLoginTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lastLoginTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get bdenyotherplayer() : int
      {
         return this._2066382787bdenyotherplayer;
      }
      
      public function toDebugString(param1:String = "") : String
      {
         return param1 + "accountName = " + this.accountName + "\n" + (param1 + "alliance = " + this.alliance + "\n") + (param1 + "allianceLevel = " + this.allianceLevel + "\n") + (param1 + "castleCount = " + this.castleCount + "\n") + (param1 + "createrTime = " + this.createrTime + "\n") + (param1 + "date = " + this.date + "\n") + (param1 + "effortPoint = " + this.effortPoint + "\n") + (param1 + "faceUrl = " + this.faceUrl + "\n") + (param1 + "facebookId = " + this.facebookId + "\n") + (param1 + "flag = " + this.flag + "\n") + (param1 + "getvotes = " + this.getvotes + "\n") + (param1 + "historygetvotes = " + this.historygetvotes + "\n") + (param1 + "honor = " + this.honor + "\n") + (param1 + "id = " + this.id + "\n") + (param1 + "lastLoginTime = " + this.lastLoginTime + "\n") + (param1 + "levelId = " + this.levelId + "\n") + (param1 + "medal = " + this.medal + "\n") + (param1 + "office = " + this.office + "\n") + (param1 + "population = " + this.population + "\n") + (param1 + "prestige = " + this
         .prestige + "\n") + (param1 + "prweekvotes = " + this.prweekvotes + "\n") + (param1 + "ranking = " + this.ranking + "\n") + (param1 + "sex = " + this.sex + "\n") + (param1 + "starlv = " + this.starlv + "\n") + (param1 + "term = " + this.term + "\n") + (param1 + "titleId = " + this.titleId + "\n") + (param1 + "topvotes = " + this.topvotes + "\n") + (param1 + "userId = " + this.userId + "\n") + (param1 + "userName = " + this.userName + "\n") + (param1 + "bdenyotherplayer = " + this.bdenyotherplayer + "\n");
      }
      
      public function set createrTime(param1:Number) : void
      {
         var _loc2_:Object = this._476980509createrTime;
         if(_loc2_ !== param1)
         {
            this._476980509createrTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"createrTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get historygetvotes() : Number
      {
         return this._1447054905historygetvotes;
      }
      
      public function copyTo(param1:PlayerInfoBean) : void
      {
         param1.accountName = this.accountName;
         param1.alliance = this.alliance;
         param1.allianceLevel = this.allianceLevel;
         param1.castleCount = this.castleCount;
         param1.createrTime = this.createrTime;
         param1.date = this.date;
         param1.effortPoint = this.effortPoint;
         param1.faceUrl = this.faceUrl;
         param1.facebookId = this.facebookId;
         param1.flag = this.flag;
         param1.getvotes = this.getvotes;
         param1.historygetvotes = this.historygetvotes;
         param1.honor = this.honor;
         param1.id = this.id;
         param1.lastLoginTime = this.lastLoginTime;
         param1.levelId = this.levelId;
         param1.medal = this.medal;
         param1.office = this.office;
         param1.population = this.population;
         param1.prestige = this.prestige;
         param1.prweekvotes = this.prweekvotes;
         param1.ranking = this.ranking;
         param1.sex = this.sex;
         param1.starlv = this.starlv;
         param1.term = this.term;
         param1.titleId = this.titleId;
         param1.topvotes = this.topvotes;
         param1.userId = this.userId;
         param1.userName = this.userName;
         param1.bdenyotherplayer = this.bdenyotherplayer;
      }
      
      [Bindable(event="propertyChange")]
      public function get faceUrl() : String
      {
         return this._1092354606faceUrl;
      }
      
      public function set sex(param1:int) : void
      {
         var _loc2_:Object = this._113766sex;
         if(_loc2_ !== param1)
         {
            this._113766sex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sex",_loc2_,param1));
         }
      }
      
      public function set honor(param1:int) : void
      {
         var _loc2_:Object = this._99462250honor;
         if(_loc2_ !== param1)
         {
            this._99462250honor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"honor",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get levelId() : int
      {
         return this._69784511levelId;
      }
      
      public function set term(param1:String) : void
      {
         var _loc2_:Object = this._3556460term;
         if(_loc2_ !== param1)
         {
            this._3556460term = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"term",_loc2_,param1));
         }
      }
      
      public function set starlv(param1:int) : void
      {
         var _loc2_:Object = this._892483748starlv;
         if(_loc2_ !== param1)
         {
            this._892483748starlv = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"starlv",_loc2_,param1));
         }
      }
      
      public function set flag(param1:String) : void
      {
         var _loc2_:Object = this._3145580flag;
         if(_loc2_ !== param1)
         {
            this._3145580flag = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"flag",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get lastLoginTime() : Number
      {
         return this._781316064lastLoginTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get createrTime() : Number
      {
         return this._476980509createrTime;
      }
      
      public function set userName(param1:String) : void
      {
         var _loc2_:Object = this._266666762userName;
         if(_loc2_ !== param1)
         {
            this._266666762userName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"userName",_loc2_,param1));
         }
      }
      
      public function set medal(param1:int) : void
      {
         var _loc2_:Object = this._103771895medal;
         if(_loc2_ !== param1)
         {
            this._103771895medal = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"medal",_loc2_,param1));
         }
      }
      
      public function set castleCount(param1:int) : void
      {
         var _loc2_:Object = this._764803337castleCount;
         if(_loc2_ !== param1)
         {
            this._764803337castleCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"castleCount",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get userName() : String
      {
         return this._266666762userName;
      }
      
      [Bindable(event="propertyChange")]
      public function get castleCount() : int
      {
         return this._764803337castleCount;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get medal() : int
      {
         return this._103771895medal;
      }
   }
}

