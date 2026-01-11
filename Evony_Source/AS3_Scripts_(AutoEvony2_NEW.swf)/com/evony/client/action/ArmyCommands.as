// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ArmyCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.army.StayAllianceReponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.army.TroopParamResponse;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.module.army.ArmyPracticeResponse;
    import com.evony.common.paramBeans.NewArmyParam;

    public class ArmyCommands 
    {

        public var _callBackArmy_callback:Function;
        internal var sender:Sender;
        public var _getInjuredTroop_callback:Function;
        public var _newArmy_callback:Function;
        public var _getFleeTroop_callback:Function;
        public var _getTroopParam_callback:Function;
        public var _setArmyGoOut_callback:Function;
        public var _disbandFleeTroop_callback:Function;
        public var _disbandInjuredTroop_callback:Function;
        public var _exerciseArmy_callback:Function;
        public var _setAllowAllianceArmy_callback:Function;
        public var _getStayAllianceArmys_callback:Function;
        public var _cureInjuredTroop_callback:Function;
        public var _recruitFleeTroop_callback:Function;
        public var _id:String = "ArmyCommands";


        public function getStayAllianceArmys(_arg_1:int, _arg_2:Function=null):StayAllianceReponse
        {
            this._getStayAllianceArmys_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.getStayAllianceArmys", {"castleId":_arg_1});
            };
            return (null);
        }

        public function disbandFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._disbandFleeTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.disbandFleeTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function recruitFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._recruitFleeTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.recruitFleeTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getTroopParam(_arg_1:int, _arg_2:Function=null):TroopParamResponse
        {
            this._getTroopParam_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.getTroopParam", {"castleId":_arg_1});
            };
            return (null);
        }

        public function exerciseArmy(_arg_1:int, _arg_2:TroopBean, _arg_3:TroopBean, _arg_4:Function=null):ArmyPracticeResponse
        {
            this._exerciseArmy_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.exerciseArmy", {
                    "castleId":_arg_1,
                    "troopParamAttack":_arg_2,
                    "troopParamDefend":_arg_3
                });
            };
            return (null);
        }

        public function getFleeTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._getFleeTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.getFleeTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function disbandInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._disbandInjuredTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.disbandInjuredTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function newArmy(_arg_1:int, _arg_2:NewArmyParam, _arg_3:Function=null):CommandResponse
        {
            this._newArmy_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.newArmy", {
                    "castleId":_arg_1,
                    "newArmyBean":_arg_2
                });
            };
            return (null);
        }

        public function setAllowAllianceArmy(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):CommandResponse
        {
            this._setAllowAllianceArmy_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.setAllowAllianceArmy", {
                    "castleId":_arg_1,
                    "isAllow":_arg_2
                });
            };
            return (null);
        }

        public function getInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._getInjuredTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.getInjuredTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function callBackArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._callBackArmy_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.callBackArmy", {
                    "castleId":_arg_1,
                    "armyId":_arg_2
                });
            };
            return (null);
        }

        public function setArmyGoOut(_arg_1:int, _arg_2:Boolean, _arg_3:Function=null):CommandResponse
        {
            this._setArmyGoOut_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.setArmyGoOut", {
                    "castleId":_arg_1,
                    "isArmyGoOut":_arg_2
                });
            };
            return (null);
        }

        public function cureInjuredTroop(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._cureInjuredTroop_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("army.cureInjuredTroop", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

