package org.httpclient.io
{
   import flash.errors.*;
   import flash.utils.ByteArray;
   import org.httpclient.HttpHeader;
   import org.httpclient.HttpResponse;
   import org.httpclient.Log;
   
   public class HttpResponseBuffer
   {
      
      private var _bodyBytesRead:Number = 0;
      
      private var _responseBody:HttpBuffer = new HttpBuffer();
      
      private var _hasResponseBody:Boolean;
      
      private var _onResponseData:Function;
      
      private var _onResponseHeader:Function;
      
      private var _responseHeader:HttpResponse;
      
      private var _isPayloadDone:Boolean = false;
      
      private var _onResponseComplete:Function;
      
      private var _headerData:Array = [];
      
      private var _buffer:HttpBuffer = new HttpBuffer();
      
      public function HttpResponseBuffer(param1:Boolean, param2:Function, param3:Function, param4:Function)
      {
         super();
         this._hasResponseBody = param1;
         this._onResponseHeader = param2;
         this._onResponseData = param3;
         this._onResponseComplete = param4;
      }
      
      private function handlePayload(param1:ByteArray) : Boolean
      {
         if(this._responseHeader.isChunked)
         {
            this._responseBody.write(param1);
            this._bodyBytesRead += param1.length;
            return this._responseBody.readChunks(this._onResponseData);
         }
         if(param1.bytesAvailable > 0)
         {
            this._onResponseData(param1);
            this._bodyBytesRead += param1.length;
         }
         Log.debug("Bytes read (body): " + this._bodyBytesRead + ", content length: " + this._responseHeader.contentLength);
         return this._responseHeader.contentLength != -1 && this._bodyBytesRead >= this._responseHeader.contentLength;
      }
      
      protected function parseHeader(param1:Array) : HttpResponse
      {
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc2_:String = param1[0];
         var _loc3_:Array = _loc2_.match(/\AHTTP(?:\/(\d+\.\d+))?\s+(\d\d\d)\s*(.*)\z/);
         if(!_loc3_)
         {
            throw new Error("Invalid header: " + _loc2_ + ", matches: " + _loc3_);
         }
         var _loc4_:String = _loc3_[1];
         var _loc5_:String = _loc3_[2];
         var _loc6_:String = _loc3_[3];
         var _loc7_:Array = [];
         var _loc8_:Number = 1;
         while(_loc8_ < param1.length)
         {
            _loc2_ = param1[_loc8_];
            _loc9_ = int(_loc2_.indexOf(":"));
            if(_loc9_ != -1)
            {
               _loc10_ = _loc2_.substring(0,_loc9_);
               _loc11_ = _loc2_.substring(_loc9_ + 1,_loc2_.length);
               _loc7_.push({
                  "name":_loc10_,
                  "value":_loc11_
               });
            }
            else
            {
               Log.warn("Invalid header: " + _loc2_);
            }
            _loc8_++;
         }
         return new HttpResponse(_loc4_,_loc5_,_loc6_,new HttpHeader(_loc7_));
      }
      
      public function get header() : HttpResponse
      {
         return this._responseHeader;
      }
      
      public function writeBytes(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         if(this._isPayloadDone)
         {
            return;
         }
         if(!this._responseHeader)
         {
            this._buffer.write(param1);
            _loc2_ = this._buffer.readLine(true);
            while(_loc2_ != null)
            {
               if(_loc2_ == "")
               {
                  this._responseHeader = this.parseHeader(this._headerData);
                  Log.debug("Response header:\n" + this._responseHeader);
                  this._onResponseHeader(this._responseHeader);
                  if(this._responseHeader.isInformation)
                  {
                     this._buffer.truncate();
                     this._responseHeader = null;
                     this._isPayloadDone = false;
                  }
                  else
                  {
                     if(this._responseHeader.code != "204")
                     {
                        _loc3_ = this._buffer.readAvailable();
                        Log.debug("Response payload (from parsing header): " + _loc3_.length);
                        this._isPayloadDone = this.handlePayload(_loc3_);
                        break;
                     }
                     this._hasResponseBody = false;
                  }
               }
               else
               {
                  this._headerData.push(_loc2_);
               }
               _loc2_ = this._buffer.readLine(true);
            }
         }
         else
         {
            Log.debug("Response payload: " + param1.length);
            this._isPayloadDone = this.handlePayload(param1);
         }
         Log.debug("Has response body? " + this._hasResponseBody + "; Payload done? " + this._isPayloadDone);
         if(!this._hasResponseBody || this._isPayloadDone)
         {
            this._onResponseComplete(this._responseHeader);
         }
      }
   }
}

