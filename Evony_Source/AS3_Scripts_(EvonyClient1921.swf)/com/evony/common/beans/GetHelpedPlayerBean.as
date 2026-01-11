// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.GetHelpedPlayerBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.paramBeans.*;

    public class GetHelpedPlayerBean implements IEventDispatcher 
    {

        private var _2095387960playerFBID:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function GetHelpedPlayerBean(_arg_1:Object=null)
        {
            var _local_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.playerFBID != null)
                {
                    this.playerFBID = _arg_1.playerFBID;
                };
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function toDebugString(_arg_1:String=""):String
        {
            var _local_3:int;
            var _local_2:* = "";
            return (_local_2 + (((_arg_1 + "playerFBID = ") + this.playerFBID) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function copyTo(_arg_1:GetHelpedPlayerBean):void
        {
            _arg_1.playerFBID = this.playerFBID;
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set playerFBID(_arg_1:String):void
        {
            var _local_2:Object = this._2095387960playerFBID;
            if (_local_2 !== _arg_1)
            {
                this._2095387960playerFBID = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerFBID", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get playerFBID():String
        {
            return (this._2095387960playerFBID);
        }

        public function toObject():Object
        {
            var _local_1:Object = new Object();
            _local_1.playerFBID = this.playerFBID;
            return (_local_1);
        }


    }
}//package com.evony.common.beans

