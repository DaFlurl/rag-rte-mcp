// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.NpcHeroCommand

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.npchero.NpcHeroListResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class NpcHeroCommand 
    {

        public var _getNpcHerosList_callback:Function;
        public var _getNpcHerosListByMoney_callback:Function;
        public var _getNpcHerosListByFilter_callback:Function;
        private var sender:Sender;
        public var _getNpcHeroInfroByID_callback:Function;


        public function getNpcHeroInfroByID(_arg_1:int, _arg_2:int, _arg_3:Function=null):NpcHeroListResponse
        {
            this._getNpcHeroInfroByID_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.npcid = _arg_1;
            _local_4.castleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("npchero.getNpcHeroInfroByID", _local_4);
            };
            return (null);
        }

        public function getNpcHerosList(_arg_1:int, _arg_2:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosList_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("npchero.getNpcHerosList", _local_3);
            };
            return (null);
        }

        public function getNpcHerosListByFilter(_arg_1:String, _arg_2:int, _arg_3:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosListByFilter_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.filter = _arg_1;
            _local_4.castleId = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("npchero.getNpcHerosListByFilter", _local_4);
            };
            return (null);
        }

        public function getNpcHerosListByMoney(_arg_1:int, _arg_2:Function=null):NpcHeroListResponse
        {
            this._getNpcHerosListByMoney_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.castleId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("npchero.getNpcHerosListByMoney", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

