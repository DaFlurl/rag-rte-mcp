// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.WindowChangeEvent

package com.evony.events
{
    import flash.events.Event;
    import view.AllWindows;

    public class WindowChangeEvent extends Event 
    {

        public static const ID_CLOSE:String = "Window.close";

        private var eventData:Object;
        private var id:String;

        public function WindowChangeEvent(_arg_1:String, _arg_2:Object=null, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(AllWindows.EVENT_CHANGE, _arg_3, _arg_4);
            this.id = _arg_1;
            this.eventData = _arg_2;
        }

        public function getId():String
        {
            return (this.id);
        }

        public function getEventData():Object
        {
            return (this.eventData);
        }


    }
}//package com.evony.events

