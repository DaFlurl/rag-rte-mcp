// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.GamblingRankingCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.gamblingranking.GamblingRankingRespone;
    import com.evony.common.module.gamblingranking.GamblingRankingRewardRespone;

    public class GamblingRankingCommands 
    {

        private var sender:Sender;
        public var _getGamblingRankingReward_callback:Function;
        public var _getGamblingRankingYesterday_callback:Function;
        public var _getGamblingRankingToday_callback:Function;


        public function getGamblingRankingToday(_arg_1:int, _arg_2:int, _arg_3:Function=null):GamblingRankingRespone
        {
            this._getGamblingRankingToday_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamblingranking.getGamblingRankingToday", {
                    "pageNo":_arg_1,
                    "pageSize":_arg_2
                });
            };
            return (null);
        }

        public function getGamblingRankingYesterday(_arg_1:int, _arg_2:int, _arg_3:Function=null):GamblingRankingRespone
        {
            this._getGamblingRankingYesterday_callback = _arg_3;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamblingranking.getGamblingRankingYesterday", {
                    "pageNo":_arg_1,
                    "pageSize":_arg_2
                });
            };
            return (null);
        }

        public function getGamblingRankingReward(_arg_1:Function=null):GamblingRankingRewardRespone
        {
            this._getGamblingRankingReward_callback = _arg_1;
            if (this.sender != null)
            {
                this.sender.sendMessage("gamblingranking.getGamblingRankingReward", {});
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

