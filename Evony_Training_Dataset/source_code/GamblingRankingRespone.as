// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.gamblingranking.GamblingRankingRespone

package com.evony.common.module.gamblingranking
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.GamblingRankingBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class GamblingRankingRespone extends BaseBean 
    {

        public var msg:String;
        public var gamblingRankingBeansArray:ArrayCollection = new ArrayCollection();
        public var packageId:Number;
        public var totalPage:int;
        public var pageNo:int;
        public var errorMsg:String;
        public var ok:int;

        public function GamblingRankingRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            var _local_6:* = null;
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
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.gamblingRankingBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.gamblingRankingBeans.length)
                {
                    _local_6 = new GamblingRankingBean(_arg_2.gamblingRankingBeans[_local_5]);
                    this.gamblingRankingBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- GamblingRankingRespone ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.gamblingRankingBeansArray.length)
            {
                _local_3 = (_local_3 + this.getGamblingRankingBeans(_local_2).toDebugString((((_arg_1 + "gamblingRankingBeans[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
        }

        public function getGamblingRankingBeans(_arg_1:int):GamblingRankingBean
        {
            return (this.gamblingRankingBeansArray[_arg_1] as GamblingRankingBean);
        }

        public function copyTo(_arg_1:GamblingRankingRespone):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.gamblingRankingBeansArray, _arg_1.gamblingRankingBeansArray);
        }

        public function setGamblingRankingBeans(_arg_1:GamblingRankingBean, _arg_2:int):void
        {
            this.gamblingRankingBeansArray[_arg_2] = _arg_1;
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.pageNo = this.pageNo;
            _local_1.totalPage = this.totalPage;
            return (_local_1);
        }


    }
}//package com.evony.common.module.gamblingranking

