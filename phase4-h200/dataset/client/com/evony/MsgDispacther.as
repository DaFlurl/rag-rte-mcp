// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.MsgDispacther

package com.evony
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import mx.events.PropertyChangeEvent;

    public class MsgDispacther extends EventDispatcher 
    {

        private static var ins:MsgDispacther = new (MsgDispacther)();

        private var _1069971177useEnglish:Boolean = true;
        private var _340524749showBuildingLevel:Boolean = true;

        public function MsgDispacther(_arg_1:IEventDispatcher=null)
        {
            super(_arg_1);
        }

        public static function getInstance():MsgDispacther
        {
            return (ins);
        }


        public function set useEnglish(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1069971177useEnglish;
            if (_local_2 !== _arg_1)
            {
                this._1069971177useEnglish = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useEnglish", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get showBuildingLevel():Boolean
        {
            return (this._340524749showBuildingLevel);
        }

        public function set showBuildingLevel(_arg_1:Boolean):void
        {
            var _local_2:Object = this._340524749showBuildingLevel;
            if (_local_2 !== _arg_1)
            {
                this._340524749showBuildingLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showBuildingLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get useEnglish():Boolean
        {
            return (this._1069971177useEnglish);
        }


    }
}//package com.evony

