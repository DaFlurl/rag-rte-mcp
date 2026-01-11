// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.HeroCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.hero.HeroListResponse;
    import com.evony.common.module.hero.DisappearHeroResponse;
    import com.evony.common.module.hero.RandomHeroResponse;
    import com.evony.common.module.hero.SetShowInfroResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class HeroCommand 
    {

        public var _releaseHero_callback:Function;
        public var _RetSetHeroAttri_callback:Function;
        public var _addPoint2_callback:Function;
        public var _useItem_callback:Function;
        public var _ShowPlayerHerosByUserName_callback:Function;
        public var _resetPoint_callback:Function;
        public var _callBackHero_callback:Function;
        public var _awardGold_callback:Function;
        public var _addPoint_callback:Function;
        public var _GetDisappearHeros_callback:Function;
        public var _tryGetSeizedHero_callback:Function;
        public var _dischargeChief_callback:Function;
        public var _levelUp_callback:Function;
        private var sender:Sender;
        public var _getHerosListFromTavern_callback:Function;
        public var _setHeroFacebookId_callback:Function;
        public var _refreshHerosListFromTavern_callback:Function;
        public var _SetShowHeroId_callback:Function;
        public var _fireHero_callback:Function;
        public var _getFleeHeroList_callback:Function;
        public var _hireHero_callback:Function;
        public var _recruitFleeHero_callback:Function;
        public var _RecoverDisappearHero_callback:Function;
        public var _GetRandomHero_callback:Function;
        public var _changeName_callback:Function;
        public var _hireFacebookFriendHero_callback:Function;
        public var _GenSaveRandomHero_callback:Function;
        public var _promoteToChief_callback:Function;


        public function resetPoint(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._resetPoint_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.resetPoint", _local_4);
            };
            return (null);
        }

        public function getHerosListFromTavern(_arg_1:int, _arg_2:Function=null):HeroListResponse
        {
            this._getHerosListFromTavern_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.getHerosListFromTavern", _local_3);
            };
            return (null);
        }

        public function GenSaveRandomHero(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._GenSaveRandomHero_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleid = _arg_1;
            _local_5.heroname = _arg_2;
            _local_5.faceurl = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.GenSaveRandomHero", _local_5);
            };
            return (null);
        }

        public function releaseHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._releaseHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.releaseHero", _local_4);
            };
            return (null);
        }

        public function hireHero(_arg_1:int, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._hireHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroName = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.hireHero", _local_4);
            };
            return (null);
        }

        public function promoteToChief(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._promoteToChief_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.promoteToChief", _local_4);
            };
            return (null);
        }

        public function addPoint2(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._addPoint2_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.heroId = _arg_2;
            _local_7.management = _arg_3;
            _local_7.power = _arg_4;
            _local_7.stratagem = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("hero.addPoint2", _local_7);
            };
            return (null);
        }

        public function GetDisappearHeros(_arg_1:Function=null):DisappearHeroResponse
        {
            this._GetDisappearHeros_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("hero.GetDisappearHeros", _local_2);
            };
            return (null);
        }

        public function getFleeHeroList(_arg_1:int, _arg_2:Function=null):HeroListResponse
        {
            this._getFleeHeroList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.getFleeHeroList", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function GetRandomHero(_arg_1:Function=null):RandomHeroResponse
        {
            this._GetRandomHero_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("hero.GetRandomHero", _local_2);
            };
            return (null);
        }

        public function dischargeChief(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._dischargeChief_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.dischargeChief", _local_3);
            };
            return (null);
        }

        public function RetSetHeroAttri(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Function=null):RandomHeroResponse
        {
            this._RetSetHeroAttri_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.lockmanagement = _arg_1;
            _local_6.lockpower = _arg_2;
            _local_6.lockstratagem = _arg_3;
            _local_6.busecoin = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("hero.RetSetHeroAttri", _local_6);
            };
            return (null);
        }

        public function hireFacebookFriendHero(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._hireFacebookFriendHero_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.castleId = _arg_1;
            _local_6.heroName = _arg_2;
            _local_6.newName = _arg_3;
            _local_6.facebookid = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("hero.hireFacebookFriendHero", _local_6);
            };
            return (null);
        }

        public function useItem(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._useItem_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.heroId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.useItem", _local_5);
            };
            return (null);
        }

        public function levelUp(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._levelUp_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.levelUp", _local_4);
            };
            return (null);
        }

        public function fireHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._fireHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.fireHero", _local_4);
            };
            return (null);
        }

        public function RecoverDisappearHero(_arg_1:int, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._RecoverDisappearHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleid = _arg_1;
            _local_4.id = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.RecoverDisappearHero", _local_4);
            };
            return (null);
        }

        public function changeName(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._changeName_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.heroId = _arg_2;
            _local_5.newName = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.changeName", _local_5);
            };
            return (null);
        }

        public function awardGold(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._awardGold_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.awardGold", _local_4);
            };
            return (null);
        }

        public function recruitFleeHero(_arg_1:int, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._recruitFleeHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroName = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.recruitFleeHero", _local_4);
            };
            return (null);
        }

        public function setHeroFacebookId(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._setHeroFacebookId_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.heroId = _arg_2;
            _local_5.facebookId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.setHeroFacebookId", _local_5);
            };
            return (null);
        }

        public function refreshHerosListFromTavern(_arg_1:int, _arg_2:Function=null):HeroListResponse
        {
            this._refreshHerosListFromTavern_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.refreshHerosListFromTavern", _local_3);
            };
            return (null);
        }

        public function addPoint(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Function=null):CommandResponse
        {
            this._addPoint_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.heroId = _arg_2;
            _local_7.management = _arg_3;
            _local_7.power = _arg_4;
            _local_7.stratagem = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("hero.addPoint", _local_7);
            };
            return (null);
        }

        public function SetShowHeroId(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):SetShowInfroResponse
        {
            this._SetShowHeroId_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.heroid = _arg_1;
            _local_4.bAddOrDel = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.SetShowHeroId", _local_4);
            };
            return (null);
        }

        public function ShowPlayerHerosByUserName(_arg_1:String, _arg_2:Function=null):HeroListResponse
        {
            this._ShowPlayerHerosByUserName_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.UserName = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.ShowPlayerHerosByUserName", _local_3);
            };
            return (null);
        }

        public function tryGetSeizedHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._tryGetSeizedHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.tryGetSeizedHero", _local_4);
            };
            return (null);
        }

        public function callBackHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._callBackHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.callBackHero", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

