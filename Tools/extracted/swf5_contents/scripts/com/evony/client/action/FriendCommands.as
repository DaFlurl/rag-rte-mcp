package com.evony.client.action
{
   import com.evony.common.Sender;
   import com.evony.common.module.friend.FriendResponse;
   
   public class FriendCommands
   {
      public var _deleteBlock_callback:Function;
      
      public var _addFriend_callback:Function;
      
      public var _isBlockMailPlayer_callback:Function;
      
      private var sender:Sender;
      
      public var _addBlock_callback:Function;
      
      public var _deleteFriend_callback:Function;
      
      public function FriendCommands()
      {
         super();
      }
      
      public function deleteBlock(param1:String, param2:Function = null) : FriendResponse
      {
         this._deleteBlock_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("friend.deleteBlock",{"player":param1});
         }
         return null;
      }
      
      public function deleteFriend(param1:String, param2:Function = null) : FriendResponse
      {
         this._deleteFriend_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("friend.deleteFriend",{"player":param1});
         }
         return null;
      }
      
      public function addBlock(param1:String, param2:Function = null) : FriendResponse
      {
         this._addBlock_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("friend.addBlock",{"player":param1});
         }
         return null;
      }
      
      public function setSender(param1:Sender) : void
      {
         this.sender = param1;
      }
      
      public function isBlockMailPlayer(param1:int, param2:Function = null) : FriendResponse
      {
         this._isBlockMailPlayer_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("friend.isBlockMailPlayer",{"mailId":param1});
         }
         return null;
      }
      
      public function addFriend(param1:String, param2:Function = null) : FriendResponse
      {
         this._addFriend_callback = param2;
         if(this.sender != null)
         {
            this.sender.sendMessage("friend.addFriend",{"player":param1});
         }
         return null;
      }
   }
}

