// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.validators.Validator

package mx.validators
{
    import flash.events.EventDispatcher;
    import mx.core.IMXMLObject;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import mx.events.ValidationResultEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Validator extends EventDispatcher implements IMXMLObject 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        protected static const ROMAN_LETTERS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        protected static const DECIMAL_DIGITS:String = "0123456789";

        private var _resourceManager:IResourceManager = ResourceManager.getInstance();
        private var _enabled:Boolean = true;
        private var _listener:Object;
        protected var subFields:Array = [];
        private var document:Object;
        public var required:Boolean = true;
        private var requiredFieldErrorOverride:String;
        private var _triggerEvent:String = "valueCommit";
        private var _source:Object;
        private var _property:String;
        private var _requiredFieldError:String;
        private var _trigger:IEventDispatcher;

        public function Validator()
        {
            resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler, false, 0, true);
            resourcesChanged();
        }

        private static function findObjectFromString(doc:Object, value:String):Object
        {
            var resourceManager:IResourceManager;
            var message:String;
            var obj:Object = doc;
            var parts:Array = value.split(".");
            var n:int = parts.length;
            var i:int;
            while (i < n)
            {
                try
                {
                    obj = obj[parts[i]];
                    if (obj == null)
                    {
                    };
                }
                catch(error:Error)
                {
                    if (((error is TypeError) && (!(error.message.indexOf("null has no properties") == -1))))
                    {
                        resourceManager = ResourceManager.getInstance();
                        message = resourceManager.getString("validators", "fieldNotFound", [value]);
                        throw (new Error(message));
                    };
                    throw (error);
                };
                i = (i + 1);
            };
            return (obj);
        }

        private static function trimString(_arg_1:String):String
        {
            var _local_2:int;
            while (_arg_1.indexOf(" ", _local_2) == _local_2)
            {
                _local_2++;
            };
            var _local_3:int = (_arg_1.length - 1);
            while (_arg_1.lastIndexOf(" ", _local_3) == _local_3)
            {
                _local_3--;
            };
            return ((_local_3 >= _local_2) ? _arg_1.slice(_local_2, (_local_3 + 1)) : "");
        }

        public static function validateAll(_arg_1:Array):Array
        {
            var _local_5:Validator;
            var _local_6:ValidationResultEvent;
            var _local_2:Array = [];
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = Validator(_arg_1[_local_4]);
                if (_local_5.enabled)
                {
                    _local_6 = _local_5.validate();
                    if (_local_6.type != ValidationResultEvent.VALID)
                    {
                        _local_2.push(_local_6);
                    };
                };
                _local_4++;
            };
            return (_local_2);
        }


        private function triggerHandler(_arg_1:Event):void
        {
            validate();
        }

        public function set enabled(_arg_1:Boolean):void
        {
            _enabled = _arg_1;
        }

        public function set triggerEvent(_arg_1:String):void
        {
            if (_triggerEvent == _arg_1)
            {
                return;
            };
            removeTriggerHandler();
            _triggerEvent = _arg_1;
            addTriggerHandler();
        }

        protected function getValueFromSource():Object
        {
            var _local_1:String;
            if (((_source) && (_property)))
            {
                return (_source[_property]);
            };
            if (((!(_source)) && (_property)))
            {
                _local_1 = resourceManager.getString("validators", "SAttributeMissing");
                throw (new Error(_local_1));
            };
            if (((_source) && (!(_property))))
            {
                _local_1 = resourceManager.getString("validators", "PAttributeMissing");
                throw (new Error(_local_1));
            };
            return (null);
        }

        protected function addListenerHandler():void
        {
            var _local_1:Object;
            var _local_2:Array = actualListeners;
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_1 = _local_2[_local_4];
                if ((_local_1 is IValidatorListener))
                {
                    addEventListener(ValidationResultEvent.VALID, IValidatorListener(_local_1).validationResultHandler);
                    addEventListener(ValidationResultEvent.INVALID, IValidatorListener(_local_1).validationResultHandler);
                };
                _local_4++;
            };
        }

        private function removeTriggerHandler():void
        {
            if (actualTrigger)
            {
                actualTrigger.removeEventListener(_triggerEvent, triggerHandler);
            };
        }

        public function validate(_arg_1:Object=null, _arg_2:Boolean=false):ValidationResultEvent
        {
            if (_arg_1 == null)
            {
                _arg_1 = getValueFromSource();
            };
            if (((isRealValue(_arg_1)) || (required)))
            {
                return (processValidation(_arg_1, _arg_2));
            };
            return (new ValidationResultEvent(ValidationResultEvent.VALID));
        }

        public function get source():Object
        {
            return (_source);
        }

        public function set property(_arg_1:String):void
        {
            _property = _arg_1;
        }

        public function get requiredFieldError():String
        {
            return (_requiredFieldError);
        }

        protected function handleResults(_arg_1:Array):ValidationResultEvent
        {
            var _local_2:ValidationResultEvent;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            if (_arg_1.length > 0)
            {
                _local_2 = new ValidationResultEvent(ValidationResultEvent.INVALID);
                _local_2.results = _arg_1;
                if (subFields.length > 0)
                {
                    _local_3 = {};
                    _local_5 = _arg_1.length;
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        _local_4 = _arg_1[_local_6].subField;
                        if (_local_4)
                        {
                            _local_3[_local_4] = true;
                        };
                        _local_6++;
                    };
                    _local_5 = subFields.length;
                    _local_6 = 0;
                    while (_local_6 < _local_5)
                    {
                        if (!_local_3[subFields[_local_6]])
                        {
                            _arg_1.push(new ValidationResult(false, subFields[_local_6]));
                        };
                        _local_6++;
                    };
                };
            }
            else
            {
                _local_2 = new ValidationResultEvent(ValidationResultEvent.VALID);
            };
            return (_local_2);
        }

        public function get listener():Object
        {
            return (_listener);
        }

        public function get trigger():IEventDispatcher
        {
            return (_trigger);
        }

        public function set source(_arg_1:Object):void
        {
            var _local_2:String;
            if (_source == _arg_1)
            {
                return;
            };
            if ((_arg_1 is String))
            {
                _local_2 = resourceManager.getString("validators", "SAttribute", [_arg_1]);
                throw (new Error(_local_2));
            };
            removeTriggerHandler();
            removeListenerHandler();
            _source = _arg_1;
            addTriggerHandler();
            addListenerHandler();
        }

        [Bindable("unused")]
        protected function get resourceManager():IResourceManager
        {
            return (_resourceManager);
        }

        public function get enabled():Boolean
        {
            return (_enabled);
        }

        private function processValidation(_arg_1:Object, _arg_2:Boolean):ValidationResultEvent
        {
            var _local_3:ValidationResultEvent;
            var _local_4:Array;
            if (_enabled)
            {
                _local_4 = doValidation(_arg_1);
                _local_3 = handleResults(_local_4);
            }
            else
            {
                _arg_2 = true;
            };
            if (!_arg_2)
            {
                dispatchEvent(_local_3);
            };
            return (_local_3);
        }

        public function get triggerEvent():String
        {
            return (_triggerEvent);
        }

        protected function get actualTrigger():IEventDispatcher
        {
            if (_trigger)
            {
                return (_trigger);
            };
            if (_source)
            {
                return (_source as IEventDispatcher);
            };
            return (null);
        }

        protected function resourcesChanged():void
        {
            requiredFieldError = requiredFieldErrorOverride;
        }

        protected function get actualListeners():Array
        {
            var _local_1:Array = [];
            if (_listener)
            {
                _local_1.push(_listener);
            }
            else
            {
                if (_source)
                {
                    _local_1.push(_source);
                };
            };
            return (_local_1);
        }

        protected function removeListenerHandler():void
        {
            var _local_1:Object;
            var _local_2:Array = actualListeners;
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_1 = _local_2[_local_4];
                if ((_local_1 is IValidatorListener))
                {
                    removeEventListener(ValidationResultEvent.VALID, IValidatorListener(_local_1).validationResultHandler);
                    removeEventListener(ValidationResultEvent.INVALID, IValidatorListener(_local_1).validationResultHandler);
                };
                _local_4++;
            };
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            this.document = _arg_1;
        }

        public function get property():String
        {
            return (_property);
        }

        public function set requiredFieldError(_arg_1:String):void
        {
            requiredFieldErrorOverride = _arg_1;
            _requiredFieldError = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("validators", "requiredFieldError"));
        }

        private function validateRequired(_arg_1:Object):ValidationResult
        {
            var _local_2:String;
            if (required)
            {
                _local_2 = ((_arg_1 != null) ? String(_arg_1) : "");
                _local_2 = trimString(_local_2);
                if (_local_2.length == 0)
                {
                    return (new ValidationResult(true, "", "requiredField", requiredFieldError));
                };
            };
            return (null);
        }

        protected function doValidation(_arg_1:Object):Array
        {
            var _local_2:Array = [];
            var _local_3:ValidationResult = validateRequired(_arg_1);
            if (_local_3)
            {
                _local_2.push(_local_3);
            };
            return (_local_2);
        }

        public function set listener(_arg_1:Object):void
        {
            removeListenerHandler();
            _listener = _arg_1;
            addListenerHandler();
        }

        protected function isRealValue(_arg_1:Object):Boolean
        {
            return (!(_arg_1 == null));
        }

        public function set trigger(_arg_1:IEventDispatcher):void
        {
            removeTriggerHandler();
            _trigger = _arg_1;
            addTriggerHandler();
        }

        private function addTriggerHandler():void
        {
            if (actualTrigger)
            {
                actualTrigger.addEventListener(_triggerEvent, triggerHandler);
            };
        }

        private function resourceManager_changeHandler(_arg_1:Event):void
        {
            resourcesChanged();
        }


    }
}//package mx.validators

