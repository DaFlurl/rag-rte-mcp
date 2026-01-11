// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.paramBeans.NewArmyParam

package com.evony.common.paramBeans
{
    import flash.events.IEventDispatcher;
    import com.evony.common.beans.ResourceBean;
    import flash.events.EventDispatcher;
    import com.evony.common.beans.TroopBean;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class NewArmyParam implements IEventDispatcher 
    {

        private var _1383259878missionType:int;
        private var _1220754763heroId:int;
        private var _341064690resource:ResourceBean;
        private var _1570047522backAfterConstruct:Boolean;
        private var _148334278useItem:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _865287327troops:TroopBean;
        private var _148431469useFlag:Boolean;
        private var _337438527restTime:int;
        private var _2098575745targetPoint:int;

        public function NewArmyParam(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.heroId != null)
                {
                    this.heroId = _arg_1.heroId;
                };
                if (_arg_1.missionType != null)
                {
                    this.missionType = _arg_1.missionType;
                };
                if (_arg_1.resource != null)
                {
                    this.resource = new ResourceBean(_arg_1.resource);
                };
                if (_arg_1.restTime != null)
                {
                    this.restTime = _arg_1.restTime;
                };
                if (_arg_1.targetPoint != null)
                {
                    this.targetPoint = _arg_1.targetPoint;
                };
                if (_arg_1.troops != null)
                {
                    this.troops = new TroopBean(_arg_1.troops);
                };
                if (_arg_1.backAfterConstruct != null)
                {
                    this.backAfterConstruct = _arg_1.backAfterConstruct;
                };
                if (_arg_1.useFlag != null)
                {
                    this.useFlag = _arg_1.useFlag;
                };
                if (_arg_1.useItem != null)
                {
                    this.useItem = _arg_1.useItem;
                };
            };
        }

        public function set restTime(_arg_1:int):void
        {
            var _local_2:Object = this._337438527restTime;
            if (_local_2 !== _arg_1)
            {
                this._337438527restTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "restTime", _local_2, _arg_1));
            };
        }

        public function set useItem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._148334278useItem;
            if (_local_2 !== _arg_1)
            {
                this._148334278useItem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useItem", _local_2, _arg_1));
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get useFlag():Boolean
        {
            return (this._148431469useFlag);
        }

        [Bindable(event="propertyChange")]
        public function get resource():ResourceBean
        {
            return (this._341064690resource);
        }

        public function toObject():Object
        {
            return ({
                "heroId":this.heroId,
                "missionType":this.missionType,
                "resource":this.resource.toObject(),
                "restTime":this.restTime,
                "targetPoint":this.targetPoint,
                "troops":this.troops.toObject(),
                "backAfterConstruct":this.backAfterConstruct,
                "useFlag":this.useFlag,
                "useItem":this.useItem
            });
        }

        public function set resource(_arg_1:ResourceBean):void
        {
            var _local_2:Object = this._341064690resource;
            if (_local_2 !== _arg_1)
            {
                this._341064690resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _local_2, _arg_1));
            };
        }

        public function set useFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._148431469useFlag;
            if (_local_2 !== _arg_1)
            {
                this._148431469useFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get backAfterConstruct():Boolean
        {
            return (this._1570047522backAfterConstruct);
        }

        [Bindable(event="propertyChange")]
        public function get heroId():int
        {
            return (this._1220754763heroId);
        }

        [Bindable(event="propertyChange")]
        public function get useItem():Boolean
        {
            return (this._148334278useItem);
        }

        [Bindable(event="propertyChange")]
        public function get restTime():int
        {
            return (this._337438527restTime);
        }

        public function set troops(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._865287327troops;
            if (_local_2 !== _arg_1)
            {
                this._865287327troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troops", _local_2, _arg_1));
            };
        }

        public function set backAfterConstruct(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1570047522backAfterConstruct;
            if (_local_2 !== _arg_1)
            {
                this._1570047522backAfterConstruct = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backAfterConstruct", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return (((((((((((_arg_1 + "heroId = ") + this.heroId) + "\n") + (((_arg_1 + "missionType = ") + this.missionType) + "\n")) + ((this.resource == null) ? (_arg_1 + "resource = null\n") : this.resource.toDebugString((_arg_1 + "resource.")))) + (((_arg_1 + "restTime = ") + this.restTime) + "\n")) + (((_arg_1 + "targetPoint = ") + this.targetPoint) + "\n")) + ((this.troops == null) ? (_arg_1 + "troops = null\n") : this.troops.toDebugString((_arg_1 + "troops.")))) + (((_arg_1 + "backAfterConstruct = ") + this.backAfterConstruct) + "\n")) + (((_arg_1 + "useFlag = ") + this.useFlag) + "\n")) + (((_arg_1 + "useItem = ") + this.useItem) + "\n"));
        }

        public function set missionType(_arg_1:int):void
        {
            var _local_2:Object = this._1383259878missionType;
            if (_local_2 !== _arg_1)
            {
                this._1383259878missionType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "missionType", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function copyTo(_arg_1:NewArmyParam):void
        {
            _arg_1.heroId = this.heroId;
            _arg_1.missionType = this.missionType;
            if (this.resource == null)
            {
                _arg_1.resource = null;
            }
            else
            {
                this.resource.copyTo(_arg_1.resource);
            };
            _arg_1.restTime = this.restTime;
            _arg_1.targetPoint = this.targetPoint;
            if (this.troops == null)
            {
                _arg_1.troops = null;
            }
            else
            {
                this.troops.copyTo(_arg_1.troops);
            };
            _arg_1.backAfterConstruct = this.backAfterConstruct;
            _arg_1.useFlag = this.useFlag;
            _arg_1.useItem = this.useItem;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get troops():TroopBean
        {
            return (this._865287327troops);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get missionType():int
        {
            return (this._1383259878missionType);
        }

        public function set heroId(_arg_1:int):void
        {
            var _local_2:Object = this._1220754763heroId;
            if (_local_2 !== _arg_1)
            {
                this._1220754763heroId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroId", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set targetPoint(_arg_1:int):void
        {
            var _local_2:Object = this._2098575745targetPoint;
            if (_local_2 !== _arg_1)
            {
                this._2098575745targetPoint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPoint", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get targetPoint():int
        {
            return (this._2098575745targetPoint);
        }


    }
}//package com.evony.common.paramBeans

