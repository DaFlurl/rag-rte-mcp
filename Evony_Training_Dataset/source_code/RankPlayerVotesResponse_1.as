// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.rank.RankPlayerVotesResponse

package com.evony.common.module.rank
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class RankPlayerVotesResponse extends BaseBean 
    {

        public var packageId:Number;
        public var preweekterm:String;
        public var msg:String;
        public var beansArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;
        public var votestoal:Number;
        public var pageNo:int;
        public var pageSize:int;
        public var totalPage:int;
        public var voteendtime:Number;

        public function RankPlayerVotesResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:PlayerInfoBean;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
            if (_arg_2.pageNo != null)
            {
                this.pageNo = _arg_2.pageNo;
            };
            if (_arg_2.pageSize != null)
            {
                this.pageSize = _arg_2.pageSize;
            };
            if (_arg_2.preweekterm != null)
            {
                this.preweekterm = _arg_2.preweekterm;
            };
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.voteendtime != null)
            {
                this.voteendtime = _arg_2.voteendtime;
            };
            if (_arg_2.votestoal != null)
            {
                this.votestoal = _arg_2.votestoal;
            };
            if (_arg_2.beans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.beans.length)
                {
                    _local_6 = new PlayerInfoBean(_arg_2.beans[_local_5]);
                    this.beansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function getBeans(_arg_1:int):PlayerInfoBean
        {
            return (this.beansArray[_arg_1] as PlayerInfoBean);
        }

        public function setBeans(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.beansArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:RankPlayerVotesResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.pageSize = this.pageSize;
            _arg_1.preweekterm = this.preweekterm;
            _arg_1.totalPage = this.totalPage;
            _arg_1.voteendtime = this.voteendtime;
            _arg_1.votestoal = this.votestoal;
            CommonUtil.arrayCopy(this.beansArray, _arg_1.beansArray);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- RankPlayerVotesResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageSize = ") + this.pageSize) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "preweekterm = ") + this.preweekterm) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "voteendtime = ") + this.voteendtime) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "votestoal = ") + this.votestoal) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.beansArray.length)
            {
                _local_2 = (_local_2 + this.getBeans(_local_3).toDebugString((((_arg_1 + "beans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.pageNo = this.pageNo;
            _local_1.pageSize = this.pageSize;
            _local_1.preweekterm = this.preweekterm;
            _local_1.totalPage = this.totalPage;
            _local_1.voteendtime = this.voteendtime;
            _local_1.votestoal = this.votestoal;
            return (_local_1);
        }


    }
}//package com.evony.common.module.rank

