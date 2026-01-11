// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.client.action.GamblingRankingCommands

package com.evony.client.action
{
    import com.evony.common.Sender;
    import com.evony.common.module.gamblingranking.GamblingRankingRespone;
    import com.evony.common.module.gamblingranking.GamblingRankingRewardRespone;
    import com.evony.common.beans.*;
    import com.evony.common.paramBeans.*;

    public class GamblingRankingCommands 
    {

        private var sender:Sender;
        public var _getGamblingRankingReward_callback:Function;
        public var _getGamblingRankingYesterday_callback:Function;
        public var _getGamblingRankingToday_callback:Function;


        public function getGamblingRankingToday(_arg_1:int, _arg_2:int, _arg_3:Function=null):GamblingRankingRespone
        {
            this._getGamblingRankingToday_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.pageNo = _arg_1;
            _local_4.pageSize = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamblingranking.getGamblingRankingToday", _local_4);
            };
            return (null);
        }

        public function getGamblingRankingYesterday(_arg_1:int, _arg_2:int, _arg_3:Function=null):GamblingRankingRespone
        {
            this._getGamblingRankingYesterday_callback = _arg_3;
            var _local_4:Object = new Object();
            _local_4.pageNo = _arg_1;
            _local_4.pageSize = _arg_2;
            if (this.sender != null)
            {
                sender.sendMessage("gamblingranking.getGamblingRankingYesterday", _local_4);
            };
            return (null);
        }

        public function getGamblingRankingReward(_arg_1:Function=null):GamblingRankingRewardRespone
        {
            this._getGamblingRankingReward_callback = _arg_1;
            var _local_2:Object = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("gamblingranking.getGamblingRankingReward", _local_2);
            };
            return (null);
        }

        public function setSender(_arg_1:Sender):void
        {
            this.sender = _arg_1;
        }


    }
}//package com.evony.client.action

