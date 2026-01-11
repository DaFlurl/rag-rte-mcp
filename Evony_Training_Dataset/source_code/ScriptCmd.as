// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.ScriptCmd

package autoevony.scripts
{
    import autoevony.player.Map;
    import autoevony.common.Utils;

    public class ScriptCmd 
    {

        private static var TYPENAMES:Array = new Array("String", "Boolean", "Number", "int", "Coordinate", "Resource", "Fortification", "Troop", "*");

        public var func:Function;
        public var cmdName:String;
        private var params:Array;
        private var paramTypes:Array;
        private var nParamsRequired:int;

        public function ScriptCmd(_arg_1:String, _arg_2:Function, _arg_3:Array, _arg_4:Array, _arg_5:int)
        {
            var _local_6:String;
            super();
            this.func = _arg_2;
            this.cmdName = _arg_1;
            this.params = _arg_3;
            this.paramTypes = _arg_4;
            this.nParamsRequired = _arg_5;
            if (((!(_arg_3.length == _arg_4.length)) || (_arg_4.length < _arg_5)))
            {
                throw (new Error(("FATAL ERROR: Invalid param number in Script Prototype for " + _arg_1)));
            };
            for each (_local_6 in _arg_4)
            {
                if (TYPENAMES.indexOf(_local_6) == -1)
                {
                    throw (new Error(("FATAL ERROR: Invalid param type in Script Prototype for " + _arg_1)));
                };
            };
        }

        public static function getValue(_arg_1:String, _arg_2:String):Object
        {
            if (_arg_1 == "String")
            {
                return (_arg_2);
            };
            if (_arg_1 == "Boolean")
            {
                return (_arg_2.toLowerCase() == "true");
            };
            if (_arg_1 == "Coordinate")
            {
                return (Map.coordStringToFieldId(_arg_2));
            };
            if (_arg_1 == "Number")
            {
                return (Utils.removeAbbr(_arg_2));
            };
            if (_arg_1 == "int")
            {
                return (int(Utils.removeAbbr(_arg_2)));
            };
            if (_arg_1 == "Resource")
            {
                return ((_arg_2.toLowerCase() == "none") ? null : Utils.getEstResoBean(_arg_2));
            };
            if (_arg_1 == "Fortification")
            {
                return ((_arg_2.toLowerCase() == "none") ? null : Utils.getFortifications(_arg_2));
            };
            if (_arg_1 == "Troop")
            {
                return ((_arg_2.toLowerCase() == "none") ? null : Utils.getTroops(_arg_2));
            };
            throw (new Error("FATAL ERROR: Unexpected call to getValue in Script Prototype"));
        }


        public function hasInvalidArgs(_arg_1:Array):String
        {
            if (_arg_1.length < this.nParamsRequired)
            {
                if (this.paramTypes.length == this.nParamsRequired)
                {
                    return ((("Not enough params, " + this.nParamsRequired) + " are required\nUsage: ") + this.describeCmd());
                };
                return ((("Not enough params, at least " + this.nParamsRequired) + " are required\nUsage: ") + this.describeCmd());
            };
            if (((_arg_1.length > this.params.length) && ((this.paramTypes.length == 0) || (!(this.paramTypes[(this.paramTypes.length - 1)] == "*")))))
            {
                return ("Too many params, usage: " + this.describeCmd());
            };
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                if (this.paramTypes[_local_2] == "*") break;
                if (!this.isValidType(this.paramTypes[_local_2], _arg_1[_local_2]))
                {
                    return ((((((("Invalid value " + _arg_1[_local_2]) + " for param ") + this.params[_local_2]) + "(type ") + this.paramTypes[_local_2]) + ")\nUsage: ") + this.describeCmd());
                };
                _local_2++;
            };
            return (null);
        }

        private function isValidType(_arg_1:String, _arg_2:String):Boolean
        {
            if (((((!(_arg_2.indexOf("%") == -1)) || (!(_arg_2.indexOf("{") == -1))) || (!(_arg_2.indexOf("$") == -1))) || (((this.cmdName == "if") && (_arg_2.charAt(0) == "(")) && (_arg_2.charAt((_arg_2.length - 1)) == ")"))))
            {
                return (true);
            };
            if (_arg_1 == "String")
            {
                return (true);
            };
            if (_arg_1 == "Boolean")
            {
                return ((_arg_2.toLowerCase() == "true") || (_arg_2.toLowerCase() == "false"));
            };
            if (_arg_1 == "Number")
            {
                return (Utils.hasValue((Utils.removeAbbr(_arg_2) + "")));
            };
            if (_arg_1 == "int")
            {
                return ((Utils.hasValue((Utils.removeAbbr(_arg_2) + ""))) && (int(Utils.removeAbbr(_arg_2)) == Utils.removeAbbr(_arg_2)));
            };
            if (_arg_1 == "Coordinate")
            {
                return (!(Map.coordStringToFieldId(_arg_2) == -1));
            };
            if (_arg_1 == "Resource")
            {
                return ((_arg_2.toLowerCase() == "none") || (!(Utils.getEstResoBean(_arg_2) == null)));
            };
            if (_arg_1 == "Fortification")
            {
                return ((_arg_2.toLowerCase() == "none") || (!(Utils.getFortifications(_arg_2) == null)));
            };
            if (_arg_1 == "Troop")
            {
                return ((_arg_2.toLowerCase() == "none") || (!(Utils.getTroops(_arg_2) == null)));
            };
            throw (new Error(((("FATAL ERROR: Invalid Script Prototype for " + this.cmdName) + ", invalid type: ") + _arg_1)));
        }

        private function describeCmd():String
        {
            var _local_1:String = this.cmdName;
            var _local_2:int;
            while (_local_2 < this.params.length)
            {
                _local_1 = (_local_1 + (" " + ((_local_2 >= this.nParamsRequired) ? (("[" + this.params[_local_2]) + "]") : this.params[_local_2])));
                _local_2++;
            };
            return (_local_1);
        }

        public function getCmdInfo():String
        {
            var _local_1:String = this.describeCmd();
            var _local_2:int;
            while (_local_2 < this.params.length)
            {
                _local_1 = (_local_1 + ((("\n  " + this.params[_local_2]) + " is of type ") + this.paramTypes[_local_2]));
                _local_2++;
            };
            return (_local_1);
        }

        public function paramsToArray(_arg_1:Array):Array
        {
            var _local_4:Array;
            var _local_5:int;
            if (this.hasInvalidArgs(_arg_1) != null)
            {
                return (null);
            };
            var _local_2:Array = new Array();
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                if (this.paramTypes[_local_3] == "*") break;
                _local_2.push(getValue(this.paramTypes[_local_3], _arg_1[_local_3]));
                _local_3++;
            };
            if (((_local_3 < this.paramTypes.length) && (this.paramTypes[_local_3] == "*")))
            {
                _local_4 = new Array();
                _local_5 = _local_3;
                while (_local_5 < _arg_1.length)
                {
                    _local_4.push(_arg_1[_local_5]);
                    _local_5++;
                };
                _local_2.push(_local_4);
            };
            return (_local_2);
        }


    }
}//package autoevony.scripts

