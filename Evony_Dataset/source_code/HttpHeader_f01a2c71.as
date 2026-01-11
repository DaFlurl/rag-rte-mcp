// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.HttpHeader

package org.httpclient
{
    import com.adobe.utils.StringUtil;

    public class HttpHeader 
    {

        private var _headers:Array;

        public function HttpHeader(_arg_1:Array=null)
        {
            this._headers = _arg_1;
            if (!this._headers)
            {
                this._headers = [];
            };
        }

        public function get content():String
        {
            var _local_2:Object;
            var _local_1:* = "";
            for each (_local_2 in this._headers)
            {
                _local_1 = (_local_1 + (((_local_2["name"] + ": ") + _local_2["value"]) + "\r\n"));
            };
            return (_local_1);
        }

        public function add(_arg_1:String, _arg_2:String):void
        {
            this._headers.push({
                "name":_arg_1,
                "value":_arg_2
            });
        }

        public function get isEmpty():Boolean
        {
            return (this._headers.length == 0);
        }

        public function remove(_arg_1:String):void
        {
            var _local_2:int = this.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                this._headers.splice(_local_2, 1);
            };
        }

        public function get length():Number
        {
            return (this._headers.length);
        }

        public function indexOf(_arg_1:String):int
        {
            var _local_2:int;
            while (_local_2 < this._headers.length)
            {
                if (this._headers[_local_2]["name"].toLowerCase() == _arg_1.toLowerCase())
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        public function toString():String
        {
            var _local_2:Object;
            var _local_1:Array = [];
            for each (_local_2 in this._headers)
            {
                _local_1.push(((_local_2["name"] + ": ") + _local_2["value"]));
            };
            return (_local_1.join("\n"));
        }

        public function get cookies():String
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_1:* = "";
            for each (_local_3 in this._headers)
            {
                if (_local_3["name"].toLowerCase() == "set-cookie")
                {
                    if (_local_1 != "")
                    {
                        _local_1 = (_local_1 + "; ");
                    };
                    _local_2 = _local_3["value"].split(";")[0];
                    _local_1 = (_local_1 + _local_2);
                };
            };
            return (_local_1);
        }

        public function replace(_arg_1:String, _arg_2:String):void
        {
            if (_arg_2 == null)
            {
                this.remove(_arg_1);
                return;
            };
            var _local_3:Object = this.find(_arg_1);
            if (_local_3)
            {
                _local_3["value"] = _arg_2;
            }
            else
            {
                this.add(_arg_1, _arg_2);
            };
        }

        public function find(_arg_1:String):Object
        {
            var _local_2:int = this.indexOf(_arg_1);
            if (_local_2 != -1)
            {
                return (this._headers[_local_2]);
            };
            return (null);
        }

        public function getValue(_arg_1:String):String
        {
            var _local_2:Object = this.find(_arg_1);
            if (_local_2)
            {
                return (_local_2["value"]);
            };
            return (null);
        }

        public function contains(_arg_1:String, _arg_2:String):Boolean
        {
            var _local_3:Object = this.find(_arg_1);
            if (!_local_3)
            {
                return (false);
            };
            return (StringUtil.trim(_local_3["value"].toLowerCase()) == _arg_2.toLowerCase());
        }


    }
}//package org.httpclient

