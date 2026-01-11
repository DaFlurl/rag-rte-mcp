// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.Cell

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
            this._value = "";
            this._note = "";
            this._format = "";
        }

        public function toString():String
        {
            return (this.value);
        }

        public function get formula():Formula
        {
            return (this._formula);
        }

        public function set note(_arg_1:String):void
        {
            this._note = _arg_1;
        }

        public function get value():*
        {
            var _local_1:*;
            var _local_2:Date;
            _local_1 = ((this._formula != null) ? this._formula.result : this._value);
            if (Formatter.isDate(this._format))
            {
                _local_2 = new Date();
                _local_2.hours = 0;
                _local_2.minutes = 0;
                _local_2.seconds = 0;
                _local_2.milliseconds = 0;
                _local_2.fullYear = ((this.dateMode == ExcelFile.BASE1899) ? 1899 : 1904);
                _local_2.month = ((this.dateMode == ExcelFile.BASE1899) ? 11 : 0);
                _local_2.date = ((this.dateMode == ExcelFile.BASE1899) ? 30 : 0);
                _local_2.date = (_local_2.date + (this._value + 1));
                _local_1 = _local_2;
            };
            return (_local_1);
        }

        public function set format(_arg_1:String):void
        {
            this._format = _arg_1;
        }

        public function get format():String
        {
            return (this._format);
        }

        public function get note():String
        {
            return (this._note);
        }

        public function set value(_arg_1:*):void
        {
            this._value = _arg_1;
        }

        public function set formula(_arg_1:Formula):void
        {
            this._formula = _arg_1;
        }


    }
}//package com.as3xls.xls

