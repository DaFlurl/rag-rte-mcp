// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.VisitCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.visit.GetHelpedPlayersResponse;
    import com.evony.common.module.visit.GetAllVisitorCommentsResponse;

    public class VisitCommands 
    {

        public var _helpIncreaseProduction_callback:Function;
        public var _markCommentAsRead_callback:Function;
        public var _getAllVisitorComments_callback:Function;
        public var _deleteComment_callback:Function;
        public var _getHelpedPlayers_callback:Function;
        private var sender:Sender;
        public var _getVisitorComments_callback:Function;
        public var _visitorComment_callback:Function;


        public function visitorComment(_arg_1:String, _arg_2:Function=null):CommandResponse
        {
            this._visitorComment_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.visitorComment", {"comment":_arg_1});
            };
            return (null);
        }

        public function getHelpedPlayers(_arg_1:Function=null):GetHelpedPlayersResponse
        {
            this._getHelpedPlayers_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.getHelpedPlayers", {});
            };
            return (null);
        }

        public function deleteComment(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._deleteComment_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.deleteComment", {"id":_arg_1});
            };
            return (null);
        }

        public function getVisitorComments(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Function=null):GetAllVisitorCommentsResponse
        {
            this._getVisitorComments_callback = _arg_4;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.getVisitorComments", {
                    "visitorId":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3
                });
            };
            return (null);
        }

        public function getAllVisitorComments(_arg_1:int, _arg_2:int, _arg_3:Function=null):GetAllVisitorCommentsResponse
        {
            this._getAllVisitorComments_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.getAllVisitorComments", {
                    "pageNo":_arg_1,
                    "pageSize":_arg_2
                });
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }

        public function markCommentAsRead(_arg_1:int, _arg_2:Function=null):CommandResponse
        {
            this._markCommentAsRead_callback = _arg_2;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.markCommentAsRead", {"id":_arg_1});
            };
            return (null);
        }

        public function helpIncreaseProduction(_arg_1:String, _arg_2:String, _arg_3:Function=null):CommandResponse
        {
            this._helpIncreaseProduction_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("visit.helpIncreaseProduction", {
                    "fromServer":_arg_1,
                    "fromPlayer":_arg_2
                });
            };
            return (null);
        }


    }
}//package com.evony.client.action

