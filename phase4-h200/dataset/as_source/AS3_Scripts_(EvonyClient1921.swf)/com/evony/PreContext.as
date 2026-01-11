// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.PreContext

package com.evony
{
    import flash.events.IEventDispatcher;
    import flash.events.EventDispatcher;
    import com.evony.net.client.GameClient;
    import com.evony.common.beans.PlayerBean;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;

    public class PreContext implements IEventDispatcher 
    {

        private static var instance:PreContext = new (PreContext)();

        public var taskId:String;
        public var userName:String = "";
        public var fbUrl:String;
        public var password:String = "";
        public var fbType:String;
        private var _1128135084bVisitor:Boolean = false;
        public var VisitSelfSID:String;
        private var _866650764facebookNickName:String = "";
        private var _bindingEventDispatcher:EventDispatcher;
        private var _363649103facebookUser:Boolean = false;
        public var client:GameClient;
        public var taskXY:String;
        private var _1625418852isTryUser:Boolean = false;
        private var _1218920142userIsFirstLogin:Boolean = false;
        public var player:PlayerBean = null;
        public var TargetFbuid:String = "";
        private var _1950292456bHasLordName:Boolean = false;
        public var bVisitHostName:String = "";

        public function PreContext()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public static function getInstance():PreContext
        {
            return (instance);
        }


        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get bHasLordName():Boolean
        {
            return (this._1950292456bHasLordName);
        }

        public function set userIsFirstLogin(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1218920142userIsFirstLogin;
            if (_local_2 !== _arg_1)
            {
                this._1218920142userIsFirstLogin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userIsFirstLogin", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isTryUser():Boolean
        {
            return (this._1625418852isTryUser);
        }

        [Bindable(event="propertyChange")]
        public function get bVisitor():Boolean
        {
            return (this._1128135084bVisitor);
        }

        public function set bHasLordName(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1950292456bHasLordName;
            if (_local_2 !== _arg_1)
            {
                this._1950292456bHasLordName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bHasLordName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get facebookUser():Boolean
        {
            return (this._363649103facebookUser);
        }

        public function setPlayerBean(_arg_1:PlayerBean):void
        {
            this.player = _arg_1;
        }

        public function set isTryUser(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1625418852isTryUser;
            if (_local_2 !== _arg_1)
            {
                this._1625418852isTryUser = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isTryUser", _local_2, _arg_1));
            };
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get userIsFirstLogin():Boolean
        {
            return (this._1218920142userIsFirstLogin);
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function set bVisitor(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1128135084bVisitor;
            if (_local_2 !== _arg_1)
            {
                this._1128135084bVisitor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bVisitor", _local_2, _arg_1));
            };
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set facebookNickName(_arg_1:String):void
        {
            var _local_2:Object = this._866650764facebookNickName;
            if (_local_2 !== _arg_1)
            {
                this._866650764facebookNickName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebookNickName", _local_2, _arg_1));
            };
        }

        public function set facebookUser(_arg_1:Boolean):void
        {
            var _local_2:Object = this._363649103facebookUser;
            if (_local_2 !== _arg_1)
            {
                this._363649103facebookUser = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "facebookUser", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get facebookNickName():String
        {
            return (this._866650764facebookNickName);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }


    }
}//package com.evony

