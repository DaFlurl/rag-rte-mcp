// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.VisitCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.visit.GetHelpedPlayersResponse;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.visit.GetAllVisitorCommentsResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class VisitCommands 
    {

        public var _getAllVisitorComments_callback:Function;
        public var _deleteComment_callback:Function;
        public var _getVisitorComments_callback:Function;
        public var _getHelpedPlayers_callback:Function;
        public var _markCommentAsRead_callback:Function;
        private var sender:Sender;
        public var _helpIncreaseProduction_callback:Function;
        public var _visitorComment_callback:Function;


        public function getHelpedPlayers(_arg_1:Function=null):GetHelpedPlayersResponse
        {
            this._getHelpedPlayers_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("visit.getHelpedPlayers", _local_2);
            };
            return (null);
        }

        public function visitorComment(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._visitorComment_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.comment = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("visit.visitorComment", _local_3);
            };
            return (null);
        }

        public function getVisitorComments(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Function=null):GetAllVisitorCommentsResponse
        {
            this._getVisitorComments_callback = _arg_4;
            var _local_5:Object = new Object();
            _local_5.visitorId = _arg_1;
            _local_5.pageNo = _arg_2;
            _local_5.pageSize = _arg_3;
            if (this.sender != null)
            {
                sender.sendMessage("visit.getVisitorComments", _local_5);
            };
            return (null);
        }

        public function getAllVisitorComments(_arg_1:int, _arg_2:int, _arg_3:Function=null):GetAllVisitorCommentsResponse
        {
            this._getAllVisitorComments_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.pageNo = _arg_1;
            _local_4.pageSize = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("visit.getAllVisitorComments", _local_4);
            };
            return (null);
        }

        public function markCommentAsRead(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._markCommentAsRead_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.id = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("visit.markCommentAsRead", _local_3);
            };
            return (null);
        }

        public function deleteComment(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._deleteComment_callback = _arg_2;
            var _local_3:Object = new Object();
            _local_3.id = _arg_1;
            if (this.sender != null)
            {
                sender.sendMessage("visit.deleteComment", _local_3);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function helpIncreaseProduction(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._helpIncreaseProduction_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.fromServer = _arg_1;
            _local_4.fromPlayer = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("visit.helpIncreaseProduction", _local_4);
            };
            return (null);
        }


    }
}//package com.evony.client.action

