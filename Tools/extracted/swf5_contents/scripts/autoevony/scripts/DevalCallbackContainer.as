package autoevony.scripts
{
   public class DevalCallbackContainer
   {
      private var dynScriptLib:String = null;
      
      private var dynImportLib:String = null;
      
      private var thisScript:Script = null;
      
      public var varsObj:Object = null;
      
      private var funcName:String = null;
      
      public function DevalCallbackContainer(param1:String, param2:String, param3:String, param4:Script)
      {
         super();
         this.dynImportLib = param3 + "";
         this.dynScriptLib = param2;
         this.funcName = param1;
         this.thisScript = param4;
         this.varsObj = new Object();
      }
      
      public function callback(... rest) : *
      {
         if(!rest)
         {
            rest = new Array();
         }
         this.varsObj[this.funcName + "_callbackParametersArray"] = rest;
         return this.thisScript.callbackHelper(this.dynImportLib + "\n\n" + this.dynScriptLib + "\n\n",this.funcName + ".run(" + this.funcName + "_callbackParametersArray);",this.varsObj);
      }
   }
}

