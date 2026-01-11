// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.PlayerBuffUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.BuffBean;
    import com.evony.common.beans.*;

    public class PlayerBuffUpdate extends BaseBean 
    {

        public var updateType:int;
        public var buffBean:BuffBean;

        public function PlayerBuffUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.buffBean != null)
            {
                this.buffBean = new BuffBean(_arg_2.buffBean);
            };
            if (_arg_2.updateType != null)
            {
                this.updateType = _arg_2.updateType;
            };
        }

        public function copyTo(_arg_1:PlayerBuffUpdate):void
        {
            if (buffBean != null)
            {
                this.buffBean.copyTo(_arg_1.buffBean);
            }
            else
            {
                _arg_1.buffBean = null;
            };
            _arg_1.updateType = this.updateType;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.buffBean = this.buffBean.toObject();
            _local_1.updateType = this.updateType;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- PlayerBuffUpdate ----\n";
            if (buffBean != null)
            {
                _local_2 = (_local_2 + this.buffBean.toDebugString((_arg_1 + "buffBean.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "buffBean = null\n"));
            };
            return (_local_2 + (((_arg_1 + "updateType = ") + this.updateType) + "\n"));
        }


    }
}//package com.evony.common.server.events

