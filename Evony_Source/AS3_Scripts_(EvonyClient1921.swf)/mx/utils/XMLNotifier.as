// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.XMLNotifier

package mx.utils
{
    import flash.utils.Dictionary;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class XMLNotifier 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var instance:XMLNotifier;

        public function XMLNotifier(_arg_1:XMLNotifierSingleton)
        {
        }

        public static function getInstance():XMLNotifier
        {
            if (!instance)
            {
                instance = new XMLNotifier(new XMLNotifierSingleton());
            };
            return (instance);
        }

        mx_internal static function initializeXMLForNotification():Function
        {
            var notificationFunction:Function = function (_arg_1:Object, _arg_2:String, _arg_3:Object, _arg_4:Object, _arg_5:Object):void
            {
                var _local_8:Object;
                var _local_7:Dictionary = arguments.callee.watched;
                if (_local_7 != null)
                {
                    for (_local_8 in _local_7)
                    {
                        IXMLNotifiable(_local_8).xmlNotification(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
                    };
                };
            };
            return (notificationFunction);
        }


        public function watchXML(_arg_1:Object, _arg_2:IXMLNotifiable, _arg_3:String=null):void
        {
            var _local_6:Dictionary;
            var _local_4:XML = XML(_arg_1);
            var _local_5:Object = _local_4.notification();
            if (!(_local_5 is Function))
            {
                _local_5 = initializeXMLForNotification();
                _local_4.setNotification((_local_5 as Function));
                if (((_arg_3) && (_local_5["uid"] == null)))
                {
                    _local_5["uid"] = _arg_3;
                };
            };
            if (_local_5["watched"] == undefined)
            {
                _local_5["watched"] = (_local_6 = new Dictionary(true));
            }
            else
            {
                _local_6 = _local_5["watched"];
            };
            _local_6[_arg_2] = true;
        }

        public function unwatchXML(_arg_1:Object, _arg_2:IXMLNotifiable):void
        {
            var _local_5:Dictionary;
            var _local_3:XML = XML(_arg_1);
            var _local_4:Object = _local_3.notification();
            if (!(_local_4 is Function))
            {
                return;
            };
            if (_local_4["watched"] != undefined)
            {
                _local_5 = _local_4["watched"];
                delete _local_5[_arg_2];
            };
        }


    }
}//package mx.utils

class XMLNotifierSingleton 
{


}


