package com.as3xls.xls.style
{
   public class XFormat
   {
      
      private var _format:uint;
      
      private var _type:uint;
      
      public function XFormat(param1:uint, param2:uint)
      {
         super();
         this._type = param1;
         this._format = param2;
      }
      
      public function get format() : uint
      {
         return this._format;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
   }
}

