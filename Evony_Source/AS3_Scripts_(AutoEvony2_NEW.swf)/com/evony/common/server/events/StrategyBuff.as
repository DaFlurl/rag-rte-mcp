// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.server.events.StrategyBuff

package com.evony.common.server.events
{
    import com.evony.common.BaseBean;

    public class StrategyBuff extends BaseBean 
    {

        public function StrategyBuff(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
        }

        public function copyTo(_arg_1:StrategyBuff):void
        {
        }

        override public function toDebugString(_arg_1:String=""):String
        {
            return ("---- StrategyBuff ----\n");
        }

        public function toObject():Object
        {
            return ({});
        }


    }
}//package com.evony.common.server.events

