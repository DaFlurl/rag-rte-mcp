// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.army.TroopParamResponse

package com.evony.common.module.army
{
    import com.evony.common.BaseBean;

    public class TroopParamResponse extends BaseBean 
    {

        public var msg:String;
        public var driveSkillParam:int;
        public var packageId:Number;
        public var loadSkillParam:int;
        public var errorMsg:String;
        public var transportStationParam:int;
        public var ok:int;
        public var marchSkillParam:int;

        public function TroopParamResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.ok != null)
            {
                this.ok = _arg_2.ok;
            };
            if (_arg_2.packageId != null)
            {
                this.packageId = _arg_2.packageId;
            };
            if (_arg_2.msg != null)
            {
                this.msg = _arg_2.msg;
            };
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.driveSkillParam != null)
            {
                this.driveSkillParam = _arg_2.driveSkillParam;
            };
            if (_arg_2.loadSkillParam != null)
            {
                this.loadSkillParam = _arg_2.loadSkillParam;
            };
            if (_arg_2.transportStationParam != null)
            {
                this.transportStationParam = _arg_2.transportStationParam;
            };
            if (_arg_2.marchSkillParam != null)
            {
                this.marchSkillParam = _arg_2.marchSkillParam;
            };
        }

        public function toObject():Object
        {
            return ({
                "driveSkillParam":this.driveSkillParam,
                "errorMsg":this.errorMsg,
                "loadSkillParam":this.loadSkillParam,
                "marchSkillParam":this.marchSkillParam,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "transportStationParam":this.transportStationParam
            });
        }

        public function copyTo(_arg_1:TroopParamResponse):void
        {
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.msg = this.msg;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.driveSkillParam = this.driveSkillParam;
            _arg_1.loadSkillParam = this.loadSkillParam;
            _arg_1.transportStationParam = this.transportStationParam;
            _arg_1.marchSkillParam = this.marchSkillParam;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (((((((("---- TroopParamResponse ----\n" + (((_arg_1 + "driveSkillParam = ") + this.driveSkillParam) + "\n")) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "loadSkillParam = ") + this.loadSkillParam) + "\n")) + (((_arg_1 + "marchSkillParam = ") + this.marchSkillParam) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + (((_arg_1 + "transportStationParam = ") + this.transportStationParam) + "\n"));
        }


    }
}//package com.evony.common.module.army

