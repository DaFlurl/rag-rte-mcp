// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.EquipmentCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.gemstone.GemstoneRespone;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class EquipmentCommands 
    {

        public var _EnhancedByGemStone_callback:Function;
        public var _WearAllEquipmenttech_callback:Function;
        public var _TakeOffEquipmenttech_callback:Function;
        public var _EnhancedStarByGemStone_callback:Function;
        private var sender:Sender;
        public var _TakeOffAllEquipmenttech_callback:Function;
        public var _WearEquipmenttech_callback:Function;


        public function WearEquipmenttech(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._WearEquipmenttech_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.heroid = _arg_1;
            _local_6.Equipmenttechid = _arg_2;
            _local_6.AddAttributeType = _arg_3;
            _local_6.pos = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.WearEquipmenttech", _local_6);
            };
            return (null);
        }

        public function TakeOffAllEquipmenttech(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._TakeOffAllEquipmenttech_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.heroid = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.TakeOffAllEquipmenttech", _local_3);
            };
            return (null);
        }

        public function EnhancedStarByGemStone(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Function=null):GemstoneRespone
        {
            this._EnhancedStarByGemStone_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.gemstoneid = _arg_1;
            _local_5.count = _arg_2;
            _local_5.pos = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.EnhancedStarByGemStone", _local_5);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function WearAllEquipmenttech(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._WearAllEquipmenttech_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.heroid = _arg_1;
            _local_4.AddAttributeType = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.WearAllEquipmenttech", _local_4);
            };
            return (null);
        }

        public function TakeOffEquipmenttech(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:Function=null):CommandResponse
        {
            this._TakeOffEquipmenttech_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.heroid = _arg_1;
            _local_5.Equipmenttechid = _arg_2;
            _local_5.pos = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.TakeOffEquipmenttech", _local_5);
            };
            return (null);
        }

        public function EnhancedByGemStone(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Function=null):GemstoneRespone
        {
            this._EnhancedByGemStone_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.gemstoneid = _arg_1;
            _local_5.pos = _arg_2;
            _local_5.lv = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("equipment.EnhancedByGemStone", _local_5);
            };
            return (null);
        }


    }
}//package com.evony.client.action

