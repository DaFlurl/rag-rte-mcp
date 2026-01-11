// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.rank.RankHeroResponse

package com.evony.common.module.rank
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.RankHeroBean;
    import com.evony.common.CommonUtil;

    public class RankHeroResponse extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var pageNo:int;
        public var totalPage:int;
        public var beansArray:ArrayCollection = new ArrayCollection();
        public var pageSize:int;
        public var errorMsg:String;
        public var ok:int;

        public function RankHeroResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:RankHeroBean;
            var _local_6:int;
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
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.beans)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.beans.length)
                {
                    _local_5 = new RankHeroBean(_arg_2.beans[_local_6]);
                    this.beansArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function setBeans(_arg_1:RankHeroBean, _arg_2:int):void
        {
            this.beansArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- RankHeroResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageSize = ") + this.pageSize) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            var _local_3:int;
            while (_local_3 < this.beansArray.length)
            {
                _local_2 = (_local_2 + this.getBeans(_local_3).toDebugString((((_arg_1 + "beansArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getBeans(_arg_1:int):RankHeroBean
        {
            return (this.beansArray[_arg_1] as RankHeroBean);
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
            _local_1.totalPage = this.totalPage;
            return (_local_1);
        }

        public function copyTo(_arg_1:RankHeroResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.pageSize = this.pageSize;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.beansArray, _arg_1.beansArray);
        }


    }
}//package com.evony.common.module.rank

