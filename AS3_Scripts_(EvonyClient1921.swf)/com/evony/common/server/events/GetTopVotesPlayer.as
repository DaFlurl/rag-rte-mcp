// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.GetTopVotesPlayer

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;
    import com.evony.common.beans.*;

    public class GetTopVotesPlayer extends BaseBean 
    {

        public var getvotes:Number;

        public function GetTopVotesPlayer(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            var _local_5:int;
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.getvotes != null)
            {
                this.getvotes = _arg_2.getvotes;
            };
        }

        public function copyTo(_arg_1:GetTopVotesPlayer):void
        {
            _arg_1.getvotes = this.getvotes;
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.getvotes = this.getvotes;
            return (_local_1);
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "---- GetTopVotesPlayer ----\n";
            return (_local_2 + (((_arg_1 + "getvotes = ") + this.getvotes) + "\n"));
        }


    }
}//package com.evony.common.server.events

