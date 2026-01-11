// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.AllianceCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.alliance.MilitarySituationListResponse;
    import com.evony.common.module.alliance.AllianceListResponse;
    import com.evony.common.module.alliance.AllianceMembersResponse;
    import com.evony.common.module.alliance.AllianceEventListResponse;
    import com.evony.common.module.alliance.AllianceArmyResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;

    public class AllianceCommands 
    {

        public var _getAllianceArmyReport_callback:Function;
        public var _getAllianceInfo_callback:Function;
        public var _getMilitarySituationList_callback:Function;
        private var sender:Sender;
        public var _getAllianceList_callback:Function;
        public var _getAllianceMembers_callback:Function;
        public var _getAllianceEventList_callback:Function;


        public function getMilitarySituationList(_arg_1:int, _arg_2:int, _arg_3:Function=null):MilitarySituationListResponse
        {
            this._getMilitarySituationList_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getMilitarySituationList", {
                    "pageNo":_arg_1,
                    "pageSize":_arg_2
                });
            };
            return (null);
        }

        public function getAllianceList(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):AllianceListResponse
        {
            this._getAllianceList_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceList", {
                    "pageSize":_arg_1,
                    "pageNum":_arg_2,
                    "ranking":_arg_3,
                    "name":_arg_4
                });
            };
            return (null);
        }

        public function getAllianceMembers(_arg_1:Function=null):AllianceMembersResponse
        {
            this._getAllianceMembers_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceMembers", {});
            };
            return (null);
        }

        public function getAllianceEventList(_arg_1:int, _arg_2:Function=null):AllianceEventListResponse
        {
            this._getAllianceEventList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceEventList", {"pageNo":_arg_1});
            };
            return (null);
        }

        public function getAllianceArmyReport(_arg_1:int, _arg_2:Function=null):AllianceArmyResponse
        {
            this._getAllianceArmyReport_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceArmyReport", {"armyId":_arg_1});
            };
            return (null);
        }

        public function getAllianceInfo(_arg_1:String, _arg_2:Function=null):AllianceInfoResponse
        {
            this._getAllianceInfo_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("alliance.getAllianceInfo", {"allianceName":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

