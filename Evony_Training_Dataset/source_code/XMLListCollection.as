// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.collections.XMLListCollection

package mx.collections
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class XMLListCollection extends ListCollectionView 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";

        public function XMLListCollection(_arg_1:XMLList=null)
        {
            this.source = _arg_1;
        }

        public function child(propertyName:Object):XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.child(propertyName));
            }));
        }

        private function execXMLListFunction(_arg_1:Function):XMLList
        {
            var _local_2:int;
            var _local_3:XMLList;
            var _local_4:int;
            var _local_5:Object;
            if (!localIndex)
            {
                return (_arg_1(source));
            };
            _local_2 = localIndex.length;
            _local_3 = new (XMLList)("");
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_5 = localIndex[_local_4];
                _local_3 = (_local_3 + _arg_1(_local_5));
                _local_4++;
            };
            return (_local_3);
        }

        override public function toString():String
        {
            var _local_1:String;
            var _local_2:int;
            if (!localIndex)
            {
                return (source.toString());
            };
            _local_1 = "";
            _local_2 = 0;
            while (_local_2 < localIndex.length)
            {
                if (_local_2 > 0)
                {
                    _local_1 = (_local_1 + "\n");
                };
                _local_1 = (_local_1 + localIndex[_local_2].toString());
                _local_2++;
            };
            return (_local_1);
        }

        public function text():XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.text());
            }));
        }

        public function toXMLString():String
        {
            var _local_1:String;
            var _local_2:int;
            if (!localIndex)
            {
                return (source.toXMLString());
            };
            _local_1 = "";
            _local_2 = 0;
            while (_local_2 < localIndex.length)
            {
                if (_local_2 > 0)
                {
                    _local_1 = (_local_1 + "\n");
                };
                _local_1 = (_local_1 + localIndex[_local_2].toXMLString());
                _local_2++;
            };
            return (_local_1);
        }

        public function copy():XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (XMLList(_arg_1.copy()));
            }));
        }

        public function set source(_arg_1:XMLList):void
        {
            if (list)
            {
                XMLListAdapter(list).source = null;
            };
            list = new XMLListAdapter(_arg_1);
        }

        public function attributes():XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.attributes());
            }));
        }

        [Bindable("listChanged")]
        public function get source():XMLList
        {
            return ((list) ? XMLListAdapter(list).source : null);
        }

        public function attribute(attributeName:Object):XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.attribute(attributeName));
            }));
        }

        public function descendants(name:Object="*"):XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.descendants(name));
            }));
        }

        public function elements(name:String="*"):XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.elements(name));
            }));
        }

        public function children():XMLList
        {
            return (execXMLListFunction(function (_arg_1:Object):XMLList
            {
                return (_arg_1.children());
            }));
        }


    }
}//package mx.collections

