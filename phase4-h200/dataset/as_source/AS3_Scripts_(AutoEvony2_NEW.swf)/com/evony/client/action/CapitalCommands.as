// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.CapitalCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.capital.CapitalCommandResponse;
    import com.evony.common.*;
    import com.evony.common.module.capital.*;

    public class CapitalCommands 
    {

        public var _getUsedPoliciesTimes_callback:Function;
        public var _levyTaxes_callback:Function;
        public var _reduceArmaments_callback:Function;
        public var _levyFood_callback:Function;
        public var _getLeftPoliciesTimes_callback:Function;
        internal var sender:Sender;
        public var _levyArmy_callback:Function;
        public var _levyPopulation_callback:Function;


        public function levyArmy(_arg_1:int, _arg_2:int, _arg_3:Function=null):CapitalCommandResponse
        {
            this._levyArmy_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetFieldId = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.levyArmy", _local_4);
            };
            return (null);
        }

        public function getUsedPoliciesTimes(_arg_1:int, _arg_2:Function=null):CapitalCommandResponse
        {
            this._getUsedPoliciesTimes_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.getUsedPoliciesTimes", _local_3);
            };
            return (null);
        }

        public function levyPopulation(_arg_1:int, _arg_2:int, _arg_3:Function=null):CapitalCommandResponse
        {
            this._levyPopulation_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetFieldId = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.levyPopulation", _local_4);
            };
            return (null);
        }

        public function reduceArmaments(_arg_1:int, _arg_2:int, _arg_3:Function=null):CapitalCommandResponse
        {
            this._reduceArmaments_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetFieldId = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.reduceArmaments", _local_4);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function getLeftPoliciesTimes(_arg_1:int, _arg_2:Function=null):CapitalCommandResponse
        {
            this._getLeftPoliciesTimes_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.getLeftPoliciesTimes", _local_3);
            };
            return (null);
        }

        public function levyFood(_arg_1:int, _arg_2:int, _arg_3:Function=null):CapitalCommandResponse
        {
            this._levyFood_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetFieldId = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.levyFood", _local_4);
            };
            return (null);
        }

        public function levyTaxes(_arg_1:int, _arg_2:int, _arg_3:Function=null):CapitalCommandResponse
        {
            this._levyTaxes_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.targetFieldId = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("capital.levyTaxes", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

