// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.resources.ResourceBundle

package mx.resources
{
    import mx.core.mx_internal;
    import flash.system.ApplicationDomain;
    import mx.utils.StringUtil;

    use namespace mx_internal;

    public class ResourceBundle implements IResourceBundle 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        mx_internal static var locale:String;
        mx_internal static var backupApplicationDomain:ApplicationDomain;

        mx_internal var _locale:String;
        private var _content:Object = {};
        mx_internal var _bundleName:String;

        public function ResourceBundle(_arg_1:String=null, _arg_2:String=null)
        {
            mx_internal::_locale = _arg_1;
            mx_internal::_bundleName = _arg_2;
            _content = getContent();
        }

        private static function getClassByName(_arg_1:String, _arg_2:ApplicationDomain):Class
        {
            var _local_3:Class;
            if (_arg_2.hasDefinition(_arg_1))
            {
                _local_3 = (_arg_2.getDefinition(_arg_1) as Class);
            };
            return (_local_3);
        }

        public static function getResourceBundle(_arg_1:String, _arg_2:ApplicationDomain=null):ResourceBundle
        {
            var _local_3:String;
            var _local_4:Class;
            var _local_5:Object;
            var _local_6:ResourceBundle;
            if (!_arg_2)
            {
                _arg_2 = ApplicationDomain.currentDomain;
            };
            _local_3 = (((mx_internal::locale + "$") + _arg_1) + "_properties");
            _local_4 = getClassByName(_local_3, _arg_2);
            if (!_local_4)
            {
                _local_3 = (_arg_1 + "_properties");
                _local_4 = getClassByName(_local_3, _arg_2);
            };
            if (!_local_4)
            {
                _local_3 = _arg_1;
                _local_4 = getClassByName(_local_3, _arg_2);
            };
            if (((!(_local_4)) && (mx_internal::backupApplicationDomain)))
            {
                _local_3 = (_arg_1 + "_properties");
                _local_4 = getClassByName(_local_3, mx_internal::backupApplicationDomain);
                if (!_local_4)
                {
                    _local_3 = _arg_1;
                    _local_4 = getClassByName(_local_3, mx_internal::backupApplicationDomain);
                };
            };
            if (_local_4)
            {
                _local_5 = new (_local_4)();
                if ((_local_5 is ResourceBundle))
                {
                    _local_6 = ResourceBundle(_local_5);
                    return (_local_6);
                };
            };
            throw (new Error(("Could not find resource bundle " + _arg_1)));
        }


        protected function getContent():Object
        {
            return ({});
        }

        public function getString(_arg_1:String):String
        {
            return (String(_getObject(_arg_1)));
        }

        public function get content():Object
        {
            return (_content);
        }

        public function getBoolean(_arg_1:String, _arg_2:Boolean=true):Boolean
        {
            var _local_3:String = _getObject(_arg_1).toLowerCase();
            if (_local_3 == "false")
            {
                return (false);
            };
            if (_local_3 == "true")
            {
                return (true);
            };
            return (_arg_2);
        }

        public function getStringArray(_arg_1:String):Array
        {
            var _local_2:Array = _getObject(_arg_1).split(",");
            var _local_3:int = _local_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_2[_local_4] = StringUtil.trim(_local_2[_local_4]);
                _local_4++;
            };
            return (_local_2);
        }

        public function getObject(_arg_1:String):Object
        {
            return (_getObject(_arg_1));
        }

        private function _getObject(_arg_1:String):Object
        {
            var _local_2:Object = content[_arg_1];
            if (!_local_2)
            {
                throw (new Error(((("Key " + _arg_1) + " was not found in resource bundle ") + bundleName)));
            };
            return (_local_2);
        }

        public function get locale():String
        {
            return (mx_internal::_locale);
        }

        public function get bundleName():String
        {
            return (mx_internal::_bundleName);
        }

        public function getNumber(_arg_1:String):Number
        {
            return (Number(_getObject(_arg_1)));
        }


    }
}//package mx.resources

