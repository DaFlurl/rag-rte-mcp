// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.AvailableResearchListBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class AvailableResearchListBean implements IEventDispatcher 
    {

        private var _1607243192endTime:Number;
        private var _1999144890upgradeing:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1371991915conditionBean:ConditionBean;
        private var _499553710enhancedstarlv:int;
        private var _102865796level:int;
        private var _3198785help:int;
        private var _2129294769startTime:Number;
        private var _35872819castleId:Number;
        private var _858803723typeId:int;
        private var _1780023352avalevel:int;
        private var _676059661permition:Boolean;

        public function AvailableResearchListBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.avalevel != null)
                {
                    this.avalevel = _arg_1.avalevel;
                };
                if (_arg_1.castleId != null)
                {
                    this.castleId = _arg_1.castleId;
                };
                if (_arg_1.conditionBean != null)
                {
                    this.conditionBean = new ConditionBean(_arg_1.conditionBean);
                };
                if (_arg_1.endTime != null)
                {
                    this.endTime = _arg_1.endTime;
                };
                if (_arg_1.enhancedstarlv != null)
                {
                    this.enhancedstarlv = _arg_1.enhancedstarlv;
                };
                if (_arg_1.help != null)
                {
                    this.help = _arg_1.help;
                };
                if (_arg_1.level != null)
                {
                    this.level = _arg_1.level;
                };
                if (_arg_1.startTime != null)
                {
                    this.startTime = _arg_1.startTime;
                };
                if (_arg_1.typeId != null)
                {
                    this.typeId = _arg_1.typeId;
                };
                if (_arg_1.permition != null)
                {
                    this.permition = _arg_1.permition;
                };
                if (_arg_1.upgradeing != null)
                {
                    this.upgradeing = _arg_1.upgradeing;
                };
            };
        }

        public function set help(_arg_1:int):void
        {
            var _local_2:Object = this._3198785help;
            if (_local_2 !== _arg_1)
            {
                this._3198785help = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "help", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get level():int
        {
            return (this._102865796level);
        }

        public function set upgradeing(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1999144890upgradeing;
            if (_local_2 !== _arg_1)
            {
                this._1999144890upgradeing = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "upgradeing", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get permition():Boolean
        {
            return (this._676059661permition);
        }

        public function set endTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1607243192endTime;
            if (_local_2 !== _arg_1)
            {
                this._1607243192endTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _local_2, _arg_1));
            };
        }

        public function set level(_arg_1:int):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        public function toObject():Object
        {
            return ({
                "avalevel":this.avalevel,
                "castleId":this.castleId,
                "conditionBean":this.conditionBean.toObject(),
                "endTime":this.endTime,
                "enhancedstarlv":this.enhancedstarlv,
                "help":this.help,
                "level":this.level,
                "startTime":this.startTime,
                "typeId":this.typeId,
                "permition":this.permition,
                "upgradeing":this.upgradeing
            });
        }

        public function set startTime(_arg_1:Number):void
        {
            var _local_2:Object = this._2129294769startTime;
            if (_local_2 !== _arg_1)
            {
                this._2129294769startTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _local_2, _arg_1));
            };
        }

        public function set permition(_arg_1:Boolean):void
        {
            var _local_2:Object = this._676059661permition;
            if (_local_2 !== _arg_1)
            {
                this._676059661permition = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "permition", _local_2, _arg_1));
            };
        }

        public function set enhancedstarlv(_arg_1:int):void
        {
            var _local_2:Object = this._499553710enhancedstarlv;
            if (_local_2 !== _arg_1)
            {
                this._499553710enhancedstarlv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enhancedstarlv", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get avalevel():int
        {
            return (this._1780023352avalevel);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get help():int
        {
            return (this._3198785help);
        }

        [Bindable(event="propertyChange")]
        public function get upgradeing():Boolean
        {
            return (this._1999144890upgradeing);
        }

        [Bindable(event="propertyChange")]
        public function get endTime():Number
        {
            return (this._1607243192endTime);
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((((_arg_1 + "avalevel = ") + this.avalevel) + "\n") + (((_arg_1 + "castleId = ") + this.castleId) + "\n")) + ((this.conditionBean != null) ? this.conditionBean.toDebugString((_arg_1 + "conditionBean.")) : (_arg_1 + "conditionBean = null\n"))) + (((_arg_1 + "endTime = ") + this.endTime) + "\n")) + (((_arg_1 + "enhancedstarlv = ") + this.enhancedstarlv) + "\n")) + (((_arg_1 + "help = ") + this.help) + "\n")) + (((_arg_1 + "level = ") + this.level) + "\n")) + (((_arg_1 + "startTime = ") + this.startTime) + "\n")) + (((_arg_1 + "typeId = ") + this.typeId) + "\n")) + (((_arg_1 + "permition = ") + this.permition) + "\n")) + (((_arg_1 + "upgradeing = ") + this.upgradeing) + "\n"));
        }

        [Bindable(event="propertyChange")]
        public function get castleId():Number
        {
            return (this._35872819castleId);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        [Bindable(event="propertyChange")]
        public function get startTime():Number
        {
            return (this._2129294769startTime);
        }

        public function copyTo(_arg_1:AvailableResearchListBean):void
        {
            _arg_1.avalevel = this.avalevel;
            _arg_1.castleId = this.castleId;
            if (this.conditionBean != null)
            {
                this.conditionBean.copyTo(_arg_1.conditionBean);
            }
            else
            {
                _arg_1.conditionBean = null;
            };
            _arg_1.endTime = this.endTime;
            _arg_1.enhancedstarlv = this.enhancedstarlv;
            _arg_1.help = this.help;
            _arg_1.level = this.level;
            _arg_1.startTime = this.startTime;
            _arg_1.typeId = this.typeId;
            _arg_1.permition = this.permition;
            _arg_1.upgradeing = this.upgradeing;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get enhancedstarlv():int
        {
            return (this._499553710enhancedstarlv);
        }

        public function set conditionBean(_arg_1:ConditionBean):void
        {
            var _local_2:Object = this._1371991915conditionBean;
            if (_local_2 !== _arg_1)
            {
                this._1371991915conditionBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "conditionBean", _local_2, _arg_1));
            };
        }

        public function set typeId(_arg_1:int):void
        {
            var _local_2:Object = this._858803723typeId;
            if (_local_2 !== _arg_1)
            {
                this._858803723typeId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get conditionBean():ConditionBean
        {
            return (this._1371991915conditionBean);
        }

        public function set castleId(_arg_1:Number):void
        {
            var _local_2:Object = this._35872819castleId;
            if (_local_2 !== _arg_1)
            {
                this._35872819castleId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleId", _local_2, _arg_1));
            };
        }

        public function set avalevel(_arg_1:int):void
        {
            var _local_2:Object = this._1780023352avalevel;
            if (_local_2 !== _arg_1)
            {
                this._1780023352avalevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "avalevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get typeId():int
        {
            return (this._858803723typeId);
        }


    }
}//package com.evony.common.beans

