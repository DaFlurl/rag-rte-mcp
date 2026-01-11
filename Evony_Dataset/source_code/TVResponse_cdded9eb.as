// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.mail.TVResponse

package com.evony.common.module.mail
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.TVmsgBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class TVResponse extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var tvBeansArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function TVResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
            if (_arg_2.tvBeans)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.tvBeans.length)
                {
                    _local_6 = new TVmsgBean(_arg_2.tvBeans[_local_5]);
                    this.tvBeansArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- TVResponse ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.tvBeansArray.length)
            {
                _local_3 = (_local_3 + this.getTvBeans(_local_2).toDebugString((((_arg_1 + "tvBeans[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
        }

        public function copyTo(_arg_1:TVResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.tvBeansArray, _arg_1.tvBeansArray);
        }

        public function getTvBeans(_arg_1:int):TVmsgBean
        {
            return (this.tvBeansArray[_arg_1] as TVmsgBean);
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }

        public function setTvBeans(_arg_1:TVmsgBean, _arg_2:int):void
        {
            this.tvBeansArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.mail

