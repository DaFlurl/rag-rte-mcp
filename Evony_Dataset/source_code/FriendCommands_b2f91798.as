// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.FriendCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.friend.FriendResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class FriendCommands 
    {

        public var _deleteBlock_callback:Function;
        public var _addFriend_callback:Function;
        public var _isBlockMailPlayer_callback:Function;
        private var sender:Sender;
        public var _addBlock_callback:Function;
        public var _deleteFriend_callback:Function;


        public function deleteBlock(_arg_1:String, _arg_2:Function=null):FriendResponse
        {
            this._deleteBlock_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.player = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.deleteBlock", _local_3);
            };
            return (null);
        }

        public function deleteFriend(_arg_1:String, _arg_2:Function=null):FriendResponse
        {
            this._deleteFriend_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.player = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.deleteFriend", _local_3);
            };
            return (null);
        }

        public function addBlock(_arg_1:String, _arg_2:Function=null):FriendResponse
        {
            this._addBlock_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.player = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.addBlock", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function isBlockMailPlayer(_arg_1:int, _arg_2:Function=null):FriendResponse
        {
            this._isBlockMailPlayer_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.mailId = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.isBlockMailPlayer", _local_3);
            };
            return (null);
        }

        public function addFriend(_arg_1:String, _arg_2:Function=null):FriendResponse
        {
            this._addFriend_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.player = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.addFriend", _local_3);
            };
            return (null);
        }


    }
}//package com.evony.client.action

