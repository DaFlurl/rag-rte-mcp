// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.DegrafaObject

package com.degrafa.core
{
    import mx.core.IMXMLObject;
    import flash.events.EventDispatcher;
    import mx.events.PropertyChangeEvent;
    import mx.events.PropertyChangeEventKind;
    import mx.utils.NameUtil;
    import flash.events.Event;
    import mx.events.FlexEvent;

    public class DegrafaObject implements IDegrafaObject, IMXMLObject 
    {

        public var objectBindings:Array;
        private var _suppressEventProcessing:Boolean = false;
        private var _eventDispatcher:EventDispatcher;
        private var _id:String;
        private var _parent:IDegrafaObject;
        private var _isInitialized:Boolean;
        private var _enableEvents:Boolean = true;
        private var _document:Object;


        public function willTrigger(_arg_1:String):Boolean
        {
            return (eventDispatcher.willTrigger(_arg_1));
        }

        public function set enableEvents(_arg_1:Boolean):void
        {
            _enableEvents = _arg_1;
        }

        public function get name():String
        {
            return (id);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (eventDispatcher.hasEventListener(_arg_1));
        }

        public function dispatchPropertyChange(_arg_1:Boolean=false, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null, _arg_5:Object=null):Boolean
        {
            return (dispatchEvent(new PropertyChangeEvent("propertyChange", _arg_1, false, PropertyChangeEventKind.UPDATE, _arg_2, _arg_3, _arg_4, _arg_5)));
        }

        public function get hasEventManager():Boolean
        {
            return ((_eventDispatcher) ? true : false);
        }

        public function get id():String
        {
            if (_id)
            {
                return (_id);
            };
            _id = NameUtil.createUniqueName(this);
            return (_id);
        }

        public function get parent():IDegrafaObject
        {
            return (_parent);
        }

        public function get document():Object
        {
            return (_document);
        }

        public function set suppressEventProcessing(_arg_1:Boolean):void
        {
            if (((_suppressEventProcessing == true) && (_arg_1 == false)))
            {
                _suppressEventProcessing = _arg_1;
                initChange("suppressEventProcessing", false, true, this);
            }
            else
            {
                _suppressEventProcessing = _arg_1;
            };
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            if (_suppressEventProcessing)
            {
                _arg_1.stopImmediatePropagation();
                return (false);
            };
            return (eventDispatcher.dispatchEvent(_arg_1));
        }

        protected function set eventDispatcher(_arg_1:EventDispatcher):void
        {
            _eventDispatcher = _arg_1;
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            eventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            eventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get isInitialized():Boolean
        {
            return (_isInitialized);
        }

        public function set parent(_arg_1:IDegrafaObject):void
        {
            _parent = _arg_1;
        }

        public function get suppressEventProcessing():Boolean
        {
            return (_suppressEventProcessing);
        }

        public function initChange(_arg_1:String, _arg_2:Object, _arg_3:Object, _arg_4:Object):void
        {
            if (hasEventManager)
            {
                dispatchPropertyChange(false, _arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        protected function get eventDispatcher():EventDispatcher
        {
            if (!_eventDispatcher)
            {
                _eventDispatcher = new EventDispatcher(this);
            };
            return (_eventDispatcher);
        }

        public function initialized(_arg_1:Object, _arg_2:String):void
        {
            if (!_id)
            {
                if (_arg_2)
                {
                    _id = _arg_2;
                }
                else
                {
                    _id = NameUtil.createUniqueName(this);
                };
            };
            _document = _arg_1;
            _isInitialized = true;
            if (((enableEvents) && (!(_suppressEventProcessing))))
            {
                dispatchEvent(new FlexEvent(FlexEvent.INITIALIZE));
            };
        }

        public function get enableEvents():Boolean
        {
            return (_enableEvents);
        }


    }
}//package com.degrafa.core

