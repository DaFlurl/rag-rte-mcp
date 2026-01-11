package org.httpclient.http.multipart
{
   import flash.utils.ByteArray;
   
   public class Multipart
   {
      public static const BOUNDARY:String = "----------------314159265358979323846";
      
      private static const BOUNDARY_CHARS:String = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      private var _partIndex:int = 0;
      
      private var _parts:Array = [];
      
      private var _bytesSent:uint = 0;
      
      private var _footerSent:Boolean = false;
      
      private var _footer:ByteArray;
      
      public function Multipart(param1:Array)
      {
         super();
         this._parts = param1;
         this._footer = this.footer();
      }
      
      private static function generateBoundary() : String
      {
         var _loc4_:Number = NaN;
         var _loc1_:Number = Math.round(Math.random() * 10) * 30;
         var _loc2_:String = "";
         var _loc3_:Number = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = Math.round(Math.random() * (BOUNDARY_CHARS.length - 1));
            _loc2_ += BOUNDARY_CHARS.charAt(_loc4_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get length() : uint
      {
         var _loc2_:Part = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this._parts)
         {
            _loc1_ += _loc2_.length;
         }
         return _loc1_ + this._footer.length;
      }
      
      public function get currentPart() : Part
      {
         if(!this.hasMoreParts)
         {
            return null;
         }
         return Part(this._parts[this._partIndex]);
      }
      
      protected function get hasMoreParts() : Boolean
      {
         return this._partIndex < this._parts.length;
      }
      
      public function readBytes(param1:ByteArray, param2:uint, param3:uint) : void
      {
         if(!this.hasMoreParts)
         {
            if(!this._footerSent)
            {
               this._footer.readBytes(param1,param2,param3);
               this._footerSent = true;
            }
            return;
         }
         this.currentPart.readBytes(param1,param2,param3);
         this._bytesSent += param1.length;
         if(this._bytesSent >= this.currentPart.length)
         {
            this.currentPart.close();
            this._partIndex += 1;
            this._bytesSent = 0;
         }
      }
      
      protected function footer() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUTFBytes("--" + Multipart.BOUNDARY + "--\r\n");
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function get bytesAvailable() : uint
      {
         if(this.hasMoreParts)
         {
            return this.currentPart.bytesAvailable;
         }
         if(!this._footerSent)
         {
            return this._footer.bytesAvailable;
         }
         return 0;
      }
   }
}

