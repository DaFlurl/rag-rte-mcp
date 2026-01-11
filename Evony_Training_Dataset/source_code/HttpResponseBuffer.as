// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.httpclient.io.HttpResponseBuffer

package org.httpclient.io
{
    import org.httpclient.HttpResponse;
    import org.httpclient.Log;
    import flash.utils.ByteArray;
    import org.httpclient.HttpHeader;
    import flash.errors.*;

    public class HttpResponseBuffer 
    {

        private var _bodyBytesRead:Number = 0;
        private var _hasResponseBody:Boolean;
        private var _onResponseData:Function;
        private var _onResponseHeader:Function;
        private var _responseHeader:HttpResponse;
        private var _isPayloadDone:Boolean = false;
        private var _onResponseComplete:Function;

        private var _buffer:HttpBuffer = new HttpBuffer();
        private var _headerData:Array = [];
        private var _responseBody:HttpBuffer = new HttpBuffer();

        public function HttpResponseBuffer(_arg_1:Boolean, _arg_2:Function, _arg_3:Function, _arg_4:Function)
        {
            this._hasResponseBody = _arg_1;
            this._onResponseHeader = _arg_2;
            this._onResponseData = _arg_3;
            this._onResponseComplete = _arg_4;
        }

        private function handlePayload(_arg_1:ByteArray):Boolean
        {
            if (this._responseHeader.isChunked)
            {
                this._responseBody.write(_arg_1);
                this._bodyBytesRead = (this._bodyBytesRead + _arg_1.length);
                return (this._responseBody.readChunks(this._onResponseData));
            };
            if (_arg_1.bytesAvailable > 0)
            {
                this._onResponseData(_arg_1);
                this._bodyBytesRead = (this._bodyBytesRead + _arg_1.length);
            };
            Log.debug(((("Bytes read (body): " + this._bodyBytesRead) + ", content length: ") + this._responseHeader.contentLength));
            return ((!(this._responseHeader.contentLength == -1)) && (this._bodyBytesRead >= this._responseHeader.contentLength));
        }

        protected function parseHeader(_arg_1:Array):HttpResponse
        {
            var _local_9:int;
            var _local_10:String;
            var _local_11:String;
            var _local_2:String = _arg_1[0];
            var _local_3:Array = _local_2.match(/\AHTTP(?:\/(\d+\.\d+))?\s+(\d\d\d)\s*(.*)\z/);
            if (!_local_3)
            {
                throw (new Error(((("Invalid header: " + _local_2) + ", matches: ") + _local_3)));
            };
            var _local_4:String = _local_3[1];
            var _local_5:String = _local_3[2];
            var _local_6:String = _local_3[3];
            var _local_7:Array = [];
            var _local_8:Number = 1;
            while (_local_8 < _arg_1.length)
            {
                _local_2 = _arg_1[_local_8];
                _local_9 = _local_2.indexOf(":");
                if (_local_9 != -1)
                {
                    _local_10 = _local_2.substring(0, _local_9);
                    _local_11 = _local_2.substring((_local_9 + 1), _local_2.length);
                    _local_7.push({
                        "name":_local_10,
                        "value":_local_11
                    });
                }
                else
                {
                    Log.warn(("Invalid header: " + _local_2));
                };
                _local_8++;
            };
            return (new HttpResponse(_local_4, _local_5, _local_6, new HttpHeader(_local_7)));
        }

        public function get header():HttpResponse
        {
            return (this._responseHeader);
        }

        public function writeBytes(_arg_1:ByteArray):void
        {
            var _local_2:String;
            var _local_3:ByteArray;
            if (this._isPayloadDone)
            {
                return;
            };
            if (!this._responseHeader)
            {
                this._buffer.write(_arg_1);
                _local_2 = this._buffer.readLine(true);
                while (_local_2 != null)
                {
                    if (_local_2 == "")
                    {
                        this._responseHeader = this.parseHeader(this._headerData);
                        Log.debug(("Response header:\n" + this._responseHeader));
                        this._onResponseHeader(this._responseHeader);
                        if (this._responseHeader.isInformation)
                        {
                            this._buffer.truncate();
                            this._responseHeader = null;
                            this._isPayloadDone = false;
                        }
                        else
                        {
                            if (this._responseHeader.code == "204")
                            {
                                this._hasResponseBody = false;
                            }
                            else
                            {
                                _local_3 = this._buffer.readAvailable();
                                Log.debug(("Response payload (from parsing header): " + _local_3.length));
                                this._isPayloadDone = this.handlePayload(_local_3);
                                break;
                            };
                        };
                    }
                    else
                    {
                        this._headerData.push(_local_2);
                    };
                    _local_2 = this._buffer.readLine(true);
                };
            }
            else
            {
                Log.debug(("Response payload: " + _arg_1.length));
                this._isPayloadDone = this.handlePayload(_arg_1);
            };
            Log.debug(((("Has response body? " + this._hasResponseBody) + "; Payload done? ") + this._isPayloadDone));
            if (((!(this._hasResponseBody)) || (this._isPayloadDone)))
            {
                this._onResponseComplete(this._responseHeader);
            };
        }


    }
}//package org.httpclient.io

