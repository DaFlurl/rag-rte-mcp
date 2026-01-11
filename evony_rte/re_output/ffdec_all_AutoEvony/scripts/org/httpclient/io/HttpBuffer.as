package org.httpclient.io
{
   import com.adobe.utils.StringUtil;
   import flash.utils.ByteArray;
   import org.httpclient.Log;
   
   public class HttpBuffer
   {
      
      protected var _data:ByteArray = new ByteArray();
      
      protected var _chunkLength:uint = 0;
      
      protected var _cursor:uint = 0;
      
      public function HttpBuffer()
      {
         super();
      }
      
      public function truncate() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         if(this._data.bytesAvailable)
         {
            this._data.readBytes(_loc1_);
         }
         this._data = _loc1_;
         this._cursor = 0;
      }
      
      public function readLine(param1:Boolean = false) : String
      {
         var _loc6_:int = 0;
         if(this._data.bytesAvailable == 0)
         {
            return null;
         }
         var _loc2_:uint = this._data.position;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Boolean = false;
         while(this._data.bytesAvailable > 0)
         {
            _loc6_ = this._data.readByte();
            _loc3_.writeByte(_loc6_);
            if(_loc6_ == 10)
            {
               _loc4_ = true;
               break;
            }
         }
         var _loc5_:String = null;
         if(_loc4_)
         {
            _loc3_.position = 0;
            _loc5_ = _loc3_.readUTFBytes(_loc3_.length);
            this._cursor = this._data.position;
            return param1 ? StringUtil.rtrim(_loc5_) : _loc5_;
         }
         this._data.position = this._cursor;
         return null;
      }
      
      public function read(param1:ByteArray) : void
      {
         this._data.readBytes(param1);
         this._cursor = this._data.position;
      }
      
      public function readAvailable() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         this.read(_loc1_);
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function readChunks(param1:Function) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:ByteArray = null;
         while(this._data.bytesAvailable > 0)
         {
            if(this._chunkLength == 0)
            {
               _loc2_ = this.readLine();
               if(!_loc2_)
               {
                  throw new Error("No data available");
               }
               _loc3_ = _loc2_.match(/\A([0-9a-fA-F]+).*/);
               if(!_loc3_)
               {
                  throw new Error("Invalid chunk; trying to find chunk length at line: " + _loc2_);
               }
               _loc4_ = _loc3_[1];
               _loc5_ = parseInt(_loc4_,16);
               Log.debug("Chunk size: " + _loc5_);
               if(_loc5_ <= 0)
               {
                  return true;
               }
               this._chunkLength = _loc5_;
            }
            if(this._data.bytesAvailable < this._chunkLength + 2)
            {
               this.truncate();
               return false;
            }
            _loc6_ = new ByteArray();
            this._data.readBytes(_loc6_,0,this._chunkLength);
            Log.debug("Read chunk size: " + this._chunkLength);
            this._data.position += 2;
            this._cursor = this._data.position;
            this._chunkLength = 0;
            param1(_loc6_);
         }
         return false;
      }
      
      public function get bytesAvailable() : uint
      {
         return this._data.bytesAvailable;
      }
      
      public function write(param1:ByteArray) : void
      {
         this._data.position = this._data.length;
         this._data.writeBytes(param1);
         this._data.position = this._cursor;
      }
   }
}

