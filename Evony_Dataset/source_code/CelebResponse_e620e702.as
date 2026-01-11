// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.celeb.CelebResponse

package com.evony.common.module.celeb
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.RankAllianceBean;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class CelebResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var allianceBeanArray:ArrayCollection = new ArrayCollection();
        public var playerBeanArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var ok:int;

        public function CelebResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:RankAllianceBean;
            var _local_7:PlayerInfoBean;
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
            if (_arg_2.allianceBean)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.allianceBean.length)
                {
                    _local_6 = new RankAllianceBean(_arg_2.allianceBean[_local_5]);
                    this.allianceBeanArray.addItem(_local_6);
                    _local_5++;
                };
            };
            if (_arg_2.playerBean)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.playerBean.length)
                {
                    _local_7 = new PlayerInfoBean(_arg_2.playerBean[_local_5]);
                    this.playerBeanArray.addItem(_local_7);
                    _local_5++;
                };
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }

        public function getPlayerBean(_arg_1:int):PlayerInfoBean
        {
            return (this.playerBeanArray[_arg_1] as PlayerInfoBean);
        }

        public function setAllianceBean(_arg_1:RankAllianceBean, _arg_2:int):void
        {
            this.allianceBeanArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- CelebResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.allianceBeanArray.length)
            {
                _local_2 = (_local_2 + this.getAllianceBean(_local_3).toDebugString((((_arg_1 + "allianceBean[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.playerBeanArray.length)
            {
                _local_2 = (_local_2 + this.getPlayerBean(_local_3).toDebugString((((_arg_1 + "playerBean[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:CelebResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allianceBeanArray, _arg_1.allianceBeanArray);
            CommonUtil.arrayCopy(this.playerBeanArray, _arg_1.playerBeanArray);
        }

        public function setPlayerBean(_arg_1:PlayerInfoBean, _arg_2:int):void
        {
            this.playerBeanArray[_arg_2] = _arg_1;
        }

        public function getAllianceBean(_arg_1:int):RankAllianceBean
        {
            return (this.allianceBeanArray[_arg_1] as RankAllianceBean);
        }


    }
}//package com.evony.common.module.celeb

