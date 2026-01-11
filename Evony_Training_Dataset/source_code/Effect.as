// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.Effect

package mx.effects
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import mx.effects.effectClasses.PropertyChanges;
    import flash.utils.getQualifiedClassName;
    import mx.managers.LayoutManager;
    import mx.events.EffectEvent;
    import mx.core.IFlexDisplayObject;
    import mx.effects.effectClasses.AddRemoveEffectTargetFilter;
    import mx.effects.effectClasses.HideShowEffectTargetFilter;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Effect extends EventDispatcher implements IEffect 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        private var _perElementOffset:Number = 0;
        private var _hideFocusRing:Boolean = false;
        private var _customFilter:EffectTargetFilter;
        public var repeatCount:int = 1;
        public var suspendBackgroundProcessing:Boolean = false;
        public var startDelay:int = 0;
        private var _relevantProperties:Array;
        private var _callValidateNow:Boolean = false;
        mx_internal var applyActualDimensions:Boolean = true;
        private var _filter:String;
        private var _triggerEvent:Event;
        private var _effectTargetHost:IEffectTargetHost;
        mx_internal var durationExplicitlySet:Boolean = false;
        public var repeatDelay:int = 0;
        mx_internal var propertyChangesArray:Array;
        mx_internal var filterObject:EffectTargetFilter;
        protected var endValuesCaptured:Boolean = false;
        private var _duration:Number = 500;
        private var isPaused:Boolean = false;

        private var _instances:Array = [];
        public var instanceClass:Class = IEffectInstance;
        private var _relevantStyles:Array = [];
        private var _targets:Array = [];

        public function Effect(_arg_1:Object=null)
        {
            this.target = _arg_1;
        }

        private static function mergeArrays(_arg_1:Array, _arg_2:Array):Array
        {
            var _local_3:int;
            var _local_4:Boolean;
            var _local_5:int;
            if (_arg_2)
            {
                _local_3 = 0;
                while (_local_3 < _arg_2.length)
                {
                    _local_4 = true;
                    _local_5 = 0;
                    while (_local_5 < _arg_1.length)
                    {
                        if (_arg_1[_local_5] == _arg_2[_local_3])
                        {
                            _local_4 = false;
                            break;
                        };
                        _local_5++;
                    };
                    if (_local_4)
                    {
                        _arg_1.push(_arg_2[_local_3]);
                    };
                    _local_3++;
                };
            };
            return (_arg_1);
        }

        private static function stripUnchangedValues(_arg_1:Array):Array
        {
            var _local_3:Object;
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                for (_local_3 in _arg_1[_local_2].start)
                {
                    if (((_arg_1[_local_2].start[_local_3] == _arg_1[_local_2].end[_local_3]) || ((((typeof(_arg_1[_local_2].start[_local_3]) == "number") && (typeof(_arg_1[_local_2].end[_local_3]) == "number")) && (isNaN(_arg_1[_local_2].start[_local_3]))) && (isNaN(_arg_1[_local_2].end[_local_3])))))
                    {
                        delete _arg_1[_local_2].start[_local_3];
                        delete _arg_1[_local_2].end[_local_3];
                    };
                };
                _local_2++;
            };
            return (_arg_1);
        }


        public function get targets():Array
        {
            return (_targets);
        }

        public function set targets(_arg_1:Array):void
        {
            var _local_2:int = _arg_1.length;
            var _local_3:int = (_local_2 - 1);
            while (_local_3 > 0)
            {
                if (_arg_1[_local_3] == null)
                {
                    _arg_1.splice(_local_3, 1);
                };
                _local_3--;
            };
            _targets = _arg_1;
        }

        public function set hideFocusRing(_arg_1:Boolean):void
        {
            _hideFocusRing = _arg_1;
        }

        public function get hideFocusRing():Boolean
        {
            return (_hideFocusRing);
        }

        public function stop():void
        {
            var _local_3:IEffectInstance;
            var _local_1:int = _instances.length;
            var _local_2:int = _local_1;
            while (_local_2 >= 0)
            {
                _local_3 = IEffectInstance(_instances[_local_2]);
                if (_local_3)
                {
                    _local_3.stop();
                };
                _local_2--;
            };
        }

        public function captureStartValues():void
        {
            if (targets.length > 0)
            {
                propertyChangesArray = captureValues(null, true);
                _callValidateNow = true;
            };
            endValuesCaptured = false;
        }

        mx_internal function captureValues(_arg_1:Array, _arg_2:Boolean):Array
        {
            var _local_3:int;
            var _local_4:int;
            var _local_6:Object;
            var _local_7:Object;
            var _local_8:int;
            var _local_9:int;
            if (!_arg_1)
            {
                _arg_1 = [];
                _local_3 = targets.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _arg_1.push(new PropertyChanges(targets[_local_4]));
                    _local_4++;
                };
            };
            var _local_5:Array = ((filterObject) ? mergeArrays(relevantProperties, filterObject.filterProperties) : relevantProperties);
            if (((_local_5) && (_local_5.length > 0)))
            {
                _local_3 = _arg_1.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_7 = _arg_1[_local_4].target;
                    _local_6 = ((_arg_2) ? _arg_1[_local_4].start : _arg_1[_local_4].end);
                    _local_8 = _local_5.length;
                    _local_9 = 0;
                    while (_local_9 < _local_8)
                    {
                        _local_6[_local_5[_local_9]] = getValueFromTarget(_local_7, _local_5[_local_9]);
                        _local_9++;
                    };
                    _local_4++;
                };
            };
            var _local_10:Array = ((filterObject) ? mergeArrays(relevantStyles, filterObject.filterStyles) : relevantStyles);
            if (((_local_10) && (_local_10.length > 0)))
            {
                _local_3 = _arg_1.length;
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_7 = _arg_1[_local_4].target;
                    _local_6 = ((_arg_2) ? _arg_1[_local_4].start : _arg_1[_local_4].end);
                    _local_8 = _local_10.length;
                    _local_9 = 0;
                    while (_local_9 < _local_8)
                    {
                        _local_6[_local_10[_local_9]] = _local_7.getStyle(_local_10[_local_9]);
                        _local_9++;
                    };
                    _local_4++;
                };
            };
            return (_arg_1);
        }

        protected function getValueFromTarget(_arg_1:Object, _arg_2:String):*
        {
            if ((_arg_2 in _arg_1))
            {
                return (_arg_1[_arg_2]);
            };
            return (undefined);
        }

        public function set target(_arg_1:Object):void
        {
            _targets.splice(0);
            if (_arg_1)
            {
                _targets[0] = _arg_1;
            };
        }

        public function get className():String
        {
            var _local_1:String = getQualifiedClassName(this);
            var _local_2:int = _local_1.indexOf("::");
            if (_local_2 != -1)
            {
                _local_1 = _local_1.substr((_local_2 + 2));
            };
            return (_local_1);
        }

        public function set perElementOffset(_arg_1:Number):void
        {
            _perElementOffset = _arg_1;
        }

        public function resume():void
        {
            var _local_1:int;
            var _local_2:int;
            if (((isPlaying) && (isPaused)))
            {
                isPaused = false;
                _local_1 = _instances.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    IEffectInstance(_instances[_local_2]).resume();
                    _local_2++;
                };
            };
        }

        public function set duration(_arg_1:Number):void
        {
            durationExplicitlySet = true;
            _duration = _arg_1;
        }

        public function play(_arg_1:Array=null, _arg_2:Boolean=false):Array
        {
            var _local_6:IEffectInstance;
            if (((_arg_1 == null) && (!(propertyChangesArray == null))))
            {
                if (_callValidateNow)
                {
                    LayoutManager.getInstance().validateNow();
                };
                if (!endValuesCaptured)
                {
                    propertyChangesArray = captureValues(propertyChangesArray, false);
                };
                propertyChangesArray = stripUnchangedValues(propertyChangesArray);
                applyStartValues(propertyChangesArray, this.targets);
            };
            var _local_3:Array = createInstances(_arg_1);
            var _local_4:int = _local_3.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = IEffectInstance(_local_3[_local_5]);
                Object(_local_6).playReversed = _arg_2;
                _local_6.startEffect();
                _local_5++;
            };
            return (_local_3);
        }

        public function captureEndValues():void
        {
            propertyChangesArray = captureValues(propertyChangesArray, false);
            endValuesCaptured = true;
        }

        protected function filterInstance(_arg_1:Array, _arg_2:Object):Boolean
        {
            if (filterObject)
            {
                return (filterObject.filterInstance(_arg_1, effectTargetHost, _arg_2));
            };
            return (true);
        }

        public function get customFilter():EffectTargetFilter
        {
            return (_customFilter);
        }

        public function get effectTargetHost():IEffectTargetHost
        {
            return (_effectTargetHost);
        }

        public function set relevantProperties(_arg_1:Array):void
        {
            _relevantProperties = _arg_1;
        }

        public function captureMoreStartValues(_arg_1:Array):void
        {
            var _local_2:Array;
            if (_arg_1.length > 0)
            {
                _local_2 = captureValues(null, true);
                propertyChangesArray = propertyChangesArray.concat(_local_2);
            };
        }

        public function deleteInstance(_arg_1:IEffectInstance):void
        {
            EventDispatcher(_arg_1).removeEventListener(EffectEvent.EFFECT_START, effectStartHandler);
            EventDispatcher(_arg_1).removeEventListener(EffectEvent.EFFECT_END, effectEndHandler);
            var _local_2:int = _instances.length;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                if (_instances[_local_3] === _arg_1)
                {
                    _instances.splice(_local_3, 1);
                };
                _local_3++;
            };
        }

        public function get filter():String
        {
            return (_filter);
        }

        public function set triggerEvent(_arg_1:Event):void
        {
            _triggerEvent = _arg_1;
        }

        public function get target():Object
        {
            if (_targets.length > 0)
            {
                return (_targets[0]);
            };
            return (null);
        }

        public function get duration():Number
        {
            return (_duration);
        }

        public function set customFilter(_arg_1:EffectTargetFilter):void
        {
            _customFilter = _arg_1;
            filterObject = _arg_1;
        }

        public function get perElementOffset():Number
        {
            return (_perElementOffset);
        }

        public function set effectTargetHost(_arg_1:IEffectTargetHost):void
        {
            _effectTargetHost = _arg_1;
        }

        public function get isPlaying():Boolean
        {
            return ((_instances) && (_instances.length > 0));
        }

        protected function effectEndHandler(_arg_1:EffectEvent):void
        {
            var _local_2:IEffectInstance = IEffectInstance(_arg_1.effectInstance);
            deleteInstance(_local_2);
            dispatchEvent(_arg_1);
        }

        public function get relevantProperties():Array
        {
            if (_relevantProperties)
            {
                return (_relevantProperties);
            };
            return (getAffectedProperties());
        }

        public function createInstance(_arg_1:Object=null):IEffectInstance
        {
            var _local_6:int;
            var _local_7:int;
            if (!_arg_1)
            {
                _arg_1 = this.target;
            };
            var _local_2:IEffectInstance;
            var _local_3:PropertyChanges;
            var _local_4:Boolean = true;
            var _local_5:Boolean;
            if (propertyChangesArray)
            {
                _local_5 = true;
                _local_4 = filterInstance(propertyChangesArray, _arg_1);
            };
            if (_local_4)
            {
                _local_2 = IEffectInstance(new instanceClass(_arg_1));
                initInstance(_local_2);
                if (_local_5)
                {
                    _local_6 = propertyChangesArray.length;
                    _local_7 = 0;
                    while (_local_7 < _local_6)
                    {
                        if (propertyChangesArray[_local_7].target == _arg_1)
                        {
                            _local_2.propertyChanges = propertyChangesArray[_local_7];
                        };
                        _local_7++;
                    };
                };
                EventDispatcher(_local_2).addEventListener(EffectEvent.EFFECT_START, effectStartHandler);
                EventDispatcher(_local_2).addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _instances.push(_local_2);
                if (triggerEvent)
                {
                    _local_2.initEffect(triggerEvent);
                };
            };
            return (_local_2);
        }

        protected function effectStartHandler(_arg_1:EffectEvent):void
        {
            dispatchEvent(_arg_1);
        }

        public function getAffectedProperties():Array
        {
            return ([]);
        }

        public function set relevantStyles(_arg_1:Array):void
        {
            _relevantStyles = _arg_1;
        }

        public function get triggerEvent():Event
        {
            return (_triggerEvent);
        }

        protected function applyValueToTarget(target:Object, property:String, value:*, props:Object):void
        {
            if ((property in target))
            {
                try
                {
                    if ((((applyActualDimensions) && (target is IFlexDisplayObject)) && (property == "height")))
                    {
                        target.setActualSize(target.width, value);
                    }
                    else
                    {
                        if ((((applyActualDimensions) && (target is IFlexDisplayObject)) && (property == "width")))
                        {
                            target.setActualSize(value, target.height);
                        }
                        else
                        {
                            target[property] = value;
                        };
                    };
                }
                catch(e:Error)
                {
                };
            };
        }

        protected function initInstance(_arg_1:IEffectInstance):void
        {
            _arg_1.duration = duration;
            Object(_arg_1).durationExplicitlySet = durationExplicitlySet;
            _arg_1.effect = this;
            _arg_1.effectTargetHost = effectTargetHost;
            _arg_1.hideFocusRing = hideFocusRing;
            _arg_1.repeatCount = repeatCount;
            _arg_1.repeatDelay = repeatDelay;
            _arg_1.startDelay = startDelay;
            _arg_1.suspendBackgroundProcessing = suspendBackgroundProcessing;
        }

        mx_internal function applyStartValues(_arg_1:Array, _arg_2:Array):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:Object;
            var _local_9:Boolean;
            var _local_3:Array = relevantProperties;
            var _local_4:int = _arg_1.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_8 = _arg_1[_local_5].target;
                _local_9 = false;
                _local_6 = _arg_2.length;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    if (_arg_2[_local_7] == _local_8)
                    {
                        _local_9 = filterInstance(_arg_1, _local_8);
                        break;
                    };
                    _local_7++;
                };
                if (_local_9)
                {
                    _local_6 = _local_3.length;
                    _local_7 = 0;
                    while (_local_7 < _local_6)
                    {
                        if (((_local_3[_local_7] in _arg_1[_local_5].start) && (_local_3[_local_7] in _local_8)))
                        {
                            applyValueToTarget(_local_8, _local_3[_local_7], _arg_1[_local_5].start[_local_3[_local_7]], _arg_1[_local_5].start);
                        };
                        _local_7++;
                    };
                    _local_6 = relevantStyles.length;
                    _local_7 = 0;
                    while (_local_7 < _local_6)
                    {
                        if ((relevantStyles[_local_7] in _arg_1[_local_5].start))
                        {
                            _local_8.setStyle(relevantStyles[_local_7], _arg_1[_local_5].start[relevantStyles[_local_7]]);
                        };
                        _local_7++;
                    };
                };
                _local_5++;
            };
        }

        public function end(_arg_1:IEffectInstance=null):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:IEffectInstance;
            if (_arg_1)
            {
                _arg_1.end();
            }
            else
            {
                _local_2 = _instances.length;
                _local_3 = _local_2;
                while (_local_3 >= 0)
                {
                    _local_4 = IEffectInstance(_instances[_local_3]);
                    if (_local_4)
                    {
                        _local_4.end();
                    };
                    _local_3--;
                };
            };
        }

        public function get relevantStyles():Array
        {
            return (_relevantStyles);
        }

        public function createInstances(_arg_1:Array=null):Array
        {
            var _local_6:IEffectInstance;
            if (!_arg_1)
            {
                _arg_1 = this.targets;
            };
            var _local_2:Array = [];
            var _local_3:int = _arg_1.length;
            var _local_4:Number = 0;
            var _local_5:int;
            while (_local_5 < _local_3)
            {
                _local_6 = createInstance(_arg_1[_local_5]);
                if (_local_6)
                {
                    _local_6.startDelay = (_local_6.startDelay + _local_4);
                    _local_4 = (_local_4 + perElementOffset);
                    _local_2.push(_local_6);
                };
                _local_5++;
            };
            triggerEvent = null;
            return (_local_2);
        }

        public function pause():void
        {
            var _local_1:int;
            var _local_2:int;
            if (((isPlaying) && (!(isPaused))))
            {
                isPaused = true;
                _local_1 = _instances.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    IEffectInstance(_instances[_local_2]).pause();
                    _local_2++;
                };
            };
        }

        public function set filter(_arg_1:String):void
        {
            if (!customFilter)
            {
                _filter = _arg_1;
                switch (_arg_1)
                {
                    case "add":
                    case "remove":
                        filterObject = new AddRemoveEffectTargetFilter();
                        AddRemoveEffectTargetFilter(filterObject).add = (_arg_1 == "add");
                        return;
                    case "hide":
                    case "show":
                        filterObject = new HideShowEffectTargetFilter();
                        HideShowEffectTargetFilter(filterObject).show = (_arg_1 == "show");
                        return;
                    case "move":
                        filterObject = new EffectTargetFilter();
                        filterObject.filterProperties = ["x", "y"];
                        return;
                    case "resize":
                        filterObject = new EffectTargetFilter();
                        filterObject.filterProperties = ["width", "height"];
                        return;
                    case "addItem":
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {"added":true};
                        return;
                    case "removeItem":
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {"removed":true};
                        return;
                    case "replacedItem":
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {"replaced":true};
                        return;
                    case "replacementItem":
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {"replacement":true};
                        return;
                    default:
                        filterObject = null;
                };
            };
        }

        public function reverse():void
        {
            var _local_1:int;
            var _local_2:int;
            if (isPlaying)
            {
                _local_1 = _instances.length;
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    IEffectInstance(_instances[_local_2]).reverse();
                    _local_2++;
                };
            };
        }


    }
}//package mx.effects

