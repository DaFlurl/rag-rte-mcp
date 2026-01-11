// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.mail.MailListResponse

package com.evony.common.module.mail
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.MailBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class MailListResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var pageNo:int;
        public var errorMsg:String;
        public var totalPage:int;
        public var ok:int;
        public var mailsArray:ArrayCollection = new ArrayCollection();

        public function MailListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:MailBean;
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
            if (_arg_2.mails)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.mails.length)
                {
                    _local_6 = new MailBean(_arg_2.mails[_local_5]);
                    this.mailsArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- MailListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.mailsArray.length)
            {
                _local_2 = (_local_2 + this.getMails(_local_3).toDebugString((((_arg_1 + "mails[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getMails(_arg_1:int):MailBean
        {
            return (this.mailsArray[_arg_1] as MailBean);
        }

        public function setMails(_arg_1:MailBean, _arg_2:int):void
        {
            this.mailsArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:MailListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.mailsArray, _arg_1.mailsArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.pageNo = this.pageNo;
            _local_1.totalPage = this.totalPage;
            return (_local_1);
        }


    }
}//package com.evony.common.module.mail

