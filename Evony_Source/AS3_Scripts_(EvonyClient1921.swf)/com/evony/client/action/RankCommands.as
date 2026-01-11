// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.RankCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.rank.RankPlayerResponse;
    import com.evony.common.module.rank.TopVotesPlayersResponse;
    import com.evony.common.module.rank.RankPlayerVotesResponse;
    import com.evony.common.module.rank.RankAllianceResponse;
    import com.evony.common.module.rank.RankCastleResponse;
    import com.evony.common.module.rank.RankHeroResponse;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class RankCommands 
    {

        public var _getPlayerRank_callback:Function;
        public var _getHeroRank_callback:Function;
        public var _getCastleRank_callback:Function;
        public var _getAllianceRank_callback:Function;
        private var sender:Sender;
        public var _getVoteRank_callback:Function;
        public var _getTopVotesPlayer_callback:Function;


        public function getPlayerRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankPlayerResponse
        {
            this._getPlayerRank_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.key = _arg_1;
            _local_6.pageNo = _arg_2;
            _local_6.pageSize = _arg_3;
            _local_6.sortType = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getPlayerRank", _local_6);
            };
            return (null);
        }

        public function getTopVotesPlayer(_arg_1:Function=null):TopVotesPlayersResponse
        {
            this._getTopVotesPlayer_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("rank.getTopVotesPlayer", _local_2);
            };
            return (null);
        }

        public function getVoteRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankPlayerVotesResponse
        {
            this._getVoteRank_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.key = _arg_1;
            _local_6.pageNo = _arg_2;
            _local_6.pageSize = _arg_3;
            _local_6.sortType = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getVoteRank", _local_6);
            };
            return (null);
        }

        public function getAllianceRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankAllianceResponse
        {
            this._getAllianceRank_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.key = _arg_1;
            _local_6.pageNo = _arg_2;
            _local_6.pageSize = _arg_3;
            _local_6.sortType = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getAllianceRank", _local_6);
            };
            return (null);
        }

        public function getCastleRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankCastleResponse
        {
            this._getCastleRank_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.key = _arg_1;
            _local_6.pageNo = _arg_2;
            _local_6.pageSize = _arg_3;
            _local_6.sortType = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getCastleRank", _local_6);
            };
            return (null);
        }

        public function getHeroRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankHeroResponse
        {
            this._getHeroRank_callback = _arg_5;
            var _local_6:Object = new Object();
            _local_6.key = _arg_1;
            _local_6.pageNo = _arg_2;
            _local_6.pageSize = _arg_3;
            _local_6.sortType = _arg_4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getHeroRank", _local_6);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

