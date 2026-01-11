// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.Sheet

package com.as3xls.xls
{
    import mx.collections.ArrayCollection;
    import com.as3xls.xls.formula.Formula;

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
            this._formats = new Array();
            this._xformats = new Array();
            this._values = new ArrayCollection();
            this._header = "";
            this._footer = "";
        }

        public function set xformats(_arg_1:Array):void
        {
            this._xformats = _arg_1;
        }

        public function get cols():uint
        {
            return (this._cols);
        }

        public function get header():String
        {
            return (this._header);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function getCell(_arg_1:uint, _arg_2:uint):Cell
        {
            if (!(this._values[_arg_1][_arg_2] is Cell))
            {
                this._values[_arg_1][_arg_2] = new Cell();
                this._values[_arg_1][_arg_2].dateMode = this._dateMode;
            };
            return (this._values[_arg_1][_arg_2]);
        }

        public function get rows():uint
        {
            return (this._rows);
        }

        public function set header(_arg_1:String):void
        {
            this._header = _arg_1;
        }

        public function get footer():String
        {
            return (this._footer);
        }

        public function get formats():Array
        {
            return (this._formats);
        }

        public function get values():ArrayCollection
        {
            return (this._values);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set dateMode(_arg_1:uint):void
        {
            var _local_3:uint;
            this._dateMode = _arg_1;
            var _local_2:uint;
            while (_local_2 < this._values.length)
            {
                _local_3 = 0;
                while (_local_3 < this._values[_local_2].length)
                {
                    this._values[_local_2][_local_3].dateMode = this._dateMode;
                    _local_3++;
                };
                _local_2++;
            };
        }

        public function setCell(_arg_1:uint, _arg_2:uint, _arg_3:*):void
        {
            if (!(this._values[_arg_1][_arg_2] is Cell))
            {
                this._values[_arg_1][_arg_2] = new Cell();
            };
            if ((_arg_3 is Formula))
            {
                (this._values[_arg_1][_arg_2] as Cell).formula = _arg_3;
            }
            else
            {
                (this._values[_arg_1][_arg_2] as Cell).value = _arg_3;
            };
        }

        public function get dateMode():uint
        {
            return (this._dateMode);
        }

        public function set footer(_arg_1:String):void
        {
            this._footer = _arg_1;
        }

        public function set formats(_arg_1:Array):void
        {
            this._formats = _arg_1;
        }

        public function resize(_arg_1:uint, _arg_2:uint):void
        {
            var _local_4:uint;
            this._rows = Math.max(_arg_1, this._rows);
            this._cols = Math.max(_arg_2, this._cols);
            while (this._values.length <= this._rows)
            {
                this._values.addItem(new Array());
            };
            var _local_3:uint;
            while (_local_3 < this._values.length)
            {
                _local_4 = 0;
                while (_local_4 < this._cols)
                {
                    this._values[_local_3][_local_4] = new Cell();
                    this._values[_local_3][_local_4].dateMode = this._dateMode;
                    _local_4++;
                };
                _local_3++;
            };
        }

        public function get xformats():Array
        {
            return (this._xformats);
        }


    }
}//package com.as3xls.xls

