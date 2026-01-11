// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.colony.OverviewColonyCastleRespone

package com.evony.common.module.colony
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.*;

    public class OverviewColonyCastleRespone extends BaseBean 
    {

        public var msg:String;
        public var packageId:Number;
        public var castleBean:CastleBean;
        public var errorMsg:String;
        public var ok:int;

        public function OverviewColonyCastleRespone(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleBean != null)
            {
                this.castleBean = new CastleBean(_arg_2.castleBean);
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
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- OverviewColonyCastleRespone ----\n";
            if (castleBean != null)
            {
                _local_2 = (_local_2 + this.castleBean.toDebugString((_arg_1 + "castleBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "castleBean = null\n"));
            };
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            return (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
        }

        public function copyTo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (castleBean != null)
            {
                this.castleBean.copyTo(_arg_1.castleBean);
            }
            else
            {
                _arg_1.castleBean = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleBean = this.castleBean.toObject();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.colony

