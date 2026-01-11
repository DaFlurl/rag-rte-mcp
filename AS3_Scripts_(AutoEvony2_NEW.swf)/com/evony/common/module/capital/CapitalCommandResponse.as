// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.capital.CapitalCommandResponse

package com.evony.common.module.capital
{
    import com.evony.common.BaseBean;
    import com.evony.common.*;

    public class CapitalCommandResponse extends BaseBean 
    {

        public var errorMsg:String;
        public var packageId:Number;
        public var targetFieldId:int;
        public var castleId:int;
        public var armyType:String;
        public var amount:int;
        public var msg:String;
        public var ok:int;

        public function CapitalCommandResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:* = 0;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.amount != null)
            {
                this.amount = _arg_2.amount;
            };
            if (_arg_2.armyType != null)
            {
                this.armyType = _arg_2.armyType;
            };
            if (_arg_2.castleId != null)
            {
                this.castleId = _arg_2.castleId;
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
            if (_arg_2.targetFieldId != null)
            {
                this.targetFieldId = _arg_2.targetFieldId;
            };
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_2:* = "---- CapitalCommandResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "amount = ") + this.amount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "armyType = ") + this.armyType) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "castleId = ") + this.castleId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            return (_local_2 + (((_arg_1 + "targetFieldId = ") + this.targetFieldId) + "\n"));
        }

        public function copyTo(_arg_1:CapitalCommandResponse):void
        {
            _arg_1.amount = this.amount;
            _arg_1.armyType = this.armyType;
            _arg_1.castleId = this.castleId;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.targetFieldId = this.targetFieldId;
        }

        public function toObject():Object
        {
            var _local_1:* = new Object();
            _local_1.amount = this.amount;
            _local_1.armyType = this.armyType;
            _local_1.castleId = this.castleId;
            _local_1.errorMsg = this.errorMsg;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.targetFieldId = this.targetFieldId;
            return (_local_1);
        }


    }
}//package com.evony.common.module.capital

