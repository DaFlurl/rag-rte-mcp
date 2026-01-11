// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.utilities.external.LoadingLocation

package com.degrafa.utilities.external
{
    import flash.system.Security;
    import mx.core.Application;
    import mx.utils.NameUtil;

    public class LoadingLocation 
    {

        private var _policyFile:String = null;
        private var _basepath:String = null;
        private var _id:String;
        private var _requestedPolicyFile:Boolean = false;

        public function LoadingLocation(_arg_1:String=null, _arg_2:String=null):void
        {
            if (_arg_1 != null)
            {
                _basepath = _arg_1;
                _policyFile = _arg_2;
            };
        }

        private static function requiresPolicyFile():Boolean
        {
            var _local_1:Boolean;
            switch (Security.sandboxType)
            {
                case "application":
                    _local_1 = false;
                    break;
                case Security.REMOTE:
                case Security.LOCAL_TRUSTED:
                case Security.LOCAL_WITH_NETWORK:
                    _local_1 = true;
                    break;
                case Security.LOCAL_WITH_FILE:
                    trace("this swf cannot communicate with the internet");
                    _local_1 = false;
                    break;
            };
            return (_local_1);
        }

        public static function extractLocation(_arg_1:String=null):Object
        {
            var _local_3:Array;
            if (((_arg_1 == null) || (_arg_1.indexOf("//") == -1)))
            {
                _arg_1 = Application.application.url;
            };
            var _local_2:Object = {};
            if (_arg_1.indexOf("///") != -1)
            {
                _local_3 = _arg_1.split("///");
                _local_3[1] = ("/" + _local_3[1]);
            }
            else
            {
                _local_3 = _arg_1.split("//");
            };
            _local_2.protocol = (_local_3.shift() + "//");
            _local_3 = _local_3[0].split("/");
            _local_2.domain = _local_3.shift();
            if (_local_3[(_local_3.length - 1)] != "")
            {
                _local_3[(_local_3.length - 1)] = "";
            };
            _local_2.basepath = ("/" + _local_3.join("/"));
            return (_local_2);
        }


        public function get requestedPolicyFile():Boolean
        {
            return (_requestedPolicyFile);
        }

        public function requestPolicyFile():void
        {
            var _local_1:Object;
            if (((!(_requestedPolicyFile)) && (LoadingLocation.requiresPolicyFile())))
            {
                if (_basepath)
                {
                    if (_policyFile == null)
                    {
                        _local_1 = LoadingLocation.extractLocation(_basepath);
                        _policyFile = ((_local_1.protocol + _local_1.domain) + "/crossdomain.xml");
                    };
                    Security.loadPolicyFile(_policyFile);
                    _requestedPolicyFile = true;
                }
                else
                {
                    _local_1 = LoadingLocation.extractLocation(Application.application.url);
                    _basepath = ((_local_1.protocol + _local_1.domain) + _local_1.basepath);
                    _requestedPolicyFile = true;
                };
            };
        }

        public function get basePath():String
        {
            return (_basepath);
        }

        public function get policyFile():String
        {
            return (_policyFile);
        }

        public function get name():String
        {
            return (id);
        }

        public function toString():String
        {
            return (("[LoadingLocation " + _basepath) + "]");
        }

        public function set basePath(_arg_1:String):void
        {
            _basepath = _arg_1;
        }

        public function set id(_arg_1:String):void
        {
            _id = _arg_1;
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

        public function set policyFile(_arg_1:String):void
        {
            _policyFile = _arg_1;
        }


    }
}//package com.degrafa.utilities.external

