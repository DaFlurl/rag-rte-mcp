// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.tech.AvailableResearchListResponse

package com.evony.common.module.tech
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.CommonUtil;

    public class AvailableResearchListResponse extends BaseBean 
    {

        public var msg:String;
        public var academyCount:int;
        public var packageId:Number;
        public var acailableResearchBeansArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function AvailableResearchListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:AvailableResearchListBean;
            var _local_6:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.academyCount != null)
            {
                this.academyCount = _arg_2.academyCount;
            };
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
            if (_arg_2.acailableResearchBeans)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.acailableResearchBeans.length)
                {
                    _local_5 = new AvailableResearchListBean(_arg_2.acailableResearchBeans[_local_6]);
                    this.acailableResearchBeansArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function toObject():Object
        {
            return ({
                "academyCount":this.academyCount,
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }

        public function setAcailableResearchBeans(_arg_1:AvailableResearchListBean, _arg_2:int):void
        {
            this.acailableResearchBeansArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = ((((("---- AvailableResearchListResponse ----\n" + (((_arg_1 + "academyCount = ") + this.academyCount) + "\n")) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.acailableResearchBeansArray.length)
            {
                _local_2 = (_local_2 + this.getAcailableResearchBeans(_local_3).toDebugString((((_arg_1 + "acailableResearchBeans[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function getAcailableResearchBeans(_arg_1:int):AvailableResearchListBean
        {
            return (this.acailableResearchBeansArray[_arg_1] as AvailableResearchListBean);
        }

        public function copyTo(_arg_1:AvailableResearchListResponse):void
        {
            _arg_1.academyCount = this.academyCount;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.acailableResearchBeansArray, _arg_1.acailableResearchBeansArray);
        }


    }
}//package com.evony.common.module.tech

