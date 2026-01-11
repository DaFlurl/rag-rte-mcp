// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.HistoryManagerImpl

package mx.managers
{
    import flash.utils.Dictionary;
    import flash.display.LoaderInfo;
    import mx.core.ApplicationGlobals;
    import flash.display.DisplayObject;
    import mx.events.BrowserChangeEvent;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HistoryManagerImpl implements IHistoryManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const HANDSHAKE_INTERVAL:int = 500;
        private static const MAX_HANDSHAKE_TRIES:int = 100;
        private static const ID_NAME_SEPARATOR:String = "-";
        private static const NAME_VALUE_SEPARATOR:String = "=";
        private static const PROPERTY_SEPARATOR:String = "&";
        private static var systemManager:ISystemManager;
        private static var instance:IHistoryManager;
        private static var appID:String;
        private static var historyURL:String;

        private var registeredObjects:Array = [];
        private var pendingQueryString:String;
        private var pendingStates:Object = {};
        private var registrationMap:Dictionary;

        public function HistoryManagerImpl()
        {
            var _local_1:LoaderInfo;
            var _local_2:String;
            super();
            if (instance)
            {
                throw (new Error("Instance already exists."));
            };
            if (appID)
            {
                return;
            };
            if (!ApplicationGlobals.application.historyManagementEnabled)
            {
                return;
            };
            if (HistoryManagerGlobals.loaderInfo)
            {
                _local_1 = HistoryManagerGlobals.loaderInfo;
            }
            else
            {
                _local_1 = DisplayObject(systemManager).loaderInfo;
            };
            if (HistoryManagerGlobals.loaderInfo)
            {
                _local_2 = HistoryManagerGlobals.loaderInfo.url;
            }
            else
            {
                _local_2 = DisplayObject(systemManager).loaderInfo.url;
            };
            appID = calcCRC(_local_2);
            BrowserManager.getInstance().addEventListener(BrowserChangeEvent.BROWSER_URL_CHANGE, browserURLChangeHandler);
            BrowserManager.getInstance().initForHistoryManager();
        }

        public static function getInstance():IHistoryManager
        {
            if (!instance)
            {
                systemManager = SystemManagerGlobals.topLevelSystemManagers[0];
                instance = new (HistoryManagerImpl)();
            };
            return (instance);
        }


        public function registered():void
        {
        }

        public function unregister(_arg_1:IHistoryManagerClient):void
        {
            if (!ApplicationGlobals.application.historyManagementEnabled)
            {
                return;
            };
            var _local_2:int = -1;
            var _local_3:int = registeredObjects.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (registeredObjects[_local_4] == _arg_1)
                {
                    _local_2 = _local_4;
                    break;
                };
                _local_4++;
            };
            if (_local_2 >= 0)
            {
                registeredObjects.splice(_local_2, 1);
            };
            if (((_arg_1) && (registrationMap)))
            {
                delete registrationMap[_arg_1];
            };
        }

        private function updateCRC(_arg_1:uint, _arg_2:uint):uint
        {
            var _local_6:Boolean;
            var _local_3:uint = 4129;
            var _local_4:uint = 128;
            var _local_5:int;
            while (_local_5 < 8)
            {
                _local_6 = (!((_arg_1 & 0x8000) == 0));
                _arg_1 = (_arg_1 << 1);
                _arg_1 = (_arg_1 & 0xFFFF);
                if ((_arg_2 & _local_4) != 0)
                {
                    _arg_1++;
                };
                if (_local_6)
                {
                    _arg_1 = (_arg_1 ^ _local_3);
                };
                _local_4 = (_local_4 >> 1);
                _local_5++;
            };
            return (_arg_1);
        }

        private function submitQuery():void
        {
            if (pendingQueryString)
            {
                BrowserManager.getInstance().setFragment(pendingQueryString);
                pendingQueryString = null;
                ApplicationGlobals.application.resetHistory = true;
            };
        }

        public function browserURLChangeHandler(_arg_1:BrowserChangeEvent):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_9:Array;
            var _local_10:int;
            var _local_11:String;
            var _local_12:Object;
            var _local_13:IHistoryManagerClient;
            if (!ApplicationGlobals.application.historyManagementEnabled)
            {
                return;
            };
            var _local_4:Array = _arg_1.url.split(PROPERTY_SEPARATOR);
            var _local_5:Object = {};
            var _local_6:int = _local_4.length;
            var _local_7:int;
            while (_local_7 < _local_6)
            {
                _local_9 = _local_4[_local_7].split(NAME_VALUE_SEPARATOR);
                _local_5[_local_9[0]] = parseString(_local_9[1]);
                _local_7++;
            };
            var _local_8:Object = {};
            for (_local_2 in _local_5)
            {
                _local_10 = _local_2.indexOf(ID_NAME_SEPARATOR);
                if (_local_10 > -1)
                {
                    _local_3 = _local_2.substr(0, _local_10);
                    _local_11 = _local_2.substr((_local_10 + 1), _local_2.length);
                    _local_12 = _local_5[_local_2];
                    if (!_local_8[_local_3])
                    {
                        _local_8[_local_3] = {};
                    };
                    _local_8[_local_3][_local_11] = _local_12;
                };
            };
            _local_6 = registeredObjects.length;
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_13 = registeredObjects[_local_7];
                _local_3 = getRegistrationInfo(_local_13).crc;
                _local_13.loadState(_local_8[_local_3]);
                delete _local_8[_local_3];
                _local_7++;
            };
            for (_local_2 in _local_8)
            {
                pendingStates[_local_2] = _local_8[_local_2];
            };
        }

        public function registerHandshake():void
        {
        }

        private function getRegistrationInfo(_arg_1:IHistoryManagerClient):RegistrationInfo
        {
            return ((registrationMap) ? registrationMap[_arg_1] : null);
        }

        private function getPath(_arg_1:IHistoryManagerClient):String
        {
            return (_arg_1.toString());
        }

        public function load(_arg_1:Object):void
        {
        }

        private function depthCompare(_arg_1:Object, _arg_2:Object):int
        {
            var _local_3:RegistrationInfo = getRegistrationInfo(IHistoryManagerClient(_arg_1));
            var _local_4:RegistrationInfo = getRegistrationInfo(IHistoryManagerClient(_arg_2));
            if (((!(_local_3)) || (!(_local_4))))
            {
                return (0);
            };
            if (_local_3.depth > _local_4.depth)
            {
                return (1);
            };
            if (_local_3.depth < _local_4.depth)
            {
                return (-1);
            };
            return (0);
        }

        public function register(_arg_1:IHistoryManagerClient):void
        {
            if (!ApplicationGlobals.application.historyManagementEnabled)
            {
                return;
            };
            unregister(_arg_1);
            registeredObjects.push(_arg_1);
            var _local_2:String = getPath(_arg_1);
            var _local_3:String = calcCRC(_local_2);
            var _local_4:int = calcDepth(_local_2);
            if (!registrationMap)
            {
                registrationMap = new Dictionary(true);
            };
            registrationMap[_arg_1] = new RegistrationInfo(_local_3, _local_4);
            registeredObjects.sort(depthCompare);
            if (pendingStates[_local_3])
            {
                _arg_1.loadState(pendingStates[_local_3]);
                delete pendingStates[_local_3];
            };
        }

        private function parseString(_arg_1:String):Object
        {
            if (_arg_1 == "true")
            {
                return (true);
            };
            if (_arg_1 == "false")
            {
                return (false);
            };
            var _local_2:int = parseInt(_arg_1);
            if (_local_2.toString() == _arg_1)
            {
                return (_local_2);
            };
            var _local_3:Number = parseFloat(_arg_1);
            if (_local_3.toString() == _arg_1)
            {
                return (_local_3);
            };
            return (_arg_1);
        }

        private function calcDepth(_arg_1:String):int
        {
            return (_arg_1.split(".").length);
        }

        public function loadInitialState():void
        {
        }

        public function save():void
        {
            var _local_5:IHistoryManagerClient;
            var _local_6:Object;
            var _local_7:String;
            var _local_8:String;
            var _local_9:Object;
            if (!ApplicationGlobals.application.historyManagementEnabled)
            {
                return;
            };
            var _local_1:Boolean;
            var _local_2:String = ("app=" + appID);
            var _local_3:int = registeredObjects.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = registeredObjects[_local_4];
                _local_6 = _local_5.saveState();
                _local_7 = getRegistrationInfo(_local_5).crc;
                for (_local_8 in _local_6)
                {
                    _local_9 = _local_6[_local_8];
                    if (_local_2.length > 0)
                    {
                        _local_2 = (_local_2 + PROPERTY_SEPARATOR);
                    };
                    _local_2 = (_local_2 + _local_7);
                    _local_2 = (_local_2 + ID_NAME_SEPARATOR);
                    _local_2 = (_local_2 + escape(_local_8));
                    _local_2 = (_local_2 + NAME_VALUE_SEPARATOR);
                    _local_2 = (_local_2 + escape(_local_9.toString()));
                    _local_1 = true;
                };
                _local_4++;
            };
            if (_local_1)
            {
                pendingQueryString = _local_2;
                ApplicationGlobals.application.callLater(this.submitQuery);
            };
        }

        private function calcCRC(_arg_1:String):String
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_2:uint = 0xFFFF;
            var _local_3:int = _arg_1.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1.charCodeAt(_local_4);
                _local_6 = (_local_5 & 0xFF);
                _local_7 = (_local_5 >> 8);
                if (_local_7 != 0)
                {
                    _local_2 = updateCRC(_local_2, _local_7);
                };
                _local_2 = updateCRC(_local_2, _local_6);
                _local_4++;
            };
            _local_2 = updateCRC(_local_2, 0);
            _local_2 = updateCRC(_local_2, 0);
            return (_local_2.toString(16));
        }


    }
}//package mx.managers

import mx.core.mx_internal; 

use namespace mx_internal;

class RegistrationInfo 
{

    mx_internal static const VERSION:String = "3.5.0.12683";

    public var depth:int;
    public var crc:String;

    public function RegistrationInfo(_arg_1:String, _arg_2:int)
    {
        this.crc = _arg_1;
        this.depth = _arg_2;
    }

}


