// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.common.MapCastleResponse

package com.evony.common.module.common
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.CommonUtil;

    public class MapCastleResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;
        public var castleArrayArray:ArrayCollection = new ArrayCollection();

        public function MapCastleResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:MapCastleBean;
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
            if (_arg_2.castleArray)
            {
                _local_5 = null;
                _local_6 = 0;
                while (_local_6 < _arg_2.castleArray.length)
                {
                    _local_5 = new MapCastleBean(_arg_2.castleArray[_local_6]);
                    this.castleArrayArray.addItem(_local_5);
                    _local_6++;
                };
            };
        }

        public function setCastleArray(_arg_1:MapCastleBean, _arg_2:int):void
        {
            this.castleArrayArray[_arg_2] = _arg_1;
        }

        public function getCastleArray(_arg_1:int):MapCastleBean
        {
            return (this.castleArrayArray[_arg_1] as MapCastleBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:String = (((("---- MapCastleResponse ----\n" + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            var _local_3:int;
            while (_local_3 < this.castleArrayArray.length)
            {
                _local_2 = (_local_2 + this.getCastleArray(_local_3).toDebugString((((_arg_1 + "castleArray[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:MapCastleResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.castleArrayArray, _arg_1.castleArrayArray);
        }

        public function toObject():Object
        {
            return ({
                "errorMsg":this.errorMsg,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId
            });
        }


    }
}//package com.evony.common.module.common

