// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ModifyCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.gamemaster.CreateHeroResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class ModifyCommands 
    {

        public var _removeHero_callback:Function;
        public var _removeBuilding_callback:Function;
        public var _removeItem_callback:Function;
        public var _setTechnology_callback:Function;
        public var _setResources_callback:Function;
        public var _addItems_callback:Function;
        public var _addHero_callback:Function;
        public var _addBuilding_callback:Function;
        private var sender:Sender;


        public function removeBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._removeBuilding_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.position = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeBuilding", _local_4);
            };
            return (null);
        }

        public function setTechnology(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._setTechnology_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.technologyType = _arg_1;
            _local_4.level = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.setTechnology", _local_4);
            };
            return (null);
        }

        public function removeHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._removeHero_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.castleId = _arg_1;
            _local_4.heroId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeHero", _local_4);
            };
            return (null);
        }

        public function addItems(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._addItems_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.type = _arg_1;
            _local_4.amount = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addItems", _local_4);
            };
            return (null);
        }

        public function setResources(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:Function=null):CommandResponse
        {
            this._setResources_callback = _arg_8;
            var _local_9:Object = new Object();
            _local_9.castleId = _arg_1;
            _local_9.wood = _arg_2;
            _local_9.iron = _arg_3;
            _local_9.stone = _arg_4;
            _local_9.food = _arg_5;
            _local_9.gold = _arg_6;
            _local_9.population = _arg_7;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.setResources", _local_9);
            };
            return (null);
        }

        public function addBuilding(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._addBuilding_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.castleId = _arg_1;
            _local_6.buildingType = _arg_2;
            _local_6.position = _arg_3;
            _local_6.level = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addBuilding", _local_6);
            };
            return (null);
        }

        public function removeItem(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._removeItem_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.type = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeItem", _local_3);
            };
            return (null);
        }

        public function addHero(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:Function=null):CreateHeroResponse
        {
            this._addHero_callback = _arg_11;
            var _local_12:Object = new Object();
            _local_12.castleId = _arg_1;
            _local_12.name = _arg_2;
            _local_12.level = _arg_3;
            _local_12.experience = _arg_4;
            _local_12.loyalty = _arg_5;
            _local_12.status = _arg_6;
            _local_12.management = _arg_7;
            _local_12.power = _arg_8;
            _local_12.stratagem = _arg_9;
            _local_12.remain = _arg_10;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addHero", _local_12);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

