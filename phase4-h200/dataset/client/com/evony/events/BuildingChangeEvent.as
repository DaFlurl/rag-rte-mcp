// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.events.BuildingChangeEvent

package com.evony.events
{
    import flash.events.Event;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.beans.BuildingQueueBean;

    public class BuildingChangeEvent extends Event 
    {

        private var bean:BuildingBean;
        private var queueBean:BuildingQueueBean;
        public var castleId:int;

        public function BuildingChangeEvent(_arg_1:String, _arg_2:BuildingBean, _arg_3:int=0, _arg_4:BuildingQueueBean=null, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this.bean = _arg_2;
            this.castleId = _arg_3;
            this.queueBean = _arg_4;
        }

        public function getQueueBean():BuildingQueueBean
        {
            return (this.queueBean);
        }

        public function getBean():BuildingBean
        {
            return (this.bean);
        }


    }
}//package com.evony.events

