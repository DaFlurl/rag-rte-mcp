// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceListResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.AllianceQueryBean;
    import com.evony.common.CommonUtil;

    public class AllianceListResponse extends BaseBean 
    {

        public static const ALLIANCE_LIST_NOT_IN_ALLI:int = -1;

        public var packageId:Number;
        public var msg:String;
        public var pageNo:int;
        public var totalPage:int;
        public var errorMsg:String;
        public var ok:int;
        public var alliancesArray:ArrayCollection = new ArrayCollection();

        public function AllianceListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:AllianceQueryBean;
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
            if (_arg_2.totalPage != null)
            {
                this.totalPage = _arg_2.totalPage;
            };
            if (_arg_2.alliances)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.alliances.length)
                {
                    _local_5 = new AllianceQueryBean(_arg_2.alliances[_local_6]);
                    this.alliancesArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function setAlliances(_arg_1:AllianceQueryBean, _arg_2:int):void
        {
            this.alliancesArray[_arg_2] = _arg_1;
        }

        public function getAlliances(_arg_1:int):AllianceQueryBean
        {
            return (this.alliancesArray[_arg_1] as AllianceQueryBean);
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "pageNo":this.pageNo,
                "totalPage":this.totalPage
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((((("---- AllianceListResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + (((_arg_1 + "pageNo = ") + this.pageNo) + "\n")) + (((_arg_1 + "totalPage = ") + this.totalPage) + "\n"));
            var _local_3:int;
            while (_local_3 < this.alliancesArray.length)
            {
                _local_2 = (_local_2 + this.getAlliances(_local_3).toDebugString((((_arg_1 + "alliances[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:AllianceListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.pageNo = this.pageNo;
            _arg_1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.alliancesArray, _arg_1.alliancesArray);
        }


    }
}//package com.evony.common.module.alliance

