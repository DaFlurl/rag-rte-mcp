// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.NoListenerEvent

package com.evony.common
{
    import flash.events.Event;

    public class NoListenerEvent extends Event 
    {

        public static const EVENT:String = "NoListenerEvent";

        internal var bean:BaseBean;
        internal var cmd:String;

        public function NoListenerEvent(_arg_1:String, _arg_2:BaseBean, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(EVENT, _arg_3, _arg_4);
            this.cmd = _arg_1;
            this.bean = _arg_2;
        }

        public function getResponseName():String
        {
            return (this.cmd);
        }

        public function getBean():BaseBean
        {
            return (this.bean);
        }


    }
}//package com.evony.common

