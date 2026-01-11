// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.castle.CastleSignResponse

package com.evony.common.module.castle
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CastleSignInfoBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class CastleSignResponse extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var ok:int;
        public var errorMsg:String;
        public var castleSignInfoArrArray:ArrayCollection = new ArrayCollection();

        public function CastleSignResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
            if (_arg_2.castleSignInfoArr)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.castleSignInfoArr.length)
                {
                    _local_6 = new CastleSignInfoBean(_arg_2.castleSignInfoArr[_local_5]);
                    this.castleSignInfoArrArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function getCastleSignInfoArr(_arg_1:int):CastleSignInfoBean
        {
            return (this.castleSignInfoArrArray[_arg_1] as CastleSignInfoBean);
        }

        public function copyTo(_arg_1:CastleSignResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.castleSignInfoArrArray, _arg_1.castleSignInfoArrArray);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- CastleSignResponse ----\n";
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = 0;
            while (_local_2 < this.castleSignInfoArrArray.length)
            {
                _local_3 = (_local_3 + this.getCastleSignInfoArr(_local_2).toDebugString((((_arg_1 + "castleSignInfoArr[") + _local_2) + "].")));
                _local_2++;
            };
            return (_local_3);
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

        public function setCastleSignInfoArr(_arg_1:CastleSignInfoBean, _arg_2:int):void
        {
            this.castleSignInfoArrArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.castle

