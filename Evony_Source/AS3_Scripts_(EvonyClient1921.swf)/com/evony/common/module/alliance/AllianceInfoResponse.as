// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.module.alliance.AllianceInfoResponse

package com.evony.common.module.alliance
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class AllianceInfoResponse extends BaseBean 
    {

        public var errorMsg:String;
        public var msg:String;
        public var packageId:Number;
        public var leader:String;
        public var allinaceInfo:String;
        public var creator:String;
        public var memberCount:int;
        public var prestigeCount:int;
        public var ok:int;
        public var ranking:int;

        public function AllianceInfoResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
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

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- AllianceInfoResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "allinaceInfo = ") + this.allinaceInfo) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "creator = ") + this.creator) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "errorMsg = ") + this.errorMsg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "leader = ") + this.leader) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "memberCount = ") + this.memberCount) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "msg = ") + this.msg) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "ok = ") + this.ok) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "packageId = ") + this.packageId) + "\n"));
            _local_2 = (_local_2 + (((_arg_1 + "prestigeCount = ") + this.prestigeCount) + "\n"));
            return (_local_2 + (((_arg_1 + "ranking = ") + this.ranking) + "\n"));
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

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.allinaceInfo = this.allinaceInfo;
            _local_1.creator = this.creator;
            _local_1.errorMsg = this.errorMsg;
            _local_1.leader = this.leader;
            _local_1.memberCount = this.memberCount;
            _local_1.msg = this.msg;
            _local_1.ok = this.ok;
            _local_1.packageId = this.packageId;
            _local_1.prestigeCount = this.prestigeCount;
            _local_1.ranking = this.ranking;
            return (_local_1);
        }


    }
}//package com.evony.common.module.alliance

