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
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getPlayerRank", {
                    "key":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3,
                    "sortType":_arg_4
                });
            };
            return (null);
        }

        public function getTopVotesPlayer(_arg_1:Function=null):TopVotesPlayersResponse
        {
            this._getTopVotesPlayer_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getTopVotesPlayer", new Object());
            };
            return (null);
        }

        public function getVoteRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankPlayerVotesResponse
        {
            this._getVoteRank_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getVoteRank", {
                    "key":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3,
                    "sortType":_arg_4
                });
            };
            return (null);
        }

        public function getAllianceRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankAllianceResponse
        {
            this._getAllianceRank_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getAllianceRank", {
                    "key":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3,
                    "sortType":_arg_4
                });
            };
            return (null);
        }

        public function getCastleRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankCastleResponse
        {
            this._getCastleRank_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getCastleRank", {
                    "key":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3,
                    "sortType":_arg_4
                });
            };
            return (null);
        }

        public function getHeroRank(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Function=null):RankHeroResponse
        {
            this._getHeroRank_callback = _arg_5;
            if (this.sender != null)
            {
                this.sender.sendMessage("rank.getHeroRank", {
                    "key":_arg_1,
                    "pageNo":_arg_2,
                    "pageSize":_arg_3,
                    "sortType":_arg_4
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

