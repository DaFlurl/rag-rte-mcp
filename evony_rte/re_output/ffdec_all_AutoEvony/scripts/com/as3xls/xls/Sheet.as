package com.as3xls.xls
{
   import com.as3xls.xls.formula.Formula;
   import mx.collections.ArrayCollection;
   
   public class Sheet
   {
      
      private var _values:ArrayCollection;
      
      private var _xformats:Array;
      
      private var _footer:String;
      
      private var _dateMode:uint;
      
      private var _cols:uint;
      
      private var _formats:Array;
      
      private var _name:String;
      
      private var _header:String;
      
      private var _rows:uint;
      
      public function Sheet()
      {
         super();
         this._formats = new Array();
         this._xformats = new Array();
         this._values = new ArrayCollection();
         this._header = "";
         this._footer = "";
      }
      
      public function set xformats(param1:Array) : void
      {
         this._xformats = param1;
      }
      
      public function get cols() : uint
      {
         return this._cols;
      }
      
      public function get header() : String
      {
         return this._header;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function getCell(param1:uint, param2:uint) : Cell
      {
         if(!(this._values[param1][param2] is Cell))
         {
            this._values[param1][param2] = new Cell();
            this._values[param1][param2].dateMode = this._dateMode;
         }
         return this._values[param1][param2];
      }
      
      public function get rows() : uint
      {
         return this._rows;
      }
      
      public function set header(param1:String) : void
      {
         this._header = param1;
      }
      
      public function get footer() : String
      {
         return this._footer;
      }
      
      public function get formats() : Array
      {
         return this._formats;
      }
      
      public function get values() : ArrayCollection
      {
         return this._values;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set dateMode(param1:uint) : void
      {
         var _loc3_:uint = 0;
         this._dateMode = param1;
         var _loc2_:uint = 0;
         while(_loc2_ < this._values.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this._values[_loc2_].length)
            {
               this._values[_loc2_][_loc3_].dateMode = this._dateMode;
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function setCell(param1:uint, param2:uint, param3:*) : void
      {
         if(!(this._values[param1][param2] is Cell))
         {
            this._values[param1][param2] = new Cell();
         }
         if(param3 is Formula)
         {
            (this._values[param1][param2] as Cell).formula = param3;
         }
         else
         {
            (this._values[param1][param2] as Cell).value = param3;
         }
      }
      
      public function get dateMode() : uint
      {
         return this._dateMode;
      }
      
      public function set footer(param1:String) : void
      {
         this._footer = param1;
      }
      
      public function set formats(param1:Array) : void
      {
         this._formats = param1;
      }
      
      public function resize(param1:uint, param2:uint) : void
      {
         var _loc4_:uint = 0;
         this._rows = Math.max(param1,this._rows);
         this._cols = Math.max(param2,this._cols);
         while(this._values.length <= this._rows)
         {
            this._values.addItem(new Array());
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._values.length)
         {
            _loc4_ = 0;
            while(_loc4_ < this._cols)
            {
               this._values[_loc3_][_loc4_] = new Cell();
               this._values[_loc3_][_loc4_].dateMode = this._dateMode;
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function get xformats() : Array
      {
         return this._xformats;
      }
   }
}

