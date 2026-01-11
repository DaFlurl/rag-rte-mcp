// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.CurCastleChangeEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;

    public class CurCastleChangeEvent extends Event 
    {

        private var castle:CastleBean;

        public function CurCastleChangeEvent(_arg_1:CastleBean, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(Context.EVENT_CASTLE_CHANGE, _arg_2, _arg_3);
            this.castle = _arg_1;
        }

        public function getCastle():CastleBean
        {
            return (this.castle);
        }


    }
}//package com.evony.events

