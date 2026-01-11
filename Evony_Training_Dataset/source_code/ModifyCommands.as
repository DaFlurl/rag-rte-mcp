// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.ModifyCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.gamemaster.CreateHeroResponse;

    public class ModifyCommands 
    {

        public var _removeHero_callback:Function;
        public var _removeBuilding_callback:Function;
        private var sender:Sender;
        public var _removeItem_callback:Function;
        public var _setResources_callback:Function;
        public var _addItems_callback:Function;
        public var _addHero_callback:Function;
        public var _addBuilding_callback:Function;
        public var _setTechnology_callback:Function;


        public function setTechnology(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._setTechnology_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.setTechnology", {
                    "technologyType":_arg_1,
                    "level":_arg_2
                });
            };
            return (null);
        }

        public function removeBuilding(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._removeBuilding_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.removeBuilding", {
                    "castleId":_arg_1,
                    "position":_arg_2
                });
            };
            return (null);
        }

        public function removeHero(_arg_1:int, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._removeHero_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.removeHero", {
                    "castleId":_arg_1,
                    "heroId":_arg_2
                });
            };
            return (null);
        }

        public function addItems(_arg_1:String, _arg_2:int, _arg_3:Function=null):CommandResponse
        {
            this._addItems_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.addItems", {
                    "type":_arg_1,
                    "amount":_arg_2
                });
            };
            return (null);
        }

        public function setResources(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:Function=null):CommandResponse
        {
            this._setResources_callback = _arg_8;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.setResources", {
                    "castleId":_arg_1,
                    "wood":_arg_2,
                    "iron":_arg_3,
                    "stone":_arg_4,
                    "food":_arg_5,
                    "gold":_arg_6,
                    "population":_arg_7
                });
            };
            return (null);
        }

        public function addBuilding(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):CommandResponse
        {
            this._addBuilding_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.addBuilding", {
                    "castleId":_arg_1,
                    "buildingType":_arg_2,
                    "position":_arg_3,
                    "level":_arg_4
                });
            };
            return (null);
        }

        public function removeItem(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._removeItem_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.removeItem", {"type":_arg_1});
            };
            return (null);
        }

        public function addHero(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:Function=null):CreateHeroResponse
        {
            this._addHero_callback = _arg_11;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamemaster.addHero", {
                    "castleId":_arg_1,
                    "name":_arg_2,
                    "level":_arg_3,
                    "experience":_arg_4,
                    "loyalty":_arg_5,
                    "status":_arg_6,
                    "management":_arg_7,
                    "power":_arg_8,
                    "stratagem":_arg_9,
                    "remain":_arg_10
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

