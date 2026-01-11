package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.hero.DisappearHeroResponse;
   import com.evony.common.module.hero.HeroListResponse;
   import com.evony.common.module.hero.RandomHeroResponse;
   import com.evony.common.module.hero.SetShowInfroResponse;
   
   public class HeroCommand
   {
      
      public var _addPoint2_callback:Function;
      
      public var _releaseHero_callback:Function;
      
      public var _awardGold_callback:Function;
      
      public var _useItem_callback:Function;
      
      public var _ShowPlayerHerosByUserName_callback:Function;
      
      public var _callBackHero_callback:Function;
      
      public var _tryGetSeizedHero_callback:Function;
      
      public var _addPoint_callback:Function;
      
      public var _GetDisappearHeros_callback:Function;
      
      public var _dischargeChief_callback:Function;
      
      public var _levelUp_callback:Function;
      
      public var _resetPoint_callback:Function;
      
      public var _RetSetHeroAttri_callback:Function;
      
      private var sender:Sender;
      
      public var _getHerosListFromTavern_callback:Function;
      
      public var _setHeroFacebookId_callback:Function;
      
      public var _refreshHerosListFromTavern_callback:Function;
      
      public var _getFleeHeroList_callback:Function;
      
      public var _fireHero_callback:Function;
      
      public var _SetShowHeroId_callback:Function;
      
      public var _hireHero_callback:Function;
      
      public var _recruitFleeHero_callback:Function;
      
      public var _changeName_callback:Function;
      
      public var _RecoverDisappearHero_callback:Function;
      
      public var _GetRandomHero_callback:Function;
      
      public var _hireFacebookFriendHero_callback:Function;
      
      public var _GenSaveRandomHero_callback:Function;
      
      public var _promoteToChief_callback:Function;
      
      public function HeroCommand()
      {
         super();
      }
      
      public function resetPoint(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._resetPoint_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.resetPoint",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function getHerosListFromTavern(param1:int, param2:Function = null) : HeroListResponse
      {
         this._getHerosListFromTavern_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.getHerosListFromTavern",{"castleId":param1});
         }
         return null;
      }
      
      public function GenSaveRandomHero(param1:int, param2:String, param3:String, param4:Function = null) : CommandResponse
      {
         this._GenSaveRandomHero_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.GenSaveRandomHero",{
               "castleid":param1,
               "heroname":param2,
               "faceurl":param3
            });
         }
         return null;
      }
      
      public function setHeroFacebookId(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._setHeroFacebookId_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.setHeroFacebookId",{
               "castleId":param1,
               "heroId":param2,
               "facebookId":param3
            });
         }
         return null;
      }
      
      public function releaseHero(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._releaseHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.releaseHero",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function addPoint2(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
      {
         this._addPoint2_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.addPoint2",{
               "castleId":param1,
               "heroId":param2,
               "management":param3,
               "power":param4,
               "stratagem":param5
            });
         }
         return null;
      }
      
      public function hireHero(param1:int, param2:String, param3:Function = null) : CommandResponse
      {
         this._hireHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.hireHero",{
               "castleId":param1,
               "heroName":param2
            });
         }
         return null;
      }
      
      public function promoteToChief(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._promoteToChief_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.promoteToChief",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function dischargeChief(param1:int, param2:Function = null) : CommandResponse
      {
         this._dischargeChief_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.dischargeChief",{"castleId":param1});
         }
         return null;
      }
      
      public function getFleeHeroList(param1:int, param2:Function = null) : HeroListResponse
      {
         this._getFleeHeroList_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.getFleeHeroList",{"castleId":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function useItem(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._useItem_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.useItem",{
               "castleId":param1,
               "heroId":param2,
               "itemId":param3
            });
         }
         return null;
      }
      
      public function GetDisappearHeros(param1:Function = null) : DisappearHeroResponse
      {
         this._GetDisappearHeros_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.GetDisappearHeros",{});
         }
         return null;
      }
      
      public function levelUp(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._levelUp_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.levelUp",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function hireFacebookFriendHero(param1:int, param2:String, param3:String, param4:String, param5:Function = null) : CommandResponse
      {
         this._hireFacebookFriendHero_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.hireFacebookFriendHero",{
               "castleId":param1,
               "heroName":param2,
               "newName":param3,
               "facebookid":param4
            });
         }
         return null;
      }
      
      public function GetRandomHero(param1:Function = null) : RandomHeroResponse
      {
         this._GetRandomHero_callback = param1;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.GetRandomHero",{});
         }
         return null;
      }
      
      public function fireHero(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._fireHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.fireHero",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function RecoverDisappearHero(param1:int, param2:String, param3:Function = null) : CommandResponse
      {
         this._RecoverDisappearHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.RecoverDisappearHero",{
               "castleid":param1,
               "id":param2
            });
         }
         return null;
      }
      
      public function changeName(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
      {
         this._changeName_callback = param4;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.changeName",{
               "castleId":param1,
               "heroId":param2,
               "newName":param3
            });
         }
         return null;
      }
      
      public function awardGold(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._awardGold_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.awardGold",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function recruitFleeHero(param1:int, param2:String, param3:Function = null) : CommandResponse
      {
         this._recruitFleeHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.recruitFleeHero",{
               "castleId":param1,
               "heroName":param2
            });
         }
         return null;
      }
      
      public function RetSetHeroAttri(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Function = null) : RandomHeroResponse
      {
         this._RetSetHeroAttri_callback = param5;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.RetSetHeroAttri",{
               "lockmanagement":param1,
               "lockpower":param2,
               "lockstratagem":param3,
               "busecoin":param4
            });
         }
         return null;
      }
      
      public function refreshHerosListFromTavern(param1:int, param2:Function = null) : HeroListResponse
      {
         this._refreshHerosListFromTavern_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.refreshHerosListFromTavern",{"castleId":param1});
         }
         return null;
      }
      
      public function addPoint(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Function = null) : CommandResponse
      {
         this._addPoint_callback = param6;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.addPoint",{
               "castleId":param1,
               "heroId":param2,
               "management":param3,
               "power":param4,
               "stratagem":param5
            });
         }
         return null;
      }
      
      public function SetShowHeroId(param1:int, param2:Boolean, param3:Function = null) : SetShowInfroResponse
      {
         this._SetShowHeroId_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.SetShowHeroId",{
               "heroid":param1,
               "bAddOrDel":param2
            });
         }
         return null;
      }
      
      public function ShowPlayerHerosByUserName(param1:String, param2:Function = null) : HeroListResponse
      {
         this._ShowPlayerHerosByUserName_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.ShowPlayerHerosByUserName",{"UserName":param1});
         }
         return null;
      }
      
      public function tryGetSeizedHero(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._tryGetSeizedHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.tryGetSeizedHero",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
      
      public function callBackHero(param1:int, param2:int, param3:Function = null) : CommandResponse
      {
         this._callBackHero_callback = param3;
         if(this.sender != null)
         {
            this.sender.sendMessage("hero.callBackHero",{
               "castleId":param1,
               "heroId":param2
            });
         }
         return null;
      }
   }
}

