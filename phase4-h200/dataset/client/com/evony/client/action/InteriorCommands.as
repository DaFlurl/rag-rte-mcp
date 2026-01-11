// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.InteriorCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.interior.ResourceProduceDataResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class InteriorCommands 
    {

        public var _pacifyPeople_callback:Function;
        public var _modifyTaxRate_callback:Function;
        public var _modifyCommenceRate_callback:Function;
        private var sender:Sender;
        public var _taxation_callback:Function;
        public var _getResourceProduceData_callback:Function;


        public function modifyTaxRate(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._modifyTaxRate_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.tax = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.modifyTaxRate", _local_4);
            };
            return (null);
        }

        public function taxation(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._taxation_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.typeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.taxation", _local_4);
            };
            return (null);
        }

        public function getResourceProduceData(_arg_1:int, _arg_2:Function=null):ResourceProduceDataResponse
        {
            this._getResourceProduceData_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("interior.getResourceProduceData", _local_3);
            };
            return (null);
        }

        public function modifyCommenceRate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._modifyCommenceRate_callback = _arg_6;
            var _local_7:Object = new Object();
            _local_7.castleId = _arg_1;
            _local_7.foodrate = _arg_2;
            _local_7.woodrate = _arg_3;
            _local_7.stonerate = _arg_4;
            _local_7.ironrate = _arg_5;
            if (this.sender != null)
            {
                sender.sendMessage("interior.modifyCommenceRate", _local_7);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function pacifyPeople(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._pacifyPeople_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.typeId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.pacifyPeople", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

