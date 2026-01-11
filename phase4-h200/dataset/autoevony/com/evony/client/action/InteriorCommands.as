// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.InteriorCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.interior.ResourceProduceDataResponse;

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
            if (this.sender != null)
            {
                this.sender.sendMessage("interior.modifyTaxRate", {
                    "castleId":_arg_1,
                    "tax":_arg_2
                });
            };
            return (null);
        }

        public function taxation(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._taxation_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("interior.taxation", {
                    "castleId":_arg_1,
                    "typeId":_arg_2
                });
            };
            return (null);
        }

        public function getResourceProduceData(_arg_1:int, _arg_2:Function=null):ResourceProduceDataResponse
        {
            this._getResourceProduceData_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("interior.getResourceProduceData", {"castleId":_arg_1});
            };
            return (null);
        }

        public function modifyCommenceRate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Function=null):CommandResponse
        {
            this._modifyCommenceRate_callback = _arg_6;
            if (this.sender != null)
            {
                this.sender.sendMessage("interior.modifyCommenceRate", {
                    "castleId":_arg_1,
                    "foodrate":_arg_2,
                    "woodrate":_arg_3,
                    "stonerate":_arg_4,
                    "ironrate":_arg_5
                });
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
            if (this.sender != null)
            {
                this.sender.sendMessage("interior.pacifyPeople", {
                    "castleId":_arg_1,
                    "typeId":_arg_2
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

