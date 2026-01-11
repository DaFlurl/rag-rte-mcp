package com.as3xls.xls
{
   import com.as3xls.biff.BIFFReader;
   import com.as3xls.biff.BIFFVersion;
   import com.as3xls.biff.BIFFWriter;
   import com.as3xls.biff.Record;
   import com.as3xls.cdf.CDFReader;
   import com.as3xls.xls.formula.Formula;
   import com.as3xls.xls.style.XFormat;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import mx.collections.ArrayCollection;
   
   public class ExcelFile
   {
      public static const BASE1899:uint = 0;
      
      public static const BASE1904:uint = 1;
      
      public static const GLOBALS:uint = 5;
      
      public static const SHEET:uint = 16;
      
      private static const ignore:Array = [77,225,192,193,225,226,93,156,191,235,238,241,317,431,438,439,444,448,449,450,2147,2248,4188];
      
      private var _sheets:ArrayCollection = new ArrayCollection();
      
      private var globalFormats:Array = new Array();
      
      private var br:BIFFReader;
      
      private var _sst:Array;
      
      private var lastRecordType:uint;
      
      private var currentSheet:Sheet;
      
      private const handlers:Array = this.initHandlers();
      
      private var currentFileType:uint;
      
      private var dateMode:uint;
      
      private var currentSheetIdx:uint = 0;
      
      private var globalXFormats:Array = new Array();
      
      private var notes:Array;
      
      private var version:uint;
      
      public function ExcelFile()
      {
         super();
      }
      
      private function writeaccess(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedByte();
         var _loc4_:String = param1.data.readUTFBytes(_loc3_);
      }
      
      private function eof(param1:Record, param2:Sheet) : void
      {
      }
      
      private function mulblank(param1:Record, param2:Sheet) : void
      {
         var _loc5_:uint = 0;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         while(param1.data.bytesAvailable > 2)
         {
            _loc5_ = param1.data.readUnsignedShort();
            param2.setCell(_loc3_,_loc4_,"");
            _loc4_++;
         }
      }
      
      private function string(param1:Record, param2:Sheet) : void
      {
      }
      
      private function sst(param1:Record, param2:Sheet) : void
      {
         var _loc6_:String = null;
         var _loc3_:uint = param1.data.readUnsignedInt();
         var _loc4_:uint = param1.data.readUnsignedInt();
         this._sst = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.readUnicodeStr16();
            this._sst.push(_loc6_);
            _loc5_++;
         }
      }
      
      private function gcw(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function defrowheight(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readUnsignedShort();
      }
      
      private function columndefault(param1:Record, param2:Sheet) : void
      {
      }
      
      private function ixfe(param1:Record, param2:Sheet) : void
      {
      }
      
      private function tableop(param1:Record, param2:Sheet) : void
      {
      }
      
      private function externname(param1:Record, param2:Sheet) : void
      {
      }
      
      private function efont(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function colinfo(param1:Record, param2:Sheet) : void
      {
      }
      
      public function saveToByteArray() : ByteArray
      {
         var _loc11_:Record = null;
         var _loc12_:uint = 0;
         var _loc13_:* = undefined;
         var _loc14_:Record = null;
         var _loc15_:Number = NaN;
         var _loc16_:uint = 0;
         var _loc1_:Sheet = this._sheets[0] as Sheet;
         var _loc2_:BIFFWriter = new BIFFWriter();
         var _loc3_:Record = new Record(Type.BOF);
         _loc3_.data.writeShort(BIFFVersion.BIFF2);
         _loc3_.data.writeByte(0);
         _loc3_.data.writeByte(16);
         _loc2_.writeTag(_loc3_);
         var _loc4_:Record = new Record(Type.DATEMODE);
         _loc4_.data.writeShort(1);
         _loc2_.writeTag(_loc4_);
         var _loc5_:Array = ["General","0","0.00","#,##0","#,##0.00","","","","","0%","0.00%","0.00E+00","#?/?","#??/??","M/D/YY","D-MMM-YY","D-MMM","MMM-YY"];
         var _loc6_:Record = new Record(Type.BUILTINFMTCOUNT);
         _loc6_.data.writeShort(_loc5_.length);
         _loc2_.writeTag(_loc6_);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc11_ = new Record(Type.FORMAT);
            _loc11_.data.writeByte(_loc5_[_loc7_].length);
            _loc11_.data.writeUTFBytes(_loc5_[_loc7_]);
            _loc2_.writeTag(_loc11_);
            _loc7_++;
         }
         var _loc8_:Record = new Record(Type.DIMENSIONS);
         _loc8_.data.writeShort(0);
         _loc8_.data.writeShort(_loc1_.rows + 1);
         _loc8_.data.writeShort(0);
         _loc8_.data.writeShort(_loc1_.cols + 1);
         _loc2_.writeTag(_loc8_);
         var _loc9_:uint = 0;
         while(_loc9_ < _loc1_.rows)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc1_.cols)
            {
               _loc13_ = _loc1_.getCell(_loc9_,_loc12_).value;
               _loc14_ = new Record(1);
               _loc14_.data.writeShort(_loc9_);
               _loc14_.data.writeShort(_loc12_);
               if(_loc13_ is Date)
               {
                  _loc15_ = _loc13_.time / 86400000 + 24106.667;
                  _loc14_.type = Type.NUMBER;
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(15);
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeDouble(_loc15_);
               }
               else if(isNaN(Number(_loc13_)) == false && String(_loc13_) != "")
               {
                  _loc14_.type = Type.NUMBER;
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeDouble(_loc13_);
               }
               else if(String(_loc13_).length > 0)
               {
                  _loc14_.type = Type.LABEL;
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
                  _loc16_ = uint(String(_loc13_).length);
                  _loc14_.data.writeByte(_loc16_);
                  _loc14_.data.writeUTFBytes(_loc13_);
               }
               else
               {
                  _loc14_.type = Type.BLANK;
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
                  _loc14_.data.writeByte(0);
               }
               _loc2_.writeTag(_loc14_);
               _loc12_++;
            }
            _loc9_++;
         }
         var _loc10_:Record = new Record(Type.EOF);
         _loc2_.writeTag(_loc10_);
         _loc2_.stream.position = 0;
         return _loc2_.stream;
      }
      
      private function boolerr(param1:Record, param2:Sheet) : void
      {
      }
      
      private function dconref(param1:Record, param2:Sheet) : void
      {
      }
      
      private function integer(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedByte();
         var _loc6_:uint = param1.data.readUnsignedByte();
         var _loc7_:uint = param1.data.readUnsignedByte();
         var _loc8_:uint = uint(_loc6_ & 0x3F);
         var _loc9_:Number = param1.data.readUnsignedShort();
         var _loc10_:String = param2.formats[_loc8_];
         param2.setCell(_loc3_,_loc4_,_loc9_);
         param2.getCell(_loc3_,_loc4_).format = _loc10_;
      }
      
      private function rk(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:Number = this.readRK(param1,param2);
         param2.setCell(_loc3_,_loc4_,_loc6_);
         var _loc7_:String = param2.formats[param2.xformats[_loc5_].format];
         if(_loc7_ == null || _loc7_.length == 0)
         {
            _loc7_ = Formatter.builtInFormats[param2.xformats[_loc5_].format];
         }
         param2.getCell(_loc3_,_loc4_).format = _loc7_;
      }
      
      private function window1(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:uint = param1.data.readUnsignedShort();
         var _loc7_:* = param1.data.readUnsignedByte() == 1;
      }
      
      private function window2(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:* = false;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         if(param1.type == 62)
         {
            _loc3_ = param1.data.readUnsignedByte() == 1;
            _loc4_ = param1.data.readUnsignedByte() == 1;
            _loc5_ = param1.data.readUnsignedByte() == 1;
            _loc6_ = param1.data.readUnsignedByte() == 1;
            _loc7_ = param1.data.readUnsignedByte() == 1;
            _loc8_ = param1.data.readUnsignedShort();
            _loc9_ = param1.data.readUnsignedShort();
            _loc10_ = param1.data.readUnsignedByte() == 1;
            _loc11_ = param1.data.readUnsignedInt();
         }
         else
         {
            _loc12_ = param1.data.readUnsignedShort();
            _loc9_ = param1.data.readUnsignedShort();
            _loc10_ = param1.data.readUnsignedByte() == 1;
            _loc11_ = param1.data.readUnsignedInt();
         }
      }
      
      private function topmargin(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readDouble();
      }
      
      private function colwidth(param1:Record, param2:Sheet) : void
      {
      }
      
      private function number(param1:Record, param2:Sheet) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         if(param1.type < 512)
         {
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
         }
         else
         {
            _loc6_ = param1.data.readUnsignedShort();
         }
         var _loc5_:Number = param1.data.readDouble();
         if(this.version == BIFFVersion.BIFF2)
         {
            param2.setCell(_loc3_,_loc4_,_loc5_);
         }
         else
         {
            param2.setCell(_loc3_,_loc4_,_loc5_);
            _loc7_ = param2.formats[param2.xformats[_loc6_].format];
            if(_loc7_ == null || _loc7_.length == 0)
            {
               _loc7_ = Formatter.builtInFormats[param2.xformats[_loc6_].format];
            }
            param2.getCell(_loc3_,_loc4_).format = _loc7_;
         }
      }
      
      private function cont(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         switch(this.lastRecordType)
         {
            case 236:
               _loc3_ = param1.data.readUnsignedByte();
               _loc4_ = param1.data.readUTFBytes(param1.data.bytesAvailable);
               this.notes.push(_loc4_);
         }
      }
      
      private function defcolwidth(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function readRK(param1:Record, param2:Sheet) : Number
      {
         var _loc6_:Number = NaN;
         var _loc7_:ByteArray = null;
         var _loc3_:uint = param1.data.readUnsignedInt();
         var _loc4_:* = (_loc3_ & 1) == 1;
         var _loc5_:* = (_loc3_ & 2) == 2;
         param1.data.position -= 4;
         if(_loc5_)
         {
            _loc6_ = param1.data.readInt() >> 2;
         }
         else
         {
            _loc7_ = new ByteArray();
            _loc7_[7] = 0;
            _loc7_[6] = 0;
            _loc7_[5] = 0;
            _loc7_[4] = 0;
            _loc7_[3] = param1.data.readUnsignedByte();
            _loc7_[2] = param1.data.readUnsignedByte();
            _loc7_[1] = param1.data.readUnsignedByte();
            _loc7_[0] = param1.data.readUnsignedByte();
            _loc6_ = _loc7_.readDouble();
         }
         if(_loc4_)
         {
            _loc6_ = Math.round(_loc6_) / 100;
         }
         return _loc6_;
      }
      
      private function datemode(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         this.dateMode = _loc3_;
         var _loc4_:uint = 0;
         while(_loc4_ < this._sheets.length)
         {
            this._sheets.getItemAt(_loc4_).dateMode = this.dateMode;
            _loc4_++;
         }
      }
      
      private function vcenter(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function bookbool(param1:Record, param2:Sheet) : void
      {
      }
      
      private function blank(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         param2.setCell(_loc3_,_loc4_,"");
      }
      
      private function font(param1:Record, param2:Sheet) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc3_:Number = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         if(param1.type == 561 || this.version >= BIFFVersion.BIFF5)
         {
            _loc7_ = param1.data.readUnsignedShort();
         }
         if(param1.type == 561 && this.version <= BIFFVersion.BIFF4)
         {
            _loc5_ = param1.data.readUnsignedByte();
            _loc6_ = param1.data.readUTFBytes(_loc5_);
         }
      }
      
      private function uselfs(param1:Record, param2:Sheet) : void
      {
      }
      
      private function extsst(param1:Record, param2:Sheet) : void
      {
      }
      
      private function printheaders(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function gridset(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedByte() == 1;
      }
      
      private function horizpagebreaks(param1:Record, param2:Sheet) : void
      {
      }
      
      private function phonetic(param1:Record, param2:Sheet) : void
      {
      }
      
      private function pane(param1:Record, param2:Sheet) : void
      {
      }
      
      private function printgridlines(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function formula(param1:Record, param2:Sheet) : void
      {
         var _loc6_:* = false;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         if(this.version == BIFFVersion.BIFF2)
         {
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
         }
         else
         {
            _loc11_ = param1.data.readUnsignedShort();
         }
         var _loc5_:Number = param1.data.readDouble();
         if(this.version == BIFFVersion.BIFF2)
         {
            _loc6_ = param1.data.readUnsignedByte() == 1;
         }
         else
         {
            _loc6_ = param1.data.readUnsignedShort() == 0;
         }
         if(this.version >= BIFFVersion.BIFF5)
         {
            param1.data.position += 4;
         }
         if(this.version == BIFFVersion.BIFF2)
         {
            _loc7_ = param1.data.readUnsignedByte();
         }
         else
         {
            _loc7_ = param1.data.readUnsignedShort();
         }
         var _loc8_:ByteArray = new ByteArray();
         param1.data.readBytes(_loc8_,0,_loc7_);
         var _loc9_:Formula = new Formula(_loc3_,_loc4_,_loc8_,this.version,param2);
         param2.setCell(_loc3_,_loc4_,_loc9_);
         var _loc10_:String = param2.formats[param2.xformats[_loc11_].format];
         if(_loc10_ == null || _loc10_.length == 0)
         {
            _loc10_ = Formatter.builtInFormats[param2.xformats[_loc11_].format];
         }
         param2.getCell(_loc3_,_loc4_).format = _loc10_;
      }
      
      public function loadFromByteArray(param1:ByteArray) : void
      {
         var _loc3_:Record = null;
         var _loc4_:CDFReader = null;
         if(CDFReader.isCDFFile(param1))
         {
            _loc4_ = new CDFReader(param1);
            param1 = _loc4_.loadDirectoryEntry(0);
         }
         this.br = new BIFFReader(param1);
         var _loc2_:Array = [];
         while(true)
         {
            _loc3_ = this.br.readTag();
            if(_loc3_ == null)
            {
               break;
            }
            if(ignore.indexOf(_loc3_.type) == -1)
            {
               if(_loc3_.type != Type.CONTINUE)
               {
                  this.lastRecordType = _loc3_.type;
               }
               if(this.handlers[_loc3_.type] is Function)
               {
                  (this.handlers[_loc3_.type] as Function).call(this,_loc3_,this.currentSheet);
               }
               else
               {
                  _loc2_.push(_loc3_.type);
               }
            }
         }
         if(_loc2_.length > 0)
         {
         }
      }
      
      private function leftmargin(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readDouble();
      }
      
      private function externcount(param1:Record, param2:Sheet) : void
      {
      }
      
      private function sheetprotection(param1:Record, param2:Sheet) : void
      {
      }
      
      private function palette(param1:Record, param2:Sheet) : void
      {
      }
      
      private function hideobj(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function setup(param1:Record, param2:Sheet) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:uint = param1.data.readUnsignedShort();
         var _loc7_:uint = param1.data.readUnsignedShort();
         if(this.version == BIFFVersion.BIFF4)
         {
            _loc8_ = param1.data.readUnsignedShort();
         }
         else
         {
            _loc8_ = param1.data.readUnsignedShort();
            _loc9_ = param1.data.readUnsignedShort();
            _loc10_ = param1.data.readUnsignedShort();
            _loc11_ = param1.data.readDouble();
            _loc12_ = param1.data.readDouble();
            _loc13_ = param1.data.readUnsignedShort();
         }
      }
      
      private function precision(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function calcmode(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function array(param1:Record, param2:Sheet) : void
      {
         var _loc7_:* = false;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedByte();
         var _loc6_:uint = param1.data.readUnsignedByte();
         if(this.version == BIFFVersion.BIFF2)
         {
            _loc7_ = param1.data.readUnsignedByte() == 1;
         }
         else
         {
            _loc7_ = (param1.data.readUnsignedShort() & 1) == 1;
         }
         if(this.version == BIFFVersion.BIFF8)
         {
            param1.data.position += 4;
         }
         var _loc8_:ByteArray = new ByteArray();
         param1.data.readBytes(_loc8_,0,param1.data.bytesAvailable);
      }
      
      private function name(param1:Record, param2:Sheet) : void
      {
      }
      
      private function selection(param1:Record, param2:Sheet) : void
      {
      }
      
      private function uncalced(param1:Record, param2:Sheet) : void
      {
      }
      
      private function dv(param1:Record, param2:Sheet) : void
      {
      }
      
      private function vertpagebreaks(param1:Record, param2:Sheet) : void
      {
      }
      
      private function country(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
      }
      
      private function initHandlers() : Array
      {
         var _loc1_:Array = [this.dimensions,this.blank,this.integer,this.number,this.label,this.boolerr,this.formula,this.string,this.row,this.bof,this.eof,this.index,this.calccount,this.calcmode,this.precision,this.refmode,this.delta,this.iteration,this.protect,this.password,this.header,this.footer,this.externcount,this.externsheet,this.name,this.windowprotect,this.vertpagebreaks,this.horizpagebreaks,this.note,this.selection,this.format,this.builtinfmtcount,this.columndefault,this.array,this.datemode,this.externname,this.colwidth,this.defrowheight,this.leftmargin,this.rightmargin,this.topmargin,this.bottommargin,this.printheaders,this.printgridlines,null,null,null,this.filepass,null,this.font,this.font2,null,null,null,this.tableop,this.tableop2,null,null,null,null,this.cont,this.window1,this.window2,null,this.backup,this.pane,this.codepage,this.xf,this.ixfe,this.efont,null,null,null,null,null,null,null,null,null,null,null,this.dconref,null,null,null,this.defcolwidth,this.builtinfmtcount,null,null
         ,this.xct,this.crn,this.filesharing,this.writeaccess,null,this.uncalced,this.saverecalc,null,null,null,this.objectprotect,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.colinfo,null,null,this.guts,this.wsbool,this.gridset,this.hcenter,this.vcenter,this.boundsheet,this.writeprot,null,null,null,null,null,this.country,this.hideobj,null,null,null,null,this.palette,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.setup,null,null,null,null,null,null,null,null,null,this.gcw,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.mulrk,this.mulblank,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.dbcell,null,null,this.bookbool,null,null,null,null,null,this.xf,null,null,null,null,this.mergedcells,null,null,null,null,null,null,null,null,null,this.phonetic,null,null,null,null,null,null
         ,null,null,null,null,null,null,this.sst,this.labelsst,null,this.extsst,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.uselfs,this.dsf,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
         ,this.dv,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,this.dimensions,this.blank,null,this.number,this.label,null,this.formula,null,this.row,this.bof,null,this.index,null,null];
         _loc1_[Type.RK] = this.rk;
         _loc1_[Type.SHRFMLA] = this.shrfmla;
         _loc1_[Type.SHEETPROTECTION] = this.sheetprotection;
         _loc1_[Type.RANGEPROTECTION] = this.rangeprotection;
         _loc1_[549] = this.defrowheight;
         _loc1_[561] = this.font;
         _loc1_[574] = this.window2;
         _loc1_[579] = this.xf;
         _loc1_[659] = this.style;
         _loc1_[1030] = this.formula;
         _loc1_[1033] = this.bof;
         _loc1_[1054] = this.format;
         _loc1_[1091] = this.xf;
         _loc1_[2057] = this.bof;
         return _loc1_;
      }
      
      private function footer(param1:Record, param2:Sheet) : void
      {
         if(param1.data.bytesAvailable == 0)
         {
            return;
         }
         var _loc3_:uint = param1.data.readUnsignedByte();
         var _loc4_:String = param1.data.readUTFBytes(_loc3_).substr(2);
         param2.footer = _loc4_;
      }
      
      private function header(param1:Record, param2:Sheet) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         if(param1.data.length == 0)
         {
            _loc3_ = "";
         }
         else if(this.version == BIFFVersion.BIFF8)
         {
            _loc3_ = param1.readUnicodeStr16();
         }
         else
         {
            _loc4_ = param1.data.readUnsignedByte();
            _loc3_ = param1.data.readUTFBytes(_loc4_);
         }
         param2.header = _loc3_;
      }
      
      private function boundsheet(param1:Record, param2:Sheet) : void
      {
         var _loc6_:uint = 0;
         var _loc8_:Sheet = null;
         var _loc3_:uint = param1.data.readUnsignedInt();
         var _loc4_:uint = param1.data.readUnsignedByte();
         var _loc5_:uint = param1.data.readUnsignedByte();
         if(this.version == BIFFVersion.BIFF5)
         {
            _loc6_ = param1.data.readUnsignedByte();
         }
         else
         {
            _loc6_ = param1.data.readUnsignedShort();
         }
         var _loc7_:String = param1.data.readUTFBytes(_loc6_);
         _loc8_ = new Sheet();
         _loc8_.dateMode = this.dateMode;
         _loc8_.name = _loc7_;
         _loc8_.formats = _loc8_.formats.concat(this.globalFormats);
         _loc8_.xformats = _loc8_.xformats.concat(this.globalXFormats);
         this._sheets.addItem(_loc8_);
      }
      
      private function password(param1:Record, param2:Sheet) : void
      {
      }
      
      private function mergedcells(param1:Record, param2:Sheet) : void
      {
      }
      
      private function labelsst(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:uint = param1.data.readUnsignedInt();
         var _loc7_:String = this._sst[_loc6_];
         param2.setCell(_loc3_,_loc4_,_loc7_);
      }
      
      private function bottommargin(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readDouble();
      }
      
      private function filepass(param1:Record, param2:Sheet) : void
      {
      }
      
      private function style(param1:Record, param2:Sheet) : void
      {
      }
      
      private function refmode(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function objectprotect(param1:Record, param2:Sheet) : void
      {
      }
      
      private function delta(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readDouble();
      }
      
      private function shrfmla(param1:Record, param2:Sheet) : void
      {
         var _loc9_:ByteArray = null;
         var _loc11_:uint = 0;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedByte();
         var _loc6_:uint = param1.data.readUnsignedByte();
         ++param1.data.position;
         var _loc7_:uint = param1.data.readUnsignedByte();
         var _loc8_:uint = this.version == BIFFVersion.BIFF2 ? param1.data.readUnsignedByte() : param1.data.readUnsignedShort();
         var _loc10_:uint = _loc3_;
         while(_loc10_ < _loc4_)
         {
            _loc11_ = _loc5_;
            while(_loc11_ <= _loc6_)
            {
               _loc9_ = new ByteArray();
               _loc9_.endian = Endian.LITTLE_ENDIAN;
               param1.data.readBytes(_loc9_,0,_loc8_);
               param1.data.position -= _loc8_;
               param2.getCell(_loc10_,_loc11_).sharedTokens = _loc9_;
               _loc11_++;
            }
            _loc10_++;
         }
      }
      
      private function hcenter(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function dsf(param1:Record, param2:Sheet) : void
      {
      }
      
      private function externsheet(param1:Record, param2:Sheet) : void
      {
      }
      
      private function bof(param1:Record, param2:Sheet) : void
      {
         var _loc5_:Sheet = null;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         this.currentFileType = _loc4_;
         if(_loc4_ == SHEET)
         {
            if(this._sheets.length == 0)
            {
               _loc5_ = new Sheet();
               _loc5_.dateMode = this.dateMode;
               this._sheets.addItem(_loc5_);
               _loc5_.formats = _loc5_.formats.concat(this.globalFormats);
               _loc5_.xformats = _loc5_.xformats.concat(this.globalXFormats);
            }
            this.notes = new Array();
            this.currentSheet = this._sheets.getItemAt(this.currentSheetIdx) as Sheet;
            ++this.currentSheetIdx;
         }
         if(param1.type == 9)
         {
            this.version = BIFFVersion.BIFF2;
         }
         else if(param1.type == 521)
         {
            this.version = BIFFVersion.BIFF3;
         }
         else if(param1.type == 1033)
         {
            this.version = BIFFVersion.BIFF4;
         }
         else if(param1.type == 2057 && _loc3_ != 1536)
         {
            this.version = BIFFVersion.BIFF5;
         }
         else if(_loc4_ == 5)
         {
            this.version = BIFFVersion.BIFF8;
         }
      }
      
      private function font2(param1:Record, param2:Sheet) : void
      {
      }
      
      private function builtinfmtcount(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function wsbool(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function backup(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function rightmargin(param1:Record, param2:Sheet) : void
      {
         var _loc3_:Number = param1.data.readDouble();
      }
      
      private function dimensions(param1:Record, param2:Sheet) : void
      {
         if(param1.data.length == 0)
         {
            return;
         }
         var _loc3_:uint = param1.length == 14 ? param1.data.readUnsignedInt() : param1.data.readUnsignedShort();
         var _loc4_:uint = param1.length == 14 ? param1.data.readUnsignedInt() : param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:uint = param1.data.readUnsignedShort();
         param2.resize(_loc4_,_loc6_);
      }
      
      private function protect(param1:Record, param2:Sheet) : void
      {
      }
      
      private function saverecalc(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedByte() == 1;
      }
      
      private function writeprot(param1:Record, param2:Sheet) : void
      {
      }
      
      private function rangeprotection(param1:Record, param2:Sheet) : void
      {
      }
      
      private function index(param1:Record, param2:Sheet) : void
      {
      }
      
      private function calccount(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function iteration(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function windowprotect(param1:Record, param2:Sheet) : void
      {
         var _loc3_:* = param1.data.readUnsignedShort() == 1;
      }
      
      private function filesharing(param1:Record, param2:Sheet) : void
      {
      }
      
      private function row(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort() - 1;
         var _loc6_:uint = param1.data.readUnsignedShort();
         var _loc7_:uint = param1.data.readUnsignedShort();
         var _loc8_:* = param1.data.readUnsignedByte() == 1;
         var _loc9_:uint = param1.data.readUnsignedShort();
      }
      
      private function tableop2(param1:Record, param2:Sheet) : void
      {
      }
      
      private function crn(param1:Record, param2:Sheet) : void
      {
      }
      
      private function dbcell(param1:Record, param2:Sheet) : void
      {
      }
      
      private function xct(param1:Record, param2:Sheet) : void
      {
      }
      
      private function guts(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         var _loc5_:uint = param1.data.readUnsignedShort();
         var _loc6_:uint = param1.data.readUnsignedShort();
      }
      
      private function xf(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         switch(this.version)
         {
            case BIFFVersion.BIFF2:
               _loc3_ = param1.data.readUnsignedByte();
               ++param1.data.position;
               _loc4_ = uint(param1.data.readUnsignedByte() & 0x3F);
               break;
            case BIFFVersion.BIFF3:
            case BIFFVersion.BIFF4:
               _loc3_ = param1.data.readUnsignedByte();
               _loc4_ = param1.data.readUnsignedByte();
               break;
            case BIFFVersion.BIFF5:
               _loc3_ = param1.data.readUnsignedShort();
               _loc4_ = param1.data.readUnsignedShort();
               break;
            case BIFFVersion.BIFF8:
               _loc3_ = param1.data.readUnsignedShort();
               _loc4_ = param1.data.readUnsignedShort();
         }
         if(param2 is Sheet)
         {
            param2.xformats.push(new XFormat(param1.type,_loc4_));
         }
         else
         {
            this.globalXFormats.push(new XFormat(param1.type,_loc4_));
         }
      }
      
      private function note(param1:Record, param2:Sheet) : void
      {
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         if(this.version <= BIFFVersion.BIFF5)
         {
            _loc6_ = param1.data.readUnsignedShort();
            _loc5_ = param1.data.readUTFBytes(param1.data.bytesAvailable);
         }
         else
         {
            _loc7_ = param1.data.readUnsignedShort();
            _loc8_ = (param1.data.readUnsignedShort() - 1) * 2;
            _loc9_ = param1.readUnicodeStr16();
            _loc5_ = this.notes[_loc8_];
         }
         param2.getCell(_loc3_,_loc4_).note = _loc5_;
      }
      
      public function get sheets() : ArrayCollection
      {
         return this._sheets;
      }
      
      private function format(param1:Record, param2:Sheet) : void
      {
         if(this.version == BIFFVersion.BIFF4 || this.version == BIFFVersion.BIFF5)
         {
            param1.data.position += 2;
         }
         var _loc3_:uint = param1.data.readUnsignedByte();
         var _loc4_:String = param1.data.readUTFBytes(_loc3_);
         if(param2 is Sheet)
         {
            param2.formats.push(_loc4_);
         }
         else
         {
            this.globalFormats.push(_loc4_);
         }
      }
      
      private function label(param1:Record, param2:Sheet) : void
      {
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         if(param1.type == Type.LABEL)
         {
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
            param1.data.readUnsignedByte();
            _loc5_ = param1.data.readUnsignedByte();
         }
         else
         {
            _loc8_ = param1.data.readUnsignedShort();
            _loc5_ = param1.data.readUnsignedShort();
         }
         var _loc6_:String = param1.data.readUTFBytes(_loc5_);
         var _loc7_:String = param2.formats[param2.xformats[_loc8_].format];
         if(_loc7_ == null || _loc7_.length == 0)
         {
            _loc7_ = Formatter.builtInFormats[param2.xformats[_loc8_].format];
         }
         param2.setCell(_loc3_,_loc4_,_loc6_);
         param2.getCell(_loc3_,_loc4_).format = _loc7_;
      }
      
      private function codepage(param1:Record, param2:Sheet) : void
      {
         var _loc3_:uint = param1.data.readUnsignedShort();
      }
      
      private function mulrk(param1:Record, param2:Sheet) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc3_:uint = param1.data.readUnsignedShort();
         var _loc4_:uint = param1.data.readUnsignedShort();
         while(param1.data.bytesAvailable > 2)
         {
            _loc5_ = param1.data.readUnsignedShort();
            _loc6_ = this.readRK(param1,param2);
            _loc7_ = param2.formats[param2.xformats[_loc5_].format];
            if(_loc7_ == null || _loc7_.length == 0)
            {
               _loc7_ = Formatter.builtInFormats[param2.xformats[_loc5_].format];
            }
            param2.setCell(_loc3_,_loc4_,_loc6_);
            param2.getCell(_loc3_,_loc4_).format = _loc7_;
            _loc4_++;
         }
      }
   }
}

