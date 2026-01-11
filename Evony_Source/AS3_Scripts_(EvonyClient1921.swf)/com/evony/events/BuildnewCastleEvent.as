// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.BuildnewCastleEvent

package com.evony.events
{
    import flash.events.Event;

    public class BuildnewCastleEvent extends Event 
    {

        public static const EVENT_BUILD_CASTLE:String = "new.castle.build";

        private var _obj:Object;

        public function BuildnewCastleEvent(_arg_1:Object, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(EVENT_BUILD_CASTLE, _arg_2, _arg_3);
            this._obj = _arg_1;
        }

        public function getObj():Object
        {
            return (this._obj);
        }


    }
}//package com.evony.events

