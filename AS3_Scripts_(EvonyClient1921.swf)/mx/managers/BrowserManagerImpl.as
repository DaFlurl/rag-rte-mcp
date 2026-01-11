// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.BrowserManagerImpl

package mx.managers
{
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.display.Stage;
    import flash.external.ExternalInterface;
    import mx.events.BrowserChangeEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import mx.core.ApplicationGlobals;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BrowserManagerImpl extends EventDispatcher implements IBrowserManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var instance:IBrowserManager;

        private var _title:String;
        private var _isFirefoxMac:Boolean;
        private var browserMode:Boolean = true;
        private var _fragment:String;
        private var _base:String;
        private var _browserUserAgent:String;
        private var _url:String;
        private var _defaultFragment:String = "";
        private var _browserPlatform:String;

        public function BrowserManagerImpl()
        {
            var sandboxRoot:Object;
            var parent:Object;
            super();
            var systemManager:Object = SystemManagerGlobals.topLevelSystemManagers;
            if (systemManager)
            {
                systemManager = systemManager[0];
            };
            if (systemManager)
            {
                sandboxRoot = systemManager.getSandboxRoot();
                if (!sandboxRoot.dispatchEvent(new Event("mx.managers::BrowserManager", false, true)))
                {
                    browserMode = false;
                    return;
                };
                try
                {
                    parent = sandboxRoot.parent;
                    while (parent)
                    {
                        if ((sandboxRoot.parent is Stage)) break;
                        parent = parent.parent;
                    };
                }
                catch(e:Error)
                {
                    browserMode = false;
                    return;
                };
                sandboxRoot.addEventListener("mx.managers::BrowserManager", sandboxBrowserManagerHandler, false, 0, true);
            };
            try
            {
                ExternalInterface.addCallback("browserURLChange", browserURLChangeBrowser);
                ExternalInterface.addCallback("debugTrace", debugTrace);
            }
            catch(e:Error)
            {
                browserMode = false;
            };
        }

        public static function getInstance():IBrowserManager
        {
            if (!instance)
            {
                instance = new (BrowserManagerImpl)();
            };
            return (instance);
        }


        public function initForHistoryManager():void
        {
            setup("", "");
        }

        private function setup(_arg_1:String, _arg_2:String):void
        {
            if (!browserMode)
            {
                return;
            };
            _defaultFragment = _arg_1;
            _url = ExternalInterface.call("BrowserHistory.getURL");
            if (!_url)
            {
                browserMode = false;
                return;
            };
            _browserUserAgent = ExternalInterface.call("BrowserHistory.getUserAgent");
            _browserPlatform = ExternalInterface.call("BrowserHistory.getPlatform");
            _isFirefoxMac = ((((_browserUserAgent) && (_browserPlatform)) && (_browserUserAgent.indexOf("Firefox") > -1)) && (_browserPlatform.indexOf("Mac") > -1));
            var _local_3:int = _url.indexOf("#");
            if (((_local_3 == -1) || (_local_3 == (_url.length - 1))))
            {
                _base = _url;
                _fragment = "";
                _title = _arg_2;
                ExternalInterface.call("BrowserHistory.setDefaultURL", _arg_1);
                setTitle(_arg_2);
            }
            else
            {
                _base = _url.substring(0, _local_3);
                _fragment = _url.substring((_local_3 + 1));
                _title = ExternalInterface.call("BrowserHistory.getTitle");
                ExternalInterface.call("BrowserHistory.setDefaultURL", _fragment);
                if (_fragment != _defaultFragment)
                {
                    browserURLChange(_fragment, true);
                };
            };
        }

        private function browserURLChange(_arg_1:String, _arg_2:Boolean=false):void
        {
            var _local_3:String;
            if ((((!(_arg_1 == null)) && (!(decodeURI(_fragment) == decodeURI(_arg_1)))) || (_arg_2)))
            {
                _fragment = _arg_1;
                _local_3 = url;
                _url = ((_base + "#") + _arg_1);
                dispatchEvent(new BrowserChangeEvent(BrowserChangeEvent.BROWSER_URL_CHANGE, false, false, url, _local_3));
                dispatchEvent(new BrowserChangeEvent(BrowserChangeEvent.URL_CHANGE, false, false, url, _local_3));
            };
        }

        [Bindable("urlChange")]
        public function get base():String
        {
            return (_base);
        }

        public function setFragment(_arg_1:String):void
        {
            var _local_4:URLRequest;
            if (!browserMode)
            {
                return;
            };
            var _local_2:String = _url;
            var _local_3:String = _fragment;
            _url = ((base + "#") + _arg_1);
            _fragment = _arg_1;
            if (dispatchEvent(new BrowserChangeEvent(BrowserChangeEvent.APPLICATION_URL_CHANGE, false, true, _url, _local_2)))
            {
                if (!_isFirefoxMac)
                {
                    ExternalInterface.call("BrowserHistory.setBrowserURL", _arg_1, ExternalInterface.objectID);
                }
                else
                {
                    _local_4 = new URLRequest((((("javascript:BrowserHistory.setBrowserURL('" + _arg_1) + "','") + ExternalInterface.objectID) + "');"));
                    navigateToURL(_local_4, "_self");
                };
                dispatchEvent(new BrowserChangeEvent(BrowserChangeEvent.URL_CHANGE, false, false, _url, _local_2));
            }
            else
            {
                _fragment = _local_3;
                _url = _local_2;
            };
        }

        private function debugTrace(_arg_1:String):void
        {
            trace(_arg_1);
        }

        [Bindable("urlChange")]
        public function get fragment():String
        {
            if (((_fragment) && (_fragment.length)))
            {
                return (_fragment);
            };
            return (_defaultFragment);
        }

        [Bindable("urlChange")]
        public function get title():String
        {
            return (_title);
        }

        public function setTitle(_arg_1:String):void
        {
            if (!browserMode)
            {
                return;
            };
            ExternalInterface.call("BrowserHistory.setTitle", _arg_1);
            _title = ExternalInterface.call("BrowserHistory.getTitle");
        }

        public function init(_arg_1:String="", _arg_2:String=""):void
        {
            ApplicationGlobals.application.historyManagementEnabled = false;
            setup(_arg_1, _arg_2);
        }

        private function sandboxBrowserManagerHandler(_arg_1:Event):void
        {
            _arg_1.preventDefault();
        }

        private function browserURLChangeBrowser(_arg_1:String):void
        {
            browserURLChange(_arg_1, false);
        }

        [Bindable("urlChange")]
        public function get url():String
        {
            return (_url);
        }


    }
}//package mx.managers

