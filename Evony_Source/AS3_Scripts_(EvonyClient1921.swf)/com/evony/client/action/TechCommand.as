// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TechCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.castle.CoinsNeedResponse;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class TechCommand 
    {

        public var _getCoinsNeed_callback:Function;
        public var _research_callback:Function;
        public var _speedUpResearch_callback:Function;
        public var _cancelResearch_callback:Function;
        public var _getResearchList_callback:Function;
        private var sender:Sender;


        public function getCoinsNeed(_arg_1:int, _arg_2:Function=null):CoinsNeedResponse
        {
            this._getCoinsNeed_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.getCoinsNeed", _local_3);
            };
            return (null);
        }

        public function getResearchList(_arg_1:int, _arg_2:Function=null):AvailableResearchListResponse
        {
            this._getResearchList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.getResearchList", _local_3);
            };
            return (null);
        }

        public function research(_arg_1:int, _arg_2:int, _arg_3:Function=null):ResearchResponse
        {
            this._research_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.techId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("tech.research", _local_4);
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
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.cancelResearch", _local_3);
            };
            return (null);
        }

        public function speedUpResearch(_arg_1:int, _arg_2:String, _arg_3:Function=null):ResearchResponse
        {
            this._speedUpResearch_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.itemId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("tech.speedUpResearch", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

