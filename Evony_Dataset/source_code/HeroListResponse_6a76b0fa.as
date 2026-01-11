// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.hero.HeroListResponse

package com.evony.common.module.hero
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.CommonUtil;
    import mx.collections.*;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class HeroListResponse extends BaseBean 
    {

        public var herosArray:ArrayCollection;
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var posCount:int;
        public var ok:int;

        public function HeroListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:HeroBean;
            super(_arg_1, _arg_3, _arg_4);
            this.herosArray = new ArrayCollection();
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
            if (_arg_2.posCount != null)
            {
                this.posCount = _arg_2.posCount;
            };
            if (_arg_2.heros)
            {
                _local_5 = 0;
                _local_6 = null;
                while (_local_5 < _arg_2.heros.length)
                {
                    _local_6 = new HeroBean(_arg_2.heros[_local_5]);
                    this.herosArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        public function getHeros(_arg_1:int):HeroBean
        {
            return (this.herosArray[_arg_1] as HeroBean);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- HeroListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "posCount = ") + this.posCount) + "\n"));
            var _local_3:int;
            while (_local_3 < this.herosArray.length)
            {
                _local_2 = (_local_2 + this.getHeros(_local_3).toDebugString((((_arg_1 + "heros[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:HeroListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.posCount = this.posCount;
            CommonUtil.arrayCopy(this.herosArray, _arg_1.herosArray);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.posCount = this.posCount;
            return (_local_1);
        }

        public function setHeros(_arg_1:HeroBean, _arg_2:int):void
        {
            this.herosArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.hero

