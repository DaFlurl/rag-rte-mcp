package com.as3xls.xls
{
   import com.as3xls.xls.formula.Formula;
   import flash.utils.ByteArray;
   
   public class Cell
   {
      
      public var dateMode:uint = 1;
      
      private var _formula:Formula;
      
      private var _value:*;
      
      private var _format:String;
      
      private var _note:String;
      
      public var sharedTokens:ByteArray;
      
      public function Cell()
      {
         super();
         this._value = "";
         this._note = "";
         this._format = "";
      }
      
      public function toString() : String
      {
         return this.value;
      }
      
      public function get formula() : Formula
      {
         return this._formula;
      }
      
      public function set note(param1:String) : void
      {
         this._note = param1;
      }
      
      public function get value() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Date = null;
         _loc1_ = this._formula != null ? this._formula.result : this._value;
         if(Formatter.isDate(this._format))
         {
            _loc2_ = new Date();
            _loc2_.hours = 0;
            _loc2_.minutes = 0;
            _loc2_.seconds = 0;
            _loc2_.milliseconds = 0;
            _loc2_.fullYear = this.dateMode == ExcelFile.BASE1899 ? 1899 : 1904;
            _loc2_.month = this.dateMode == ExcelFile.BASE1899 ? 11 : 0;
            _loc2_.date = this.dateMode == ExcelFile.BASE1899 ? 30 : 0;
            _loc2_.date += this._value + 1;
            _loc1_ = _loc2_;
         }
         return _loc1_;
      }
      
      public function set format(param1:String) : void
      {
         this._format = param1;
      }
      
      public function get format() : String
      {
         return this._format;
      }
      
      public function get note() : String
      {
         return this._note;
      }
      
      public function set value(param1:*) : void
      {
         this._value = param1;
      }
      
      public function set formula(param1:Formula) : void
      {
         this._formula = param1;
      }
   }
}

