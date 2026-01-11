// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.army.TroopParamResponse

package com.evony.common.module.army
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class TroopParamResponse extends BaseBean 
    {

        public var msg:String;
        public var loadSkillParam:int;
        public var driveSkillParam:int;
        public var packageId:Number;
        public var errorMsg:String;
        public var transportStationParam:int;
        public var ok:int;
        public var marchSkillParam:int;

        public function TroopParamResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.driveSkillParam != null)
            {
                this.driveSkillParam = _arg_2.driveSkillParam;
            };
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.loadSkillParam != null)
            {
                this.loadSkillParam = _arg_2.loadSkillParam;
            };
            if (_arg_2.marchSkillParam != null)
            {
                this.marchSkillParam = _arg_2.marchSkillParam;
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
            if (_arg_2.transportStationParam != null)
            {
                this.transportStationParam = _arg_2.transportStationParam;
            };
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.driveSkillParam = this.driveSkillParam;
            _local_1.errorMsg = this.errorMsg;
            _local_1.loadSkillParam = this.loadSkillParam;
            _local_1.marchSkillParam = this.marchSkillParam;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.transportStationParam = this.transportStationParam;
            return (_local_1);
        }

        public function copyTo(_arg_1:TroopParamResponse):void
        {
            _arg_1.driveSkillParam = this.driveSkillParam;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.loadSkillParam = this.loadSkillParam;
            _arg_1.marchSkillParam = this.marchSkillParam;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.transportStationParam = this.transportStationParam;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- TroopParamResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "driveSkillParam = ") + this.driveSkillParam) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "loadSkillParam = ") + this.loadSkillParam) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "marchSkillParam = ") + this.marchSkillParam) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            return (_local_2 + (((_arg_1 + "transportStationParam = ") + this.transportStationParam) + "\n"));
        }


    }
}//package com.evony.common.module.army

