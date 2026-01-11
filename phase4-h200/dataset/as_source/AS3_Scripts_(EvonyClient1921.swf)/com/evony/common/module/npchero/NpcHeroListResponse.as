// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.npchero.NpcHeroListResponse

package com.evony.common.module.npchero
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.NpcHeroBean;
    import com.evony.common.beans.SimpleNpcHeroBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class NpcHeroListResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public var npcHerosArray:ArrayCollection = new ArrayCollection();
        public var simpleNpcHerosArray:ArrayCollection = new ArrayCollection();

        public function NpcHeroListResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:NpcHeroBean;
            var _local_7:SimpleNpcHeroBean;
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
            if (_arg_2.npcHeros)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.npcHeros.length)
                {
                    _local_6 = new NpcHeroBean(_arg_2.npcHeros[_local_5]);
                    this.npcHerosArray.addItem(_local_6);
                    _local_5++;
                };
            };
            if (_arg_2.simpleNpcHeros)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.simpleNpcHeros.length)
                {
                    _local_7 = new SimpleNpcHeroBean(_arg_2.simpleNpcHeros[_local_5]);
                    this.simpleNpcHerosArray.addItem(_local_7);
                    _local_5++;
                };
            };
        }

        public function getSimpleNpcHeros(_arg_1:int):SimpleNpcHeroBean
        {
            return (this.simpleNpcHerosArray[_arg_1] as SimpleNpcHeroBean);
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

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- NpcHeroListResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.npcHerosArray.length)
            {
                _local_2 = (_local_2 + this.getNpcHeros(_local_3).toDebugString((((_arg_1 + "npcHeros[") + _local_3) + "].")));
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < this.simpleNpcHerosArray.length)
            {
                _local_2 = (_local_2 + this.getSimpleNpcHeros(_local_3).toDebugString((((_arg_1 + "simpleNpcHeros[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function setSimpleNpcHeros(_arg_1:SimpleNpcHeroBean, _arg_2:int):void
        {
            this.simpleNpcHerosArray[_arg_2] = _arg_1;
        }

        public function getNpcHeros(_arg_1:int):NpcHeroBean
        {
            return (this.npcHerosArray[_arg_1] as NpcHeroBean);
        }

        public function copyTo(_arg_1:NpcHeroListResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.npcHerosArray, _arg_1.npcHerosArray);
            CommonUtil.arrayCopy(this.simpleNpcHerosArray, _arg_1.simpleNpcHerosArray);
        }

        public function setNpcHeros(_arg_1:NpcHeroBean, _arg_2:int):void
        {
            this.npcHerosArray[_arg_2] = _arg_1;
        }


    }
}//package com.evony.common.module.npchero

