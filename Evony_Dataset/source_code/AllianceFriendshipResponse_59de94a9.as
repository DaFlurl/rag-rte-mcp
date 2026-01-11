// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceFriendshipResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.UnitAlliance;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class AllianceFriendshipResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public var enemyListArray:ArrayCollection = new ArrayCollection();
        public var friendlyListArray:ArrayCollection = new ArrayCollection();
        public var middleListArray:ArrayCollection = new ArrayCollection();

        public function AllianceFriendshipResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:UnitAlliance;
            var _local_7:UnitAlliance;
            var _local_8:UnitAlliance;
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
            if (_arg_2.enemyList)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.enemyList.length)
                {
                    _local_6 = new UnitAlliance(_arg_2.enemyList[_local_5]);
                    this.enemyListArray.addItem(_local_6);
                    _local_5++;
                };
            };
            if (_arg_2.friendlyList)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.friendlyList.length)
                {
                    _local_7 = new UnitAlliance(_arg_2.friendlyList[_local_5]);
                    this.friendlyListArray.addItem(_local_7);
                    _local_5++;
                };
            };
            if (_arg_2.middleList)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.middleList.length)
                {
                    _local_8 = new UnitAlliance(_arg_2.middleList[_local_5]);
                    this.middleListArray.addItem(_local_8);
                    _local_5++;
                };
            };
        }

        public function setEnemyList(_arg_1:UnitAlliance, _arg_2:int):void
        {
            this.enemyListArray[_arg_2] = _arg_1;
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

        public function setFriendlyList(_arg_1:UnitAlliance, _arg_2:int):void
        {
            this.friendlyListArray[_arg_2] = _arg_1;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- AllianceFriendshipResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.enemyListArray.length)
            {
                _local_2 = (_local_2 + this.getEnemyList(_local_3).toDebugString((((_arg_1 + "enemyList[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.friendlyListArray.length)
            {
                _local_2 = (_local_2 + this.getFriendlyList(_local_3).toDebugString((((_arg_1 + "friendlyList[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.middleListArray.length)
            {
                _local_2 = (_local_2 + this.getMiddleList(_local_3).toDebugString((((_arg_1 + "middleList[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function setMiddleList(_arg_1:UnitAlliance, _arg_2:int):void
        {
            this.middleListArray[_arg_2] = _arg_1;
        }

        public function getMiddleList(_arg_1:int):UnitAlliance
        {
            return (this.middleListArray[_arg_1] as UnitAlliance);
        }

        public function getEnemyList(_arg_1:int):UnitAlliance
        {
            return (this.enemyListArray[_arg_1] as UnitAlliance);
        }

        public function copyTo(_arg_1:AllianceFriendshipResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.enemyListArray, _arg_1.enemyListArray);
            CommonUtil.arrayCopy(this.friendlyListArray, _arg_1.friendlyListArray);
            CommonUtil.arrayCopy(this.middleListArray, _arg_1.middleListArray);
        }

        public function getFriendlyList(_arg_1:int):UnitAlliance
        {
            return (this.friendlyListArray[_arg_1] as UnitAlliance);
        }


    }
}//package com.evony.common.module.alliance

