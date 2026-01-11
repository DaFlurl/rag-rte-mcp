// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceInfoResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;

    public class AllianceInfoResponse extends BaseBean 
    {

        public var packageId:Number;
        public var msg:String;
        public var allinaceInfo:String;
        public var creator:String;
        public var leader:String;
        public var prestigeCount:int;
        public var memberCount:int;
        public var errorMsg:String;
        public var ok:int;
        public var ranking:int;

        public function AllianceInfoResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.allinaceInfo != null)
            {
                this.allinaceInfo = _arg_2.allinaceInfo;
            };
            if (_arg_2.creator != null)
            {
                this.creator = _arg_2.creator;
            };
            if (_arg_2.errorMsg != null)
            {
                this.errorMsg = _arg_2.errorMsg;
            };
            if (_arg_2.leader != null)
            {
                this.leader = _arg_2.leader;
            };
            if (_arg_2.memberCount != null)
            {
                this.memberCount = _arg_2.memberCount;
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
            if (_arg_2.prestigeCount != null)
            {
                this.prestigeCount = _arg_2.prestigeCount;
            };
            if (_arg_2.ranking != null)
            {
                this.ranking = _arg_2.ranking;
            };
        }

        public function toObject():Object
        {
            return ({
                "allinaceInfo":this.allinaceInfo,
                "creator":this.creator,
                "errorMsg":this.errorMsg,
                "leader":this.leader,
                "memberCount":this.memberCount,
                "msg":this.msg,
                "ok":this.ok,
                "packageId":this.packageId,
                "prestigeCount":this.prestigeCount,
                "ranking":this.ranking
            });
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((("---- AllianceInfoResponse ----\n" + (((_arg_1 + "allinaceInfo = ") + this.allinaceInfo) + "\n")) + (((_arg_1 + "creator = ") + this.creator) + "\n")) + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n")) + (((_arg_1 + "leader = ") + this.leader) + "\n")) + (((_arg_1 + "memberCount = ") + this.memberCount) + "\n")) + (((_arg_1 + "msg = ") + this.msg) + "\n")) + (((_arg_1 + "ok = ") + this.ok) + "\n")) + (((_arg_1 + "packageId = ") + this.packageId) + "\n")) + (((_arg_1 + "prestigeCount = ") + this.prestigeCount) + "\n")) + (((_arg_1 + "ranking = ") + this.ranking) + "\n"));
        }

        public function copyTo(_arg_1:AllianceInfoResponse):void
        {
            _arg_1.allinaceInfo = this.allinaceInfo;
            _arg_1.creator = this.creator;
            _arg_1.errorMsg = this.errorMsg;
            _arg_1.leader = this.leader;
            _arg_1.memberCount = this.memberCount;
            _arg_1.msg = this.msg;
            _arg_1.ok = this.ok;
            _arg_1.packageId = this.packageId;
            _arg_1.prestigeCount = this.prestigeCount;
            _arg_1.ranking = this.ranking;
        }


    }
}//package com.evony.common.module.alliance

