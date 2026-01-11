// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.TroopCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.troop.ProduceQueueResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.troop.TroopProduceListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class TroopCommands 
    {

        public var _produceTroop_callback:Function;
        public var _accTroopProduce_callback:Function;
        public var _checkIdleBarrack_callback:Function;
        public var _getProduceQueue_callback:Function;
        public var _cancelTroopProduce_callback:Function;
        public var _getTroopProduceList_callback:Function;
        private var sender:Sender;
        public var _disbandTroop_callback:Function;


        public function getProduceQueue(_arg_1:int, _arg_2:Function=null):ProduceQueueResponse
        {
            this._getProduceQueue_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("troop.getProduceQueue", _local_3);
            };
            return (null);
        }

        public function cancelTroopProduce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._cancelTroopProduce_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.positionId = _arg_2;
            _local_5.queueId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("troop.cancelTroopProduce", _local_5);
            };
            return (null);
        }

        public function checkIdleBarrack(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._checkIdleBarrack_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.troopType = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("troop.checkIdleBarrack", _local_4);
            };
            return (null);
        }

        public function disbandTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._disbandTroop_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.troopType = _arg_2;
            _local_5.num = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("troop.disbandTroop", _local_5);
            };
            return (null);
        }

        public function produceTroop(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Function=null):CommandResponse
        {
            this._produceTroop_callback = _arg_7;
            var _local_8:Object = new Object();
            _local_8.castleId = _arg_1;
            _local_8.positionId = _arg_2;
            _local_8.troopType = _arg_3;
            _local_8.num = _arg_4;
            _local_8.isShare = _arg_5;
            _local_8.toIdle = _arg_6;
            if (this.sender != null)
            {
                sender.sendMessage("troop.produceTroop", _local_8);
            };
            return (null);
        }

        public function accTroopProduce(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Function=null):CommandResponse
        {
            this._accTroopProduce_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.castleId = _arg_1;
            _local_6.positionId = _arg_2;
            _local_6.queueId = _arg_3;
            _local_6.itemId = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("troop.accTroopProduce", _local_6);
            };
            return (null);
        }

        public function getTroopProduceList(_arg_1:int, _arg_2:int, _arg_3:Function=null):TroopProduceListResponse
        {
            this._getTroopProduceList_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.positionId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("troop.getTroopProduceList", _local_4);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

