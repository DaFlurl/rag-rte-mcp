// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.CelebRankCompleteTipResponse

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class CelebRankCompleteTipResponse extends BaseBean 
    {

        public var name:String;
        public var rank:int;

        public function CelebRankCompleteTipResponse(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.name != null)
            {
                this.name = _arg_2.name;
            };
            if (_arg_2.rank != null)
            {
                this.rank = _arg_2.rank;
            };
        }

        public function copyTo(_arg_1:CelebRankCompleteTipResponse):void
        {
            _arg_1.name = this.name;
            _arg_1.rank = this.rank;
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- CelebRankCompleteTipResponse ----\n";
            _local_2 = (_local_2 + (((_arg_1 + "name = ") + this.name) + "\n"));
            return (_local_2 + (((_arg_1 + "rank = ") + this.rank) + "\n"));
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.name = this.name;
            _local_1.rank = this.rank;
            return (_local_1);
        }


    }
}//package com.evony.common.server.events

