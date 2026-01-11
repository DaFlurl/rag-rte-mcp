// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.states.StateManager

package com.degrafa.states
{
    import mx.events.StateChangeEvent;
    import mx.events.FlexEvent;

    public class StateManager 
    {

        private var requestedCurrentState:String;
        private var _currentState:String;
        private var stateClient:IDegrafaStateClient;
        private var _currentStateChanged:Boolean;

        public function StateManager(_arg_1:IDegrafaStateClient)
        {
            this.stateClient = _arg_1;
        }

        public function findCommonBaseState(_arg_1:String, _arg_2:String):String
        {
            var _local_3:State = getState(_arg_1);
            var _local_4:State = getState(_arg_2);
            if (((!(_local_3)) || (!(_local_4))))
            {
                return ("");
            };
            if (((isBaseState(_local_3.basedOn)) && (isBaseState(_local_4.basedOn))))
            {
                return ("");
            };
            var _local_5:Array = getBaseStates(_local_3);
            var _local_6:Array = getBaseStates(_local_4);
            var _local_7:* = "";
            while (_local_5[(_local_5.length - 1)] == _local_6[(_local_6.length - 1)])
            {
                _local_7 = _local_5.pop();
                _local_6.pop();
                if (((!(_local_5.length)) || (!(_local_6.length)))) break;
            };
            if (((_local_5.length) && (_local_5[(_local_5.length - 1)] == _local_4.name)))
            {
                _local_7 = _local_4.name;
            }
            else
            {
                if (((_local_6.length) && (_local_6[(_local_6.length - 1)] == _local_3.name)))
                {
                    _local_7 = _local_3.name;
                };
            };
            return (_local_7);
        }

        public function initializeState(_arg_1:String):void
        {
            var _local_2:State = getState(_arg_1);
            while (_local_2)
            {
                _local_2 = getState(_local_2.basedOn);
            };
        }

        public function getBaseStates(_arg_1:State):Array
        {
            var _local_2:Array = [];
            while (((_arg_1) && (_arg_1.basedOn)))
            {
                _local_2.push(_arg_1.basedOn);
                _arg_1 = getState(_arg_1.basedOn);
            };
            return (_local_2);
        }

        public function applyState(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:State = getState(_arg_1);
            if (_arg_1 == _arg_2)
            {
                return;
            };
            if (_local_3)
            {
                if (_local_3.basedOn != _arg_2)
                {
                    applyState(_local_3.basedOn, _arg_2);
                };
                _local_4 = _local_3.overrides;
                _local_5 = 0;
                while (_local_5 < _local_4.length)
                {
                    _local_4[_local_5].apply(stateClient);
                    _local_5++;
                };
            };
        }

        public function removeState(_arg_1:String, _arg_2:String):void
        {
            var _local_4:Array;
            var _local_5:int;
            var _local_3:State = getState(_arg_1);
            if (_arg_1 == _arg_2)
            {
                return;
            };
            if (_local_3)
            {
                _local_3.dispatchExitState();
                _local_4 = _local_3.overrides;
                _local_5 = _local_4.length;
                while (_local_5)
                {
                    _local_4[(_local_5 - 1)].remove(stateClient);
                    _local_5--;
                };
                if (_local_3.basedOn != _arg_2)
                {
                    removeState(_local_3.basedOn, _arg_2);
                };
            };
        }

        public function commitCurrentState():void
        {
            var _local_2:StateChangeEvent;
            var _local_1:String = findCommonBaseState(_currentState, requestedCurrentState);
            var _local_3:String = ((_currentState) ? _currentState : "");
            var _local_4:State = getState(requestedCurrentState);
            initializeState(requestedCurrentState);
            _local_2 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGING);
            _local_2.oldState = _local_3;
            _local_2.newState = ((requestedCurrentState) ? requestedCurrentState : "");
            stateClient.dispatchEvent(_local_2);
            if (isBaseState(_currentState))
            {
                stateClient.dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
            };
            removeState(_currentState, _local_1);
            _currentState = requestedCurrentState;
            if (isBaseState(currentState))
            {
                stateClient.dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
            }
            else
            {
                applyState(_currentState, _local_1);
            };
            _local_2 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE);
            _local_2.oldState = _local_3;
            _local_2.newState = ((_currentState) ? _currentState : "");
            stateClient.dispatchEvent(_local_2);
        }

        public function set currentState(_arg_1:String):void
        {
            setCurrentState(_arg_1);
        }

        public function isBaseState(_arg_1:String):Boolean
        {
            return ((!(_arg_1)) || (_arg_1 == ""));
        }

        public function setCurrentState(_arg_1:String):void
        {
            if (((!(_arg_1 == currentState)) && (!((isBaseState(_arg_1)) && (isBaseState(currentState))))))
            {
                requestedCurrentState = _arg_1;
                if (stateClient.isInitialized)
                {
                    commitCurrentState();
                }
                else
                {
                    _currentStateChanged = true;
                };
            };
        }

        public function getState(_arg_1:String):State
        {
            if (((!(stateClient.states)) || (isBaseState(_arg_1))))
            {
                return (null);
            };
            var _local_2:int;
            while (_local_2 < stateClient.states.length)
            {
                if (stateClient.states[_local_2].name == _arg_1)
                {
                    return (stateClient.states[_local_2]);
                };
                _local_2++;
            };
            return (null);
        }

        public function get currentState():String
        {
            return ((_currentStateChanged) ? requestedCurrentState : _currentState);
        }


    }
}//package com.degrafa.states

