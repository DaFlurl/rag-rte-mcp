// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.as3xls.xls.ExcelFile

package com.as3xls.xls
{
    import com.as3xls.biff.BIFFReader;
    import mx.collections.ArrayCollection;
    import com.as3xls.biff.Record;
    import com.as3xls.biff.BIFFWriter;
    import com.as3xls.biff.BIFFVersion;
    import flash.utils.ByteArray;
    import com.as3xls.xls.formula.Formula;
    import com.as3xls.cdf.CDFReader;
    import flash.utils.Endian;
    import com.as3xls.xls.style.XFormat;

    public class ExcelFile 
    {

        public static const BASE1899:uint = 0;
        public static const BASE1904:uint = 1;
        public static const GLOBALS:uint = 5;
        public static const SHEET:uint = 16;
        private static const ignore:Array = [77, 225, 192, 193, 225, 226, 93, 156, 191, 235, 238, 241, 317, 431, 438, 439, 444, 448, 449, 450, 2147, 2248, 4188];

        private var br:BIFFReader;
        private var _sst:Array;
        private var lastRecordType:uint;
        private var currentSheet:Sheet;
        private var currentFileType:uint;
        private var dateMode:uint;
        private var currentSheetIdx:uint = 0;
        private var notes:Array;
        private var version:uint;

        private var globalFormats:Array = new Array();
        private var globalXFormats:Array = new Array();
        private var _sheets:ArrayCollection = new ArrayCollection();
        private const handlers:Array = ExcelFile.initHandlers();


        private function writeaccess(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedByte();
            var _local_4:String = _arg_1.data.readUTFBytes(_local_3);
        }

        private function eof(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function mulblank(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:uint;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            while (_arg_1.data.bytesAvailable > 2)
            {
                _local_5 = _arg_1.data.readUnsignedShort();
                _arg_2.setCell(_local_3, _local_4, "");
                _local_4++;
            };
        }

        private function string(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function sst(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_6:String;
            var _local_3:uint = _arg_1.data.readUnsignedInt();
            var _local_4:uint = _arg_1.data.readUnsignedInt();
            this._sst = new Array();
            var _local_5:uint;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_1.readUnicodeStr16();
                this._sst.push(_local_6);
                _local_5++;
            };
        }

        private function gcw(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function defrowheight(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readUnsignedShort();
        }

        private function columndefault(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function ixfe(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function tableop(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function externname(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function efont(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function colinfo(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        public function saveToByteArray():ByteArray
        {
            var _local_11:Record;
            var _local_12:uint;
            var _local_13:*;
            var _local_14:Record;
            var _local_15:Number;
            var _local_16:uint;
            var _local_1:Sheet = (this._sheets[0] as Sheet);
            var _local_2:BIFFWriter = new BIFFWriter();
            var _local_3:Record = new Record(Type.BOF);
            _local_3.data.writeShort(BIFFVersion.BIFF2);
            _local_3.data.writeByte(0);
            _local_3.data.writeByte(16);
            _local_2.writeTag(_local_3);
            var _local_4:Record = new Record(Type.DATEMODE);
            _local_4.data.writeShort(1);
            _local_2.writeTag(_local_4);
            var _local_5:Array = ["General", "0", "0.00", "#,##0", "#,##0.00", "", "", "", "", "0%", "0.00%", "0.00E+00", "#?/?", "#??/??", "M/D/YY", "D-MMM-YY", "D-MMM", "MMM-YY"];
            var _local_6:Record = new Record(Type.BUILTINFMTCOUNT);
            _local_6.data.writeShort(_local_5.length);
            _local_2.writeTag(_local_6);
            var _local_7:uint;
            while (_local_7 < _local_5.length)
            {
                _local_11 = new Record(Type.FORMAT);
                _local_11.data.writeByte(_local_5[_local_7].length);
                _local_11.data.writeUTFBytes(_local_5[_local_7]);
                _local_2.writeTag(_local_11);
                _local_7++;
            };
            var _local_8:Record = new Record(Type.DIMENSIONS);
            _local_8.data.writeShort(0);
            _local_8.data.writeShort((_local_1.rows + 1));
            _local_8.data.writeShort(0);
            _local_8.data.writeShort((_local_1.cols + 1));
            _local_2.writeTag(_local_8);
            var _local_9:uint;
            while (_local_9 < _local_1.rows)
            {
                _local_12 = 0;
                while (_local_12 < _local_1.cols)
                {
                    _local_13 = _local_1.getCell(_local_9, _local_12).value;
                    _local_14 = new Record(1);
                    _local_14.data.writeShort(_local_9);
                    _local_14.data.writeShort(_local_12);
                    if ((_local_13 is Date))
                    {
                        _local_15 = ((_local_13.time / 86400000) + 24106.667);
                        _local_14.type = Type.NUMBER;
                        _local_14.data.writeByte(0);
                        _local_14.data.writeByte(15);
                        _local_14.data.writeByte(0);
                        _local_14.data.writeDouble(_local_15);
                    }
                    else
                    {
                        if (((isNaN(Number(_local_13)) == false) && (!(String(_local_13) == ""))))
                        {
                            _local_14.type = Type.NUMBER;
                            _local_14.data.writeByte(0);
                            _local_14.data.writeByte(0);
                            _local_14.data.writeByte(0);
                            _local_14.data.writeDouble(_local_13);
                        }
                        else
                        {
                            if (String(_local_13).length > 0)
                            {
                                _local_14.type = Type.LABEL;
                                _local_14.data.writeByte(0);
                                _local_14.data.writeByte(0);
                                _local_14.data.writeByte(0);
                                _local_16 = String(_local_13).length;
                                _local_14.data.writeByte(_local_16);
                                _local_14.data.writeUTFBytes(_local_13);
                            }
                            else
                            {
                                _local_14.type = Type.BLANK;
                                _local_14.data.writeByte(0);
                                _local_14.data.writeByte(0);
                                _local_14.data.writeByte(0);
                            };
                        };
                    };
                    _local_2.writeTag(_local_14);
                    _local_12++;
                };
                _local_9++;
            };
            var _local_10:Record = new Record(Type.EOF);
            _local_2.writeTag(_local_10);
            _local_2.stream.position = 0;
            return (_local_2.stream);
        }

        private function boolerr(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function dconref(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function integer(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedByte();
            var _local_6:uint = _arg_1.data.readUnsignedByte();
            var _local_7:uint = _arg_1.data.readUnsignedByte();
            var _local_8:uint = (_local_6 & 0x3F);
            var _local_9:Number = _arg_1.data.readUnsignedShort();
            var _local_10:String = _arg_2.formats[_local_8];
            _arg_2.setCell(_local_3, _local_4, _local_9);
            _arg_2.getCell(_local_3, _local_4).format = _local_10;
        }

        private function rk(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:Number = this.readRK(_arg_1, _arg_2);
            _arg_2.setCell(_local_3, _local_4, _local_6);
            var _local_7:String = _arg_2.formats[_arg_2.xformats[_local_5].format];
            if (((_local_7 == null) || (_local_7.length == 0)))
            {
                _local_7 = Formatter.builtInFormats[_arg_2.xformats[_local_5].format];
            };
            _arg_2.getCell(_local_3, _local_4).format = _local_7;
        }

        private function window1(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:uint = _arg_1.data.readUnsignedShort();
            var _local_7:* = (_arg_1.data.readUnsignedByte() == 1);
        }

        private function window2(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:Boolean;
            var _local_11:uint;
            var _local_12:uint;
            if (_arg_1.type == 62)
            {
                _local_3 = (_arg_1.data.readUnsignedByte() == 1);
                _local_4 = (_arg_1.data.readUnsignedByte() == 1);
                _local_5 = (_arg_1.data.readUnsignedByte() == 1);
                _local_6 = (_arg_1.data.readUnsignedByte() == 1);
                _local_7 = (_arg_1.data.readUnsignedByte() == 1);
                _local_8 = _arg_1.data.readUnsignedShort();
                _local_9 = _arg_1.data.readUnsignedShort();
                _local_10 = (_arg_1.data.readUnsignedByte() == 1);
                _local_11 = _arg_1.data.readUnsignedInt();
            }
            else
            {
                _local_12 = _arg_1.data.readUnsignedShort();
                _local_9 = _arg_1.data.readUnsignedShort();
                _local_10 = (_arg_1.data.readUnsignedByte() == 1);
                _local_11 = _arg_1.data.readUnsignedInt();
            };
        }

        private function topmargin(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readDouble();
        }

        private function colwidth(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function number(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_6:uint;
            var _local_7:String;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            if (_arg_1.type < 0x0200)
            {
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
            }
            else
            {
                _local_6 = _arg_1.data.readUnsignedShort();
            };
            var _local_5:Number = _arg_1.data.readDouble();
            if (this.version == BIFFVersion.BIFF2)
            {
                _arg_2.setCell(_local_3, _local_4, _local_5);
            }
            else
            {
                _arg_2.setCell(_local_3, _local_4, _local_5);
                _local_7 = _arg_2.formats[_arg_2.xformats[_local_6].format];
                if (((_local_7 == null) || (_local_7.length == 0)))
                {
                    _local_7 = Formatter.builtInFormats[_arg_2.xformats[_local_6].format];
                };
                _arg_2.getCell(_local_3, _local_4).format = _local_7;
            };
        }

        private function cont(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint;
            var _local_4:String;
            switch (this.lastRecordType)
            {
                case 236:
                    _local_3 = _arg_1.data.readUnsignedByte();
                    _local_4 = _arg_1.data.readUTFBytes(_arg_1.data.bytesAvailable);
                    this.notes.push(_local_4);
                    return;
            };
        }

        private function defcolwidth(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function readRK(_arg_1:Record, _arg_2:Sheet):Number
        {
            var _local_6:Number;
            var _local_7:ByteArray;
            var _local_3:uint = _arg_1.data.readUnsignedInt();
            var _local_4:* = ((_local_3 & 0x01) == 1);
            var _local_5:* = ((_local_3 & 0x02) == 2);
            _arg_1.data.position = (_arg_1.data.position - 4);
            if (_local_5)
            {
                _local_6 = (_arg_1.data.readInt() >> 2);
            }
            else
            {
                _local_7 = new ByteArray();
                _local_7[7] = 0;
                _local_7[6] = 0;
                _local_7[5] = 0;
                _local_7[4] = 0;
                _local_7[3] = _arg_1.data.readUnsignedByte();
                _local_7[2] = _arg_1.data.readUnsignedByte();
                _local_7[1] = _arg_1.data.readUnsignedByte();
                _local_7[0] = _arg_1.data.readUnsignedByte();
                _local_6 = _local_7.readDouble();
            };
            if (_local_4)
            {
                _local_6 = (Math.round(_local_6) / 100);
            };
            return (_local_6);
        }

        private function datemode(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            this.dateMode = _local_3;
            var _local_4:uint;
            while (_local_4 < this._sheets.length)
            {
                this._sheets.getItemAt(_local_4).dateMode = this.dateMode;
                _local_4++;
            };
        }

        private function vcenter(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function bookbool(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function blank(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            _arg_2.setCell(_local_3, _local_4, "");
        }

        private function font(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:uint;
            var _local_6:String;
            var _local_7:uint;
            var _local_3:Number = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            if (((_arg_1.type == 561) || (this.version >= BIFFVersion.BIFF5)))
            {
                _local_7 = _arg_1.data.readUnsignedShort();
            };
            if (((_arg_1.type == 561) && (this.version <= BIFFVersion.BIFF4)))
            {
                _local_5 = _arg_1.data.readUnsignedByte();
                _local_6 = _arg_1.data.readUTFBytes(_local_5);
            };
        }

        private function uselfs(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function extsst(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function printheaders(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function gridset(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedByte() == 1);
        }

        private function horizpagebreaks(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function phonetic(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function pane(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function printgridlines(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function formula(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_6:Boolean;
            var _local_7:uint;
            var _local_11:uint;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            if (this.version == BIFFVersion.BIFF2)
            {
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
            }
            else
            {
                _local_11 = _arg_1.data.readUnsignedShort();
            };
            var _local_5:Number = _arg_1.data.readDouble();
            if (this.version == BIFFVersion.BIFF2)
            {
                _local_6 = (_arg_1.data.readUnsignedByte() == 1);
            }
            else
            {
                _local_6 = (_arg_1.data.readUnsignedShort() == 0);
            };
            if (this.version >= BIFFVersion.BIFF5)
            {
                _arg_1.data.position = (_arg_1.data.position + 4);
            };
            if (this.version == BIFFVersion.BIFF2)
            {
                _local_7 = _arg_1.data.readUnsignedByte();
            }
            else
            {
                _local_7 = _arg_1.data.readUnsignedShort();
            };
            var _local_8:ByteArray = new ByteArray();
            _arg_1.data.readBytes(_local_8, 0, _local_7);
            var _local_9:Formula = new Formula(_local_3, _local_4, _local_8, this.version, _arg_2);
            _arg_2.setCell(_local_3, _local_4, _local_9);
            var _local_10:String = _arg_2.formats[_arg_2.xformats[_local_11].format];
            if (((_local_10 == null) || (_local_10.length == 0)))
            {
                _local_10 = Formatter.builtInFormats[_arg_2.xformats[_local_11].format];
            };
            _arg_2.getCell(_local_3, _local_4).format = _local_10;
        }

        public function loadFromByteArray(_arg_1:ByteArray):void
        {
            var _local_3:Record;
            var _local_4:CDFReader;
            if (CDFReader.isCDFFile(_arg_1))
            {
                _local_4 = new CDFReader(_arg_1);
                _arg_1 = _local_4.loadDirectoryEntry(0);
            };
            this.br = new BIFFReader(_arg_1);
            var _local_2:Array = [];
            while ((_local_3 = this.br.readTag()) != null)
            {
                if (ignore.indexOf(_local_3.type) == -1)
                {
                    if (_local_3.type != Type.CONTINUE)
                    {
                        this.lastRecordType = _local_3.type;
                    };
                    if ((this.handlers[_local_3.type] is Function))
                    {
                        (this.handlers[_local_3.type] as Function).call(this, _local_3, this.currentSheet);
                    }
                    else
                    {
                        _local_2.push(_local_3.type);
                    };
                };
            };
            if (_local_2.length > 0)
            {
            };
        }

        private function leftmargin(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readDouble();
        }

        private function externcount(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function sheetprotection(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function palette(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function hideobj(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function setup(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_8:uint;
            var _local_9:uint;
            var _local_10:uint;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:uint;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:uint = _arg_1.data.readUnsignedShort();
            var _local_7:uint = _arg_1.data.readUnsignedShort();
            if (this.version == BIFFVersion.BIFF4)
            {
                _local_8 = _arg_1.data.readUnsignedShort();
            }
            else
            {
                _local_8 = _arg_1.data.readUnsignedShort();
                _local_9 = _arg_1.data.readUnsignedShort();
                _local_10 = _arg_1.data.readUnsignedShort();
                _local_11 = _arg_1.data.readDouble();
                _local_12 = _arg_1.data.readDouble();
                _local_13 = _arg_1.data.readUnsignedShort();
            };
        }

        private function precision(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function calcmode(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function array(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_7:Boolean;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedByte();
            var _local_6:uint = _arg_1.data.readUnsignedByte();
            if (this.version == BIFFVersion.BIFF2)
            {
                _local_7 = (_arg_1.data.readUnsignedByte() == 1);
            }
            else
            {
                _local_7 = ((_arg_1.data.readUnsignedShort() & 0x01) == 1);
            };
            if (this.version == BIFFVersion.BIFF8)
            {
                _arg_1.data.position = (_arg_1.data.position + 4);
            };
            var _local_8:ByteArray = new ByteArray();
            _arg_1.data.readBytes(_local_8, 0, _arg_1.data.bytesAvailable);
        }

        private function name(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function selection(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function uncalced(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function dv(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function vertpagebreaks(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function country(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
        }

        private function initHandlers():Array
        {
            var _local_1:Array = [this.dimensions, this.blank, this.integer, this.number, this.label, this.boolerr, this.formula, this.string, this.row, this.bof, this.eof, this.index, this.calccount, this.calcmode, this.precision, this.refmode, this.delta, this.iteration, this.protect, this.password, this.header, this.footer, this.externcount, this.externsheet, this.name, this.windowprotect, this.vertpagebreaks, this.horizpagebreaks, this.note, this.selection, this.format, this.builtinfmtcount, this.columndefault, this.array, this.datemode, this.externname, this.colwidth, this.defrowheight, this.leftmargin, this.rightmargin, this.topmargin, this.bottommargin, this.printheaders, this.printgridlines, null, null, null, this.filepass, null, this.font, this.font2, null, null, null, this.tableop, this.tableop2, null, null, null, null, this.cont, this.window1, this.window2, null, this.backup, this.pane, this.codepage, this.xf, this.ixfe, this.efont, null, null, null, null, null, null, null, null, null, null, null, this.dconref, null, null, null, this.defcolwidth, this.builtinfmtcount, null, null, this.xct, this.crn, this.filesharing, this.writeaccess, null, this.uncalced, this.saverecalc, null, null, null, this.objectprotect, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.colinfo, null, null, this.guts, this.wsbool, this.gridset, this.hcenter, this.vcenter, this.boundsheet, this.writeprot, null, null, null, null, null, this.country, this.hideobj, null, null, null, null, this.palette, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.setup, null, null, null, null, null, null, null, null, null, this.gcw, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.mulrk, this.mulblank, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.dbcell, null, null, this.bookbool, null, null, null, null, null, this.xf, null, null, null, null, this.mergedcells, null, null, null, null, null, null, null, null, null, this.phonetic, null, null, null, null, null, null, null, null, null, null, null, null, this.sst, this.labelsst, null, this.extsst, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.uselfs, this.dsf, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.dv, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, this.dimensions, this.blank, null, this.number, this.label, null, this.formula, null, this.row, this.bof, null, this.index, null, null];
            _local_1[Type.RK] = this.rk;
            _local_1[Type.SHRFMLA] = this.shrfmla;
            _local_1[Type.SHEETPROTECTION] = this.sheetprotection;
            _local_1[Type.RANGEPROTECTION] = this.rangeprotection;
            _local_1[549] = this.defrowheight;
            _local_1[561] = this.font;
            _local_1[574] = this.window2;
            _local_1[579] = this.xf;
            _local_1[659] = this.style;
            _local_1[1030] = this.formula;
            _local_1[1033] = this.bof;
            _local_1[1054] = this.format;
            _local_1[1091] = this.xf;
            _local_1[2057] = this.bof;
            return (_local_1);
        }

        private function footer(_arg_1:Record, _arg_2:Sheet):void
        {
            if (_arg_1.data.bytesAvailable == 0)
            {
                return;
            };
            var _local_3:uint = _arg_1.data.readUnsignedByte();
            var _local_4:String = _arg_1.data.readUTFBytes(_local_3).substr(2);
            _arg_2.footer = _local_4;
        }

        private function header(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:String;
            var _local_4:uint;
            if (_arg_1.data.length == 0)
            {
                _local_3 = "";
            }
            else
            {
                if (this.version == BIFFVersion.BIFF8)
                {
                    _local_3 = _arg_1.readUnicodeStr16();
                }
                else
                {
                    _local_4 = _arg_1.data.readUnsignedByte();
                    _local_3 = _arg_1.data.readUTFBytes(_local_4);
                };
            };
            _arg_2.header = _local_3;
        }

        private function boundsheet(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_6:uint;
            var _local_8:Sheet;
            var _local_3:uint = _arg_1.data.readUnsignedInt();
            var _local_4:uint = _arg_1.data.readUnsignedByte();
            var _local_5:uint = _arg_1.data.readUnsignedByte();
            if (this.version == BIFFVersion.BIFF5)
            {
                _local_6 = _arg_1.data.readUnsignedByte();
            }
            else
            {
                _local_6 = _arg_1.data.readUnsignedShort();
            };
            var _local_7:String = _arg_1.data.readUTFBytes(_local_6);
            _local_8 = new Sheet();
            _local_8.dateMode = this.dateMode;
            _local_8.name = _local_7;
            _local_8.formats = _local_8.formats.concat(this.globalFormats);
            _local_8.xformats = _local_8.xformats.concat(this.globalXFormats);
            this._sheets.addItem(_local_8);
        }

        private function password(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function mergedcells(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function labelsst(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:uint = _arg_1.data.readUnsignedInt();
            var _local_7:String = this._sst[_local_6];
            _arg_2.setCell(_local_3, _local_4, _local_7);
        }

        private function bottommargin(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readDouble();
        }

        private function filepass(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function style(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function refmode(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function objectprotect(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function delta(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readDouble();
        }

        private function shrfmla(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_9:ByteArray;
            var _local_11:uint;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedByte();
            var _local_6:uint = _arg_1.data.readUnsignedByte();
            _arg_1.data.position++;
            var _local_7:uint = _arg_1.data.readUnsignedByte();
            var _local_8:uint = ((this.version == BIFFVersion.BIFF2) ? _arg_1.data.readUnsignedByte() : _arg_1.data.readUnsignedShort());
            var _local_10:uint = _local_3;
            while (_local_10 < _local_4)
            {
                _local_11 = _local_5;
                while (_local_11 <= _local_6)
                {
                    _local_9 = new ByteArray();
                    _local_9.endian = Endian.LITTLE_ENDIAN;
                    _arg_1.data.readBytes(_local_9, 0, _local_8);
                    _arg_1.data.position = (_arg_1.data.position - _local_8);
                    _arg_2.getCell(_local_10, _local_11).sharedTokens = _local_9;
                    _local_11++;
                };
                _local_10++;
            };
        }

        private function hcenter(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function dsf(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function externsheet(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function bof(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:Sheet;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            this.currentFileType = _local_4;
            if (_local_4 == SHEET)
            {
                if (this._sheets.length == 0)
                {
                    _local_5 = new Sheet();
                    _local_5.dateMode = this.dateMode;
                    this._sheets.addItem(_local_5);
                    _local_5.formats = _local_5.formats.concat(this.globalFormats);
                    _local_5.xformats = _local_5.xformats.concat(this.globalXFormats);
                };
                this.notes = new Array();
                this.currentSheet = (this._sheets.getItemAt(this.currentSheetIdx) as Sheet);
                this.currentSheetIdx++;
            };
            if (_arg_1.type == 9)
            {
                this.version = BIFFVersion.BIFF2;
            }
            else
            {
                if (_arg_1.type == 521)
                {
                    this.version = BIFFVersion.BIFF3;
                }
                else
                {
                    if (_arg_1.type == 1033)
                    {
                        this.version = BIFFVersion.BIFF4;
                    }
                    else
                    {
                        if (((_arg_1.type == 2057) && (!(_local_3 == 0x0600))))
                        {
                            this.version = BIFFVersion.BIFF5;
                        }
                        else
                        {
                            if (_local_4 == 5)
                            {
                                this.version = BIFFVersion.BIFF8;
                            };
                        };
                    };
                };
            };
        }

        private function font2(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function builtinfmtcount(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function wsbool(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function backup(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function rightmargin(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:Number = _arg_1.data.readDouble();
        }

        private function dimensions(_arg_1:Record, _arg_2:Sheet):void
        {
            if (_arg_1.data.length == 0)
            {
                return;
            };
            var _local_3:uint = ((_arg_1.length == 14) ? _arg_1.data.readUnsignedInt() : _arg_1.data.readUnsignedShort());
            var _local_4:uint = ((_arg_1.length == 14) ? _arg_1.data.readUnsignedInt() : _arg_1.data.readUnsignedShort());
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:uint = _arg_1.data.readUnsignedShort();
            _arg_2.resize(_local_4, _local_6);
        }

        private function protect(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function saverecalc(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedByte() == 1);
        }

        private function writeprot(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function rangeprotection(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function index(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function calccount(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function iteration(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function windowprotect(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:* = (_arg_1.data.readUnsignedShort() == 1);
        }

        private function filesharing(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function row(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = (_arg_1.data.readUnsignedShort() - 1);
            var _local_6:uint = _arg_1.data.readUnsignedShort();
            var _local_7:uint = _arg_1.data.readUnsignedShort();
            var _local_8:* = (_arg_1.data.readUnsignedByte() == 1);
            var _local_9:uint = _arg_1.data.readUnsignedShort();
        }

        private function tableop2(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function crn(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function dbcell(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function xct(_arg_1:Record, _arg_2:Sheet):void
        {
        }

        private function guts(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            var _local_5:uint = _arg_1.data.readUnsignedShort();
            var _local_6:uint = _arg_1.data.readUnsignedShort();
        }

        private function xf(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint;
            var _local_4:uint;
            switch (this.version)
            {
                case BIFFVersion.BIFF2:
                    _local_3 = _arg_1.data.readUnsignedByte();
                    _arg_1.data.position++;
                    _local_4 = (_arg_1.data.readUnsignedByte() & 0x3F);
                    break;
                case BIFFVersion.BIFF3:
                case BIFFVersion.BIFF4:
                    _local_3 = _arg_1.data.readUnsignedByte();
                    _local_4 = _arg_1.data.readUnsignedByte();
                    break;
                case BIFFVersion.BIFF5:
                    _local_3 = _arg_1.data.readUnsignedShort();
                    _local_4 = _arg_1.data.readUnsignedShort();
                    break;
                case BIFFVersion.BIFF8:
                    _local_3 = _arg_1.data.readUnsignedShort();
                    _local_4 = _arg_1.data.readUnsignedShort();
                    break;
            };
            if ((_arg_2 is Sheet))
            {
                _arg_2.xformats.push(new XFormat(_arg_1.type, _local_4));
            }
            else
            {
                this.globalXFormats.push(new XFormat(_arg_1.type, _local_4));
            };
        }

        private function note(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:String;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:String;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            if (this.version <= BIFFVersion.BIFF5)
            {
                _local_6 = _arg_1.data.readUnsignedShort();
                _local_5 = _arg_1.data.readUTFBytes(_arg_1.data.bytesAvailable);
            }
            else
            {
                _local_7 = _arg_1.data.readUnsignedShort();
                _local_8 = ((_arg_1.data.readUnsignedShort() - 1) * 2);
                _local_9 = _arg_1.readUnicodeStr16();
                _local_5 = this.notes[_local_8];
            };
            _arg_2.getCell(_local_3, _local_4).note = _local_5;
        }

        public function get sheets():ArrayCollection
        {
            return (this._sheets);
        }

        private function format(_arg_1:Record, _arg_2:Sheet):void
        {
            if (((this.version == BIFFVersion.BIFF4) || (this.version == BIFFVersion.BIFF5)))
            {
                _arg_1.data.position = (_arg_1.data.position + 2);
            };
            var _local_3:uint = _arg_1.data.readUnsignedByte();
            var _local_4:String = _arg_1.data.readUTFBytes(_local_3);
            if ((_arg_2 is Sheet))
            {
                _arg_2.formats.push(_local_4);
            }
            else
            {
                this.globalFormats.push(_local_4);
            };
        }

        private function label(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:uint;
            var _local_8:uint;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            if (_arg_1.type == Type.LABEL)
            {
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
                _arg_1.data.readUnsignedByte();
                _local_5 = _arg_1.data.readUnsignedByte();
            }
            else
            {
                _local_8 = _arg_1.data.readUnsignedShort();
                _local_5 = _arg_1.data.readUnsignedShort();
            };
            var _local_6:String = _arg_1.data.readUTFBytes(_local_5);
            var _local_7:String = _arg_2.formats[_arg_2.xformats[_local_8].format];
            if (((_local_7 == null) || (_local_7.length == 0)))
            {
                _local_7 = Formatter.builtInFormats[_arg_2.xformats[_local_8].format];
            };
            _arg_2.setCell(_local_3, _local_4, _local_6);
            _arg_2.getCell(_local_3, _local_4).format = _local_7;
        }

        private function codepage(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_3:uint = _arg_1.data.readUnsignedShort();
        }

        private function mulrk(_arg_1:Record, _arg_2:Sheet):void
        {
            var _local_5:uint;
            var _local_6:Number;
            var _local_7:String;
            var _local_3:uint = _arg_1.data.readUnsignedShort();
            var _local_4:uint = _arg_1.data.readUnsignedShort();
            while (_arg_1.data.bytesAvailable > 2)
            {
                _local_5 = _arg_1.data.readUnsignedShort();
                _local_6 = this.readRK(_arg_1, _arg_2);
                _local_7 = _arg_2.formats[_arg_2.xformats[_local_5].format];
                if (((_local_7 == null) || (_local_7.length == 0)))
                {
                    _local_7 = Formatter.builtInFormats[_arg_2.xformats[_local_5].format];
                };
                _arg_2.setCell(_local_3, _local_4, _local_6);
                _arg_2.getCell(_local_3, _local_4).format = _local_7;
                _local_4++;
            };
        }


    }
}//package com.as3xls.xls

