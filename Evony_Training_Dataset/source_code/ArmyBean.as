// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.common.beans.ArmyBean

package com.evony.common.beans
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class ArmyBean implements IEventDispatcher 
    {

        private var _1409292392armyId:int;
        private var _1383259878missionType:int;
        private var _3292055king:String;
        private var _341064690resource:ResourceBean;
        private var _995699469startFieldId:int;
        private var _1220753771heroid:int;
        private var _1911605294targetPosName:String;
        private var _962590849direction:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _526788547startPosName:String;
        private var _337438527restTime:Number;
        private var _1191572123selected:Boolean;
        private var _2129294769startTime:Number;
        private var _2014132310heroLevel:int;
        private var _1134711072reachTime:Number;
        private var _1442694372targetFieldId:int;
        private var _3198970hero:String;
        private var _1806944311alliance:String;
        private var _110634834troop:TroopStrBean;

        public function ArmyBean(_arg_1:Object=null)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
            if (_arg_1 != null)
            {
                if (_arg_1.alliance != null)
                {
                    this.alliance = _arg_1.alliance;
                };
                if (_arg_1.armyId != null)
                {
                    this.armyId = _arg_1.armyId;
                };
                if (_arg_1.direction != null)
                {
                    this.direction = _arg_1.direction;
                };
                if (_arg_1.hero != null)
                {
                    this.hero = _arg_1.hero;
                };
                if (_arg_1.heroLevel != null)
                {
                    this.heroLevel = _arg_1.heroLevel;
                };
                if (_arg_1.heroid != null)
                {
                    this.heroid = _arg_1.heroid;
                };
                if (_arg_1.king != null)
                {
                    this.king = _arg_1.king;
                };
                if (_arg_1.missionType != null)
                {
                    this.missionType = _arg_1.missionType;
                };
                if (_arg_1.reachTime != null)
                {
                    this.reachTime = _arg_1.reachTime;
                };
                if (_arg_1.resource != null)
                {
                    this.resource = new ResourceBean(_arg_1.resource);
                };
                if (_arg_1.restTime != null)
                {
                    this.restTime = _arg_1.restTime;
                };
                if (_arg_1.startFieldId != null)
                {
                    this.startFieldId = _arg_1.startFieldId;
                };
                if (_arg_1.startPosName != null)
                {
                    this.startPosName = _arg_1.startPosName;
                };
                if (_arg_1.startTime != null)
                {
                    this.startTime = _arg_1.startTime;
                };
                if (_arg_1.targetFieldId != null)
                {
                    this.targetFieldId = _arg_1.targetFieldId;
                };
                if (_arg_1.targetPosName != null)
                {
                    this.targetPosName = _arg_1.targetPosName;
                };
                if (_arg_1.troop != null)
                {
                    this.troop = new TroopStrBean(_arg_1.troop);
                };
                if (_arg_1.selected != null)
                {
                    this.selected = _arg_1.selected;
                };
            };
        }

        public function set startPosName(_arg_1:String):void
        {
            var _local_2:Object = this._526788547startPosName;
            if (_local_2 !== _arg_1)
            {
                this._526788547startPosName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPosName", _local_2, _arg_1));
            };
        }

        public function set restTime(_arg_1:Number):void
        {
            var _local_2:Object = this._337438527restTime;
            if (_local_2 !== _arg_1)
            {
                this._337438527restTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "restTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get direction():int
        {
            return (this._962590849direction);
        }

        [Bindable(event="propertyChange")]
        public function get hero():String
        {
            return (this._3198970hero);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get resource():ResourceBean
        {
            return (this._341064690resource);
        }

        [Bindable(event="propertyChange")]
        public function get king():String
        {
            return (this._3292055king);
        }

        [Bindable(event="propertyChange")]
        public function get armyId():int
        {
            return (this._1409292392armyId);
        }

        public function toObject():Object
        {
            return ({
                "alliance":this.alliance,
                "armyId":this.armyId,
                "direction":this.direction,
                "hero":this.hero,
                "heroLevel":this.heroLevel,
                "heroid":this.heroid,
                "king":this.king,
                "missionType":this.missionType,
                "reachTime":this.reachTime,
                "resource":this.resource.toObject(),
                "restTime":this.restTime,
                "startFieldId":this.startFieldId,
                "startPosName":this.startPosName,
                "startTime":this.startTime,
                "targetFieldId":this.targetFieldId,
                "targetPosName":this.targetPosName,
                "troop":this.troop.toObject(),
                "selected":this.selected
            });
        }

        [Bindable(event="propertyChange")]
        public function get selected():Boolean
        {
            return (this._1191572123selected);
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

        public function set troop(_arg_1:TroopStrBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        public function get heroid():int
        {
            return (this._1220753771heroid);
        }

        [Bindable(event="propertyChange")]
        public function get targetPosName():String
        {
            return (this._1911605294targetPosName);
        }

        public function set armyId(_arg_1:int):void
        {
            var _local_2:Object = this._1409292392armyId;
            if (_local_2 !== _arg_1)
            {
                this._1409292392armyId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroLevel():int
        {
            return (this._2014132310heroLevel);
        }

        public function set selected(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1191572123selected;
            if (_local_2 !== _arg_1)
            {
                this._1191572123selected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selected", _local_2, _arg_1));
            };
        }

        public function set heroid(_arg_1:int):void
        {
            var _local_2:Object = this._1220753771heroid;
            if (_local_2 !== _arg_1)
            {
                this._1220753771heroid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroid", _local_2, _arg_1));
            };
        }

        public function set king(_arg_1:String):void
        {
            var _local_2:Object = this._3292055king;
            if (_local_2 !== _arg_1)
            {
                this._3292055king = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "king", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get alliance():String
        {
            return (this._1806944311alliance);
        }

        public function set reachTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1134711072reachTime;
            if (_local_2 !== _arg_1)
            {
                this._1134711072reachTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reachTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get restTime():Number
        {
            return (this._337438527restTime);
        }

        [Bindable(event="propertyChange")]
        public function get startPosName():String
        {
            return (this._526788547startPosName);
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set targetFieldId(_arg_1:int):void
        {
            var _local_2:Object = this._1442694372targetFieldId;
            if (_local_2 !== _arg_1)
            {
                this._1442694372targetFieldId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetFieldId", _local_2, _arg_1));
            };
        }

        public function toDebugString(_arg_1:String=""):String
        {
            return ((((((((((((((((((((_arg_1 + "alliance = ") + this.alliance) + "\n") + (((_arg_1 + "armyId = ") + this.armyId) + "\n")) + (((_arg_1 + "direction = ") + this.direction) + "\n")) + (((_arg_1 + "hero = ") + this.hero) + "\n")) + (((_arg_1 + "heroLevel = ") + this.heroLevel) + "\n")) + (((_arg_1 + "heroid = ") + this.heroid) + "\n")) + (((_arg_1 + "king = ") + this.king) + "\n")) + (((_arg_1 + "missionType = ") + this.missionType) + "\n")) + (((_arg_1 + "reachTime = ") + this.reachTime) + "\n")) + ((this.resource != null) ? this.resource.toDebugString((_arg_1 + "resource.")) : (_arg_1 + "resource = null\n"))) + (((_arg_1 + "restTime = ") + this.restTime) + "\n")) + (((_arg_1 + "startFieldId = ") + this.startFieldId) + "\n")) + (((_arg_1 + "startPosName = ") + this.startPosName) + "\n")) + (((_arg_1 + "startTime = ") + this.startTime) + "\n")) + (((_arg_1 + "targetFieldId = ") + this.targetFieldId) + "\n")) + (((_arg_1 + "targetPosName = ") + this.targetPosName) + "\n")) + ((this.troop != null) ? this.troop.toDebugString((_arg_1 + "troop.")) : (_arg_1 + "troop = null\n"))) + (((_arg_1 + "selected = ") + this.selected) + "\n"));
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
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

        [Bindable(event="propertyChange")]
        public function get startTime():Number
        {
            return (this._2129294769startTime);
        }

        [Bindable(event="propertyChange")]
        public function get troop():TroopStrBean
        {
            return (this._110634834troop);
        }

        public function copyTo(_arg_1:ArmyBean):void
        {
            _arg_1.alliance = this.alliance;
            _arg_1.armyId = this.armyId;
            _arg_1.direction = this.direction;
            _arg_1.hero = this.hero;
            _arg_1.heroLevel = this.heroLevel;
            _arg_1.heroid = this.heroid;
            _arg_1.king = this.king;
            _arg_1.missionType = this.missionType;
            _arg_1.reachTime = this.reachTime;
            if (this.resource != null)
            {
                this.resource.copyTo(_arg_1.resource);
            }
            else
            {
                _arg_1.resource = null;
            };
            _arg_1.restTime = this.restTime;
            _arg_1.startFieldId = this.startFieldId;
            _arg_1.startPosName = this.startPosName;
            _arg_1.startTime = this.startTime;
            _arg_1.targetFieldId = this.targetFieldId;
            _arg_1.targetPosName = this.targetPosName;
            if (this.troop != null)
            {
                this.troop.copyTo(_arg_1.troop);
            }
            else
            {
                _arg_1.troop = null;
            };
            _arg_1.selected = this.selected;
        }

        public function set targetPosName(_arg_1:String):void
        {
            var _local_2:Object = this._1911605294targetPosName;
            if (_local_2 !== _arg_1)
            {
                this._1911605294targetPosName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPosName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get reachTime():Number
        {
            return (this._1134711072reachTime);
        }

        public function set heroLevel(_arg_1:int):void
        {
            var _local_2:Object = this._2014132310heroLevel;
            if (_local_2 !== _arg_1)
            {
                this._2014132310heroLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get targetFieldId():int
        {
            return (this._1442694372targetFieldId);
        }

        [Bindable(event="propertyChange")]
        public function get missionType():int
        {
            return (this._1383259878missionType);
        }

        public function set startFieldId(_arg_1:int):void
        {
            var _local_2:Object = this._995699469startFieldId;
            if (_local_2 !== _arg_1)
            {
                this._995699469startFieldId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startFieldId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get startFieldId():int
        {
            return (this._995699469startFieldId);
        }

        public function set hero(_arg_1:String):void
        {
            var _local_2:Object = this._3198970hero;
            if (_local_2 !== _arg_1)
            {
                this._3198970hero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero", _local_2, _arg_1));
            };
        }

        public function set alliance(_arg_1:String):void
        {
            var _local_2:Object = this._1806944311alliance;
            if (_local_2 !== _arg_1)
            {
                this._1806944311alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _local_2, _arg_1));
            };
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set direction(_arg_1:int):void
        {
            var _local_2:Object = this._962590849direction;
            if (_local_2 !== _arg_1)
            {
                this._962590849direction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "direction", _local_2, _arg_1));
            };
        }


    }
}//package com.evony.common.beans

