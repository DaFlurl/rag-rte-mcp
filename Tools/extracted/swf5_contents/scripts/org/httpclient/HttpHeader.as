package org.httpclient
{
   import com.adobe.utils.StringUtil;
   
   public class HttpHeader
   {
      private var _headers:Array;
      
      public function HttpHeader(param1:Array = null)
      {
         super();
         this._headers = param1;
         if(!this._headers)
         {
            this._headers = [];
         }
      }
      
      public function get content() : String
      {
         var _loc2_:Object = null;
         var _loc1_:String = "";
         for each(_loc2_ in this._headers)
         {
            _loc1_ += _loc2_["name"] + ": " + _loc2_["value"] + "\r\n";
         }
         return _loc1_;
      }
      
      public function add(param1:String, param2:String) : void
      {
         this._headers.push({
            "name":param1,
            "value":param2
         });
      }
      
      public function get isEmpty() : Boolean
      {
         return this._headers.length == 0;
      }
      
      public function remove(param1:String) : void
      {
         var _loc2_:int = this.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._headers.splice(_loc2_,1);
         }
      }
      
      public function get length() : Number
      {
         return this._headers.length;
      }
      
      public function indexOf(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._headers.length)
         {
            if(this._headers[_loc2_]["name"].toLowerCase() == param1.toLowerCase())
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function toString() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._headers)
         {
            _loc1_.push(_loc2_["name"] + ": " + _loc2_["value"]);
         }
         return _loc1_.join("\n");
      }
      
      public function get cookies() : String
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc1_:* = "";
         for each(_loc3_ in this._headers)
         {
            if(_loc3_["name"].toLowerCase() == "set-cookie")
            {
               if(_loc1_ != "")
               {
                  _loc1_ += "; ";
               }
               _loc2_ = _loc3_["value"].split(";")[0];
               _loc1_ += _loc2_;
            }
         }
         return _loc1_;
      }
      
      public function replace(param1:String, param2:String) : void
      {
         if(param2 == null)
         {
            this.remove(param1);
            return;
         }
         var _loc3_:Object = this.find(param1);
         if(_loc3_)
         {
            _loc3_["value"] = param2;
         }
         else
         {
            this.add(param1,param2);
         }
      }
      
      public function find(param1:String) : Object
      {
         var _loc2_:int = this.indexOf(param1);
         if(_loc2_ != -1)
         {
            return this._headers[_loc2_];
         }
         return null;
      }
      
      public function getValue(param1:String) : String
      {
         var _loc2_:Object = this.find(param1);
         if(_loc2_)
         {
            return _loc2_["value"];
         }
         return null;
      }
      
      public function contains(param1:String, param2:String) : Boolean
      {
         var _loc3_:Object = this.find(param1);
         if(!_loc3_)
         {
            return false;
         }
         return StringUtil.trim(_loc3_["value"].toLowerCase()) == param2.toLowerCase();
      }
   }
}

