// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.army.ArmyPracticeResponse

package com.evony.common.module.army
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.beans.*;
    import com.evony.common.*;

    public class ArmyPracticeResponse extends BaseBean 
    {

        public static const ARMY_PRACTICE_RESULT_GUARD_WIN:int = -1;
        public static const ARMY_PRACTICE_RESULT_ATTACK_WIN:int = 1;

        public var packageId:Number;
        public var attackLostTroop:TroopBean;
        public var msg:String;
        public var round:int;
        public var errorMsg:String;
        public var ok:int;
        public var result:int;
        public var defendLostTroop:TroopBean;

        public function ArmyPracticeResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.attackLostTroop != null)
            {
                this.attackLostTroop = new TroopBean(_arg_2.attackLostTroop);
            };
            if (_arg_2.defendLostTroop != null)
            {
                this.defendLostTroop = new TroopBean(_arg_2.defendLostTroop);
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
            if (_arg_2.result != null)
            {
                this.result = _arg_2.result;
            };
            if (_arg_2.round != null)
            {
                this.round = _arg_2.round;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = 0;
            var _local_3:* = "---- ArmyPracticeResponse ----\n";
            if (this.attackLostTroop != null)
            {
                _local_3 = (_local_3 + this.attackLostTroop.toDebugString((_arg_1 + "attackLostTroop.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "attackLostTroop = null\n"));
            };
            if (this.defendLostTroop != null)
            {
                _local_3 = (_local_3 + this.defendLostTroop.toDebugString((_arg_1 + "defendLostTroop.")));
            }
            else
            {
                _local_3 = (_local_3 + (_arg_1 + "defendLostTroop = null\n"));
            };
            _local_3 = (_local_3 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_3 = (_local_3 + (((_arg_1 + "result = ") + this.result) + "\n"));
            return (_local_3 + (((_arg_1 + "round = ") + this.round) + "\n"));
        }

        public function copyTo(_arg_1:ArmyPracticeResponse):void
        {
            if (this.attackLostTroop != null)
            {
                this.attackLostTroop.copyTo(_arg_1.attackLostTroop);
            }
            else
            {
                _arg_1.attackLostTroop = null;
            };
            if (this.defendLostTroop != null)
            {
                this.defendLostTroop.copyTo(_arg_1.defendLostTroop);
            }
            else
            {
                _arg_1.defendLostTroop = null;
            };
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.result = this.result;
            _arg_1.round = this.round;
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.attackLostTroop = this.attackLostTroop.toObject();
            _local_1.defendLostTroop = this.defendLostTroop.toObject();
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.result = this.result;
            _local_1.round = this.round;
            return (_local_1);
        }


    }
}//package com.evony.common.module.army

