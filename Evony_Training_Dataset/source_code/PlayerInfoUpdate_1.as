// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.PlayerInfoUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.beans.*;

    public class PlayerInfoUpdate extends BaseBean 
    {

        public var playerInfo:PlayerInfoBean;

        public function PlayerInfoUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.playerInfo != null)
            {
                this.playerInfo = new PlayerInfoBean(_arg_2.playerInfo);
            };
        }

        public function copyTo(_arg_1:PlayerInfoUpdate):void
        {
            if (playerInfo != null)
            {
                this.playerInfo.copyTo(_arg_1.playerInfo);
            }
            else
            {
                _arg_1.playerInfo = null;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- PlayerInfoUpdate ----\n";
            if (playerInfo != null)
            {
                _local_2 = (_local_2 + this.playerInfo.toDebugString((_arg_1 + "playerInfo.")));
            }
            else
            {
                _local_2 = (_local_2 + (_arg_1 + "playerInfo = null\n"));
            };
            return (_local_2);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.playerInfo = this.playerInfo.toObject();
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

