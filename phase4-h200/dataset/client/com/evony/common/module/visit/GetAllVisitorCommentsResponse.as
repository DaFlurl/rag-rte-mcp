// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.visit.GetAllVisitorCommentsResponse

package com.evony.common.module.visit
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.VisitorCommentBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class GetAllVisitorCommentsResponse extends BaseBean 
    {

        public var packageId:Number;
        public var total:int;
        public var msg:String;
        public var pageNo:int;
        public var commentBeansArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var totalPage:int;
        public var ok:int;

        public function GetAllVisitorCommentsResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:VisitorCommentBean;
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
            if (_arg_2.total != null)
            {
                this.total = _arg_2.total;
            };
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.commentBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.commentBeans.length)
                {
                    _local_6 = new VisitorCommentBean(_arg_2.commentBeans[_local_5]);
                    this.commentBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function getCommentBeans(_arg_1:int):VisitorCommentBean
        {
            return (this.commentBeansArray[_arg_1] as VisitorCommentBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- GetAllVisitorCommentsResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "total = ") + this.total) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.commentBeansArray.length)
            {
                _local_2 = (_local_2 + this.getCommentBeans(_local_3).toDebugString((((_arg_1 + "commentBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function setCommentBeans(_arg_1:VisitorCommentBean, _arg_2:int):void
        {
            this.commentBeansArray[_arg_2] = _arg_1;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.pageNo = this.pageNo;
            _local_1.total = this.total;
            _local_1.totalPage = this.totalPage;
            return (_local_1);
        }

        public function copyTo(_arg_1:GetAllVisitorCommentsResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.total = this.total;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.commentBeansArray, _arg_1.commentBeansArray);
        }


    }
}//package com.evony.common.module.visit

