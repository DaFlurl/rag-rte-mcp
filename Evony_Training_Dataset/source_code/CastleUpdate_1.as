// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CastleUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.*;

    public class CastleUpdate extends BaseBean 
    {

        public var updateType:int;
        public var castleBean:CastleBean;

        public function CastleUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.castleBean != null)
            {
                this.castleBean = new CastleBean(_arg_2.castleBean);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:CastleUpdate):void
        {
            if (castleBean != null)
            {
                this.castleBean.copyTo(_arg_1.castleBean);
            }
            else
            {
                _arg_1.castleBean = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.castleBean = this.castleBean.toObject();
            _local_1.updateType = this.updateType;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- CastleUpdate ----\n";
            if (castleBean != null)
            {
                _local_2 = (_local_2 + this.castleBean.toDebugString((_arg_1 + "castleBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "castleBean = null\n"));
            };
            return (_local_2 + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

