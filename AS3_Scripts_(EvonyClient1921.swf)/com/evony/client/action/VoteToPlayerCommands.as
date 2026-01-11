// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.VoteToPlayerCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class VoteToPlayerCommands 
    {

        public var _voteToPlayerByName_callback:Function;
        private var sender:Sender;
        public var _voteToPlayerById_callback:Function;


        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function voteToPlayerById(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._voteToPlayerById_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.playerId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("vote.voteToPlayerById", _local_3);
            };
            return (null);
        }

        public function voteToPlayerByName(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._voteToPlayerByName_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.name = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("vote.voteToPlayerByName", _local_3);
            };
            return (null);
        }


    }
}//package com.evony.client.action

