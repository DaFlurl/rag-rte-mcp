// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.furlough.FurloughResponse

package com.evony.common.module.furlough
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.beans.*;

    public class FurloughResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var playerBean:PlayerBean;
        public var errorMsg:String;
        public var ok:int;

        public function FurloughResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
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
            if (_arg_2.playerBean != null)
            {
                this.playerBean = new PlayerBean(_arg_2.playerBean);
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.playerBean = this.playerBean.toObject();
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- FurloughResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            if (playerBean != null)
            {
                _local_2 = (_local_2 + this.playerBean.toDebugString((_arg_1 + "playerBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "playerBean = null\n"));
            };
            return (_local_2);
        }

        public function copyTo(_arg_1:FurloughResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            if (playerBean != null)
            {
                this.playerBean.copyTo(_arg_1.playerBean);
            }
            else
            {
                _arg_1.playerBean = null;
            };
        }


    }
}//package com.evony.common.module.furlough

