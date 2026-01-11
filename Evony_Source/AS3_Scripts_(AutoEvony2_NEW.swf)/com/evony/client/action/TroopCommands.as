// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TroopCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.troop.ProduceQueueResponse;
    import com.evony.common.module.troop.TroopProduceListResponse;
    import com.evony.common.module.CommandResponse;

    public class TroopCommands 
    {

        public var _getTroopProduceList_callback:Function;
        public var _produceTroop_callback:Function;
        public var _accTroopProduce_callback:Function;
        private var sender:Sender;
        public var _disbandTroop_callback:Function;
        public var _checkIdleBarrack_callback:Function;
        public var _getProduceQueue_callback:Function;
        public var _cancelTroopProduce_callback:Function;


        public function getProduceQueue(_arg_1:int, _arg_2:Function=null):ProduceQueueResponse
        {
            this._getProduceQueue_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.getProduceQueue", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getTroopProduceList(_arg_1:int, _arg_2:int, _arg_3:Function=null):TroopProduceListResponse
        {
            this._getTroopProduceList_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.getTroopProduceList", {
                    "castleId":_arg_1,
                    "positionId":_arg_2
                });
            };
            return (null);
        }

        public function cancelTroopProduce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._cancelTroopProduce_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.cancelTroopProduce", {
                    "castleId":_arg_1,
                    "positionId":_arg_2,
                    "queueId":_arg_3
                });
            };
            return (null);
        }

        public function checkIdleBarrack(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._checkIdleBarrack_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.checkIdleBarrack", {
                    "castleId":_arg_1,
                    "troopType":_arg_2
                });
            };
            return (null);
        }

        public function disbandTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._disbandTroop_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.disbandTroop", {
                    "castleId":_arg_1,
                    "troopType":_arg_2,
                    "num":_arg_3
                });
            };
            return (null);
        }

        public function produceTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Function=null):CommandResponse
        {
            this._produceTroop_callback = _arg_7;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.produceTroop", {
                    "castleId":_arg_1,
                    "positionId":_arg_2,
                    "troopType":_arg_3,
                    "num":_arg_4,
                    "isShare":_arg_5,
                    "toIdle":_arg_6
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function accTroopProduce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._accTroopProduce_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("troop.accTroopProduce", {
                    "castleId":_arg_1,
                    "positionId":_arg_2,
                    "queueId":_arg_3,
                    "itemId":_arg_4
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

