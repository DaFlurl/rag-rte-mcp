// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.visit.GetHelpedPlayersResponse

package com.evony.common.module.visit
{
    import com.evony.common.BaseBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.GetHelpedPlayerBean;
    import com.evony.common.CommonUtil;
    import com.evony.common.beans.*;

    public class GetHelpedPlayersResponse extends BaseBean 
    {

        public var packageId:Number;
        public var ok:int;
        public var playersArray:ArrayCollection = new ArrayCollection();
        public var msg:String;
        public var errorMsg:String;

        public function GetHelpedPlayersResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            var _local_6:GetHelpedPlayerBean;
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
            if (_arg_2.players)
            {
                _local_5 = 0;
                while (_local_5 < _arg_2.players.length)
                {
                    _local_6 = new GetHelpedPlayerBean(_arg_2.players[_local_5]);
                    this.playersArray.addItem(_local_6);
                    _local_5++;
                };
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- GetHelpedPlayersResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = 0;
            while (_local_3 < this.playersArray.length)
            {
                _local_2 = (_local_2 + this.getPlayers(_local_3).toDebugString((((_arg_1 + "players[") + _local_3) + "].")));
                _local_3++;
            };
            return (_local_2);
        }

        public function setPlayers(_arg_1:GetHelpedPlayerBean, _arg_2:int):void
        {
            this.playersArray[_arg_2] = _arg_1;
        }

        public function copyTo(_arg_1:GetHelpedPlayersResponse):void
        {
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.playersArray, _arg_1.playersArray);
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

        public function getPlayers(_arg_1:int):GetHelpedPlayerBean
        {
            return (this.playersArray[_arg_1] as GetHelpedPlayerBean);
        }


    }
}//package com.evony.common.module.visit

