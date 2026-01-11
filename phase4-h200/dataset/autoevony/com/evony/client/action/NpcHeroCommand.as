// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.NpcHeroCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.npchero.NpcHeroListResponse;

    public class NpcHeroCommand 
    {

        public var _getNpcHerosList_callback:Function;
        public var _getNpcHerosListByFilter_callback:Function;
        public var _getNpcHerosListByMoney_callback:Function;
        private var sender:Sender;
        public var _getNpcHeroInfroByID_callback:Function;


        public function getNpcHeroInfroByID(_arg_1:int, _arg_2:int, _arg_3:Function=null):NpcHeroListResponse
        {
            this._getNpcHeroInfroByID_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("npchero.getNpcHeroInfroByID", {
                    "npcid":_arg_1,
                    "castleId":_arg_2
                });
            };
            return (null);
        }

        public function getNpcHerosList(_arg_1:int, _arg_2:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosList_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("npchero.getNpcHerosList", {"castleId":_arg_1});
            };
            return (null);
        }

        public function getNpcHerosListByFilter(_arg_1:String, _arg_2:int, _arg_3:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosListByFilter_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("npchero.getNpcHerosListByFilter", {
                    "filter":_arg_1,
                    "castleId":_arg_2
                });
            };
            return (null);
        }

        public function getNpcHerosListByMoney(_arg_1:int, _arg_2:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosListByMoney_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("npchero.getNpcHerosListByMoney", {"castleId":_arg_1});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

