// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.PlayerInfoUpdate

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.PlayerInfoBean;

    public class PlayerInfoUpdate extends BaseBean 
    {

        public var playerInfo:PlayerInfoBean;

        public function PlayerInfoUpdate(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.playerInfo != null)
            {
                this.playerInfo = new PlayerInfoBean(_arg_2.playerInfo);
            };
        }

        public function copyTo(_arg_1:PlayerInfoUpdate):void
        {
            if (this.playerInfo != null)
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
            return ("---- PlayerInfoUpdate ----\n" + ((this.playerInfo != null) ? this.playerInfo.toDebugString((_arg_1 + "playerInfo.")) : (_arg_1 + "playerInfo = null\n")));
        }

        public function toObject():Object
        {
            return ({"playerInfo":this.playerInfo.toObject()});
        }


    }
}//package com.evony.common.server.events

