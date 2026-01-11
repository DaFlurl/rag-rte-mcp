// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.scripts.Script

package autoevony.scripts
{
    import flash.events.EventDispatcher;
    import mx.rpc.http.HTTPService;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import flash.events.TimerEvent;
    import autoevony.event.CityStateCompleteEvent;
    import autoevony.event.CityStateResponseEvent;
    import r1.deval.D;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import autoevony.event.StopScriptEvent;
    import autoevony.common.ScriptError;
    import autoevony.common.Utils;
    import autoevony.common.TechType;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.ScriptLogEvent;
    import com.evony.common.beans.BuildingBean;
    import autoevony.gui.MainScreen;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.net.Connection;
    import flash.events.Event;
    import com.evony.common.constants.ErrorCode;
    import flash.utils.describeType;
    import flash.utils.getQualifiedClassName;
    import r1.deval.rt.FunctionDef;
    import mx.utils.Base64Encoder;
    import r1.deval.rt.Env;

    public class Script extends EventDispatcher 
    {

        private static var m_staticVars:Object = new Object();
        public static var BADOBJECT:Object = new Object();
        public static const NEWLINE:String = "ScriptNewLineEventType";

        private var snippetDownloader:HTTPService = null;
        private var m_stack:Array = null;
        private var m_sleeping:Boolean = false;
        private var m_scriptVarsProxy:ReScriptObjectProxy = null;
        private var m_curCmdIndex:int = 0;
        private var suppressError:Boolean = false;
        private var m_subparams:Array = null;
        private var m_ECMAScriptLibrary:String = "";
        private var snippetDownloaderCallback:Function = null;
        internal var silence:Boolean = false;
        private var m_scriptVars:Object = null;
        private var m_sleepTimer:Timer = null;
        private var m_cmdComplete:Boolean = false;
        private var currentSnippetDownloadUrl:String = null;
        private var m_script:Array = null;
        private var scriptCmds:Object = null;
        private var m_dynamicImportLibrary:String = "";
        private var m_running:Boolean = false;
        private var m_stopped:Boolean = false;
        public var m_city:CityState;

        public var prototype:Object = new Object();
        private var m_loopArray:Array = new Array();
        private var m_labelPos:Dictionary = new Dictionary();
        private var m_scriptTimer:Timer = new Timer(20, 0);
        private var m_dynamicCallBackLibrary:Object = new Object();

        public function Script(_arg_1:CityState)
        {
            this.m_city = _arg_1;
            this.m_scriptTimer.addEventListener(TimerEvent.TIMER, this.runScript);
            if (!this.m_city.hasEventListener(CityStateCompleteEvent.TYPE))
            {
                this.m_city.addEventListener(CityStateCompleteEvent.TYPE, this.handleCityCompleteEvent);
            };
            if (!this.m_city.hasEventListener(CityStateResponseEvent.TYPE))
            {
                this.m_city.addEventListener(CityStateResponseEvent.TYPE, this.handleCityResponseEvent);
            };
            this.setScriptCmds();
            D.useCache(false);
        }

        public function deleteStatic(_arg_1:String):*
        {
            var _local_2:* = null;
            if (m_staticVars[_arg_1] != undefined)
            {
                _local_2 = m_staticVars[_arg_1];
                delete m_staticVars[_arg_1];
            };
            return (_local_2);
        }

        public function stop():void
        {
            if (this.snippetDownloader != null)
            {
                this.snippetDownloader.removeEventListener(ResultEvent.RESULT, this.processDownloadedData);
                this.snippetDownloader.removeEventListener(FaultEvent.FAULT, this.processDownloadError);
                this.snippetDownloader = null;
            };
            this.snippetDownloaderCallback = null;
            this.m_running = false;
            this.m_stopped = true;
            if (this.m_sleepTimer != null)
            {
                this.clearSleepTimer(null, true);
            };
            this.m_scriptTimer.reset();
            this.m_sleeping = false;
            this.m_curCmdIndex = 0;
            this.m_labelPos = new Dictionary();
            this.m_loopArray = new Array();
            this.m_city.setCityStopState();
            this.m_stack = null;
            this.m_subparams = null;
            this.m_scriptVars = null;
            this.m_scriptVarsProxy = null;
            this.m_script = null;
            this.prototype = new Object();
            if (this.m_city.currentAction == "completequests")
            {
                CityState.findQuestCount = 0;
                CityState.findQuestCastleId = 0;
                CityState.scriptQuestActive = false;
            };
            var _local_1:StopScriptEvent = new StopScriptEvent(this.m_city.castleId);
            dispatchEvent(_local_1);
        }

        private function getSetarrayCmdLine(_arg_1:String):Array
        {
            var _local_3:int;
            var _local_2:Array = new Array();
            if ((((_arg_1.indexOf('["') == -1) || (_arg_1.indexOf('"]') == -1)) || (!(_arg_1.substring((_arg_1.length - 2)) == '"]'))))
            {
                throw (new ArgumentError((("Bad/missing brackets/quotes around array values on line: " + _arg_1) + '\nThe proper syntax is:  setarray arrName["string1", "string2", "string3"]')));
            };
            _local_2.push(_arg_1.substr(0, 8).toLowerCase());
            _local_3 = ((_arg_1.charAt((_arg_1.indexOf('["') - 1)) == " ") ? 1 : 0);
            _local_2.push(_arg_1.substring(9, (_arg_1.indexOf('["') - _local_3)));
            _local_2.push(_arg_1.substring(_arg_1.indexOf('["')));
            return (_local_2);
        }

        private function isValidVarName(_arg_1:String):Boolean
        {
            if (((!(_arg_1.charAt(0) == "_")) && (!(isNaN(Number(_arg_1.charAt(0)))))))
            {
                this.notifyCmdFinish(false, new ScriptError((((("Error in parameters for " + this.getCurrentCommand().scriptCmd.cmdName) + ' command: Illegal variable name "') + _arg_1) + '"  the first character must be a letter or _'), -9999));
                return (false);
            };
            if (_arg_1.replace(/\W+?|\*/g, "") != _arg_1)
            {
                this.notifyCmdFinish(false, new ScriptError((((("Error in parameters for " + this.getCurrentCommand().scriptCmd.cmdName) + ' command: Illegal character(s) in variable name "') + _arg_1) + '" you may only use letters, numbers and _'), -9999));
                return (false);
            };
            return (true);
        }

        private function ifCompare(_arg_1:String, _arg_2:String, _arg_3:String):Boolean
        {
            var _local_4:Object = this.getValue(_arg_1);
            var _local_5:Object = this.getValue(_arg_3);
            if (((_local_4 == BADOBJECT) || (_local_5 == BADOBJECT)))
            {
                this.notifyCmdFinish(false);
            };
            if (_arg_2 == ">=")
            {
                return (_local_4 >= _local_5);
            };
            if (_arg_2 == ">")
            {
                return (_local_4 > _local_5);
            };
            if (_arg_2 == "<=")
            {
                return (_local_4 <= _local_5);
            };
            if (_arg_2 == "<")
            {
                return (_local_4 < _local_5);
            };
            if (((_arg_2 == "==") || (_arg_2 == "=")))
            {
                return (_local_4 == _local_5);
            };
            if (((_arg_2 == "!=") || (_arg_2 == "<>")))
            {
                return (!(_local_4 == _local_5));
            };
            return (false);
        }

        public function get m_castle():CityState
        {
            return (this.m_city);
        }

        public function deleteCallback(_arg_1:String=null):void
        {
            if (this.m_dynamicCallBackLibrary[_arg_1] != undefined)
            {
                delete this.m_dynamicCallBackLibrary[_arg_1];
            };
        }

        private function getIndexOf(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            if (this.m_scriptVars[_arg_2].length == undefined)
            {
                this.notifyCmdFinish(false, new ScriptError((((("Invalid array name '" + _arg_2) + "' used in 'getindexof' command. Array '") + _arg_2) + "' does not exist."), -9999));
                return;
            };
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (this.m_scriptVars[_arg_1] is Array)))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for getindexof command: Attempting to assign value of incompatible type to an already defined variable "' + _arg_1) + '" of type Array'), -9999));
                return;
            };
            if (!this.isValidVarName(_arg_1))
            {
                return;
            };
            _arg_3 = this.subVarValues(_arg_3, this.m_scriptVars);
            if (_arg_3 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            this.m_scriptVars[_arg_1] = this.m_scriptVars[_arg_2].indexOf(_arg_3);
            if (!this.silence)
            {
                this.logMsg(((("Set variable '" + _arg_1) + "' to index:  ") + this.m_scriptVars[_arg_1]));
            };
            this.notifyCmdFinish(true);
        }

        private function timedCommand(command:ScriptCommand, time:String):void
        {
            var timeInt:int;
            if (time.indexOf(":") > 0)
            {
                if (time.toString().substr(0, 1) == "@")
                {
                    timeInt = this.m_city.parseTime(time.toString().replace("@:", ""), true);
                }
                else
                {
                    timeInt = this.m_city.parseTime(time.toString());
                };
            }
            else
            {
                timeInt = int(time);
            };
            timeInt = (timeInt * 1000);
            var runTime:Date = new Date();
            runTime.setTime((runTime.getTime() + timeInt));
            this.logMsg(((("Setting " + command.scriptCmd.cmdName) + " to run at ") + runTime.toLocaleString()));
            Utils.callLater(timeInt, function ():void
            {
                command.scriptCmd.func.apply(this, command.params);
            });
        }

        public function logResearchAction(_arg_1:String, _arg_2:Date, _arg_3:AvailableResearchListBean, _arg_4:CastleBean):void
        {
            this.logMsg(((((("Performing " + _arg_1) + " on level ") + _arg_3.level) + " ") + TechType.toString(_arg_3.typeId)));
            this._mk747(_arg_2);
        }

        private function setArray(_arg_1:String, _arg_2:String):void
        {
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (!(this.m_scriptVars[_arg_1] is Array))))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for setarray command: Attempting to assign value of type Array to an already defined variable "' + _arg_1) + '" of another type'), -9999));
                return;
            };
            if (!this.isValidVarName(_arg_1))
            {
                return;
            };
            _arg_2 = this.subVarValues(_arg_2, this.m_scriptVars);
            if (_arg_2 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            var _local_3:Array = _arg_2.substring(2).slice(0, -2).split(String('", "'));
            this.m_scriptVars[_arg_1] = _local_3;
            if (!this.silence)
            {
                this.logMsg((((("Set array '" + _arg_1) + "' to:  [\"") + this.m_scriptVars[_arg_1].join('", "')) + '"]'));
            };
            this.notifyCmdFinish(true);
        }

        public function set_m_script(scriptText:String):void
        {
            if (this.m_running)
            {
                return;
            };
            if (this.snippetDownloader != null)
            {
                this.snippetDownloader.removeEventListener(ResultEvent.RESULT, this.processDownloadedData);
                this.snippetDownloader.removeEventListener(FaultEvent.FAULT, this.processDownloadError);
                this.snippetDownloader = null;
            };
            this.snippetDownloader = new HTTPService();
            this.snippetDownloader.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
            this.snippetDownloader.addEventListener(ResultEvent.RESULT, this.processDownloadedData);
            this.snippetDownloader.addEventListener(FaultEvent.FAULT, this.processDownloadError);
            try
            {
                this.processScriptText(scriptText);
            }
            catch(aE:ArgumentError)
            {
                this.onArgumentError(aE);
            }
            catch(e:Error)
            {
                this.onPreProcessingError(e);
            };
        }

        private function ifGoSub(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String):void
        {
            if (this.ifCompare(_arg_2, _arg_3, _arg_4))
            {
                this.goSub(_arg_6);
                return;
            };
            this.notifyCmdFinish(true);
        }

        private function handleCityResponseEvent(_arg_1:CityStateResponseEvent):void
        {
            var _local_2:BuildComplate;
            var _local_3:ResearchResponse;
            if ((_arg_1.response is BuildComplate))
            {
                _local_2 = (_arg_1.response as BuildComplate);
                this.logBuildAction(_arg_1.message, new Date(_local_2.buildingBean.endTime), _local_2.buildingBean, this.m_city.castle);
            };
            if ((_arg_1.response is ResearchResponse))
            {
                _local_3 = (_arg_1.response as ResearchResponse);
                this.logResearchAction(_arg_1.message, new Date(_local_3.tech.endTime), _local_3.tech, this.m_city.castle);
            }
            else
            {
                if ((_arg_1.response is CommandResponse))
                {
                    this.logMsg(((_arg_1.response.ok + ": ") + _arg_1.response.msg), _arg_1.textcolor);
                }
                else
                {
                    if ((_arg_1.response is String))
                    {
                        this.logMsg(((_arg_1.response + " ") + _arg_1.message), _arg_1.textcolor);
                    };
                };
            };
        }

        private function ifGoto(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String):void
        {
            if (this.ifCompare(_arg_2, _arg_3, _arg_4))
            {
                this._SafeStr_1(_arg_6);
                return;
            };
            this.notifyCmdFinish(true);
        }

        private function split(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (!(this.m_scriptVars[_arg_1] is Array))))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for split command: Attempting to assign value of type Array to an already defined variable "' + _arg_1) + '" of another type'), -9999));
                return;
            };
            if (!this.isValidVarName(_arg_1))
            {
                return;
            };
            _arg_3 = this.subVarValues(_arg_3, this.m_scriptVars);
            if (_arg_3 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            var _local_4:Array = _arg_3.split(_arg_2);
            this.m_scriptVars[_arg_1] = _local_4;
            if (!this.silence)
            {
                this.logMsg((((("Set array '" + _arg_1) + "' to:  [\"") + this.m_scriptVars[_arg_1].join('", "')) + '"]'));
            };
            this.notifyCmdFinish(true);
        }

        public function logError(_arg_1:String):void
        {
            if (this.suppressError)
            {
                return;
            };
            _arg_1 = _arg_1.split(">").join("&gt;").split("<").join("&lt;");
            dispatchEvent(new ScriptLogEvent(((("<font color='#ff0000'>(" + this.m_city.castle.name) + ") - ") + _arg_1), (ScriptLogEvent.ERROR + "</font>"), this.m_city));
        }

        private function echo(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null):void
        {
            var _local_7:Array = new Array(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            var _local_8:* = "";
            var _local_9:int;
            while (_local_9 < _local_7.length)
            {
                if (_local_7[_local_9] == null) break;
                _local_8 = (_local_8 + (_local_7[_local_9] + " "));
                _local_9++;
            };
            this.logMsg(_local_8);
            this.notifyCmdFinish(true);
        }

        private function join(_arg_1:String, _arg_2:String, _arg_3:String=""):void
        {
            if (((!(this.m_scriptVars[_arg_2] == undefined)) && (!(this.m_scriptVars[_arg_2] is Array))))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for join command: The specified array name "' + _arg_2) + '" points to a variable that is not an Array'), -9999));
                return;
            };
            if (this.m_scriptVars[_arg_2] == undefined)
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for join command: The specified array "' + _arg_2) + '" is undefined'), -9999));
                return;
            };
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (this.m_scriptVars[_arg_1] is Array)))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for join command: Attempting to assign value of incompatible type to an already defined variable "' + _arg_1) + '" of type Array'), -9999));
                return;
            };
            if (!this.isValidVarName(_arg_1))
            {
                return;
            };
            this.m_scriptVars[_arg_1] = this.m_scriptVars[_arg_2].join(_arg_3);
            if (!this.silence)
            {
                this.logMsg((((("Set variable '" + _arg_1) + "' to:  \"") + this.m_scriptVars[_arg_1]) + '"'));
            };
            this.notifyCmdFinish(true);
        }

        public function lineElementsToArray(_arg_1:String):Array
        {
            var _local_8:String;
            var _local_9:String;
            if (((_arg_1.length > 9) && (_arg_1.substr(0, 9).toLowerCase() == "setarray ")))
            {
                return (this.getSetarrayCmdLine(_arg_1));
            };
            var _local_2:Array = _arg_1.split(" ");
            var _local_3:Array = new Array();
            while (((_local_2.length > 1) && (_local_2[1] == "")))
            {
                _local_2.splice(1, 1);
            };
            if (((_local_2[0].toLowerCase() == "if") && (_local_2[1].charAt(0) == "(")))
            {
                if (_local_2[1].charAt(1) == ")")
                {
                    throw (new ArgumentError(("Invalid/missing condition statement for if command on line: " + _arg_1)));
                };
                _local_2.shift();
                _local_8 = _local_2.join(" ").substr(1);
                _local_9 = "(";
                while (true)
                {
                    if (_local_8.length <= 1)
                    {
                        throw (new ArgumentError(("Unmatched parentheses in condition statement for if command on line: " + _arg_1)));
                    };
                    _local_9 = (_local_9 + _local_8.charAt(0));
                    _local_8 = _local_8.substr(1);
                    if (_local_9.split("(").length == _local_9.split(")").length)
                    {
                        _local_8 = Utils.trim(_local_8);
                        _local_2 = (((_local_8.length > 9) && (_local_8.substr(0, 9).toLowerCase() == "setarray ")) ? this.getSetarrayCmdLine(_local_8) : _local_8.split(" "));
                        _local_2.unshift(_local_9);
                        _local_2.unshift("if");
                        break;
                    };
                };
                _local_3.push(_local_2.shift());
                _local_3.push(_local_2.shift());
                while (_local_2.length > 0)
                {
                    if (String(_local_2[0]).indexOf('"') == -1)
                    {
                        _local_3.push(_local_2.shift());
                    }
                    else
                    {
                        break;
                    };
                };
                if (_local_2.length > 0)
                {
                    _local_8 = _local_2.join(" ");
                    if (_local_8.charAt(0) == '"')
                    {
                        _local_8 = _local_8.substr(1);
                    };
                    if (_local_8.charAt((_local_8.length - 1)) == '"')
                    {
                        _local_8 = _local_8.substring(0, (_local_8.length - 1));
                    };
                    _local_3.push(_local_8);
                };
                return (_local_3);
            };
            var _local_4:Boolean;
            var _local_5:int = 1;
            while (_local_5 < _local_2.length)
            {
                if (_local_2[_local_5].substring(0, 7) == "$m_dyn.")
                {
                    _local_4 = true;
                    while (String(_local_2[_local_5]).substr(7).indexOf("$") == -1)
                    {
                        _local_2[_local_5] = ((_local_2[_local_5] + " ") + _local_2.splice((_local_5 + 1), 1));
                        if (_local_5 == _local_2.length)
                        {
                            throw (new ArgumentError(("No closing $ found to terminate $m_dyn statement in line: " + _arg_1)));
                        };
                    };
                };
                _local_5++;
            };
            if (_local_4)
            {
                return (_local_2);
            };
            var _local_6:int;
            var _local_7:int;
            _local_8 = _arg_1;
            _local_5 = 0;
            while (_local_5 < _local_8.length)
            {
                if (_local_8.charAt(_local_5) == " ")
                {
                    _local_5++;
                }
                else
                {
                    if (_local_8.charAt(_local_5) == '"')
                    {
                        _local_7 = _local_8.indexOf('"', (_local_5 + 1));
                        if (((_local_7 == -1) || ((_local_7 < (_local_8.length - 1)) && (!(_local_8.charAt((_local_7 + 1)) == " ")))))
                        {
                            throw (new ArgumentError(("Bad double quotes on line " + _arg_1)));
                        };
                        _local_3.push(_local_8.substring((_local_5 + 1), _local_7));
                        if ((_local_5 = (_local_7 + 1)) == _local_8.length) break;
                    };
                    if ((_local_6 = _local_8.indexOf(" ", _local_5)) == -1)
                    {
                        _local_3.push(_local_8.substr(_local_5));
                        break;
                    };
                    _local_3.push(_local_8.substring(_local_5, _local_6));
                    _local_5 = (_local_6 + 1);
                };
            };
            return (_local_3);
        }

        private function processDownloadError(_arg_1:FaultEvent):void
        {
            this.onArgumentError(new ArgumentError(("Error preprocessing script, failed to load " + this.currentSnippetDownloadUrl)));
        }

        private function goSub(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null, _arg_7:String=null, _arg_8:String=null, _arg_9:String=null, _arg_10:String=null, _arg_11:String=null):void
        {
            if (this.m_stack.length > 200)
            {
                this.notifyCmdFinish(false, new ScriptError("Stack overflow in gosub command", -9999));
                return;
            };
            this.m_stack.push(this.m_curCmdIndex);
            this.m_subparams.push(this._ft1407());
            this._ao680({
                "_1":_arg_2,
                "_2":_arg_3,
                "_3":_arg_4,
                "_4":_arg_5,
                "_5":_arg_6,
                "_6":_arg_7,
                "_7":_arg_8,
                "_8":_arg_9,
                "_9":_arg_10,
                "_10":_arg_11
            });
            this._SafeStr_1(_arg_1);
        }

        public function notifyCmdFinish(_arg_1:Boolean, _arg_2:ScriptError=null):void
        {
            var _local_3:Boolean = true;
            if (this.m_stopped)
            {
                return;
            };
            if (!_arg_1)
            {
                _local_3 = this.handleScriptError(_arg_2);
            };
            this.m_cmdComplete = _local_3;
            this.m_running = (!(_local_3));
        }

        private function _lc356(_arg_1:String):Object
        {
            var _local_12:Array;
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:int;
            var _local_6:Object;
            var _local_7:int;
            var _local_8:Array = new Array("||", "^", "*", "/", "\\", "|", "+", "-", "&&", ">=", "<=", ">", "<", "==", "!=");
            var _local_9:Array = new Array();
            var _local_10:int;
            while (true)
            {
                if (_local_10 == _arg_1.length) break;
                if (_arg_1.charAt(_local_10) == "{")
                {
                    if ((_local_5 = this.getIndexForMatchingCloseBracket(_arg_1, _local_10)) == -1)
                    {
                        this.logError(((("Unmatched { in " + _arg_1) + " at position ") + _local_10));
                        return (null);
                    };
                    if ((_local_6 = this._lc356(_arg_1.substring((_local_10 + 1), _local_5))) == null)
                    {
                        return (null);
                    };
                    _local_10 = (_local_5 + 1);
                    _local_9.push(_local_6);
                }
                else
                {
                    if (((_arg_1.charAt(_local_10) == "!") && (!(_arg_1.substr(_local_10, 2) == "!="))))
                    {
                        _local_9.push("!");
                        _local_10++;
                    }
                    else
                    {
                        _local_2 = _arg_1.length;
                        _local_3 = null;
                        for each (_local_4 in _local_8)
                        {
                            _local_7 = _arg_1.indexOf(_local_4, _local_10);
                            if (_local_7 != -1)
                            {
                                if ((_local_7 < _local_2))
                                {
                                    _local_2 = _local_7;
                                    _local_3 = _local_4;
                                };
                            };
                        };
                        if (_local_3 == null)
                        {
                            _local_9.push(_arg_1.substr(_local_10));
                            break;
                        };
                        if (_local_10 != _local_2)
                        {
                            _local_9.push(_arg_1.substring(_local_10, _local_2));
                        };
                        _local_9.push(_local_3);
                        _local_10 = (_local_2 + _local_3.length);
                    };
                };
            };
            if (_local_9.length == 0)
            {
                this.logError(("Internal parsing error for " + _arg_1));
                return (null);
            };
            _local_10 = 0;
            while (_local_10 < _local_9.length)
            {
                if ((_local_9[_local_10] is String))
                {
                    if (_local_9[_local_10] == "-")
                    {
                        if (_local_10 == (_local_9.length - 1))
                        {
                            this.logError("Invalid operand for operation -");
                            return (null);
                        };
                        if (((_local_10 == 0) || ((_local_9[(_local_10 - 1)] is String) && (!(_local_8.indexOf(_local_9[(_local_10 - 1)]) == -1)))))
                        {
                            _local_9.splice(_local_10, 2, {
                                "op":"-",
                                "oper1":0,
                                "oper2":_local_9[(_local_10 + 1)]
                            });
                            _local_10--;
                        };
                    }
                    else
                    {
                        if (_local_9[_local_10] == "!")
                        {
                            if (_local_10 == (_local_9.length - 1))
                            {
                                this.logError("Invalid operand for operation !");
                                return (null);
                            };
                            _local_9.splice(_local_10, 2, {
                                "op":"!",
                                "oper1":_local_9[(_local_10 + 1)],
                                "oper2":null
                            });
                            _local_10--;
                        };
                    };
                };
                _local_10++;
            };
            var _local_11:Array = [["^"], ["*", "/", "\\", "|"], ["+", "-"], [">=", "<=", ">", "<"], ["==", "!="], ["&&"], ["||"]];
            for each (_local_12 in _local_11)
            {
                _local_10 = 1;
                while (_local_10 < _local_9.length)
                {
                    if ((_local_9[_local_10] is String))
                    {
                        if (_local_12.indexOf(_local_9[_local_10]) != -1)
                        {
                            if (((_local_10 == 0) || (_local_10 == (_local_9.length - 1))))
                            {
                                this.logError(("Invalid operand for binary operator " + _local_9[_local_10]));
                                return (null);
                            };
                            _local_9.splice((_local_10 - 1), 3, {
                                "op":_local_9[_local_10],
                                "oper1":_local_9[(_local_10 - 1)],
                                "oper2":_local_9[(_local_10 + 1)]
                            });
                            _local_10--;
                        };
                    };
                    _local_10++;
                };
            };
            if (_local_9.length > 1)
            {
                this.logError(("Too few operators in " + _arg_1));
                return (null);
            };
            return (_local_9[0]);
        }

        private function parseExpr(_arg_1:String):String
        {
            var _local_2:Object = this._lc356(_arg_1);
            if (_local_2 == null)
            {
                this.logError(("Unable to parse expression: " + _arg_1));
                return (null);
            };
            var _local_3:Object = this.doEval(_local_2);
            if (_local_3 == BADOBJECT)
            {
                return (null);
            };
            return (_local_3.toString());
        }

        private function listCommands(_arg_1:String=""):void
        {
            var _local_4:ScriptCmd;
            _arg_1 = _arg_1.toLowerCase();
            var _local_2:* = "<b>List of script commands:</b>\n<b>Core commands:</b>   ";
            var _local_3:int;
            for each (_local_4 in this.scriptCmds)
            {
                if (_local_4.cmdName.indexOf(_arg_1) != -1)
                {
                    _local_3++;
                    _local_2 = (_local_2 + (_local_4.cmdName + "  "));
                };
            };
            _local_2 = (_local_2 + (((_local_3 > 0) ? "" : "<i>[none]</i>") + "\n<b>Additional commands:</b>   "));
            _local_3 = 0;
            for each (_local_4 in this.m_city._getScriptCmds())
            {
                if (_local_4.cmdName.indexOf(_arg_1) != -1)
                {
                    _local_3++;
                    _local_2 = (_local_2 + (_local_4.cmdName + "  "));
                };
            };
            _local_2 = (_local_2 + (((_local_3 > 0) ? "" : "[ none ]") + "\n"));
            this.logMsg(_local_2, "#000000", false);
            this.logMsg("Use 'info command' for information on a specific script command");
            if (((_arg_1 == "") && (_local_2.length > 200)))
            {
                this.logMsg("Consider using 'listcommands filter', for example 'listcommands at' to restrict the command");
            };
            this.notifyCmdFinish(true);
        }

        private function checkForAndHandleUserVariables(_arg_1:String, _arg_2:Object):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_7:int;
            var _local_11:* = "";
            while (true)
            {
                if ((_local_3 = _arg_1.indexOf("%", _local_7)) == -1) break;
                if ((_local_4 = _arg_1.indexOf("%", (_local_3 + 1))) == -1)
                {
                    this.logError(("Unmatched % in " + _arg_1));
                    return (null);
                };
                if (((!((_local_5 = _arg_1.indexOf("{", (_local_3 + 1))) == -1)) && (_local_5 < _local_4)))
                {
                    if ((_local_6 = this.getIndexForMatchingCloseBracket(_arg_1, _local_5)) == -1)
                    {
                        this.logError(("Unmatched bracket in " + _arg_1));
                        return (null);
                    };
                    if ((_local_4 = _arg_1.indexOf("%", (_local_6 + 1))) == -1)
                    {
                        this.logError(("Unmatched % in " + _arg_1));
                        return (null);
                    };
                    if ((_local_10 = this.subVarValues(_arg_1.substring(_local_5, (_local_6 + 1)), _arg_2)) == null)
                    {
                        return (null);
                    };
                    _local_8 = ((_arg_1.substring((_local_3 + 1), _local_5) + _local_10) + _arg_1.substring((_local_6 + 1), _local_4));
                }
                else
                {
                    _local_8 = _arg_1.substring((_local_3 + 1), _local_4);
                };
                if ((_local_8 = this.checkForAndHandleEvalStatements(_local_8)) == null)
                {
                    return (null);
                };
                if ((_local_9 = this.getValueFromVarName(_local_8, _arg_2)) == null)
                {
                    this.logError(("Undefined variable " + _arg_1.substring(_local_3, (_local_4 + 1))));
                    return (null);
                };
                _local_11 = (_local_11 + (_arg_1.substring(_local_7, _local_3) + _local_9));
                _local_7 = (_local_4 + 1);
            };
            return (_local_11 + _arg_1.substr(_local_7));
        }

        private function _ft1407():Object
        {
            var _local_1:String;
            var _local_2:Object = new Object();
            for (_local_1 in this.m_scriptVars)
            {
                if (_local_1.charAt(0) == "_")
                {
                    _local_2[_local_1] = this.m_scriptVars[_local_1];
                    delete this.m_scriptVars[_local_1];
                };
            };
            return (_local_2);
        }

        private function runScript(_arg_1:TimerEvent):void
        {
            if (((!(this.m_cmdComplete)) && (this.m_running)))
            {
                return;
            };
            if (this.m_curCmdIndex < this.m_script.length)
            {
                if (this.m_stopped)
                {
                    return;
                };
                this.m_running = true;
                this.m_cmdComplete = false;
                this.runCurrentCmd();
            }
            else
            {
                this.logMsg("Finished script");
                this.stop();
            };
        }

        internal function callbackHelper(dynCode:String, exec:String, varsLib:Object):*
        {
            try
            {
                return (D.eval((dynCode + exec), varsLib, this));
            }
            catch(exc:Error)
            {
                this.logError(((((("Callback error while referencing dynamic library in: " + exec) + " : ") + exc.errorID) + ":   ") + exc.message));
            };
            this.prototype = new Object();
            return (null);
        }

        private function logBuildAction(_arg_1:String, _arg_2:Date, _arg_3:BuildingBean, _arg_4:CastleBean):void
        {
            this.logMsg(((((("Performing " + _arg_1) + " on level ") + _arg_3.level) + " ") + _arg_3.name));
            this._mk747(_arg_2);
        }

        public function get c():CityState
        {
            return (this.m_city);
        }

        public function setVar(_arg_1:String, _arg_2:*):*
        {
            if ((((_arg_2 is Array) && (!(this.m_scriptVars[_arg_1] == undefined))) && (!(this.m_scriptVars[_arg_1] is Array))))
            {
                throw (new ArgumentError("Error in parameters for setVar(): Attempting to assign value of type Array to an already defined variable of another type"));
            };
            if (((!(_arg_2 is Array)) && (this.m_scriptVars[_arg_1] is Array)))
            {
                throw (new ArgumentError("Error in parameters for setVar(): Attempting to assign value of incompatible type to an already defined variable of type Array"));
            };
            if (((!(_arg_1.charAt(0) == "_")) && (!(isNaN(Number(_arg_1.charAt(0)))))))
            {
                throw (new ArgumentError((('Error in parameters for setVar(): Illegal variable name "' + _arg_1) + '"  the first character must be a letter or _')));
            };
            if (_arg_1.replace(/\W+?|\*/g, "") != _arg_1)
            {
                throw (new ArgumentError((('Error in parameters for setVar(): Illegal character(s) in variable name "' + _arg_1) + '" you may only use letters, numbers and _')));
            };
            this.m_scriptVars[_arg_1] = _arg_2;
            return (this.getVar(_arg_1));
        }

        private function processScriptText(scriptText:String, count:int=20):void
        {
            var lines:Array;
            var i:int;
            var y:String;
            var processResult:Function;
            var url:String;
            var urlcheck:Boolean;
            if (count <= 0)
            {
                throw (new ArgumentError("Error processing script, too many redirects"));
            };
            lines = scriptText.split(new RegExp("\r|\n"));
            if ((lines = MainScreen.getInstance()._snippets.getTrimmedSnippetCmdLines(lines)) == null)
            {
                throw (new ArgumentError("Script preprocessing error while loading snippets, please check all include lines"));
            };
            scriptText = lines.join("\n");
            i = 0;
            for (;i < lines.length;(i = (i + 1)))
            {
                y = Utils.trim(lines[i]);
                if (y.substr(0, 11) == "includeurl ")
                {
                    url = y.substr(11);
                    urlcheck = true;
                }
                else
                {
                    if (y.substr(0, 12) == "includefile ")
                    {
                        url = y.substr(12);
                        urlcheck = false;
                    }
                    else
                    {
                        continue;
                    };
                };
                processResult = function (result:String):void
                {
                    var nextpart:Array = lines.splice(i, (lines.length - i));
                    nextpart.splice(0, 1);
                    var totaltext:String = ((((lines.join("\n") + "\n") + result) + "\n") + nextpart.join("\n"));
                    try
                    {
                        this.processScriptText(totaltext, (count - 1));
                    }
                    catch(aE:ArgumentError)
                    {
                        this.onArgumentError(aE);
                    }
                    catch(e:Error)
                    {
                        this.onPreProcessingError(e);
                    };
                };
                try
                {
                    this.downloadUrl(url, urlcheck, processResult);
                }
                catch(aE:ArgumentError)
                {
                    this.onArgumentError(aE);
                }
                catch(e:Error)
                {
                    this.onPreProcessingError(e);
                };
                return;
            };
            try
            {
                this._set_m_script(scriptText);
                this.startExecUserScript();
            }
            catch(aE:ArgumentError)
            {
                this.onArgumentError(aE);
            }
            catch(e:Error)
            {
                this.onPreProcessingError(e);
            };
        }

        private function _SafeStr_1(_arg_1:String):void
        {
            this.m_curCmdIndex = this._pp316(_arg_1);
            if (this.m_curCmdIndex == -1)
            {
                this.logError(("Invalid label " + _arg_1));
            }
            else
            {
                if (!this.silence)
                {
                    this.logMsg(("Going to line " + (this.m_curCmdIndex + 1)));
                };
            };
            this.notifyCmdFinish(true);
        }

        public function getStatic(_arg_1:String):*
        {
            return ((m_staticVars[_arg_1] == undefined) ? null : m_staticVars[_arg_1]);
        }

        public function setStatic(_arg_1:String, _arg_2:*):*
        {
            if (((!(_arg_1.charAt(0) == "_")) && (!(isNaN(Number(_arg_1.charAt(0)))))))
            {
                throw (new ArgumentError((('Error in parameters for setStatic(): Illegal variable name "' + _arg_1) + '"  the first character must be a letter or _')));
            };
            if (_arg_1.replace(/\W+?|\*/g, "") != _arg_1)
            {
                throw (new ArgumentError((('Error in parameters for setStatic(): Illegal character(s) in variable name "' + _arg_1) + '" you may only use letters, numbers and _')));
            };
            return (m_staticVars[_arg_1] = _arg_2);
        }

        public function deleteVar(_arg_1:String):*
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            var _local_2:* = null;
            if (this.m_scriptVars[_arg_1] != undefined)
            {
                _local_2 = this.m_scriptVars[_arg_1];
                delete this.m_scriptVars[_arg_1];
            }
            else
            {
                if ((((!((_local_3 = _arg_1.indexOf("[")) == -1)) && (_arg_1.indexOf("]") == (_arg_1.length - 1))) && (Utils.hasValue(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1))))))
                {
                    _local_4 = _arg_1.substring(0, _arg_1.indexOf("["));
                    _local_5 = int(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1)));
                    if (this.m_scriptVars[_local_4].length != undefined)
                    {
                        _local_2 = this.m_scriptVars[_local_4].splice(_local_5, 1)[0];
                    };
                };
            };
            return (_local_2);
        }

        private function checkForAndHandleEvalStatements(_arg_1:String):String
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:String;
            var _local_5:* = "";
            var _local_6:int;
            while (true)
            {
                if ((_local_2 = _arg_1.indexOf("{", _local_6)) == -1) break;
                if ((_local_3 = this.getIndexForMatchingCloseBracket(_arg_1, _local_2)) == -1)
                {
                    this.logError(("Brackets are not matched in " + _arg_1));
                    return (null);
                };
                _local_4 = _arg_1.substring((_local_2 + 1), _local_3);
                if ((_local_4 = this.parseExpr(_local_4)) == null)
                {
                    return (null);
                };
                _local_5 = (_local_5 + (_arg_1.substring(_local_6, _local_2) + _local_4.toString()));
                _local_6 = (_local_3 + 1);
            };
            if (_arg_1.indexOf("}", _local_6) != -1)
            {
                this.logError(("Brackets are not matched in " + _arg_1));
                return (null);
            };
            return (_local_5 + _arg_1.substr(_local_6));
        }

        public function _cleanUp():void
        {
            this.stop();
            this.m_scriptTimer.removeEventListener(TimerEvent.TIMER, this.runScript);
            this.m_scriptTimer = null;
            this.m_city.removeEventListener(CityStateCompleteEvent.TYPE, this.handleCityCompleteEvent);
            this.m_city.removeEventListener(CityStateResponseEvent.TYPE, this.handleCityResponseEvent);
            this.m_dynamicCallBackLibrary = null;
            this.scriptCmds = null;
            this.prototype = null;
            this.m_loopArray = null;
            this.m_labelPos = null;
            this.m_city = null;
        }

        public function getCallbackVars(_arg_1:String=null):Object
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            if (this.m_dynamicCallBackLibrary[_arg_1] == undefined)
            {
                return (null);
            };
            return ((this.m_dynamicCallBackLibrary[_arg_1] as DevalCallbackContainer).varsObj);
        }

        public function getCurrentCommand():ScriptCommand
        {
            return (this.m_script[this.m_curCmdIndex] as ScriptCommand);
        }

        private function createActionResponseListener(responseEvent:String, varName:String):void
        {
            var catchResponseHandler:Function;
            var timeOutTimerHandler:Function;
            var catchTimeOutTimer:Timer;
            catchResponseHandler = function (_arg_1:Object):void
            {
                catchTimeOutTimer.reset();
                catchTimeOutTimer.removeEventListener(TimerEvent.TIMER, timeOutTimerHandler);
                catchTimeOutTimer = null;
                ResponseDispatcher.getInstance().removeEventListener(responseEvent, catchResponseHandler);
                m_city.actionResponse[varName] = _arg_1;
            };
            timeOutTimerHandler = function (_arg_1:TimerEvent):void
            {
                catchTimeOutTimer.reset();
                catchTimeOutTimer.removeEventListener(TimerEvent.TIMER, timeOutTimerHandler);
                catchTimeOutTimer = null;
                ResponseDispatcher.getInstance().removeEventListener(responseEvent, catchResponseHandler);
                m_city.actionResponse[varName] = null;
            };
            catchTimeOutTimer = new Timer(45000, 1);
            catchTimeOutTimer.addEventListener(TimerEvent.TIMER, timeOutTimerHandler);
            this.m_city.actionResponse[varName] = null;
            ResponseDispatcher.getInstance().addEventListener(responseEvent, catchResponseHandler);
            catchTimeOutTimer.start();
        }

        private function goSubReturn(_arg_1:String="0"):void
        {
            if (((this.m_stack.length == 0) || (this.m_subparams.length == 0)))
            {
                this.logMsg("Found gosubreturn without gosub. Skipping...");
                this.notifyCmdFinish(true);
                return;
            };
            this.m_curCmdIndex = this.m_stack.pop();
            var _local_2:Object = this._ft1407();
            this._ao680(this.m_subparams.pop());
            this.m_curCmdIndex;
            this.m_scriptVars["_0"] = _arg_1;
            if (!this.silence)
            {
                this.logMsg(("Returning to line " + (this.m_curCmdIndex + 1)));
            };
            this.notifyCmdFinish(true);
        }

        private function logout(_arg_1:String="now", _arg_2:String=""):void
        {
            if (_arg_1.substr(0, 3).toLowerCase() == "now")
            {
                this.doLogout();
            }
            else
            {
                this.timedCommand(new ScriptCommand(new ScriptCmd("logout", this.doLogout, new Array(), new Array(), 0), new Array()), _arg_1);
            };
            if (_arg_2.length > 0)
            {
                this.timedCommand(new ScriptCommand(new ScriptCmd("login", this.doLogin, new Array(), new Array(), 0), new Array()), _arg_2);
            };
            this.notifyCmdFinish(true);
        }

        private function getValueFromVarName(_arg_1:String, _arg_2:Object):String
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            if ((((!((_local_3 = _arg_1.indexOf("[")) == -1)) && (_arg_1.indexOf("]") == (_arg_1.length - 1))) && (Utils.hasValue(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1))))))
            {
                _local_4 = _arg_1.substring(0, _arg_1.indexOf("["));
                _local_5 = int(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1)));
                if (((_arg_2[_local_4] == undefined) || (_arg_2[_local_4] == null)))
                {
                    return (null);
                };
                if ((((_arg_2[_local_4][_local_5] == undefined) || (_arg_2[_local_4][_local_5] == null)) && (_arg_2[_local_4].length > _local_5)))
                {
                    return ("null");
                };
                if ((((_arg_2[_local_4][_local_5] == undefined) || (_arg_2[_local_4][_local_5] == null)) && (_arg_2[_local_4].length <= _local_5)))
                {
                    return (null);
                };
                return (_arg_2[_local_4][_local_5]);
            };
            if (_arg_1.substr(-7) == ".length")
            {
                _arg_1 = _arg_1.substr(0, (_arg_1.length - 7));
                if ((((_arg_2[_arg_1] == undefined) || (_arg_2[_arg_1].length == undefined)) || (_arg_2[_arg_1] == null)))
                {
                    return (null);
                };
                return (_arg_2[_arg_1].length);
            };
            if (_arg_2[_arg_1] == undefined)
            {
                return (null);
            };
            return (_arg_2[_arg_1]);
        }

        public function _pp316(_arg_1:Object):int
        {
            if (_arg_1 == null)
            {
                return (-1);
            };
            if (int(_arg_1) > 0)
            {
                return (this.m_curCmdIndex - (int(_arg_1) + 1));
            };
            if ((_arg_1 in this.m_labelPos))
            {
                return (this.m_labelPos[_arg_1]);
            };
            var _local_2:int;
            while (_local_2 < this.m_script.length)
            {
                if (((this.m_script[_local_2].scriptCmd.func == this.label) && (this.m_script[_local_2].params[0] == _arg_1))) break;
                _local_2++;
            };
            return (_local_2);
        }

        public function substitute(lineElements:Array, vars:Object, isIf:Boolean=false):Array
        {
            var arr:Array;
            var i:int;
            arr = new Array(lineElements.length);
            i = 0;
            while (i < lineElements.length)
            {
                if (((((isIf) && (i == 0)) && (lineElements[i].charAt(0) == "(")) && (lineElements[i].charAt((lineElements[i].length - 1)) == ")")))
                {
                    try
                    {
                        arr[i] = D.evalToBoolean((((this.m_dynamicImportLibrary + this.m_ECMAScriptLibrary) + "\n\n") + lineElements[i]), this.m_scriptVarsProxy, this);
                    }
                    catch(exc:Error)
                    {
                        arr[i] = null;
                        logError(((((("Problem evaluating ECMA conditional paramter in:  if " + lineElements[i]) + "  :: ") + exc.errorID) + ": ") + exc.message));
                    };
                    this.m_scriptVarsProxy.clearTempProperties();
                    this.prototype = new Object();
                }
                else
                {
                    if (((isIf) && (!(i == 0))))
                    {
                        arr[i] = lineElements[i];
                    }
                    else
                    {
                        arr[i] = this.subVarValues(lineElements[i], vars);
                    };
                };
                if (arr[i] == null)
                {
                    return (null);
                };
                i = (i + 1);
            };
            return (arr);
        }

        public function repeat(_arg_1:int):void
        {
            this.loop(_arg_1, 1);
        }

        private function cmdDelete(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:int;
            if (this.m_scriptVars[_arg_1] == undefined)
            {
                if (this.silence)
                {
                    this.notifyCmdFinish(true);
                }
                else
                {
                    this.notifyCmdFinish(false, new ScriptError((('The specified variable "' + _arg_1) + '" is already undefined. Note- using "setsilence true" will suppress this notification.'), -9999));
                };
                return;
            };
            if ((((!((_local_2 = _arg_1.indexOf("[")) == -1)) && (_arg_1.indexOf("]") == (_arg_1.length - 1))) && (Utils.hasValue(_arg_1.substring((_local_2 + 1), (_arg_1.length - 1))))))
            {
                _local_3 = _arg_1.substring(0, _arg_1.indexOf("["));
                _local_4 = int(_arg_1.substring((_local_2 + 1), (_arg_1.length - 1)));
                this.m_scriptVars[_local_3].splice(_local_4, 1);
            }
            else
            {
                delete this.m_scriptVars[_arg_1];
            };
            if (!this.silence)
            {
                this.logMsg((("Deleted variable: '" + _arg_1) + "'"));
            };
            this.notifyCmdFinish(true);
        }

        private function doLogin():void
        {
            var _local_1:Connection = Connection.getInstance();
            if (_local_1.authenticated)
            {
                this.logMsg("Already connected. Call logoff before attempting to login");
                this.notifyCmdFinish(true);
                return;
            };
            _local_1.reconnectTimer.delay = 30000;
            this.logMsg("Login - Attempting login");
            _local_1.reconnectTimer.start();
            _local_1.paused = false;
        }

        private function setArr(_arg_1:String, _arg_2:String):void
        {
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (!(this.m_scriptVars[_arg_1] is Array))))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for setarr command: Attempting to assign value of type Array to an already defined variable "' + _arg_1) + '" of another type'), -9999));
                return;
            };
            if (!this.isValidVarName(_arg_1))
            {
                return;
            };
            var _local_3:Array = _arg_2.split(" ");
            _arg_2 = this.subVarValues(_arg_2, this.m_scriptVars);
            if (_arg_2 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            this.m_scriptVars[_arg_1] = _local_3;
            if (!this.silence)
            {
                this.logMsg((((("Set array '" + _arg_1) + "' to:  [\"") + this.m_scriptVars[_arg_1].join('", "')) + '"]'));
            };
            this.notifyCmdFinish(true);
        }

        private function loop(_arg_1:int=0, _arg_2:Object=null):void
        {
            var _local_3:Array;
            var _local_4:int;
            while (_local_4 < this.m_loopArray.length)
            {
                _local_3 = this.m_loopArray[_local_4];
                if (_local_3[0] == this.m_curCmdIndex) break;
                _local_3 = null;
                _local_4++;
            };
            if (_local_3 == null)
            {
                _local_3 = new Array(3);
                _local_3[0] = this.m_curCmdIndex;
                _local_3[1] = _arg_1;
                _local_3[2] = 0;
                this.m_loopArray.push(_local_3);
            }
            else
            {
                if (((!(_local_3[1] == 0)) && (_local_3[2] >= _local_3[1])))
                {
                    _local_3[2] = 0;
                };
            };
            _local_3[2] = (_local_3[2] + 1);
            if (((_local_3[1] == 0) || (_local_3[2] < _local_3[1])))
            {
                this.m_curCmdIndex = this._pp316(_arg_2);
                dispatchEvent(new Event(NEWLINE));
                if (this.m_curCmdIndex >= this.m_script.length)
                {
                    this.logMsg(("Missing label: " + _arg_2));
                }
                else
                {
                    if (((_arg_2 == null) || (int(_arg_2) > 0)))
                    {
                        if (!this.silence)
                        {
                            this.logMsg(((("Loop " + _local_3[2]) + "/") + ((_local_3[1] == 0) ? "~" : _local_3[1])));
                        }
                        else
                        {
                            if (!this.silence)
                            {
                                this.logMsg(((((("Loop to label '" + _arg_2.toString()) + "' - ") + _local_3[2]) + "/") + ((_local_3[1] == 0) ? "~" : _local_3[1])));
                            };
                        };
                    };
                };
            }
            else
            {
                if (!this.silence)
                {
                    this.logMsg("Loop end");
                };
            };
            this.notifyCmdFinish(true);
        }

        private function onArgumentError(_arg_1:ArgumentError):void
        {
            MainScreen.getInstance()._cityPanel.setScriptState(this.m_city.castleId, false);
            this.logMsg(_arg_1.message.split("<").join("&lt;").split(">").join("&gt;"), "#DD0000");
        }

        private function print(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null, _arg_6:String=null):void
        {
            var _local_7:Object;
            var _local_8:Array = new Array(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            var _local_9:* = "";
            var _local_10:int;
            while (_local_10 < _local_8.length)
            {
                if (_local_8[_local_10] == null) break;
                if ((_local_7 = this.getValue(_local_8[_local_10])) != BADOBJECT)
                {
                    _local_9 = (_local_9 + (_local_7.toString() + " "));
                };
                _local_10++;
            };
            this.logMsg(_local_9);
            this.notifyCmdFinish(true);
        }

        private function info(_arg_1:String):void
        {
            var _local_2:ScriptCmd;
            if ((_local_2 = this.getScriptCmd(_arg_1)) == null)
            {
                _local_2 = this.m_city._getScriptCmd(_arg_1);
            };
            if (_local_2 == null)
            {
                this.logMsg((("Invalid command " + _arg_1) + ", use 'listcommands' the list of all script commands"));
            }
            else
            {
                this.logMsg(("Usage: " + _local_2.getCmdInfo()));
            };
            this.notifyCmdFinish(true);
        }

        public function _mk747(_arg_1:Date):void
        {
            this.logMsg(("Estimated finish time: " + _arg_1.toLocaleString()));
        }

        private function getScriptCmd(_arg_1:String):ScriptCmd
        {
            if (this.scriptCmds == null)
            {
                this.setScriptCmds();
            };
            if (this.scriptCmds[_arg_1] != undefined)
            {
                return (this.scriptCmds[_arg_1] as ScriptCmd);
            };
            return (null);
        }

        public function getCallback(_arg_1:String=null):Function
        {
            if (_arg_1 == null)
            {
                return (null);
            };
            if (this.m_dynamicCallBackLibrary[_arg_1] == undefined)
            {
                return (null);
            };
            return ((this.m_dynamicCallBackLibrary[_arg_1] as DevalCallbackContainer).callback as Function);
        }

        private function handleScriptError(_arg_1:ScriptError):Boolean
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:* = 5000;
            if (((_arg_1 == null) || (_arg_1.errorID == 0)))
            {
                this.logError(("Script error occured without a valid error id: " + _arg_1.message));
                this.logError("Stopping script");
                this.stop();
                return (true);
            };
            switch (_arg_1.errorID)
            {
                case -9999:
                case ErrorCode.ARMY_CANT_SEND_ARMY:
                case ErrorCode.NOT_ENOUGH_TROOP:
                case ErrorCode.HERO_NOT_IN_CASTLE:
                case ErrorCode.PACIFY_NOT_GET_TIME_EXEPTION:
                case ErrorCode.ERROR_BUILDING_POSITION:
                case ErrorCode.BUILD_UNIQUE_BUILDING_EXIST:
                case ErrorCode.INVALID_BUILDING_TYPE:
                case ErrorCode.NO_DEPEND_BUILDING:
                case ErrorCode.RESOURCE_NOT_ENOUGH:
                case ErrorCode.RESOURCE_NOT_ENOUGH_FOR_LOAD:
                case ErrorCode.TECH_RESEARCHING_ALREADY:
                case ErrorCode.NO_DEPEND_TECH:
                case ErrorCode.TECH_REACH_MAX:
                case ErrorCode.NOBILITY_NOT_ENOUGH:
                case ErrorCode.CANT_BATTLE_AFTER_ADV_MOVE:
                case ErrorCode.TOO_MANY_ARMY_FOR_TRAINING_FIELD:
                    this.logError(_arg_1.message);
                    _local_4 = true;
                    _local_3 = true;
                    break;
                case ErrorCode.TOWNHALL_LEVEL_UNSUPPORT:
                case ErrorCode.INVALID_BUILDING_STATUS:
                    this.logError("A building is still building.  Skipping.  See issue 235 on project page");
                    _local_4 = true;
                    _local_3 = true;
                    break;
                case ErrorCode.ALREADY_UPGRADING_RESEARCH_IN_ACADEMY:
                    this.logError(_arg_1.message);
                    _local_4 = true;
                    _local_3 = true;
                    break;
                case ErrorCode.ITEM_RULE_ERROR:
                    _local_4 = true;
                    _local_3 = true;
                    break;
                default:
                    this.logError(_arg_1.message);
                    _local_4 = true;
                    _local_3 = true;
            };
            if (_local_2)
            {
                if (_local_5 < 0)
                {
                    _local_5 = 5000;
                };
                this.logMsg((("Retrying in " + Math.ceil((_local_5 / 1000))) + " seconds..."));
                this.sleep(("" + (_local_5 / 1000)));
                this.m_curCmdIndex--;
                dispatchEvent(new Event(NEWLINE));
            };
            if (!_local_4)
            {
                this.logMsg(((((("An unhandled error has occured:" + _arg_1.errorID) + " - ") + _arg_1.message) + "\n") + _arg_1.getStackTrace()));
                this.logMsg("Stopping script");
                this.stop();
            };
            return (_local_3);
        }

        private function addToArray(_arg_1:String, _arg_2:int, _arg_3:String):void
        {
            if (((!(this.m_scriptVars[_arg_1] == undefined)) && (!(this.m_scriptVars[_arg_1] is Array))))
            {
                this.notifyCmdFinish(false, new ScriptError((('Error in parameters for addtoarray command: The specified array name "' + _arg_1) + '" points to a variable that is not an Array'), -9999));
                return;
            };
            _arg_3 = this.subVarValues(_arg_3, this.m_scriptVars);
            if (_arg_3 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            if (this.m_scriptVars[_arg_1] == undefined)
            {
                if (_arg_2 > 0)
                {
                    this.m_scriptVars[_arg_1] = new Array(_arg_2);
                }
                else
                {
                    this.m_scriptVars[_arg_1] = new Array();
                };
                this.m_scriptVars[_arg_1].push(_arg_3);
            }
            else
            {
                this.m_scriptVars[_arg_1].splice(_arg_2, 0, _arg_3);
            };
            if (!this.silence)
            {
                this.logMsg((((((("Pushed element to: '" + _arg_1) + "' at index: '") + _arg_2) + "' and set to: \"") + this.m_scriptVars[_arg_1][_arg_2]) + '"'));
            };
            this.notifyCmdFinish(true);
        }

        private function logMsg(_arg_1:String, _arg_2:String="#000000", _arg_3:Boolean=true):void
        {
            if (_arg_3)
            {
                _arg_1 = _arg_1.split("<").join("&lt;").split(">").join("&gt;");
            };
            dispatchEvent(new ScriptLogEvent((((((("<font color='#ff0000'>(" + (((this.m_city == null) || (this.m_city.castle == null)) ? "" : this.m_city.castle.name)) + ")</font> - <font color='") + _arg_2) + "'>") + _arg_1) + "</font>"), ScriptLogEvent.MESSAGE, this.m_city));
        }

        public function getValue(param:String):Object
        {
            var splitParam:Array;
            var functionName:String;
            var functionParamString:String;
            var name:String;
            var functionParamArr:Array;
            var arrayName:String;
            var arrayIndexString:String;
            var arrayParam:int;
            var matching:int;
            var arrayIndex:Object;
            var tempObject:Object;
            var func:Function;
            var xml:XML;
            var j:int;
            var k:int;
            if (param == "")
            {
                return ("");
            };
            if (Utils.hasValue(param))
            {
                return (Number(param));
            };
            var output:Object;
            if (param.substring(0, 6) == "m_dyn.")
            {
                try
                {
                    output = D.eval((((this.m_dynamicImportLibrary + this.m_ECMAScriptLibrary) + "\n\n") + param.substring(6)), this.m_scriptVarsProxy, this);
                    this.m_scriptVarsProxy.clearTempProperties();
                    this.prototype = new Object();
                }
                catch(exc:Error)
                {
                    this.prototype = new Object();
                    this.logError(((((((("Runtime error while referencing dynamic library: " + param) + " at: ") + param.substring(6)) + " : ") + exc.errorID) + ": ") + exc.message));
                    return (BADOBJECT);
                };
            }
            else
            {
                splitParam = null;
                splitParam = this.getValidatedParams(param);
                if (splitParam == null)
                {
                    return (BADOBJECT);
                };
                if (splitParam.length == 0)
                {
                    this.logError("Abnormal parsing error");
                    return (BADOBJECT);
                };
                output = null;
                if (splitParam.length == 1)
                {
                    if (((param == "m_city") || (param == "c")))
                    {
                        return (this.m_city);
                    };
                    if (param == "null")
                    {
                        return (null);
                    };
                    if (param == "is_building")
                    {
                        output = (!(this.m_city.cityManager._getCurrentConstruction() == null));
                    }
                    else
                    {
                        if (param == "is_researching")
                        {
                            output = (!(this.m_city.cityManager.getResearchInProgress() == null));
                        }
                        else
                        {
                            if (param == "true")
                            {
                                output = true;
                            }
                            else
                            {
                                if (param == "false")
                                {
                                    output = false;
                                }
                                else
                                {
                                    if (String(int(param)) == param)
                                    {
                                        output = int(param);
                                    }
                                    else
                                    {
                                        output = param;
                                    };
                                };
                            };
                        };
                    };
                }
                else
                {
                    functionName = null;
                    functionParamString = null;
                    name = null;
                    functionParamArr = null;
                    arrayName = null;
                    arrayIndexString = null;
                    arrayParam = 0;
                    matching = 0;
                    arrayIndex = null;
                    tempObject = this;
                    func = null;
                    xml = null;
                    j = 0;
                    while (j < splitParam.length)
                    {
                        name = splitParam[j];
                        if ((tempObject is Connection))
                        {
                            return (null);
                        };
                        if (name.charAt(0) == "_")
                        {
                            return (null);
                        };
                        if (name.indexOf("(") > 0)
                        {
                            matching = this.getIndexForMatchingCloseBracket(name, name.indexOf("("), "(", ")");
                            if (matching == -1)
                            {
                                this.logError(("Unmatched () in " + name));
                                return (BADOBJECT);
                            };
                            functionName = name.substring(0, name.indexOf("("));
                            functionParamString = name.substring((name.indexOf("(") + 1), matching);
                            functionParamArr = this._jp178(functionParamString);
                            if (functionParamArr == null)
                            {
                                return (BADOBJECT);
                            };
                            k = 0;
                            while (k < functionParamArr.length)
                            {
                                functionParamArr[k] = this.getValue(functionParamArr[k]);
                                if (functionParamArr[k] == BADOBJECT)
                                {
                                    return (BADOBJECT);
                                };
                                k = (k + 1);
                            };
                            if (Version.isTraceOn())
                            {
                                trace((((functionName + "(") + functionParamArr.join(",")) + ")"));
                            };
                            try
                            {
                                func = (tempObject[functionName] as Function);
                                xml = describeType(func);
                                tempObject = func.apply(tempObject, functionParamArr);
                            }
                            catch(exc:Error)
                            {
                                this.logError((((((((("Invalid Reference " + param) + " at: ") + getQualifiedClassName(tempObject)) + ".") + functionName) + "(") + functionParamArr.join(",")) + ")"));
                                return (BADOBJECT);
                            };
                        }
                        else
                        {
                            if (name.indexOf("[") > 0)
                            {
                                arrayName = name.substring(0, name.indexOf("["));
                                arrayIndexString = name.substring((name.indexOf("[") + 1), name.indexOf("]"));
                                arrayIndex = this.getValue(arrayIndexString);
                                if (arrayIndex == BADOBJECT)
                                {
                                    return (BADOBJECT);
                                };
                                arrayParam = int(arrayIndex);
                                if (Version.isTraceOn())
                                {
                                    trace((((arrayName + "[") + arrayParam) + "]"));
                                };
                                try
                                {
                                    tempObject = tempObject[arrayName][arrayParam];
                                }
                                catch(exc:Error)
                                {
                                    this.logError((((((((("Invalid Reference " + param) + " at: ") + getQualifiedClassName(tempObject)) + ".") + arrayName) + "[") + arrayParam) + "]"));
                                    return (BADOBJECT);
                                };
                            }
                            else
                            {
                                try
                                {
                                    tempObject = tempObject[name];
                                }
                                catch(exc:Error)
                                {
                                    this.logError(((((("Invalid Reference " + param) + " at: ") + getQualifiedClassName(tempObject)) + ".") + name));
                                    return (BADOBJECT);
                                };
                            };
                        };
                        j = (j + 1);
                    };
                    output = tempObject;
                };
            };
            return (output);
        }

        public function setCallback(_arg_1:FunctionDef):Function
        {
            var _local_2:String = Utils.trim(((" " + _arg_1.name) + " "));
            if (this.m_dynamicCallBackLibrary[_local_2] != undefined)
            {
                this.logError((((("Runtime/paramter error in setCallback(): Attempted to overwrite existing callback function: " + _local_2) + ", try using getCallback(), deleteCallback(), or a different name  Notice: returning existing reference for ") + _local_2) + " instead"));
                return ((this.m_dynamicCallBackLibrary[_local_2] as DevalCallbackContainer).callback as Function);
            };
            this.m_dynamicCallBackLibrary[("" + _local_2)] = new DevalCallbackContainer(("" + _local_2), this.m_ECMAScriptLibrary, this.m_dynamicImportLibrary, this);
            return ((this.m_dynamicCallBackLibrary[("" + _local_2)] as DevalCallbackContainer).callback as Function);
        }

        private function subVarValues(_arg_1:String, _arg_2:Object):String
        {
            _arg_1 = this.checkForAndHandleSystemVariables(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return (null);
            };
            _arg_1 = this.checkForAndHandleUserVariables(_arg_1, _arg_2);
            if (_arg_1 == null)
            {
                return (null);
            };
            _arg_1 = this.checkForAndHandleEvalStatements(_arg_1);
            if (_arg_1 == null)
            {
                return (null);
            };
            return (_arg_1);
        }

        private function _jp178(_arg_1:String):Array
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array = new Array();
            var _local_6:int;
            while (_local_6 < _arg_1.length)
            {
                if ((_local_2 = _arg_1.indexOf(",", _local_6)) == -1) break;
                _local_3 = _arg_1.indexOf("(", _local_6);
                while (((!(_local_3 == -1)) && (_local_3 < _local_2)))
                {
                    if ((_local_4 = this.getIndexForMatchingCloseBracket(_arg_1, _local_3, "(", ")")) == -1)
                    {
                        this.logMsg(("Unmatched () in " + _arg_1));
                        return (null);
                    };
                    if ((_local_2 = _arg_1.indexOf(",", _local_4)) == -1) break;
                    _local_3 = _arg_1.indexOf("(", _local_4);
                };
                if (_local_2 == -1) break;
                _local_5.push(_arg_1.substring(_local_6, _local_2));
                _local_6 = (_local_2 + 1);
            };
            if (_local_6 != _arg_1.length)
            {
                _local_5.push(_arg_1.substring(_local_6));
            };
            return (_local_5);
        }

        private function downloadUrl(_arg_1:String, _arg_2:Boolean, _arg_3:Function):void
        {
            var _local_6:String;
            var _local_7:int;
            var _local_8:Base64Encoder;
            if (_arg_2)
            {
                if (((!(_arg_1.substr(0, 7) == "http://")) && (!(_arg_1.substr(0, 8) == "https://"))))
                {
                    throw (new ArgumentError((("URL " + _arg_1) + " is not in proper format, it needs to start with  http://  or  https://")));
                };
            };
            var _local_4:String;
            var _local_5:String;
            this.snippetDownloader.method = "GET";
            if (_arg_2)
            {
                if ((_local_4 = _arg_1.substr(0, 7)) != "http://")
                {
                    _local_4 = "https://";
                };
                _local_5 = _arg_1.substr(_local_4.length);
                _local_6 = null;
                if ((_local_7 = _local_5.indexOf("@")) != -1)
                {
                    _local_6 = _local_5.substr(0, _local_7);
                    _local_5 = _local_5.substr((_local_7 + 1));
                    _local_8 = new Base64Encoder();
                    _local_8.insertNewLines = false;
                    _local_8.encode(_local_6);
                    _local_6 = _local_8.toString();
                };
                this.snippetDownloader.url = (_local_4 + _local_5);
                if (_local_6 != null)
                {
                    this.snippetDownloader.method = "POST";
                    this.snippetDownloader.headers = {"Authorization":("Basic " + _local_6)};
                };
            }
            else
            {
                this.snippetDownloader.url = _arg_1;
            };
            this.currentSnippetDownloadUrl = this.snippetDownloader.url;
            this.snippetDownloaderCallback = _arg_3;
            this.snippetDownloader.send();
        }

        private function processDownloadedData(_arg_1:ResultEvent):void
        {
            this.snippetDownloaderCallback.apply(this, new Array(_arg_1.result));
        }

        private function onPreProcessingError(_arg_1:Error):void
        {
            MainScreen.getInstance()._cityPanel.setScriptState(this.m_city.castleId, false);
            this.logMsg(_arg_1.message.split("<").join("&lt;").split(">").join("&gt;"), "#DD0000");
        }

        private function doEval(_arg_1:Object):Object
        {
            if (!_arg_1.hasOwnProperty("op"))
            {
                if ((_arg_1 is String))
                {
                    return (_arg_1);
                };
                this.logError("Internal evaluation error");
                return (BADOBJECT);
            };
            if (((!(_arg_1.oper1 == undefined)) && (_arg_1.oper1.hasOwnProperty("op"))))
            {
                _arg_1.oper1 = this.doEval(_arg_1.oper1);
            };
            if (((!(_arg_1.oper2 == undefined)) && (_arg_1.oper2.hasOwnProperty("op"))))
            {
                _arg_1.oper2 = this.doEval(_arg_1.oper2);
            };
            if (((_arg_1.oper1 == BADOBJECT) || (_arg_1.oper2 == BADOBJECT)))
            {
                return (BADOBJECT);
            };
            var _local_2:String = _arg_1.op;
            if (_local_2 == "!")
            {
                if ((_arg_1.oper1 is Boolean))
                {
                    return (!(_arg_1.oper1));
                };
                if ((_arg_1.oper1 is String))
                {
                    if (_arg_1.oper1 == "true")
                    {
                        return (false);
                    };
                    if (_arg_1.oper1 == "false")
                    {
                        return (true);
                    };
                };
                this.logError("Evaluation error: operator ! used on non-boolean");
                return (BADOBJECT);
            };
            if (new Array("^", "*", "/", "\\", "|", "+", "-", ">=", "<=", ">", "<").indexOf(_local_2) != -1)
            {
                if (((_arg_1.oper1 is String) && (Utils.hasValue(_arg_1.oper1))))
                {
                    _arg_1.oper1 = Number(_arg_1.oper1);
                };
                if (((_arg_1.oper2 is String) && (Utils.hasValue(_arg_1.oper2))))
                {
                    _arg_1.oper2 = Number(_arg_1.oper2);
                };
                if ((((_arg_1.oper1 is Number) || (_arg_1.oper1 is int)) && ((_arg_1.oper2 is Number) || (_arg_1.oper2 is int))))
                {
                    if (_local_2 == "+")
                    {
                        return (_arg_1.oper1 + _arg_1.oper2);
                    };
                    if (_local_2 == "-")
                    {
                        return (_arg_1.oper1 - _arg_1.oper2);
                    };
                    if (_local_2 == "*")
                    {
                        return (_arg_1.oper1 * _arg_1.oper2);
                    };
                    if (_local_2 == "/")
                    {
                        return (_arg_1.oper1 / _arg_1.oper2);
                    };
                    if (_local_2 == "\\")
                    {
                        return (Math.floor((_arg_1.oper1 / _arg_1.oper2)));
                    };
                    if (_local_2 == "|")
                    {
                        return (_arg_1.oper1 % _arg_1.oper2);
                    };
                    if (_local_2 == "^")
                    {
                        return (Math.pow(_arg_1.oper1, _arg_1.oper2));
                    };
                    if (_local_2 == ">")
                    {
                        return (_arg_1.oper1 > _arg_1.oper2);
                    };
                    if (_local_2 == "<")
                    {
                        return (_arg_1.oper1 < _arg_1.oper2);
                    };
                    if (_local_2 == ">=")
                    {
                        return (_arg_1.oper1 >= _arg_1.oper2);
                    };
                    if (_local_2 == "<=")
                    {
                        return (_arg_1.oper1 <= _arg_1.oper2);
                    };
                    return (BADOBJECT);
                };
                if (((_arg_1.oper1 is String) && (_arg_1.oper2 is String)))
                {
                    return ((("" + _arg_1.oper1) + _local_2) + _arg_1.oper2);
                };
                this.logError(((((("Evaluation error, operator " + _local_2) + " on non-number ") + _arg_1.oper1) + " and ") + _arg_1.oper2));
                return (BADOBJECT);
            };
            if (new Array("&&", "||").indexOf(_local_2) != -1)
            {
                if ((_arg_1.oper1 is String))
                {
                    if (_arg_1.oper1 == "true")
                    {
                        _arg_1.oper1 = true;
                    }
                    else
                    {
                        if (_arg_1.oper1 == "false")
                        {
                            _arg_1.oper1 = false;
                        };
                    };
                };
                if ((_arg_1.oper2 is String))
                {
                    if (_arg_1.oper2 == "true")
                    {
                        _arg_1.oper2 = true;
                    }
                    else
                    {
                        if (_arg_1.oper2 == "false")
                        {
                            _arg_1.oper2 = false;
                        };
                    };
                };
                if (((_arg_1.oper1 is Boolean) && (_arg_1.oper2 is Boolean)))
                {
                    if (_local_2 == "&&")
                    {
                        return ((_arg_1.oper1) && (_arg_1.oper2));
                    };
                    if (_local_2 == "||")
                    {
                        return ((_arg_1.oper1) || (_arg_1.oper2));
                    };
                    return (BADOBJECT);
                };
                this.logError(((((("Evaluation error, operator " + _local_2) + " on non-boolean ") + _arg_1.oper1) + " and ") + _arg_1.oper2));
                return (BADOBJECT);
            };
            if (_local_2 == "==")
            {
                return (_arg_1.oper1 == _arg_1.oper2);
            };
            if (_local_2 == "!=")
            {
                return (!(_arg_1.oper1 == _arg_1.oper2));
            };
            this.logError(("Evaluation error, invalid operator " + _local_2));
            return (BADOBJECT);
        }

        private function sleep(_arg_1:String, _arg_2:Boolean=false):void
        {
            var _local_3:Date;
            var _local_4:int;
            if (_arg_1.indexOf(":") > 0)
            {
                if (_arg_1.toString().substr(0, 1) != "@")
                {
                    if (_arg_1.toString().substr(0, 3) != "rnd")
                    {
                        _local_4 = this.m_city.parseTime(_arg_1.toString());
                    }
                    else
                    {
                        _local_4 = this.m_city.randomTime(_arg_1.toString().replace("rnd:", ""));
                    };
                }
                else
                {
                    _local_4 = this.m_city.parseTime(_arg_1.toString().replace("@:", ""), true);
                    if (((!(_arg_2)) && (_local_4 > (12 * 3600))))
                    {
                        this.logError((((("Sleeping too long for " + _arg_1) + ", skipping sleep.  Use 'sleep ") + _arg_1) + " true' instead!"));
                        this.notifyCmdFinish(true);
                        return;
                    };
                };
            }
            else
            {
                _local_4 = int(_arg_1);
            };
            _local_4 = (_local_4 * 1000);
            if (((_local_4 >= ((5 * 60) * 1000)) || (!(this.silence))))
            {
                this.logMsg(((("Sleeping for " + (_local_4 / 1000)) + " seconds until ") + Utils.getLogTimeStr((Utils.getServerTime() + _local_4))));
            };
            this.m_scriptTimer.stop();
            this.m_sleeping = true;
            this.m_sleepTimer = new Timer(_local_4, 1);
            this.m_sleepTimer.addEventListener(TimerEvent.TIMER, this.clearSleepTimer);
            this.m_sleepTimer.start();
        }

        private function clearSleepTimer(_arg_1:TimerEvent=null, _arg_2:Boolean=false):void
        {
            this.m_sleepTimer.stop();
            if (!_arg_2)
            {
                this.m_sleeping = false;
                this.m_scriptTimer.start();
                this.notifyCmdFinish(true);
            };
            this.m_sleepTimer.removeEventListener(TimerEvent.TIMER, this.clearSleepTimer);
            this.m_sleepTimer = null;
        }

        private function setSilence(_arg_1:Boolean=true):void
        {
            this.silence = _arg_1;
            this.notifyCmdFinish(true);
        }

        public function cmdSet(_arg_1:String, _arg_2:String):void
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            _arg_2 = this.subVarValues(_arg_2, this.m_scriptVars);
            if (_arg_2 == null)
            {
                this.notifyCmdFinish(false, new ScriptError("Bad variable evaluation", -9999));
                return;
            };
            if ((((!((_local_3 = _arg_1.indexOf("[")) == -1)) && (_arg_1.indexOf("]") == (_arg_1.length - 1))) && (Utils.hasValue(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1))))))
            {
                _local_4 = _arg_1.substring(0, _arg_1.indexOf("["));
                if (!this.isValidVarName(_local_4))
                {
                    return;
                };
                if (((!(this.m_scriptVars[_local_4] == undefined)) && (!(this.m_scriptVars[_local_4] is Array))))
                {
                    this.notifyCmdFinish(false, new ScriptError((('Error in parameters for set command: Attempting to assign value of type Array to an already defined variable "' + _local_4) + '" of incompatible type'), -9999));
                    return;
                };
                _local_5 = int(_arg_1.substring((_local_3 + 1), (_arg_1.length - 1)));
                if (this.m_scriptVars[_local_4] == undefined)
                {
                    this.m_scriptVars[_local_4] = new Array((_local_5 + 1));
                    this.m_scriptVars[_local_4][_local_5] = _arg_2;
                    if (!this.silence)
                    {
                        this.logMsg((((((("Created new Array '" + _local_4) + "' and set variable '") + _arg_1) + "' to:  \"") + this.m_scriptVars[_local_4][_local_5]) + '"'));
                    };
                }
                else
                {
                    this.m_scriptVars[_local_4][_local_5] = _arg_2;
                    if (!this.silence)
                    {
                        this.logMsg((((("Set variable '" + _arg_1) + "' to:  \"") + this.m_scriptVars[_local_4][_local_5]) + '"'));
                    };
                };
            }
            else
            {
                if (_arg_1.substr(-7) == ".length")
                {
                    _arg_1 = _arg_1.substr(0, (_arg_1.length - 7));
                    if (((!(this.m_scriptVars[_arg_1] == undefined)) && (!(this.m_scriptVars[_arg_1] is Array))))
                    {
                        this.notifyCmdFinish(false, new ScriptError((('Error in parameters for set command: Attempting to assign value of type Array to an already defined variable "' + _local_4) + '" of incompatible type'), -9999));
                        return;
                    };
                    if (this.m_scriptVars[_arg_1] == undefined)
                    {
                        if (int(_arg_2) > 0)
                        {
                            this.m_scriptVars[_arg_1] = new Array(int(_arg_2));
                        };
                        if (int(_arg_2) == 0)
                        {
                            this.m_scriptVars[_arg_1] = new Array();
                        };
                        if (int(_arg_2) < 0)
                        {
                            this.notifyCmdFinish(false, new ScriptError(((("Error in parameters for set command: Attempting to assign a negative value " + int(_arg_2)) + " to Array ") + _arg_1), -9999));
                            return;
                        };
                        if (!this.silence)
                        {
                            this.logMsg(((("Created new Array '" + _arg_1) + "' with length ") + int(_arg_2)));
                        };
                    }
                    else
                    {
                        if (int(_arg_2) > 0)
                        {
                            this.m_scriptVars[_arg_1].length = int(_arg_2);
                        };
                        if (int(_arg_2) == 0)
                        {
                            this.m_scriptVars[_arg_1] = new Array();
                        };
                        if (int(_arg_2) < 0)
                        {
                            this.notifyCmdFinish(false, new ScriptError(((("Error in parameters for set command: Attempting to assign a negative value " + int(_arg_2)) + " to Array ") + _arg_1), -9999));
                            return;
                        };
                        if (!this.silence)
                        {
                            this.logMsg((((("Set length of Array '" + _arg_1) + "' to:  \"") + this.m_scriptVars[_arg_1]) + '"'));
                        };
                    };
                }
                else
                {
                    if (!this.isValidVarName(_arg_1))
                    {
                        return;
                    };
                    if (((!(this.m_scriptVars[_arg_1] == undefined)) && (this.m_scriptVars[_arg_1] is Array)))
                    {
                        this.notifyCmdFinish(false, new ScriptError((('Error in parameters for set command: Attempting to assign value of incompatible type to an already defined variable "' + _arg_1) + '" of type Array'), -9999));
                        return;
                    };
                    this.m_scriptVars[_arg_1] = _arg_2;
                    if (!this.silence)
                    {
                        this.logMsg((((("Set variable '" + _arg_1) + "' to:  \"") + this.m_scriptVars[_arg_1]) + '"'));
                    };
                };
            };
            this.notifyCmdFinish(true);
        }

        private function getIndexForMatchingCloseBracket(_arg_1:String, _arg_2:int, _arg_3:String="{", _arg_4:String="}"):int
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int = 1;
            while (true)
            {
                if (_local_7 == 0)
                {
                    return (_arg_2);
                };
                _local_5 = _arg_1.indexOf(_arg_3, (_arg_2 + 1));
                _local_6 = _arg_1.indexOf(_arg_4, (_arg_2 + 1));
                if (_local_6 == -1)
                {
                    return (-1);
                };
                if (_local_5 != -1)
                {
                    if (_local_5 < _local_6)
                    {
                        _local_7++;
                        _arg_2 = _local_5;
                    }
                    else
                    {
                        _local_7--;
                        _arg_2 = _local_6;
                    };
                }
                else
                {
                    _local_7--;
                    _arg_2 = _local_6;
                };
            };
            return (-1); //dead code
        }

        public function _dl254():int
        {
            return (this.m_curCmdIndex);
        }

        private function _ao680(_arg_1:Object):void
        {
            var _local_2:String;
            for (_local_2 in _arg_1)
            {
                if (_local_2.charAt(0) == "_")
                {
                    this.m_scriptVars[_local_2] = _arg_1[_local_2];
                };
            };
        }

        private function setScriptCmds():void
        {
            this.scriptCmds = new Object();
            this.scriptCmds["set"] = new ScriptCmd("set", this.cmdSet, new Array("var", "value"), new Array("String", "String"), 2);
            this.scriptCmds["label"] = new ScriptCmd("label", this.label, new Array("label"), new Array("String"), 1);
            this.scriptCmds["if"] = new ScriptCmd("if", this.cmdIf, new Array("condition", "command", "arguments"), new Array("Boolean", "String", "*"), 2);
            this.scriptCmds["goto"] = new ScriptCmd("goto", this._SafeStr_1, new Array("label"), new Array("String"), 1);
            this.scriptCmds["setarray"] = new ScriptCmd("setarray", this.setArray, new Array("var", "values"), new Array("String", "*"), 2);
            this.scriptCmds["setarr"] = new ScriptCmd("setarr", this.setArr, new Array("var", "values"), new Array("String", "String"), 2);
            this.scriptCmds["gosub"] = new ScriptCmd("gosub", this.goSub, new Array("label", "_1", "_2", "_3", "_4", "_5", "_6", "_7", "_8", "_9", "_10"), new Array("String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String"), 1);
            this.scriptCmds["gosubreturn"] = new ScriptCmd("gosubreturn", this.goSubReturn, new Array("value"), new Array("String"), 0);
            this.scriptCmds["iferror"] = new ScriptCmd("iferror", this.ifError, new Array("expression", "command", "arguments"), new Array("String", "String", "*"), 2);
            this.scriptCmds["loop"] = new ScriptCmd("loop", this.loop, new Array("count", "label"), new Array("int", "String"), 0);
            this.scriptCmds["repeat"] = new ScriptCmd("repeat", this.repeat, new Array("count"), new Array("int"), 1);
            this.scriptCmds["ifgoto"] = new ScriptCmd("ifgoto", this.ifGoto, new Array("(", "value1", "compareOp", "value2", ")", "label"), new Array("String", "String", "String", "String", "String", "String"), 6);
            this.scriptCmds["ifgosub"] = new ScriptCmd("ifgosub", this.ifGoSub, new Array("(", "value1", "compareOp", "value2", ")", "label"), new Array("String", "String", "String", "String", "String", "String"), 6);
            this.scriptCmds["print"] = new ScriptCmd("print", this.print, new Array("exp1", "exp2", "exp3", "exp4", "exp5", "exp6"), new Array("String", "String", "String", "String", "String", "String"), 1);
            this.scriptCmds["echo"] = new ScriptCmd("echo", this.echo, new Array("exp1", "exp2", "exp3", "exp4", "exp5", "exp6"), new Array("String", "String", "String", "String", "String", "String"), 1);
            this.scriptCmds["getindexof"] = new ScriptCmd("getindexof", this.getIndexOf, new Array("iVar", "arrayName", "searchValue"), new Array("String", "String", "String"), 3);
            this.scriptCmds["split"] = new ScriptCmd("split", this.split, new Array("var", "delimiter", "stringToSplit"), new Array("String", "String", "String"), 3);
            this.scriptCmds["join"] = new ScriptCmd("join", this.join, new Array("var", "arrayName", "separator"), new Array("String", "String", "String"), 2);
            this.scriptCmds["addtoarray"] = new ScriptCmd("addtoarray", this.addToArray, new Array("arrayName", "index", "value"), new Array("String", "String", "String"), 3);
            this.scriptCmds["delete"] = new ScriptCmd("delete", this.cmdDelete, new Array("varName"), new Array("String"), 1);
            this.scriptCmds["sleep"] = new ScriptCmd("sleep", this.sleep, new Array("timeStr", "allowLongSleep"), new Array("String", "Boolean"), 1);
            this.scriptCmds["setsilence"] = new ScriptCmd("setsilence", this.setSilence, new Array("silenceFlag"), new Array("Boolean"), 0);
            this.scriptCmds["listcommands"] = new ScriptCmd("listcommands", this.listCommands, new Array("filter"), new Array("String"), 0);
            this.scriptCmds["info"] = new ScriptCmd("info", this.info, new Array("command"), new Array("String"), 1);
            this.scriptCmds["logout"] = new ScriptCmd("logout", this.logout, new Array("timeOut", "timeIn"), new Array("String", "String"), 1);
        }

        private function checkForAndHandleSystemVariables(_arg_1:String, _arg_2:Object):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:String;
            var _local_7:* = "";
            var _local_8:Object;
            var _local_9:int;
            while (true)
            {
                if ((_local_3 = _arg_1.indexOf("$", _local_9)) == -1) break;
                if ((_local_4 = _arg_1.indexOf("$", (_local_3 + 1))) == -1)
                {
                    this.logError(("Unmatched $ in " + _arg_1));
                    return (null);
                };
                if (((!((_local_5 = _arg_1.indexOf("{", (_local_3 + 1))) == -1)) && (_local_5 < _local_4)))
                {
                    if ((_local_4 = _arg_1.indexOf("$", this.getIndexForMatchingCloseBracket(_arg_1, _local_5))) == -1) break;
                };
                _local_6 = _arg_1.substring((_local_3 + 1), _local_4);
                if ((_local_6 = this.checkForAndHandleUserVariables(_local_6, _arg_2)) == null)
                {
                    return (null);
                };
                if ((_local_6 = this.checkForAndHandleEvalStatements(_local_6)) == null)
                {
                    return (null);
                };
                if ((_local_8 = this.getValue(_local_6)) == BADOBJECT)
                {
                    return (null);
                };
                if (_local_8 == null)
                {
                    _local_8 = "null";
                };
                _local_7 = (_local_7 + (_arg_1.substring(_local_9, _local_3) + _local_8.toString()));
                _local_9 = (_local_4 + 1);
            };
            return (_local_7 = (_local_7 + _arg_1.substr(_local_9)));
        }

        private function ifError(value:String, funcName:String, arr:Array):void
        {
            var param:String;
            this.suppressError = true;
            try
            {
                param = this.subVarValues(value, this.m_scriptVars);
            }
            catch(error:Error)
            {
            };
            this.suppressError = false;
            if (param != null)
            {
                this.notifyCmdFinish(true);
                return;
            };
            if (arr.length == 0)
            {
                this.logMsg("Depricated: please use 'iferror expression goto label' instead of 'iferror expression label", "#FF8888");
                arr.push(funcName);
                funcName = "goto";
            };
            var cmd:ScriptCmd;
            if ((cmd = this.getScriptCmd(funcName)) == null)
            {
                cmd = this.m_city._getScriptCmd(funcName);
            };
            if (cmd == null)
            {
                throw (new ArgumentError((("Invalid command " + funcName) + " from within if command")));
            };
            if (cmd.hasInvalidArgs(arr))
            {
                throw (new ArgumentError((((("Invalid param at run time " + cmd.cmdName) + " ") + arr.join(" ")) + " from within if command")));
            };
            cmd.func.apply(this.m_city, cmd.paramsToArray(arr));
        }

        private function runCurrentCmd():void
        {
            var handler:Function;
            var cmdTimer:Timer;
            handler = function (event:TimerEvent):void
            {
                var cmd:ScriptCommand;
                var cmdName:String;
                var lastQueueSize:int;
                var sParts:Array;
                cmdTimer.delay = 3000;
                if (m_sleeping)
                {
                    return;
                };
                if (m_stopped)
                {
                    cmdTimer.stop();
                    cmdTimer.removeEventListener("timer", handler);
                    cmdTimer = null;
                    return;
                };
                var conn:Connection = Connection.getInstance();
                if (((!(conn.paused)) && (conn.authenticated)))
                {
                    cmdTimer.stop();
                    cmdTimer.removeEventListener("timer", handler);
                    cmdTimer = null;
                    cmd = getCurrentCommand();
                    cmdName = cmd.scriptCmd.cmdName.toLowerCase();
                    if (((!(silence)) && (!(cmdName == "setsilence"))))
                    {
                        logMsg((((((("Running line " + (m_curCmdIndex + 1)) + ": ") + cmdName) + " ") + cmd.params.join(" ").substring(0, 50)) + "..."));
                    };
                    try
                    {
                        lastQueueSize = conn.getSendQueueLength();
                        sParts = ((cmdName != "iferror") ? substitute(cmd.params, m_scriptVars, (cmdName == "if")) : cmd.params);
                        if (sParts == null)
                        {
                            throw (new ArgumentError(("Parameter substitution problem in " + cmd.params.join(" "))));
                        };
                        if (cmd.scriptCmd.hasInvalidArgs(sParts))
                        {
                            throw (new ArgumentError(((("Invalid param at run time " + cmdName) + " ") + sParts.join(" "))));
                        };
                        if (((((cmdName == "set") && (cmd.params.length > 1)) && (sParts[1] == "null")) && (conn.getSendQueueLength() == (lastQueueSize + 1))))
                        {
                            createActionResponseListener(conn.getLastCmdInSendQueue(), cmd.params[0]);
                            sParts[1] = ("m_city.actionResponse." + sParts[0]);
                        };
                        cmd.scriptCmd.func.apply(m_city, cmd.scriptCmd.paramsToArray(sParts));
                    }
                    catch(argError:ArgumentError)
                    {
                        notifyCmdFinish(false, new ScriptError(((("Problem with parameters in " + cmdName) + " command: ") + argError.message), -9999));
                    }
                    catch(err:Error)
                    {
                        notifyCmdFinish(false, new ScriptError(err.message, err.errorID));
                    };
                    m_curCmdIndex++;
                    dispatchEvent(new Event(NEWLINE));
                };
            };
            cmdTimer = new Timer(0);
            cmdTimer.addEventListener("timer", handler);
            cmdTimer.start();
        }

        private function handleCityCompleteEvent(_arg_1:CityStateCompleteEvent):void
        {
            var _local_2:Boolean = true;
            var _local_3:ScriptError;
            if ((_arg_1.response is CommandResponse))
            {
                if (_arg_1.response.ok != 1)
                {
                    _local_2 = false;
                    _local_3 = new ScriptError(_arg_1.response.errorMsg, _arg_1.response.ok);
                };
            }
            else
            {
                if ((_arg_1.response is ScriptError))
                {
                    _local_2 = false;
                    _local_3 = (_arg_1.response as ScriptError);
                }
                else
                {
                    if (typeof(_arg_1.response) == "boolean")
                    {
                        _local_2 = _arg_1.response;
                    }
                    else
                    {
                        _local_2 = false;
                        _local_3 = new ScriptError("'Command Failed' response received", -9999);
                    };
                };
            };
            this.notifyCmdFinish(_local_2, _local_3);
        }

        private function startExecUserScript(_arg_1:int=0):void
        {
            if (this.m_running)
            {
                return;
            };
            if (((_arg_1 <= this.m_script.length) && (_arg_1 > 0)))
            {
                this.m_curCmdIndex = (_arg_1 - 1);
            };
            this.m_stopped = false;
            this.m_stack = new Array();
            this.m_subparams = new Array();
            Env.INFINITE_LOOP_LIMIT = 1000000;
            this.m_scriptTimer.start();
        }

        public function getVar(_arg_1:String):*
        {
            var _local_2:int;
            var _local_3:String;
            if (this.m_scriptVars[_arg_1] == undefined)
            {
                if ((((!((_local_2 = _arg_1.indexOf("[")) == -1)) && (_arg_1.indexOf("]") == (_arg_1.length - 1))) && (Utils.hasValue(_arg_1.substring((_local_2 + 1), (_arg_1.length - 1))))))
                {
                    _local_3 = _arg_1.substring(0, _arg_1.indexOf("["));
                    if (this.m_scriptVars[_local_3] == undefined)
                    {
                        return (null);
                    };
                    return (this.m_scriptVars[_local_3][int(_arg_1.substring((_local_2 + 1), (_arg_1.length - 1)))]);
                };
                if (_arg_1.substr(-7) == ".length")
                {
                    _arg_1 = _arg_1.substr(0, (_arg_1.length - 7));
                    if (this.m_scriptVars[_arg_1].length == undefined)
                    {
                        return (null);
                    };
                    return (this.m_scriptVars[_arg_1].length);
                };
            };
            return (this.m_scriptVars[_arg_1]);
        }

        private function label(_arg_1:String):void
        {
            this.m_labelPos[_arg_1] = this.m_curCmdIndex;
            if (!this.silence)
            {
                this.logMsg(((("Setting label '" + _arg_1) + "' on line ") + (this.m_curCmdIndex + 1)));
            };
            this.notifyCmdFinish(true);
        }

        private function doLogout():void
        {
            var _local_1:Connection = Connection.getInstance();
            _local_1.reconnectTimer.stop();
            _local_1.disconnect();
            this.logMsg("Logout - Disconnected");
            _local_1.paused = true;
        }

        private function cmdIf(_arg_1:Boolean, _arg_2:String, _arg_3:Array):void
        {
            if (!_arg_1)
            {
                this.notifyCmdFinish(true);
                return;
            };
            var _local_4:ScriptCmd = this.getScriptCmd(_arg_2);
            if (_local_4 == null)
            {
                _local_4 = this.m_city._getScriptCmd(_arg_2);
            };
            if (_local_4 == null)
            {
                throw (new ArgumentError((("Invalid command " + _arg_2) + " from within if command")));
            };
            _arg_3 = this.substitute(_arg_3, this.m_scriptVars);
            if (_arg_3 == null)
            {
                throw (new ArgumentError(("Parameter substitution problem in " + this.getCurrentCommand().params.join(" "))));
            };
            if (_local_4.hasInvalidArgs(_arg_3))
            {
                throw (new ArgumentError((((("Invalid param at run time " + _local_4.cmdName) + " ") + _arg_3.join(" ")) + " from within if command")));
            };
            _local_4.func.apply(this.m_city, _local_4.paramsToArray(_arg_3));
        }

        private function _set_m_script(scriptText:String):void
        {
            var openParInd:int;
            var closeParInd:int;
            var funcObj:Object;
            this.m_scriptVars = new Object();
            this.m_scriptVarsProxy = new ReScriptObjectProxy(this.m_scriptVars);
            this.m_script = new Array();
            var lines:Array = scriptText.replace(/\/\*.*?\*\//sg, function repl ():String
            {
                return (arguments[0].replace(/./g, ""));
            }).split(new RegExp("\r|\n"));
            var lineTxt:String;
            var cmd:String;
            var errMsg:String;
            var ecmaLineStr:String = "";
            var funcStr:String = "";
            var trimmedFuncName:String = "";
            var trimmedArgs:String = "";
            var tempECMAcode:String = "";
            var tempImportcode:String = "";
            var args:Array;
            var skipCommentBlock:Boolean;
            var scriptCmd:ScriptCmd;
            var i:int;
            while (i < lines.length)
            {
                if ((lineTxt = Utils.trim(lines[i])).length != 0)
                {
                    if (((((!((lineTxt.length >= 2) && (lineTxt.substr(0, 2) == "//"))) && (!((lineTxt.length >= 1) && (lineTxt.substr(0, 1) == "#")))) && (!((lineTxt.length >= 8) && (lineTxt.substr(0, 8).toLowerCase() == "function")))) && (!((lineTxt.length >= 6) && (lineTxt.substr(0, 6).toLowerCase() == "import")))))
                    {
                        lineTxt = lineTxt.split("//")[0].toString();
                        args = this.lineElementsToArray(lineTxt.toString());
                        if (args.length != 0)
                        {
                            if (args[0].charAt((args[0].length - 1)) == ":")
                            {
                                args.splice(0, 1);
                            };
                            if (args.length != 0)
                            {
                                cmd = args[0].toString().toLowerCase();
                                args.splice(0, 1);
                                if (cmd == "echo")
                                {
                                    if (args.length > 1)
                                    {
                                        args = [args.join(" ")];
                                    };
                                    if (args.length != 1)
                                    {
                                        throw (new ArgumentError(((("Syntax error in line " + i) + ": ") + lineTxt)));
                                    };
                                }
                                else
                                {
                                    if (((cmd == "set") || (cmd == "setarray")))
                                    {
                                        if (args.length > 2)
                                        {
                                            args = [args[0], args.join(" ").substring((String(args[0]).length + 1))];
                                        };
                                        if (args.length != 2)
                                        {
                                            throw (new ArgumentError(((("Syntax error in line " + i) + ": ") + lineTxt)));
                                        };
                                    };
                                };
                                errMsg = null;
                                if ((scriptCmd = this.getScriptCmd(cmd)) == null)
                                {
                                    scriptCmd = this.m_city._getScriptCmd(cmd);
                                };
                                if (scriptCmd == null)
                                {
                                    errMsg = (("Invalid command " + cmd) + ", run 'listcommands' for the list of all script commands");
                                }
                                else
                                {
                                    errMsg = scriptCmd.hasInvalidArgs(args);
                                };
                                if (errMsg != null)
                                {
                                    this.logMsg(((("Syntax error in line: " + lineTxt) + "\n") + errMsg));
                                    throw (new ArgumentError(((((("Syntax error in line " + i) + ": ") + lineTxt) + "\n") + errMsg)));
                                };
                                this.m_script.push(new ScriptCommand(scriptCmd, args));
                            };
                        };
                    }
                    else
                    {
                        if (((lineTxt.length >= 8) && (lineTxt.substr(0, 8).toLowerCase() == "function")))
                        {
                            funcStr = "function ";
                            ecmaLineStr = Utils.trim(lines.splice(i, 1)[0]);
                            if ((openParInd = ecmaLineStr.indexOf("(", 9)) == -1)
                            {
                                throw (new ArgumentError((("ECMA Syntax error in line: " + ecmaLineStr) + '\n no "(" found after function identifier/name')));
                            };
                            if ((trimmedFuncName = Utils.trim(ecmaLineStr.substring(9, openParInd))) == "")
                            {
                                throw (new ArgumentError((("Syntax error in line: " + ecmaLineStr) + "\nfunction identifier found with no name")));
                            };
                            if ((closeParInd = ecmaLineStr.lastIndexOf(")")) == -1)
                            {
                                throw (new ArgumentError((("ECMA Syntax error in line: " + ecmaLineStr) + '\n no ")" found after function identifier and name')));
                            };
                            trimmedArgs = (("(" + Utils.trim(ecmaLineStr.substring((openParInd + 1), closeParInd))) + ")");
                            funcStr = (funcStr + ((trimmedFuncName + trimmedArgs) + Utils.trim(ecmaLineStr.substring((closeParInd + 1)))));
                            if (funcStr.indexOf("{") == -1)
                            {
                                funcStr = (funcStr + ("\n" + lines.splice(i, 1)[0]));
                            };
                            if (funcStr.indexOf("{") == -1)
                            {
                                throw (new ArgumentError((("Syntax error in function: " + trimmedFuncName) + '\n no "{" found after function identifier, name and enclosed paramters')));
                            };
                            while (true)
                            {
                                if (funcStr.split("{").length == funcStr.split("}").length) break;
                                if (i >= lines.length)
                                {
                                    throw (new ArgumentError((("Syntax error in function: " + trimmedFuncName) + '\n unmatched "}" found after function identifier, no closing "}" found')));
                                };
                                funcStr = (funcStr + ("\n" + lines.splice(i, 1)[0]));
                            };
                            tempECMAcode = (tempECMAcode + (funcStr + "\n\n"));
                            i = (i - 1);
                        }
                        else
                        {
                            if (((lineTxt.length >= 6) && (lineTxt.substr(0, 6).toLowerCase() == "import")))
                            {
                                funcStr = "import ";
                                ecmaLineStr = Utils.trim(lines.splice(i, 1)[0]);
                                if (ecmaLineStr.charAt((ecmaLineStr.length - 1)) != ";")
                                {
                                    throw (new ArgumentError((("Syntax error in import line: " + ecmaLineStr) + '\n no ";" found to end the statement, line not terminated properly')));
                                };
                                funcStr = (funcStr + Utils.trim(ecmaLineStr.substring(6)));
                                tempImportcode = (tempImportcode + (funcStr + "\n"));
                                i = (i - 1);
                            };
                        };
                    };
                };
                i = (i + 1);
            };
            this.m_dynamicImportLibrary = (tempImportcode + "\n");
            this.m_ECMAScriptLibrary = tempECMAcode;
            if (this.m_ECMAScriptLibrary.length > 0)
            {
                try
                {
                    funcObj = null;
                    funcObj = D.parseFunctions(this.m_ECMAScriptLibrary);
                }
                catch(e:Error)
                {
                    this.m_ECMAScriptLibrary = "";
                    throw (new ArgumentError(((("Preprocessing error while parsing ECMAScript, check syntax and try again.  Error: " + e.errorID) + " ") + e.message)));
                };
            };
        }

        private function getValidatedParams(_arg_1:String):Array
        {
            var _local_8:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array = new Array();
            var _local_7:int;
            while (_local_7 < _arg_1.length)
            {
                if (_arg_1.charAt(_local_7) == ".")
                {
                    this.logError(((("Unexpected . in " + _arg_1) + " at position ") + _local_7));
                    return (null);
                };
                _local_2 = _arg_1.indexOf(".", _local_7);
                _local_3 = _arg_1.indexOf("[", _local_7);
                _local_4 = _arg_1.indexOf("(", _local_7);
                if (((!(_local_3 == -1)) && (!(_local_4 == -1))))
                {
                    if (_local_3 < _local_4)
                    {
                        _local_4 = -1;
                    }
                    else
                    {
                        _local_3 = -1;
                    };
                };
                if (_local_2 != -1)
                {
                    if (((!(_local_3 == -1)) && (_local_3 < _local_2)))
                    {
                        _local_5 = this.getIndexForMatchingCloseBracket(_arg_1, _local_3, "[", "]");
                        if (_local_3 == _local_7)
                        {
                            this.logError(((("Expect [ in " + _arg_1) + " at position ") + _local_7));
                            return (null);
                        };
                        if (_local_5 == -1)
                        {
                            this.logError(((("Unmatch [ in " + _arg_1) + " at position ") + _local_3));
                            return (null);
                        };
                        if (((_local_5 < (_arg_1.length - 1)) && (!(_arg_1.charAt((_local_5 + 1)) == "."))))
                        {
                            this.logError(((("Expect . after ] in " + _arg_1) + " at position ") + _local_5));
                            return (null);
                        };
                        _local_2 = ((_local_5 < (_arg_1.length - 1)) ? (_local_5 + 1) : -1);
                    }
                    else
                    {
                        if (((!(_local_4 == -1)) && (_local_4 < _local_2)))
                        {
                            if (_local_4 == _local_7)
                            {
                                this.logError(((("Expect ( in " + _arg_1) + " at position ") + _local_7));
                                return (null);
                            };
                            _local_8 = this.getIndexForMatchingCloseBracket(_arg_1, _local_4, "(", ")");
                            if (_local_8 == -1)
                            {
                                this.logError(((("Unmatch ( in " + _arg_1) + " at position ") + _local_4));
                                return (null);
                            };
                            if (((_local_8 < (_arg_1.length - 1)) && (!(_arg_1.charAt((_local_8 + 1)) == "."))))
                            {
                                this.logError(((("Expect . after ) in " + _arg_1) + " at position ") + _local_8));
                                return (null);
                            };
                            _local_2 = ((_local_8 < (_arg_1.length - 1)) ? (_local_8 + 1) : -1);
                        };
                    };
                };
                if (_local_2 == -1) break;
                _local_6.push(_arg_1.substring(_local_7, _local_2));
                _local_7 = (_local_2 + 1);
            };
            if (_local_7 < _arg_1.length)
            {
                _local_6.push(_arg_1.substring(_local_7));
            };
            return (_local_6);
        }


    }
}//package autoevony.scripts

// _SafeStr_1 = "goto" (String#9331, DoABC#2)


