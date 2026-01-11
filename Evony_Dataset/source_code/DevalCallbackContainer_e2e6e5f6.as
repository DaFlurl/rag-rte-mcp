// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.DevalCallbackContainer

package autoevony.scripts
{
    public class DevalCallbackContainer 
    {

        private var dynScriptLib:String = null;
        private var dynImportLib:String = null;
        private var thisScript:Script = null;
        public var varsObj:Object = null;
        private var funcName:String = null;

        public function DevalCallbackContainer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:Script)
        {
            this.dynImportLib = (_arg_3 + "");
            this.dynScriptLib = _arg_2;
            this.funcName = _arg_1;
            this.thisScript = _arg_4;
            this.varsObj = new Object();
        }

        public function callback(... _args):*
        {
            if (!_args)
            {
                _args = new Array();
            };
            this.varsObj[(this.funcName + "_callbackParametersArray")] = _args;
            return (this.thisScript.callbackHelper((((this.dynImportLib + "\n\n") + this.dynScriptLib) + "\n\n"), (((this.funcName + ".run(") + this.funcName) + "_callbackParametersArray);"), this.varsObj));
        }


    }
}//package autoevony.scripts

