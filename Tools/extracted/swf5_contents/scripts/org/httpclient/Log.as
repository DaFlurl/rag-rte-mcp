package org.httpclient
{
   import flash.utils.getQualifiedClassName;
   
   public class Log
   {
      public static const DEBUG:Number = 1;
      
      public static const INFO:Number = 2;
      
      public static const WARN:Number = 3;
      
      public static const ERROR:Number = 4;
      
      public static const OFF:Number = 5;
      
      public static var level:Number = INFO;
      
      public function Log()
      {
         super();
      }
      
      public static function error(... rest) : void
      {
         output("[ERROR] " + describeArgsToString(rest));
      }
      
      private static function output(param1:String) : void
      {
         trace(param1);
      }
      
      public static function describeArgs(param1:Array) : Array
      {
         var args:Array = param1;
         return args.map(function(param1:*, param2:int, param3:Array):*
         {
            return describe(param1);
         });
      }
      
      public static function describe(param1:*) : String
      {
         var entries:Array;
         var className:String;
         var key:String = null;
         var obj:* = param1;
         if(obj == null)
         {
            return "null";
         }
         if(obj is String)
         {
            return obj.toString();
         }
         if(obj is Number)
         {
            return obj.toString();
         }
         if(obj is Function)
         {
            return "(Function)";
         }
         if(obj is Array)
         {
            return "[ " + (obj as Array).map(function(param1:*, param2:int, param3:Array):String
            {
               return describe(param1);
            }).join(", ") + " ]";
         }
         entries = [];
         for(key in obj)
         {
            if(obj[key] != obj)
            {
               entries.push(key + ": " + obj[key]);
            }
         }
         if(entries.length > 0)
         {
            return "{" + entries.join(", ") + "}";
         }
         className = getQualifiedClassName(obj);
         return "(" + className + ") " + obj.toString();
      }
      
      public static function describeArgsToString(param1:Array) : String
      {
         if(param1.length == 0)
         {
            return "";
         }
         var _loc2_:Array = describeArgs(param1);
         if(_loc2_.length == 0)
         {
            return "";
         }
         return _loc2_.join(", ");
      }
      
      public static function warn(... rest) : void
      {
         if(level > WARN)
         {
            return;
         }
         output("[WARNING] " + describeArgsToString(rest));
      }
      
      public static function debug(... rest) : void
      {
         if(level > DEBUG)
         {
            return;
         }
         output(describeArgsToString(rest));
      }
   }
}

