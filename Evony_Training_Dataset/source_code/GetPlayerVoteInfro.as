// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.GetPlayerVoteInfro

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class GetPlayerVoteInfro extends BaseBean 
    {

        public var curdayvotes:Number;

        public function GetPlayerVoteInfro(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            if (_arg_2.curdayvotes != null)
            {
                this.curdayvotes = _arg_2.curdayvotes;
            };
        }

        public function copyTo(_arg_1:GetPlayerVoteInfro):void
        {
            _arg_1.curdayvotes = this.curdayvotes;
        }

        public function toObject():Object
        {
            return ({"curdayvotes":this.curdayvotes});
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- GetPlayerVoteInfro ----\n" + (((_arg_1 + "curdayvotes = ") + this.curdayvotes) + "\n"));
        }


    }
}//package com.evony.common.server.events

