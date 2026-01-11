// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.XMLUtil

package mx.utils
{
    import flash.xml.XMLDocument;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class XMLUtil 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function createXMLDocument(_arg_1:String):XMLDocument
        {
            var _local_2:XMLDocument = new XMLDocument();
            _local_2.ignoreWhite = true;
            _local_2.parseXML(_arg_1);
            return (_local_2);
        }

        public static function qnamesEqual(_arg_1:QName, _arg_2:QName):Boolean
        {
            return ((_arg_1.uri == _arg_2.uri) && (_arg_1.localName == _arg_2.localName));
        }

        public static function getAttributeByQName(_arg_1:XML, _arg_2:QName):XMLList
        {
            var _local_4:XML;
            var _local_5:QName;
            var _local_3:XMLList = _arg_1.attribute(_arg_2);
            for each (_local_4 in _local_3)
            {
                _local_5 = _local_4.name();
                if (_local_5.uri == _arg_2.uri)
                {
                    return (new XMLList(_local_4));
                };
            };
            return (new XMLList());
        }

        public static function qnameToString(_arg_1:QName):String
        {
            return (((_arg_1.uri) && (!(_arg_1.uri == ""))) ? ((_arg_1.uri + ":") + _arg_1.localName) : _arg_1.localName);
        }


    }
}//package mx.utils

