// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.EquipmenttechCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.module.castle.CoinsNeedResponse;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import com.evony.common.module.CommandResponse;

    public class EquipmenttechCommands 
    {

        public var _getCoinsNeed_callback:Function;
        public var _speedUpResearch_callback:Function;
        public var _cancelResearch_callback:Function;
        public var _research_callback:Function;
        private var sender:Sender;
        public var _getResearchList_callback:Function;


        public function research(_arg_1:int, _arg_2:int, _arg_3:Function=null):ResearchResponse
        {
            this._research_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("equipmenttech.research", {
                    "castleId":_arg_1,
                    "techId":_arg_2
                });
            };
            return (null);
        }

        public function getCoinsNeed(_arg_1:int, _arg_2:Function=null):CoinsNeedResponse
        {
            this._getCoinsNeed_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("equipmenttech.getCoinsNeed", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getResearchList(_arg_1:int, _arg_2:Function=null):AvailableResearchListResponse
        {
            this._getResearchList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("equipmenttech.getResearchList", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function cancelResearch(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._cancelResearch_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("equipmenttech.cancelResearch", {"castleId":_arg_1});
            };
            return (null);
        }

        public function speedUpResearch(_arg_1:int, _arg_2:String, _arg_3:Function=null):ResearchResponse
        {
            this._speedUpResearch_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("equipmenttech.speedUpResearch", {
                    "castleId":_arg_1,
                    "itemId":_arg_2
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

