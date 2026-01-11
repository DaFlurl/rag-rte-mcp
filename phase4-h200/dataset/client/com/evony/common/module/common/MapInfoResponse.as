// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.common.MapInfoResponse

package com.evony.common.module.common
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class MapInfoResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var y1:int;
        public var y2:int;
        public var ok:int;
        public var castlesArray:ArrayCollection = new ArrayCollection();
        public var errorMsg:String;
        public var mapStr:String;
        public var x1:int;
        public var x2:int;

        public function MapInfoResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:MapCastleBean;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.mapStr != null)
            {
                this.mapStr = _arg_2.mapStr;
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
            if (_arg_2.x1 != null)
            {
                this.x1 = _arg_2.x1;
            };
            if (_arg_2.x2 != null)
            {
                this.x2 = _arg_2.x2;
            };
            if (_arg_2.y1 != null)
            {
                this.y1 = _arg_2.y1;
            };
            if (_arg_2.y2 != null)
            {
                this.y2 = _arg_2.y2;
            };
            if (_arg_2.castles)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.castles.length)
                {
                    _local_6 = new MapCastleBean(_arg_2.castles[_local_5]);
                    this.castlesArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function setCastles(_arg_1:MapCastleBean, _arg_2:int):void
        {
            this.castlesArray[_arg_2] = _arg_1;
        }

        public function getCastles(_arg_1:int):MapCastleBean
        {
            return (this.castlesArray[_arg_1] as MapCastleBean);
        }

        public function copyTo(_arg_1:MapInfoResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.mapStr = this.mapStr;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.x1 = this.x1;
            _arg_1.x2 = this.x2;
            _arg_1.y1 = this.y1;
            _arg_1.y2 = this.y2;
            CommonUtil.arrayCopy(this.castlesArray, _arg_1.castlesArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.mapStr = this.mapStr;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.x1 = this.x1;
            _local_1.x2 = this.x2;
            _local_1.y1 = this.y1;
            _local_1.y2 = this.y2;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- MapInfoResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "mapStr = ") + this.mapStr) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "x1 = ") + this.x1) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "x2 = ") + this.x2) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "y1 = ") + this.y1) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "y2 = ") + this.y2) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.castlesArray.length)
            {
                _local_2 = (_local_2 + this.getCastles(_local_3).toDebugString((((_arg_1 + "castles[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.evony.common.module.common

