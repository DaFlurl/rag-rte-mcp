// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.GetTopVotesPlayer

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class GetTopVotesPlayer extends BaseBean 
    {

        public var getvotes:Number;

        public function GetTopVotesPlayer(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
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
            return ({"getvotes":this.getvotes});
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- GetTopVotesPlayer ----\n" + (((_arg_1 + "getvotes = ") + this.getvotes) + "\n"));
        }


    }
}//package com.evony.common.server.events

