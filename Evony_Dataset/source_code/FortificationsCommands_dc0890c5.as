// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.FortificationsCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.fortifications.FortProduceListResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.troop.ProduceQueueResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class FortificationsCommands 
    {

        public var _produceWallProtect_callback:Function;
        public var _accTroopProduce_callback:Function;
        private var sender:Sender;
        public var _destructWallProtect_callback:Function;
        public var _getProduceQueue_callback:Function;
        public var _getFortificationsProduceList_callback:Function;
        public var _cancelFortificationProduce_callback:Function;


        public function getFortificationsProduceList(_arg_1:int, _arg_2:Function=null):FortProduceListResponse
        {
            this._getFortificationsProduceList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.getFortificationsProduceList", _local_3);
            };
            return (null);
        }

        public function produceWallProtect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._produceWallProtect_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.wallProtectType = _arg_2;
            _local_5.num = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.produceWallProtect", _local_5);
            };
            return (null);
        }

        public function cancelFortificationProduce(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._cancelFortificationProduce_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.queueId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.cancelFortificationProduce", _local_4);
            };
            return (null);
        }

        public function destructWallProtect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._destructWallProtect_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.typeId = _arg_2;
            _local_5.num = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.destructWallProtect", _local_5);
            };
            return (null);
        }

        public function accTroopProduce(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Function=null):CommandResponse
        {
            this._accTroopProduce_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.castleId = _arg_1;
            _local_5.queueId = _arg_2;
            _local_5.itemId = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.accTroopProduce", _local_5);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function getProduceQueue(_arg_1:int, _arg_2:Function=null):ProduceQueueResponse
        {
            this._getProduceQueue_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.getProduceQueue", _local_3);
            };
            return (null);
        }


    }
}//package com.evony.client.action

