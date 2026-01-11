package autoevony.scripts
{
   import autoevony.common.ScriptError;
   import autoevony.common.TechType;
   import autoevony.common.Utils;
   import autoevony.event.CityStateCompleteEvent;
   import autoevony.event.CityStateResponseEvent;
   import autoevony.event.ScriptLogEvent;
   import autoevony.event.StopScriptEvent;
   import autoevony.gui.MainScreen;
   import autoevony.net.Connection;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.AvailableResearchListBean;
   import com.evony.common.beans.BuildingBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.constants.ErrorCode;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.tech.ResearchResponse;
   import com.evony.common.server.events.BuildComplate;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   import mx.utils.Base64Encoder;
   import r1.deval.D;
   import r1.deval.rt.Env;
   import r1.deval.rt.FunctionDef;
   
   public class Script extends EventDispatcher
   {
      
      private static var m_staticVars:Object = new Object();
      
      public static var BADOBJECT:Object = new Object();
      
      public static const NEWLINE:String = "ScriptNewLineEventType";
      
      public var prototype:Object = new Object();
      
      private var snippetDownloader:HTTPService = null;
      
      private var m_stack:Array = null;
      
      private var m_sleeping:Boolean = false;
      
      private var m_scriptVarsProxy:ReScriptObjectProxy = null;
      
      private var m_curCmdIndex:int = 0;
      
      private var m_labelPos:Dictionary = new Dictionary();
      
      private var suppressError:Boolean = false;
      
      private var m_scriptTimer:Timer = new Timer(20,0);
      
      private var m_dynamicCallBackLibrary:Object = new Object();
      
      private var m_subparams:Array = null;
      
      private var m_ECMAScriptLibrary:String = "";
      
      private var snippetDownloaderCallback:Function = null;
      
      internal var silence:Boolean = false;
      
      private var m_scriptVars:Object = null;
      
      private var m_sleepTimer:Timer = null;
      
      private var m_cmdComplete:Boolean = false;
      
      private var m_loopArray:Array = new Array();
      
      private var currentSnippetDownloadUrl:String = null;
      
      private var m_script:Array = null;
      
      private var scriptCmds:Object = null;
      
      private var m_dynamicImportLibrary:String = "";
      
      private var m_running:Boolean = false;
      
      private var m_stopped:Boolean = false;
      
      public var m_city:CityState;
      
      public function Script(param1:CityState)
      {
         super();
         this.m_city = param1;
         this.m_scriptTimer.addEventListener(TimerEvent.TIMER,this.runScript);
         if(!this.m_city.hasEventListener(CityStateCompleteEvent.TYPE))
         {
            this.m_city.addEventListener(CityStateCompleteEvent.TYPE,this.handleCityCompleteEvent);
         }
         if(!this.m_city.hasEventListener(CityStateResponseEvent.TYPE))
         {
            this.m_city.addEventListener(CityStateResponseEvent.TYPE,this.handleCityResponseEvent);
         }
         this.setScriptCmds();
         D.useCache(false);
      }
      
      public function deleteStatic(param1:String) : *
      {
         var _loc2_:* = null;
         if(m_staticVars[param1] != undefined)
         {
            _loc2_ = m_staticVars[param1];
            delete m_staticVars[param1];
         }
         return _loc2_;
      }
      
      public function stop() : void
      {
         if(this.snippetDownloader != null)
         {
            this.snippetDownloader.removeEventListener(ResultEvent.RESULT,this.processDownloadedData);
            this.snippetDownloader.removeEventListener(FaultEvent.FAULT,this.processDownloadError);
            this.snippetDownloader = null;
         }
         this.snippetDownloaderCallback = null;
         this.m_running = false;
         this.m_stopped = true;
         if(this.m_sleepTimer != null)
         {
            this.clearSleepTimer(null,true);
         }
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
         if(this.m_city.currentAction == "completequests")
         {
            CityState.findQuestCount = 0;
            CityState.findQuestCastleId = 0;
            CityState.scriptQuestActive = false;
         }
         var _loc1_:StopScriptEvent = new StopScriptEvent(this.m_city.castleId);
         dispatchEvent(_loc1_);
      }
      
      private function getSetarrayCmdLine(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array();
         if(param1.indexOf("[\"") == -1 || param1.indexOf("\"]") == -1 || param1.substring(param1.length - 2) != "\"]")
         {
            throw new ArgumentError("Bad/missing brackets/quotes around array values on line: " + param1 + "\nThe proper syntax is:  setarray arrName[\"string1\", \"string2\", \"string3\"]");
         }
         _loc2_.push(param1.substr(0,8).toLowerCase());
         _loc3_ = param1.charAt(param1.indexOf("[\"") - 1) == " " ? 1 : 0;
         _loc2_.push(param1.substring(9,param1.indexOf("[\"") - _loc3_));
         _loc2_.push(param1.substring(param1.indexOf("[\"")));
         return _loc2_;
      }
      
      private function isValidVarName(param1:String) : Boolean
      {
         if(param1.charAt(0) != "_" && !isNaN(Number(param1.charAt(0))))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for " + this.getCurrentCommand().scriptCmd.cmdName + " command: Illegal variable name \"" + param1 + "\"  the first character must be a letter or _",-9999));
            return false;
         }
         if(param1.replace(/\W+?|\*/g,"") != param1)
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for " + this.getCurrentCommand().scriptCmd.cmdName + " command: Illegal character(s) in variable name \"" + param1 + "\" you may only use letters, numbers and _",-9999));
            return false;
         }
         return true;
      }
      
      private function ifCompare(param1:String, param2:String, param3:String) : Boolean
      {
         var _loc4_:Object = this.getValue(param1);
         var _loc5_:Object = this.getValue(param3);
         if(_loc4_ == BADOBJECT || _loc5_ == BADOBJECT)
         {
            this.notifyCmdFinish(false);
         }
         if(param2 == ">=")
         {
            return _loc4_ >= _loc5_;
         }
         if(param2 == ">")
         {
            return _loc4_ > _loc5_;
         }
         if(param2 == "<=")
         {
            return _loc4_ <= _loc5_;
         }
         if(param2 == "<")
         {
            return _loc4_ < _loc5_;
         }
         if(param2 == "==" || param2 == "=")
         {
            return _loc4_ == _loc5_;
         }
         if(param2 == "!=" || param2 == "<>")
         {
            return _loc4_ != _loc5_;
         }
         return false;
      }
      
      public function get m_castle() : CityState
      {
         return this.m_city;
      }
      
      public function deleteCallback(param1:String = null) : void
      {
         if(this.m_dynamicCallBackLibrary[param1] != undefined)
         {
            delete this.m_dynamicCallBackLibrary[param1];
         }
      }
      
      private function getIndexOf(param1:String, param2:String, param3:String) : void
      {
         if(this.m_scriptVars[param2].length == undefined)
         {
            this.notifyCmdFinish(false,new ScriptError("Invalid array name \'" + param2 + "\' used in \'getindexof\' command. Array \'" + param2 + "\' does not exist.",-9999));
            return;
         }
         if(this.m_scriptVars[param1] != undefined && this.m_scriptVars[param1] is Array)
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for getindexof command: Attempting to assign value of incompatible type to an already defined variable \"" + param1 + "\" of type Array",-9999));
            return;
         }
         if(!this.isValidVarName(param1))
         {
            return;
         }
         param3 = this.subVarValues(param3,this.m_scriptVars);
         if(param3 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         this.m_scriptVars[param1] = this.m_scriptVars[param2].indexOf(param3);
         if(!this.silence)
         {
            this.logMsg("Set variable \'" + param1 + "\' to index:  " + this.m_scriptVars[param1]);
         }
         this.notifyCmdFinish(true);
      }
      
      private function timedCommand(param1:ScriptCommand, param2:String) : void
      {
         var runTime:Date;
         var command:ScriptCommand = param1;
         var time:String = param2;
         var timeInt:int = 0;
         if(time.indexOf(":") > 0)
         {
            if(time.toString().substr(0,1) == "@")
            {
               timeInt = this.m_city.parseTime(time.toString().replace("@:",""),true);
            }
            else
            {
               timeInt = this.m_city.parseTime(time.toString());
            }
         }
         else
         {
            timeInt = int(time);
         }
         timeInt *= 1000;
         runTime = new Date();
         runTime.setTime(runTime.getTime() + timeInt);
         this.logMsg("Setting " + command.scriptCmd.cmdName + " to run at " + runTime.toLocaleString());
         Utils.callLater(timeInt,function():void
         {
            command.scriptCmd.func.apply(this,command.params);
         });
      }
      
      public function logResearchAction(param1:String, param2:Date, param3:AvailableResearchListBean, param4:CastleBean) : void
      {
         this.logMsg("Performing " + param1 + " on level " + param3.level + " " + TechType.toString(param3.typeId));
         this._mk747(param2);
      }
      
      private function setArray(param1:String, param2:String) : void
      {
         if(this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for setarray command: Attempting to assign value of type Array to an already defined variable \"" + param1 + "\" of another type",-9999));
            return;
         }
         if(!this.isValidVarName(param1))
         {
            return;
         }
         param2 = this.subVarValues(param2,this.m_scriptVars);
         if(param2 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         var _loc3_:Array = param2.substring(2).slice(0,-2).split(String("\", \""));
         this.m_scriptVars[param1] = _loc3_;
         if(!this.silence)
         {
            this.logMsg("Set array \'" + param1 + "\' to:  [\"" + this.m_scriptVars[param1].join("\", \"") + "\"]");
         }
         this.notifyCmdFinish(true);
      }
      
      public function set_m_script(param1:String) : void
      {
         var scriptText:String = param1;
         if(this.m_running)
         {
            return;
         }
         if(this.snippetDownloader != null)
         {
            this.snippetDownloader.removeEventListener(ResultEvent.RESULT,this.processDownloadedData);
            this.snippetDownloader.removeEventListener(FaultEvent.FAULT,this.processDownloadError);
            this.snippetDownloader = null;
         }
         this.snippetDownloader = new HTTPService();
         this.snippetDownloader.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
         this.snippetDownloader.addEventListener(ResultEvent.RESULT,this.processDownloadedData);
         this.snippetDownloader.addEventListener(FaultEvent.FAULT,this.processDownloadError);
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
         }
      }
      
      private function ifGoSub(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         if(this.ifCompare(param2,param3,param4))
         {
            this.goSub(param6);
            return;
         }
         this.notifyCmdFinish(true);
      }
      
      private function handleCityResponseEvent(param1:CityStateResponseEvent) : void
      {
         var _loc2_:BuildComplate = null;
         var _loc3_:ResearchResponse = null;
         if(param1.response is BuildComplate)
         {
            _loc2_ = param1.response as BuildComplate;
            this.logBuildAction(param1.message,new Date(_loc2_.buildingBean.endTime),_loc2_.buildingBean,this.m_city.castle);
         }
         if(param1.response is ResearchResponse)
         {
            _loc3_ = param1.response as ResearchResponse;
            this.logResearchAction(param1.message,new Date(_loc3_.tech.endTime),_loc3_.tech,this.m_city.castle);
         }
         else if(param1.response is CommandResponse)
         {
            this.logMsg(param1.response.ok + ": " + param1.response.msg,param1.textcolor);
         }
         else if(param1.response is String)
         {
            this.logMsg(param1.response + " " + param1.message,param1.textcolor);
         }
      }
      
      private function ifGoto(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         if(this.ifCompare(param2,param3,param4))
         {
            this.goto(param6);
            return;
         }
         this.notifyCmdFinish(true);
      }
      
      private function split(param1:String, param2:String, param3:String) : void
      {
         if(this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for split command: Attempting to assign value of type Array to an already defined variable \"" + param1 + "\" of another type",-9999));
            return;
         }
         if(!this.isValidVarName(param1))
         {
            return;
         }
         param3 = this.subVarValues(param3,this.m_scriptVars);
         if(param3 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         var _loc4_:Array = param3.split(param2);
         this.m_scriptVars[param1] = _loc4_;
         if(!this.silence)
         {
            this.logMsg("Set array \'" + param1 + "\' to:  [\"" + this.m_scriptVars[param1].join("\", \"") + "\"]");
         }
         this.notifyCmdFinish(true);
      }
      
      public function logError(param1:String) : void
      {
         if(this.suppressError)
         {
            return;
         }
         param1 = param1.split(">").join("&gt;").split("<").join("&lt;");
         dispatchEvent(new ScriptLogEvent("<font color=\'#ff0000\'>(" + this.m_city.castle.name + ") - " + param1,ScriptLogEvent.ERROR + "</font>",this.m_city));
      }
      
      private function echo(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null) : void
      {
         var _loc7_:Array = new Array(param1,param2,param3,param4,param5,param6);
         var _loc8_:String = "";
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.length)
         {
            if(_loc7_[_loc9_] == null)
            {
               break;
            }
            _loc8_ += _loc7_[_loc9_] + " ";
            _loc9_++;
         }
         this.logMsg(_loc8_);
         this.notifyCmdFinish(true);
      }
      
      private function join(param1:String, param2:String, param3:String = "") : void
      {
         if(this.m_scriptVars[param2] != undefined && !(this.m_scriptVars[param2] is Array))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for join command: The specified array name \"" + param2 + "\" points to a variable that is not an Array",-9999));
            return;
         }
         if(this.m_scriptVars[param2] == undefined)
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for join command: The specified array \"" + param2 + "\" is undefined",-9999));
            return;
         }
         if(this.m_scriptVars[param1] != undefined && this.m_scriptVars[param1] is Array)
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for join command: Attempting to assign value of incompatible type to an already defined variable \"" + param1 + "\" of type Array",-9999));
            return;
         }
         if(!this.isValidVarName(param1))
         {
            return;
         }
         this.m_scriptVars[param1] = this.m_scriptVars[param2].join(param3);
         if(!this.silence)
         {
            this.logMsg("Set variable \'" + param1 + "\' to:  \"" + this.m_scriptVars[param1] + "\"");
         }
         this.notifyCmdFinish(true);
      }
      
      public function lineElementsToArray(param1:String) : Array
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(param1.length > 9 && param1.substr(0,9).toLowerCase() == "setarray ")
         {
            return this.getSetarrayCmdLine(param1);
         }
         var _loc2_:Array = param1.split(" ");
         var _loc3_:Array = new Array();
         while(_loc2_.length > 1 && _loc2_[1] == "")
         {
            _loc2_.splice(1,1);
         }
         if(_loc2_[0].toLowerCase() == "if" && _loc2_[1].charAt(0) == "(")
         {
            if(_loc2_[1].charAt(1) == ")")
            {
               throw new ArgumentError("Invalid/missing condition statement for if command on line: " + param1);
            }
            _loc2_.shift();
            _loc8_ = _loc2_.join(" ").substr(1);
            _loc9_ = "(";
            while(_loc8_.length > 1)
            {
               _loc9_ += _loc8_.charAt(0);
               _loc8_ = _loc8_.substr(1);
               if(_loc9_.split("(").length == _loc9_.split(")").length)
               {
                  _loc8_ = Utils.trim(_loc8_);
                  _loc2_ = _loc8_.length > 9 && _loc8_.substr(0,9).toLowerCase() == "setarray " ? this.getSetarrayCmdLine(_loc8_) : _loc8_.split(" ");
                  _loc2_.unshift(_loc9_);
                  _loc2_.unshift("if");
                  _loc3_.push(_loc2_.shift());
                  _loc3_.push(_loc2_.shift());
                  while(_loc2_.length > 0)
                  {
                     if(String(_loc2_[0]).indexOf("\"") != -1)
                     {
                        break;
                     }
                     _loc3_.push(_loc2_.shift());
                  }
                  if(_loc2_.length > 0)
                  {
                     _loc8_ = _loc2_.join(" ");
                     if(_loc8_.charAt(0) == "\"")
                     {
                        _loc8_ = _loc8_.substr(1);
                     }
                     if(_loc8_.charAt(_loc8_.length - 1) == "\"")
                     {
                        _loc8_ = _loc8_.substring(0,_loc8_.length - 1);
                     }
                     _loc3_.push(_loc8_);
                  }
                  return _loc3_;
               }
            }
            throw new ArgumentError("Unmatched parentheses in condition statement for if command on line: " + param1);
         }
         var _loc4_:Boolean = false;
         var _loc5_:int = 1;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc2_[_loc5_].substring(0,7) == "$m_dyn.")
            {
               _loc4_ = true;
               while(String(_loc2_[_loc5_]).substr(7).indexOf("$") == -1)
               {
                  _loc2_[_loc5_] = _loc2_[_loc5_] + " " + _loc2_.splice(_loc5_ + 1,1);
                  if(_loc5_ == _loc2_.length)
                  {
                     throw new ArgumentError("No closing $ found to terminate $m_dyn statement in line: " + param1);
                  }
               }
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            return _loc2_;
         }
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc8_ = param1;
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            if(_loc8_.charAt(_loc5_) == " ")
            {
               _loc5_++;
            }
            else
            {
               if(_loc8_.charAt(_loc5_) == "\"")
               {
                  _loc7_ = int(_loc8_.indexOf("\"",_loc5_ + 1));
                  if(_loc7_ == -1 || _loc7_ < _loc8_.length - 1 && _loc8_.charAt(_loc7_ + 1) != " ")
                  {
                     throw new ArgumentError("Bad double quotes on line " + param1);
                  }
                  _loc3_.push(_loc8_.substring(_loc5_ + 1,_loc7_));
                  _loc5_ = _loc7_ + 1;
                  if(_loc5_ == _loc8_.length)
                  {
                     break;
                  }
               }
               _loc6_ = int(_loc8_.indexOf(" ",_loc5_));
               if(_loc6_ == -1)
               {
                  _loc3_.push(_loc8_.substr(_loc5_));
                  break;
               }
               _loc3_.push(_loc8_.substring(_loc5_,_loc6_));
               _loc5_ = _loc6_ + 1;
            }
         }
         return _loc3_;
      }
      
      private function processDownloadError(param1:FaultEvent) : void
      {
         this.onArgumentError(new ArgumentError("Error preprocessing script, failed to load " + this.currentSnippetDownloadUrl));
      }
      
      private function goSub(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null, param7:String = null, param8:String = null, param9:String = null, param10:String = null, param11:String = null) : void
      {
         if(this.m_stack.length > 200)
         {
            this.notifyCmdFinish(false,new ScriptError("Stack overflow in gosub command",-9999));
            return;
         }
         this.m_stack.push(this.m_curCmdIndex);
         this.m_subparams.push(this._ft1407());
         this._ao680({
            "_1":param2,
            "_2":param3,
            "_3":param4,
            "_4":param5,
            "_5":param6,
            "_6":param7,
            "_7":param8,
            "_8":param9,
            "_9":param10,
            "_10":param11
         });
         this.goto(param1);
      }
      
      public function notifyCmdFinish(param1:Boolean, param2:ScriptError = null) : void
      {
         var _loc3_:Boolean = true;
         if(this.m_stopped)
         {
            return;
         }
         if(!param1)
         {
            _loc3_ = this.handleScriptError(param2);
         }
         this.m_cmdComplete = _loc3_;
         this.m_running = !_loc3_;
      }
      
      private function _lc356(param1:String) : Object
      {
         var _loc12_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:Array = new Array("||","^","*","/","\\","|","+","-","&&",">=","<=",">","<","==","!=");
         var _loc9_:Array = new Array();
         var _loc10_:int = 0;
         while(_loc10_ != param1.length)
         {
            if(param1.charAt(_loc10_) == "{")
            {
               _loc5_ = this.getIndexForMatchingCloseBracket(param1,_loc10_);
               if(_loc5_ == -1)
               {
                  this.logError("Unmatched { in " + param1 + " at position " + _loc10_);
                  return null;
               }
               _loc6_ = this._lc356(param1.substring(_loc10_ + 1,_loc5_));
               if(_loc6_ == null)
               {
                  return null;
               }
               _loc10_ = _loc5_ + 1;
               _loc9_.push(_loc6_);
            }
            else if(param1.charAt(_loc10_) == "!" && param1.substr(_loc10_,2) != "!=")
            {
               _loc9_.push("!");
               _loc10_++;
            }
            else
            {
               _loc2_ = param1.length;
               _loc3_ = null;
               for each(_loc4_ in _loc8_)
               {
                  _loc7_ = int(param1.indexOf(_loc4_,_loc10_));
                  if(_loc7_ != -1)
                  {
                     if(_loc7_ < _loc2_)
                     {
                        _loc2_ = _loc7_;
                        _loc3_ = _loc4_;
                     }
                  }
               }
               if(_loc3_ == null)
               {
                  _loc9_.push(param1.substr(_loc10_));
                  break;
               }
               if(_loc10_ != _loc2_)
               {
                  _loc9_.push(param1.substring(_loc10_,_loc2_));
               }
               _loc9_.push(_loc3_);
               _loc10_ = _loc2_ + _loc3_.length;
            }
         }
         if(_loc9_.length == 0)
         {
            this.logError("Internal parsing error for " + param1);
            return null;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            if(_loc9_[_loc10_] is String)
            {
               if(_loc9_[_loc10_] == "-")
               {
                  if(_loc10_ == _loc9_.length - 1)
                  {
                     this.logError("Invalid operand for operation -");
                     return null;
                  }
                  if(_loc10_ == 0 || _loc9_[_loc10_ - 1] is String && _loc8_.indexOf(_loc9_[_loc10_ - 1]) != -1)
                  {
                     _loc9_.splice(_loc10_,2,{
                        "op":"-",
                        "oper1":0,
                        "oper2":_loc9_[_loc10_ + 1]
                     });
                     _loc10_--;
                  }
               }
               else if(_loc9_[_loc10_] == "!")
               {
                  if(_loc10_ == _loc9_.length - 1)
                  {
                     this.logError("Invalid operand for operation !");
                     return null;
                  }
                  _loc9_.splice(_loc10_,2,{
                     "op":"!",
                     "oper1":_loc9_[_loc10_ + 1],
                     "oper2":null
                  });
                  _loc10_--;
               }
            }
            _loc10_++;
         }
         var _loc11_:Array = [["^"],["*","/","\\","|"],["+","-"],[">=","<=",">","<"],["==","!="],["&&"],["||"]];
         for each(_loc12_ in _loc11_)
         {
            _loc10_ = 1;
            while(_loc10_ < _loc9_.length)
            {
               if(_loc9_[_loc10_] is String)
               {
                  if(_loc12_.indexOf(_loc9_[_loc10_]) != -1)
                  {
                     if(_loc10_ == 0 || _loc10_ == _loc9_.length - 1)
                     {
                        this.logError("Invalid operand for binary operator " + _loc9_[_loc10_]);
                        return null;
                     }
                     _loc9_.splice(_loc10_ - 1,3,{
                        "op":_loc9_[_loc10_],
                        "oper1":_loc9_[_loc10_ - 1],
                        "oper2":_loc9_[_loc10_ + 1]
                     });
                     _loc10_--;
                  }
               }
               _loc10_++;
            }
         }
         if(_loc9_.length > 1)
         {
            this.logError("Too few operators in " + param1);
            return null;
         }
         return _loc9_[0];
      }
      
      private function parseExpr(param1:String) : String
      {
         var _loc2_:Object = this._lc356(param1);
         if(_loc2_ == null)
         {
            this.logError("Unable to parse expression: " + param1);
            return null;
         }
         var _loc3_:Object = this.doEval(_loc2_);
         if(_loc3_ == BADOBJECT)
         {
            return null;
         }
         return _loc3_.toString();
      }
      
      private function listCommands(param1:String = "") : void
      {
         var _loc4_:ScriptCmd = null;
         param1 = param1.toLowerCase();
         var _loc2_:String = "<b>List of script commands:</b>\n<b>Core commands:</b>   ";
         var _loc3_:int = 0;
         for each(_loc4_ in this.scriptCmds)
         {
            if(_loc4_.cmdName.indexOf(param1) != -1)
            {
               _loc3_++;
               _loc2_ += _loc4_.cmdName + "  ";
            }
         }
         _loc2_ += (_loc3_ > 0 ? "" : "<i>[none]</i>") + "\n<b>Additional commands:</b>   ";
         _loc3_ = 0;
         for each(_loc4_ in this.m_city._getScriptCmds())
         {
            if(_loc4_.cmdName.indexOf(param1) != -1)
            {
               _loc3_++;
               _loc2_ += _loc4_.cmdName + "  ";
            }
         }
         _loc2_ += (_loc3_ > 0 ? "" : "[ none ]") + "\n";
         this.logMsg(_loc2_,"#000000",false);
         this.logMsg("Use \'info command\' for information on a specific script command");
         if(param1 == "" && _loc2_.length > 200)
         {
            this.logMsg("Consider using \'listcommands filter\', for example \'listcommands at\' to restrict the command");
         }
         this.notifyCmdFinish(true);
      }
      
      private function checkForAndHandleUserVariables(param1:String, param2:Object) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc11_:String = "";
         while(true)
         {
            _loc3_ = int(param1.indexOf("%",_loc7_));
            if(_loc3_ == -1)
            {
               break;
            }
            _loc4_ = int(param1.indexOf("%",_loc3_ + 1));
            if(_loc4_ == -1)
            {
               this.logError("Unmatched % in " + param1);
               return null;
            }
            _loc5_ = int(param1.indexOf("{",_loc3_ + 1));
            if(_loc5_ != -1 && _loc5_ < _loc4_)
            {
               _loc6_ = this.getIndexForMatchingCloseBracket(param1,_loc5_);
               if(_loc6_ == -1)
               {
                  this.logError("Unmatched bracket in " + param1);
                  return null;
               }
               _loc4_ = int(param1.indexOf("%",_loc6_ + 1));
               if(_loc4_ == -1)
               {
                  this.logError("Unmatched % in " + param1);
                  return null;
               }
               _loc10_ = this.subVarValues(param1.substring(_loc5_,_loc6_ + 1),param2);
               if(_loc10_ == null)
               {
                  return null;
               }
               _loc8_ = param1.substring(_loc3_ + 1,_loc5_) + _loc10_ + param1.substring(_loc6_ + 1,_loc4_);
            }
            else
            {
               _loc8_ = param1.substring(_loc3_ + 1,_loc4_);
            }
            _loc8_ = this.checkForAndHandleEvalStatements(_loc8_);
            if(_loc8_ == null)
            {
               return null;
            }
            _loc9_ = this.getValueFromVarName(_loc8_,param2);
            if(_loc9_ == null)
            {
               this.logError("Undefined variable " + param1.substring(_loc3_,_loc4_ + 1));
               return null;
            }
            _loc11_ += param1.substring(_loc7_,_loc3_) + _loc9_;
            _loc7_ = _loc4_ + 1;
         }
         return _loc11_ + param1.substr(_loc7_);
      }
      
      private function _ft1407() : Object
      {
         var _loc1_:String = null;
         var _loc2_:Object = new Object();
         for(_loc1_ in this.m_scriptVars)
         {
            if(_loc1_.charAt(0) == "_")
            {
               _loc2_[_loc1_] = this.m_scriptVars[_loc1_];
               delete this.m_scriptVars[_loc1_];
            }
         }
         return _loc2_;
      }
      
      private function runScript(param1:TimerEvent) : void
      {
         if(!this.m_cmdComplete && this.m_running)
         {
            return;
         }
         if(this.m_curCmdIndex < this.m_script.length)
         {
            if(this.m_stopped)
            {
               return;
            }
            this.m_running = true;
            this.m_cmdComplete = false;
            this.runCurrentCmd();
         }
         else
         {
            this.logMsg("Finished script");
            this.stop();
         }
      }
      
      internal function callbackHelper(param1:String, param2:String, param3:Object) : *
      {
         var dynCode:String = param1;
         var exec:String = param2;
         var varsLib:Object = param3;
         try
         {
            return D.eval(dynCode + exec,varsLib,this);
         }
         catch(exc:Error)
         {
            this.logError("Callback error while referencing dynamic library in: " + exec + " : " + exc.errorID + ":   " + exc.message);
         }
         this.prototype = new Object();
         return null;
      }
      
      private function logBuildAction(param1:String, param2:Date, param3:BuildingBean, param4:CastleBean) : void
      {
         this.logMsg("Performing " + param1 + " on level " + param3.level + " " + param3.name);
         this._mk747(param2);
      }
      
      public function get c() : CityState
      {
         return this.m_city;
      }
      
      public function setVar(param1:String, param2:*) : *
      {
         if(param2 is Array && this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
         {
            throw new ArgumentError("Error in parameters for setVar(): Attempting to assign value of type Array to an already defined variable of another type");
         }
         if(!(param2 is Array) && this.m_scriptVars[param1] is Array)
         {
            throw new ArgumentError("Error in parameters for setVar(): Attempting to assign value of incompatible type to an already defined variable of type Array");
         }
         if(param1.charAt(0) != "_" && !isNaN(Number(param1.charAt(0))))
         {
            throw new ArgumentError("Error in parameters for setVar(): Illegal variable name \"" + param1 + "\"  the first character must be a letter or _");
         }
         if(param1.replace(/\W+?|\*/g,"") != param1)
         {
            throw new ArgumentError("Error in parameters for setVar(): Illegal character(s) in variable name \"" + param1 + "\" you may only use letters, numbers and _");
         }
         this.m_scriptVars[param1] = param2;
         return this.getVar(param1);
      }
      
      private function processScriptText(param1:String, param2:int = 20) : void
      {
         var lines:Array = null;
         var i:int = 0;
         var y:String = null;
         var processResult:Function = null;
         var scriptText:String = param1;
         var count:int = param2;
         var url:String = null;
         var urlcheck:Boolean = false;
         if(count <= 0)
         {
            throw new ArgumentError("Error processing script, too many redirects");
         }
         lines = scriptText.split(/\r|\n/);
         if((lines = MainScreen.getInstance()._snippets.getTrimmedSnippetCmdLines(lines)) == null)
         {
            throw new ArgumentError("Script preprocessing error while loading snippets, please check all include lines");
         }
         scriptText = lines.join("\n");
         i = 0;
         while(true)
         {
            if(i >= lines.length)
            {
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
               }
               return;
            }
            y = Utils.trim(lines[i]);
            if(y.substr(0,11) == "includeurl ")
            {
               url = y.substr(11);
               urlcheck = true;
               break;
            }
            if(y.substr(0,12) == "includefile ")
            {
               url = y.substr(12);
               urlcheck = false;
               break;
            }
            i++;
         }
         processResult = function(param1:String):void
         {
            var totaltext:String;
            var result:String = param1;
            var nextpart:Array = lines.splice(i,lines.length - i);
            nextpart.splice(0,1);
            totaltext = lines.join("\n") + "\n" + result + "\n" + nextpart.join("\n");
            try
            {
               this.processScriptText(totaltext,count - 1);
            }
            catch(aE:ArgumentError)
            {
               this.onArgumentError(aE);
            }
            catch(e:Error)
            {
               this.onPreProcessingError(e);
            }
         };
         try
         {
            this.downloadUrl(url,urlcheck,processResult);
         }
         catch(aE:ArgumentError)
         {
            this.onArgumentError(aE);
         }
         catch(e:Error)
         {
            this.onPreProcessingError(e);
         }
      }
      
      private function goto(param1:String) : void
      {
         this.m_curCmdIndex = this._pp316(param1);
         if(this.m_curCmdIndex == -1)
         {
            this.logError("Invalid label " + param1);
         }
         else if(!this.silence)
         {
            this.logMsg("Going to line " + (this.m_curCmdIndex + 1));
         }
         this.notifyCmdFinish(true);
      }
      
      public function getStatic(param1:String) : *
      {
         return m_staticVars[param1] == undefined ? null : m_staticVars[param1];
      }
      
      public function setStatic(param1:String, param2:*) : *
      {
         if(param1.charAt(0) != "_" && !isNaN(Number(param1.charAt(0))))
         {
            throw new ArgumentError("Error in parameters for setStatic(): Illegal variable name \"" + param1 + "\"  the first character must be a letter or _");
         }
         if(param1.replace(/\W+?|\*/g,"") != param1)
         {
            throw new ArgumentError("Error in parameters for setStatic(): Illegal character(s) in variable name \"" + param1 + "\" you may only use letters, numbers and _");
         }
         return m_staticVars[param1] = param2;
      }
      
      public function deleteVar(param1:String) : *
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         if(this.m_scriptVars[param1] != undefined)
         {
            _loc2_ = this.m_scriptVars[param1];
            delete this.m_scriptVars[param1];
         }
         else
         {
            _loc3_ = int(param1.indexOf("["));
            if(_loc3_ != -1 && param1.indexOf("]") == param1.length - 1 && Utils.hasValue(param1.substring(_loc3_ + 1,param1.length - 1)))
            {
               _loc4_ = param1.substring(0,param1.indexOf("["));
               _loc5_ = int(param1.substring(_loc3_ + 1,param1.length - 1));
               if(this.m_scriptVars[_loc4_].length != undefined)
               {
                  _loc2_ = this.m_scriptVars[_loc4_].splice(_loc5_,1)[0];
               }
            }
         }
         return _loc2_;
      }
      
      private function checkForAndHandleEvalStatements(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         while(true)
         {
            _loc2_ = int(param1.indexOf("{",_loc6_));
            if(_loc2_ == -1)
            {
               break;
            }
            _loc3_ = this.getIndexForMatchingCloseBracket(param1,_loc2_);
            if(_loc3_ == -1)
            {
               this.logError("Brackets are not matched in " + param1);
               return null;
            }
            _loc4_ = param1.substring(_loc2_ + 1,_loc3_);
            _loc4_ = this.parseExpr(_loc4_);
            if(_loc4_ == null)
            {
               return null;
            }
            _loc5_ += param1.substring(_loc6_,_loc2_) + _loc4_.toString();
            _loc6_ = _loc3_ + 1;
         }
         if(param1.indexOf("}",_loc6_) != -1)
         {
            this.logError("Brackets are not matched in " + param1);
            return null;
         }
         return _loc5_ + param1.substr(_loc6_);
      }
      
      public function _cleanUp() : void
      {
         this.stop();
         this.m_scriptTimer.removeEventListener(TimerEvent.TIMER,this.runScript);
         this.m_scriptTimer = null;
         this.m_city.removeEventListener(CityStateCompleteEvent.TYPE,this.handleCityCompleteEvent);
         this.m_city.removeEventListener(CityStateResponseEvent.TYPE,this.handleCityResponseEvent);
         this.m_dynamicCallBackLibrary = null;
         this.scriptCmds = null;
         this.prototype = null;
         this.m_loopArray = null;
         this.m_labelPos = null;
         this.m_city = null;
      }
      
      public function getCallbackVars(param1:String = null) : Object
      {
         if(param1 == null)
         {
            return null;
         }
         if(this.m_dynamicCallBackLibrary[param1] == undefined)
         {
            return null;
         }
         return (this.m_dynamicCallBackLibrary[param1] as DevalCallbackContainer).varsObj;
      }
      
      public function getCurrentCommand() : ScriptCommand
      {
         return this.m_script[this.m_curCmdIndex] as ScriptCommand;
      }
      
      private function createActionResponseListener(param1:String, param2:String) : void
      {
         var catchResponseHandler:Function = null;
         var timeOutTimerHandler:Function = null;
         var catchTimeOutTimer:Timer = null;
         var responseEvent:String = param1;
         var varName:String = param2;
         catchResponseHandler = function(param1:Object):void
         {
            catchTimeOutTimer.reset();
            catchTimeOutTimer.removeEventListener(TimerEvent.TIMER,timeOutTimerHandler);
            catchTimeOutTimer = null;
            ResponseDispatcher.getInstance().removeEventListener(responseEvent,catchResponseHandler);
            m_city.actionResponse[varName] = param1;
         };
         timeOutTimerHandler = function(param1:TimerEvent):void
         {
            catchTimeOutTimer.reset();
            catchTimeOutTimer.removeEventListener(TimerEvent.TIMER,timeOutTimerHandler);
            catchTimeOutTimer = null;
            ResponseDispatcher.getInstance().removeEventListener(responseEvent,catchResponseHandler);
            m_city.actionResponse[varName] = null;
         };
         catchTimeOutTimer = new Timer(45000,1);
         catchTimeOutTimer.addEventListener(TimerEvent.TIMER,timeOutTimerHandler);
         this.m_city.actionResponse[varName] = null;
         ResponseDispatcher.getInstance().addEventListener(responseEvent,catchResponseHandler);
         catchTimeOutTimer.start();
      }
      
      private function goSubReturn(param1:String = "0") : void
      {
         if(this.m_stack.length == 0 || this.m_subparams.length == 0)
         {
            this.logMsg("Found gosubreturn without gosub. Skipping...");
            this.notifyCmdFinish(true);
            return;
         }
         this.m_curCmdIndex = this.m_stack.pop();
         var _loc2_:Object = this._ft1407();
         this._ao680(this.m_subparams.pop());
         this.m_curCmdIndex;
         this.m_scriptVars["_0"] = param1;
         if(!this.silence)
         {
            this.logMsg("Returning to line " + (this.m_curCmdIndex + 1));
         }
         this.notifyCmdFinish(true);
      }
      
      private function logout(param1:String = "now", param2:String = "") : void
      {
         if(param1.substr(0,3).toLowerCase() == "now")
         {
            this.doLogout();
         }
         else
         {
            this.timedCommand(new ScriptCommand(new ScriptCmd("logout",this.doLogout,new Array(),new Array(),0),new Array()),param1);
         }
         if(param2.length > 0)
         {
            this.timedCommand(new ScriptCommand(new ScriptCmd("login",this.doLogin,new Array(),new Array(),0),new Array()),param2);
         }
         this.notifyCmdFinish(true);
      }
      
      private function getValueFromVarName(param1:String, param2:Object) : String
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc3_ = int(param1.indexOf("["));
         if(_loc3_ != -1 && param1.indexOf("]") == param1.length - 1 && Utils.hasValue(param1.substring(_loc3_ + 1,param1.length - 1)))
         {
            _loc4_ = param1.substring(0,param1.indexOf("["));
            _loc5_ = int(param1.substring(_loc3_ + 1,param1.length - 1));
            if(param2[_loc4_] == undefined || param2[_loc4_] == null)
            {
               return null;
            }
            if((param2[_loc4_][_loc5_] == undefined || param2[_loc4_][_loc5_] == null) && param2[_loc4_].length > _loc5_)
            {
               return "null";
            }
            if((param2[_loc4_][_loc5_] == undefined || param2[_loc4_][_loc5_] == null) && param2[_loc4_].length <= _loc5_)
            {
               return null;
            }
            return param2[_loc4_][_loc5_];
         }
         if(param1.substr(-7) == ".length")
         {
            param1 = param1.substr(0,param1.length - 7);
            if(param2[param1] == undefined || param2[param1].length == undefined || param2[param1] == null)
            {
               return null;
            }
            return param2[param1].length;
         }
         if(param2[param1] == undefined)
         {
            return null;
         }
         return param2[param1];
      }
      
      public function _pp316(param1:Object) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         if(int(param1) > 0)
         {
            return this.m_curCmdIndex - (int(param1) + 1);
         }
         if(param1 in this.m_labelPos)
         {
            return this.m_labelPos[param1];
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.m_script.length)
         {
            if(this.m_script[_loc2_].scriptCmd.func == this.label && this.m_script[_loc2_].params[0] == param1)
            {
               break;
            }
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function substitute(param1:Array, param2:Object, param3:Boolean = false) : Array
      {
         var arr:Array = null;
         var i:int = 0;
         var lineElements:Array = param1;
         var vars:Object = param2;
         var isIf:Boolean = param3;
         arr = new Array(lineElements.length);
         i = 0;
         while(i < lineElements.length)
         {
            if(isIf && i == 0 && lineElements[i].charAt(0) == "(" && lineElements[i].charAt(lineElements[i].length - 1) == ")")
            {
               try
               {
                  arr[i] = D.evalToBoolean(this.m_dynamicImportLibrary + this.m_ECMAScriptLibrary + "\n\n" + lineElements[i],this.m_scriptVarsProxy,this);
               }
               catch(exc:Error)
               {
                  arr[i] = null;
                  logError("Problem evaluating ECMA conditional paramter in:  if " + lineElements[i] + "  :: " + exc.errorID + ": " + exc.message);
               }
               this.m_scriptVarsProxy.clearTempProperties();
               this.prototype = new Object();
            }
            else if(isIf && i != 0)
            {
               arr[i] = lineElements[i];
            }
            else
            {
               arr[i] = this.subVarValues(lineElements[i],vars);
            }
            if(arr[i] == null)
            {
               return null;
            }
            i++;
         }
         return arr;
      }
      
      public function repeat(param1:int) : void
      {
         this.loop(param1,1);
      }
      
      private function cmdDelete(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(this.m_scriptVars[param1] == undefined)
         {
            if(this.silence)
            {
               this.notifyCmdFinish(true);
            }
            else
            {
               this.notifyCmdFinish(false,new ScriptError("The specified variable \"" + param1 + "\" is already undefined. Note- using \"setsilence true\" will suppress this notification.",-9999));
            }
            return;
         }
         _loc2_ = int(param1.indexOf("["));
         if(_loc2_ != -1 && param1.indexOf("]") == param1.length - 1 && Utils.hasValue(param1.substring(_loc2_ + 1,param1.length - 1)))
         {
            _loc3_ = param1.substring(0,param1.indexOf("["));
            _loc4_ = int(param1.substring(_loc2_ + 1,param1.length - 1));
            this.m_scriptVars[_loc3_].splice(_loc4_,1);
         }
         else
         {
            delete this.m_scriptVars[param1];
         }
         if(!this.silence)
         {
            this.logMsg("Deleted variable: \'" + param1 + "\'");
         }
         this.notifyCmdFinish(true);
      }
      
      private function doLogin() : void
      {
         var _loc1_:Connection = Connection.getInstance();
         if(_loc1_.authenticated)
         {
            this.logMsg("Already connected. Call logoff before attempting to login");
            this.notifyCmdFinish(true);
            return;
         }
         _loc1_.reconnectTimer.delay = 30000;
         this.logMsg("Login - Attempting login");
         _loc1_.reconnectTimer.start();
         _loc1_.paused = false;
      }
      
      private function setArr(param1:String, param2:String) : void
      {
         if(this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for setarr command: Attempting to assign value of type Array to an already defined variable \"" + param1 + "\" of another type",-9999));
            return;
         }
         if(!this.isValidVarName(param1))
         {
            return;
         }
         var _loc3_:Array = param2.split(" ");
         param2 = this.subVarValues(param2,this.m_scriptVars);
         if(param2 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         this.m_scriptVars[param1] = _loc3_;
         if(!this.silence)
         {
            this.logMsg("Set array \'" + param1 + "\' to:  [\"" + this.m_scriptVars[param1].join("\", \"") + "\"]");
         }
         this.notifyCmdFinish(true);
      }
      
      private function loop(param1:int = 0, param2:Object = null) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_loopArray.length)
         {
            _loc3_ = this.m_loopArray[_loc4_];
            if(_loc3_[0] == this.m_curCmdIndex)
            {
               break;
            }
            _loc3_ = null;
            _loc4_++;
         }
         if(_loc3_ == null)
         {
            _loc3_ = new Array(3);
            _loc3_[0] = this.m_curCmdIndex;
            _loc3_[1] = param1;
            _loc3_[2] = 0;
            this.m_loopArray.push(_loc3_);
         }
         else if(_loc3_[1] != 0 && _loc3_[2] >= _loc3_[1])
         {
            _loc3_[2] = 0;
         }
         _loc3_[2] += 1;
         if(_loc3_[1] == 0 || _loc3_[2] < _loc3_[1])
         {
            this.m_curCmdIndex = this._pp316(param2);
            dispatchEvent(new Event(NEWLINE));
            if(this.m_curCmdIndex >= this.m_script.length)
            {
               this.logMsg("Missing label: " + param2);
            }
            else if(param2 == null || int(param2) > 0)
            {
               if(!this.silence)
               {
                  this.logMsg("Loop " + _loc3_[2] + "/" + (_loc3_[1] == 0 ? "~" : _loc3_[1]));
               }
               else if(!this.silence)
               {
                  this.logMsg("Loop to label \'" + param2.toString() + "\' - " + _loc3_[2] + "/" + (_loc3_[1] == 0 ? "~" : _loc3_[1]));
               }
            }
         }
         else if(!this.silence)
         {
            this.logMsg("Loop end");
         }
         this.notifyCmdFinish(true);
      }
      
      private function onArgumentError(param1:ArgumentError) : void
      {
         MainScreen.getInstance()._cityPanel.setScriptState(this.m_city.castleId,false);
         this.logMsg(param1.message.split("<").join("&lt;").split(">").join("&gt;"),"#DD0000");
      }
      
      private function print(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:String = null, param6:String = null) : void
      {
         var _loc7_:Object = null;
         var _loc8_:Array = new Array(param1,param2,param3,param4,param5,param6);
         var _loc9_:String = "";
         var _loc10_:int = 0;
         while(_loc10_ < _loc8_.length)
         {
            if(_loc8_[_loc10_] == null)
            {
               break;
            }
            _loc7_ = this.getValue(_loc8_[_loc10_]);
            if(_loc7_ != BADOBJECT)
            {
               _loc9_ += _loc7_.toString() + " ";
            }
            _loc10_++;
         }
         this.logMsg(_loc9_);
         this.notifyCmdFinish(true);
      }
      
      private function info(param1:String) : void
      {
         var _loc2_:ScriptCmd = null;
         _loc2_ = this.getScriptCmd(param1);
         if(_loc2_ == null)
         {
            _loc2_ = this.m_city._getScriptCmd(param1);
         }
         if(_loc2_ == null)
         {
            this.logMsg("Invalid command " + param1 + ", use \'listcommands\' the list of all script commands");
         }
         else
         {
            this.logMsg("Usage: " + _loc2_.getCmdInfo());
         }
         this.notifyCmdFinish(true);
      }
      
      public function _mk747(param1:Date) : void
      {
         this.logMsg("Estimated finish time: " + param1.toLocaleString());
      }
      
      private function getScriptCmd(param1:String) : ScriptCmd
      {
         if(this.scriptCmds == null)
         {
            this.setScriptCmds();
         }
         if(this.scriptCmds[param1] != undefined)
         {
            return this.scriptCmds[param1] as ScriptCmd;
         }
         return null;
      }
      
      public function getCallback(param1:String = null) : Function
      {
         if(param1 == null)
         {
            return null;
         }
         if(this.m_dynamicCallBackLibrary[param1] == undefined)
         {
            return null;
         }
         return (this.m_dynamicCallBackLibrary[param1] as DevalCallbackContainer).callback as Function;
      }
      
      private function handleScriptError(param1:ScriptError) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:int = 5000;
         if(param1 == null || param1.errorID == 0)
         {
            this.logError("Script error occured without a valid error id: " + param1.message);
            this.logError("Stopping script");
            this.stop();
            return true;
         }
         switch(param1.errorID)
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
               this.logError(param1.message);
               _loc4_ = true;
               _loc3_ = true;
               break;
            case ErrorCode.TOWNHALL_LEVEL_UNSUPPORT:
            case ErrorCode.INVALID_BUILDING_STATUS:
               this.logError("A building is still building.  Skipping.  See issue 235 on project page");
               _loc4_ = true;
               _loc3_ = true;
               break;
            case ErrorCode.ALREADY_UPGRADING_RESEARCH_IN_ACADEMY:
               this.logError(param1.message);
               _loc4_ = true;
               _loc3_ = true;
               break;
            case ErrorCode.ITEM_RULE_ERROR:
               _loc4_ = true;
               _loc3_ = true;
               break;
            default:
               this.logError(param1.message);
               _loc4_ = true;
               _loc3_ = true;
         }
         if(_loc2_)
         {
            if(_loc5_ < 0)
            {
               _loc5_ = 5000;
            }
            this.logMsg("Retrying in " + Math.ceil(_loc5_ / 1000) + " seconds...");
            this.sleep("" + _loc5_ / 1000);
            --this.m_curCmdIndex;
            dispatchEvent(new Event(NEWLINE));
         }
         if(!_loc4_)
         {
            this.logMsg("An unhandled error has occured:" + param1.errorID + " - " + param1.message + "\n" + param1.getStackTrace());
            this.logMsg("Stopping script");
            this.stop();
         }
         return _loc3_;
      }
      
      private function addToArray(param1:String, param2:int, param3:String) : void
      {
         if(this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
         {
            this.notifyCmdFinish(false,new ScriptError("Error in parameters for addtoarray command: The specified array name \"" + param1 + "\" points to a variable that is not an Array",-9999));
            return;
         }
         param3 = this.subVarValues(param3,this.m_scriptVars);
         if(param3 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         if(this.m_scriptVars[param1] == undefined)
         {
            if(param2 > 0)
            {
               this.m_scriptVars[param1] = new Array(param2);
            }
            else
            {
               this.m_scriptVars[param1] = new Array();
            }
            this.m_scriptVars[param1].push(param3);
         }
         else
         {
            this.m_scriptVars[param1].splice(param2,0,param3);
         }
         if(!this.silence)
         {
            this.logMsg("Pushed element to: \'" + param1 + "\' at index: \'" + param2 + "\' and set to: \"" + this.m_scriptVars[param1][param2] + "\"");
         }
         this.notifyCmdFinish(true);
      }
      
      private function logMsg(param1:String, param2:String = "#000000", param3:Boolean = true) : void
      {
         if(param3)
         {
            param1 = param1.split("<").join("&lt;").split(">").join("&gt;");
         }
         dispatchEvent(new ScriptLogEvent("<font color=\'#ff0000\'>(" + (this.m_city == null || this.m_city.castle == null ? "" : this.m_city.castle.name) + ")</font> - <font color=\'" + param2 + "\'>" + param1 + "</font>",ScriptLogEvent.MESSAGE,this.m_city));
      }
      
      public function getValue(param1:String) : Object
      {
         var output:Object;
         var splitParam:Array = null;
         var functionName:String = null;
         var functionParamString:String = null;
         var name:String = null;
         var functionParamArr:Array = null;
         var arrayName:String = null;
         var arrayIndexString:String = null;
         var arrayParam:int = 0;
         var matching:int = 0;
         var arrayIndex:Object = null;
         var tempObject:Object = null;
         var func:Function = null;
         var xml:XML = null;
         var j:int = 0;
         var k:int = 0;
         var param:String = param1;
         if(param == "")
         {
            return "";
         }
         if(Utils.hasValue(param))
         {
            return Number(param);
         }
         output = null;
         if(param.substring(0,6) == "m_dyn.")
         {
            try
            {
               output = D.eval(this.m_dynamicImportLibrary + this.m_ECMAScriptLibrary + "\n\n" + param.substring(6),this.m_scriptVarsProxy,this);
               this.m_scriptVarsProxy.clearTempProperties();
               this.prototype = new Object();
            }
            catch(exc:Error)
            {
               this.prototype = new Object();
               this.logError("Runtime error while referencing dynamic library: " + param + " at: " + param.substring(6) + " : " + exc.errorID + ": " + exc.message);
               return BADOBJECT;
            }
         }
         else
         {
            splitParam = null;
            splitParam = this.getValidatedParams(param);
            if(splitParam == null)
            {
               return BADOBJECT;
            }
            if(splitParam.length == 0)
            {
               this.logError("Abnormal parsing error");
               return BADOBJECT;
            }
            output = null;
            if(splitParam.length == 1)
            {
               if(param == "m_city" || param == "c")
               {
                  return this.m_city;
               }
               if(param == "null")
               {
                  return null;
               }
               if(param == "is_building")
               {
                  output = this.m_city.cityManager._getCurrentConstruction() != null;
               }
               else if(param == "is_researching")
               {
                  output = this.m_city.cityManager.getResearchInProgress() != null;
               }
               else if(param == "true")
               {
                  output = true;
               }
               else if(param == "false")
               {
                  output = false;
               }
               else if(String(int(param)) == param)
               {
                  output = int(param);
               }
               else
               {
                  output = param;
               }
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
               while(j < splitParam.length)
               {
                  name = splitParam[j];
                  if(tempObject is Connection)
                  {
                     return null;
                  }
                  if(name.charAt(0) == "_")
                  {
                     return null;
                  }
                  if(name.indexOf("(") > 0)
                  {
                     matching = this.getIndexForMatchingCloseBracket(name,name.indexOf("("),"(",")");
                     if(matching == -1)
                     {
                        this.logError("Unmatched () in " + name);
                        return BADOBJECT;
                     }
                     functionName = name.substring(0,name.indexOf("("));
                     functionParamString = name.substring(name.indexOf("(") + 1,matching);
                     functionParamArr = this._jp178(functionParamString);
                     if(functionParamArr == null)
                     {
                        return BADOBJECT;
                     }
                     k = 0;
                     while(k < functionParamArr.length)
                     {
                        functionParamArr[k] = this.getValue(functionParamArr[k]);
                        if(functionParamArr[k] == BADOBJECT)
                        {
                           return BADOBJECT;
                        }
                        k++;
                     }
                     if(Version.isTraceOn())
                     {
                        trace(functionName + "(" + functionParamArr.join(",") + ")");
                     }
                     try
                     {
                        func = tempObject[functionName] as Function;
                        xml = describeType(func);
                        tempObject = func.apply(tempObject,functionParamArr);
                     }
                     catch(exc:Error)
                     {
                        this.logError("Invalid Reference " + param + " at: " + getQualifiedClassName(tempObject) + "." + functionName + "(" + functionParamArr.join(",") + ")");
                        return BADOBJECT;
                     }
                  }
                  else if(name.indexOf("[") > 0)
                  {
                     arrayName = name.substring(0,name.indexOf("["));
                     arrayIndexString = name.substring(name.indexOf("[") + 1,name.indexOf("]"));
                     arrayIndex = this.getValue(arrayIndexString);
                     if(arrayIndex == BADOBJECT)
                     {
                        return BADOBJECT;
                     }
                     arrayParam = int(arrayIndex);
                     if(Version.isTraceOn())
                     {
                        trace(arrayName + "[" + arrayParam + "]");
                     }
                     try
                     {
                        tempObject = tempObject[arrayName][arrayParam];
                     }
                     catch(exc:Error)
                     {
                        this.logError("Invalid Reference " + param + " at: " + getQualifiedClassName(tempObject) + "." + arrayName + "[" + arrayParam + "]");
                        return BADOBJECT;
                     }
                  }
                  else
                  {
                     try
                     {
                        tempObject = tempObject[name];
                     }
                     catch(exc:Error)
                     {
                        this.logError("Invalid Reference " + param + " at: " + getQualifiedClassName(tempObject) + "." + name);
                        return BADOBJECT;
                     }
                  }
                  j++;
               }
               output = tempObject;
            }
         }
         return output;
      }
      
      public function setCallback(param1:FunctionDef) : Function
      {
         var _loc2_:String = Utils.trim(" " + param1.name + " ");
         if(this.m_dynamicCallBackLibrary[_loc2_] != undefined)
         {
            this.logError("Runtime/paramter error in setCallback(): Attempted to overwrite existing callback function: " + _loc2_ + ", try using getCallback(), deleteCallback(), or a different name  Notice: returning existing reference for " + _loc2_ + " instead");
            return (this.m_dynamicCallBackLibrary[_loc2_] as DevalCallbackContainer).callback as Function;
         }
         this.m_dynamicCallBackLibrary["" + _loc2_] = new DevalCallbackContainer("" + _loc2_,this.m_ECMAScriptLibrary,this.m_dynamicImportLibrary,this);
         return (this.m_dynamicCallBackLibrary["" + _loc2_] as DevalCallbackContainer).callback as Function;
      }
      
      private function subVarValues(param1:String, param2:Object) : String
      {
         param1 = this.checkForAndHandleSystemVariables(param1,param2);
         if(param1 == null)
         {
            return null;
         }
         param1 = this.checkForAndHandleUserVariables(param1,param2);
         if(param1 == null)
         {
            return null;
         }
         param1 = this.checkForAndHandleEvalStatements(param1);
         if(param1 == null)
         {
            return null;
         }
         return param1;
      }
      
      private function _jp178(param1:String) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = new Array();
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc2_ = int(param1.indexOf(",",_loc6_));
            if(_loc2_ == -1)
            {
               break;
            }
            _loc3_ = int(param1.indexOf("(",_loc6_));
            while(_loc3_ != -1 && _loc3_ < _loc2_)
            {
               _loc4_ = this.getIndexForMatchingCloseBracket(param1,_loc3_,"(",")");
               if(_loc4_ == -1)
               {
                  this.logMsg("Unmatched () in " + param1);
                  return null;
               }
               _loc2_ = int(param1.indexOf(",",_loc4_));
               if(_loc2_ == -1)
               {
                  break;
               }
               _loc3_ = int(param1.indexOf("(",_loc4_));
            }
            if(_loc2_ == -1)
            {
               break;
            }
            _loc5_.push(param1.substring(_loc6_,_loc2_));
            _loc6_ = _loc2_ + 1;
         }
         if(_loc6_ != param1.length)
         {
            _loc5_.push(param1.substring(_loc6_));
         }
         return _loc5_;
      }
      
      private function downloadUrl(param1:String, param2:Boolean, param3:Function) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Base64Encoder = null;
         if(param2)
         {
            if(param1.substr(0,7) != "http://" && param1.substr(0,8) != "https://")
            {
               throw new ArgumentError("URL " + param1 + " is not in proper format, it needs to start with  http://  or  https://");
            }
         }
         var _loc4_:String = null;
         var _loc5_:String = null;
         this.snippetDownloader.method = "GET";
         if(param2)
         {
            _loc4_ = param1.substr(0,7);
            if(_loc4_ != "http://")
            {
               _loc4_ = "https://";
            }
            _loc5_ = param1.substr(_loc4_.length);
            _loc6_ = null;
            _loc7_ = int(_loc5_.indexOf("@"));
            if(_loc7_ != -1)
            {
               _loc6_ = _loc5_.substr(0,_loc7_);
               _loc5_ = _loc5_.substr(_loc7_ + 1);
               _loc8_ = new Base64Encoder();
               _loc8_.insertNewLines = false;
               _loc8_.encode(_loc6_);
               _loc6_ = _loc8_.toString();
            }
            this.snippetDownloader.url = _loc4_ + _loc5_;
            if(_loc6_ != null)
            {
               this.snippetDownloader.method = "POST";
               this.snippetDownloader.headers = {"Authorization":"Basic " + _loc6_};
            }
         }
         else
         {
            this.snippetDownloader.url = param1;
         }
         this.currentSnippetDownloadUrl = this.snippetDownloader.url;
         this.snippetDownloaderCallback = param3;
         this.snippetDownloader.send();
      }
      
      private function processDownloadedData(param1:ResultEvent) : void
      {
         this.snippetDownloaderCallback.apply(this,new Array(param1.result));
      }
      
      private function onPreProcessingError(param1:Error) : void
      {
         MainScreen.getInstance()._cityPanel.setScriptState(this.m_city.castleId,false);
         this.logMsg(param1.message.split("<").join("&lt;").split(">").join("&gt;"),"#DD0000");
      }
      
      private function doEval(param1:Object) : Object
      {
         if(!param1.hasOwnProperty("op"))
         {
            if(param1 is String)
            {
               return param1;
            }
            this.logError("Internal evaluation error");
            return BADOBJECT;
         }
         if(param1.oper1 != undefined && Boolean(param1.oper1.hasOwnProperty("op")))
         {
            param1.oper1 = this.doEval(param1.oper1);
         }
         if(param1.oper2 != undefined && Boolean(param1.oper2.hasOwnProperty("op")))
         {
            param1.oper2 = this.doEval(param1.oper2);
         }
         if(param1.oper1 == BADOBJECT || param1.oper2 == BADOBJECT)
         {
            return BADOBJECT;
         }
         var _loc2_:String = param1.op;
         if(_loc2_ == "!")
         {
            if(param1.oper1 is Boolean)
            {
               return !param1.oper1;
            }
            if(param1.oper1 is String)
            {
               if(param1.oper1 == "true")
               {
                  return false;
               }
               if(param1.oper1 == "false")
               {
                  return true;
               }
            }
            this.logError("Evaluation error: operator ! used on non-boolean");
            return BADOBJECT;
         }
         if(new Array("^","*","/","\\","|","+","-",">=","<=",">","<").indexOf(_loc2_) != -1)
         {
            if(param1.oper1 is String && Utils.hasValue(param1.oper1))
            {
               param1.oper1 = Number(param1.oper1);
            }
            if(param1.oper2 is String && Utils.hasValue(param1.oper2))
            {
               param1.oper2 = Number(param1.oper2);
            }
            if((param1.oper1 is Number || param1.oper1 is int) && (param1.oper2 is Number || param1.oper2 is int))
            {
               if(_loc2_ == "+")
               {
                  return param1.oper1 + param1.oper2;
               }
               if(_loc2_ == "-")
               {
                  return param1.oper1 - param1.oper2;
               }
               if(_loc2_ == "*")
               {
                  return param1.oper1 * param1.oper2;
               }
               if(_loc2_ == "/")
               {
                  return param1.oper1 / param1.oper2;
               }
               if(_loc2_ == "\\")
               {
                  return Math.floor(param1.oper1 / param1.oper2);
               }
               if(_loc2_ == "|")
               {
                  return param1.oper1 % param1.oper2;
               }
               if(_loc2_ == "^")
               {
                  return Math.pow(param1.oper1,param1.oper2);
               }
               if(_loc2_ == ">")
               {
                  return param1.oper1 > param1.oper2;
               }
               if(_loc2_ == "<")
               {
                  return param1.oper1 < param1.oper2;
               }
               if(_loc2_ == ">=")
               {
                  return param1.oper1 >= param1.oper2;
               }
               if(_loc2_ == "<=")
               {
                  return param1.oper1 <= param1.oper2;
               }
               return BADOBJECT;
            }
            if(param1.oper1 is String && param1.oper2 is String)
            {
               return "" + param1.oper1 + _loc2_ + param1.oper2;
            }
            this.logError("Evaluation error, operator " + _loc2_ + " on non-number " + param1.oper1 + " and " + param1.oper2);
            return BADOBJECT;
         }
         if(new Array("&&","||").indexOf(_loc2_) != -1)
         {
            if(param1.oper1 is String)
            {
               if(param1.oper1 == "true")
               {
                  param1.oper1 = true;
               }
               else if(param1.oper1 == "false")
               {
                  param1.oper1 = false;
               }
            }
            if(param1.oper2 is String)
            {
               if(param1.oper2 == "true")
               {
                  param1.oper2 = true;
               }
               else if(param1.oper2 == "false")
               {
                  param1.oper2 = false;
               }
            }
            if(param1.oper1 is Boolean && param1.oper2 is Boolean)
            {
               if(_loc2_ == "&&")
               {
                  return param1.oper1 && param1.oper2;
               }
               if(_loc2_ == "||")
               {
                  return param1.oper1 || param1.oper2;
               }
               return BADOBJECT;
            }
            this.logError("Evaluation error, operator " + _loc2_ + " on non-boolean " + param1.oper1 + " and " + param1.oper2);
            return BADOBJECT;
         }
         if(_loc2_ == "==")
         {
            return param1.oper1 == param1.oper2;
         }
         if(_loc2_ == "!=")
         {
            return param1.oper1 != param1.oper2;
         }
         this.logError("Evaluation error, invalid operator " + _loc2_);
         return BADOBJECT;
      }
      
      private function sleep(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:Date = null;
         var _loc4_:int = 0;
         if(param1.indexOf(":") > 0)
         {
            if(param1.toString().substr(0,1) != "@")
            {
               if(param1.toString().substr(0,3) != "rnd")
               {
                  _loc4_ = this.m_city.parseTime(param1.toString());
               }
               else
               {
                  _loc4_ = this.m_city.randomTime(param1.toString().replace("rnd:",""));
               }
            }
            else
            {
               _loc4_ = this.m_city.parseTime(param1.toString().replace("@:",""),true);
               if(!param2 && _loc4_ > 12 * 3600)
               {
                  this.logError("Sleeping too long for " + param1 + ", skipping sleep.  Use \'sleep " + param1 + " true\' instead!");
                  this.notifyCmdFinish(true);
                  return;
               }
            }
         }
         else
         {
            _loc4_ = int(param1);
         }
         _loc4_ *= 1000;
         if(_loc4_ >= 5 * 60 * 1000 || !this.silence)
         {
            this.logMsg("Sleeping for " + _loc4_ / 1000 + " seconds until " + Utils.getLogTimeStr(Utils.getServerTime() + _loc4_));
         }
         this.m_scriptTimer.stop();
         this.m_sleeping = true;
         this.m_sleepTimer = new Timer(_loc4_,1);
         this.m_sleepTimer.addEventListener(TimerEvent.TIMER,this.clearSleepTimer);
         this.m_sleepTimer.start();
      }
      
      private function clearSleepTimer(param1:TimerEvent = null, param2:Boolean = false) : void
      {
         this.m_sleepTimer.stop();
         if(!param2)
         {
            this.m_sleeping = false;
            this.m_scriptTimer.start();
            this.notifyCmdFinish(true);
         }
         this.m_sleepTimer.removeEventListener(TimerEvent.TIMER,this.clearSleepTimer);
         this.m_sleepTimer = null;
      }
      
      private function setSilence(param1:Boolean = true) : void
      {
         this.silence = param1;
         this.notifyCmdFinish(true);
      }
      
      public function cmdSet(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         param2 = this.subVarValues(param2,this.m_scriptVars);
         if(param2 == null)
         {
            this.notifyCmdFinish(false,new ScriptError("Bad variable evaluation",-9999));
            return;
         }
         _loc3_ = int(param1.indexOf("["));
         if(_loc3_ != -1 && param1.indexOf("]") == param1.length - 1 && Utils.hasValue(param1.substring(_loc3_ + 1,param1.length - 1)))
         {
            _loc4_ = param1.substring(0,param1.indexOf("["));
            if(!this.isValidVarName(_loc4_))
            {
               return;
            }
            if(this.m_scriptVars[_loc4_] != undefined && !(this.m_scriptVars[_loc4_] is Array))
            {
               this.notifyCmdFinish(false,new ScriptError("Error in parameters for set command: Attempting to assign value of type Array to an already defined variable \"" + _loc4_ + "\" of incompatible type",-9999));
               return;
            }
            _loc5_ = int(param1.substring(_loc3_ + 1,param1.length - 1));
            if(this.m_scriptVars[_loc4_] == undefined)
            {
               this.m_scriptVars[_loc4_] = new Array(_loc5_ + 1);
               this.m_scriptVars[_loc4_][_loc5_] = param2;
               if(!this.silence)
               {
                  this.logMsg("Created new Array \'" + _loc4_ + "\' and set variable \'" + param1 + "\' to:  \"" + this.m_scriptVars[_loc4_][_loc5_] + "\"");
               }
            }
            else
            {
               this.m_scriptVars[_loc4_][_loc5_] = param2;
               if(!this.silence)
               {
                  this.logMsg("Set variable \'" + param1 + "\' to:  \"" + this.m_scriptVars[_loc4_][_loc5_] + "\"");
               }
            }
         }
         else if(param1.substr(-7) == ".length")
         {
            param1 = param1.substr(0,param1.length - 7);
            if(this.m_scriptVars[param1] != undefined && !(this.m_scriptVars[param1] is Array))
            {
               this.notifyCmdFinish(false,new ScriptError("Error in parameters for set command: Attempting to assign value of type Array to an already defined variable \"" + _loc4_ + "\" of incompatible type",-9999));
               return;
            }
            if(this.m_scriptVars[param1] == undefined)
            {
               if(int(param2) > 0)
               {
                  this.m_scriptVars[param1] = new Array(int(param2));
               }
               if(int(param2) == 0)
               {
                  this.m_scriptVars[param1] = new Array();
               }
               if(int(param2) < 0)
               {
                  this.notifyCmdFinish(false,new ScriptError("Error in parameters for set command: Attempting to assign a negative value " + int(param2) + " to Array " + param1,-9999));
                  return;
               }
               if(!this.silence)
               {
                  this.logMsg("Created new Array \'" + param1 + "\' with length " + int(param2));
               }
            }
            else
            {
               if(int(param2) > 0)
               {
                  this.m_scriptVars[param1].length = int(param2);
               }
               if(int(param2) == 0)
               {
                  this.m_scriptVars[param1] = new Array();
               }
               if(int(param2) < 0)
               {
                  this.notifyCmdFinish(false,new ScriptError("Error in parameters for set command: Attempting to assign a negative value " + int(param2) + " to Array " + param1,-9999));
                  return;
               }
               if(!this.silence)
               {
                  this.logMsg("Set length of Array \'" + param1 + "\' to:  \"" + this.m_scriptVars[param1] + "\"");
               }
            }
         }
         else
         {
            if(!this.isValidVarName(param1))
            {
               return;
            }
            if(this.m_scriptVars[param1] != undefined && this.m_scriptVars[param1] is Array)
            {
               this.notifyCmdFinish(false,new ScriptError("Error in parameters for set command: Attempting to assign value of incompatible type to an already defined variable \"" + param1 + "\" of type Array",-9999));
               return;
            }
            this.m_scriptVars[param1] = param2;
            if(!this.silence)
            {
               this.logMsg("Set variable \'" + param1 + "\' to:  \"" + this.m_scriptVars[param1] + "\"");
            }
         }
         this.notifyCmdFinish(true);
      }
      
      private function getIndexForMatchingCloseBracket(param1:String, param2:int, param3:String = "{", param4:String = "}") : int
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 1;
         while(_loc7_ != 0)
         {
            _loc5_ = int(param1.indexOf(param3,param2 + 1));
            _loc6_ = int(param1.indexOf(param4,param2 + 1));
            if(_loc6_ == -1)
            {
               return -1;
            }
            if(_loc5_ != -1)
            {
               if(_loc5_ < _loc6_)
               {
                  _loc7_++;
                  param2 = _loc5_;
               }
               else
               {
                  _loc7_--;
                  param2 = _loc6_;
               }
            }
            else
            {
               _loc7_--;
               param2 = _loc6_;
            }
         }
         return param2;
      }
      
      public function _dl254() : int
      {
         return this.m_curCmdIndex;
      }
      
      private function _ao680(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            if(_loc2_.charAt(0) == "_")
            {
               this.m_scriptVars[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      private function setScriptCmds() : void
      {
         this.scriptCmds = new Object();
         this.scriptCmds["set"] = new ScriptCmd("set",this.cmdSet,new Array("var","value"),new Array("String","String"),2);
         this.scriptCmds["label"] = new ScriptCmd("label",this.label,new Array("label"),new Array("String"),1);
         this.scriptCmds["if"] = new ScriptCmd("if",this.cmdIf,new Array("condition","command","arguments"),new Array("Boolean","String","*"),2);
         this.scriptCmds["goto"] = new ScriptCmd("goto",this.goto,new Array("label"),new Array("String"),1);
         this.scriptCmds["setarray"] = new ScriptCmd("setarray",this.setArray,new Array("var","values"),new Array("String","*"),2);
         this.scriptCmds["setarr"] = new ScriptCmd("setarr",this.setArr,new Array("var","values"),new Array("String","String"),2);
         this.scriptCmds["gosub"] = new ScriptCmd("gosub",this.goSub,new Array("label","_1","_2","_3","_4","_5","_6","_7","_8","_9","_10"),new Array("String","String","String","String","String","String","String","String","String","String","String"),1);
         this.scriptCmds["gosubreturn"] = new ScriptCmd("gosubreturn",this.goSubReturn,new Array("value"),new Array("String"),0);
         this.scriptCmds["iferror"] = new ScriptCmd("iferror",this.ifError,new Array("expression","command","arguments"),new Array("String","String","*"),2);
         this.scriptCmds["loop"] = new ScriptCmd("loop",this.loop,new Array("count","label"),new Array("int","String"),0);
         this.scriptCmds["repeat"] = new ScriptCmd("repeat",this.repeat,new Array("count"),new Array("int"),1);
         this.scriptCmds["ifgoto"] = new ScriptCmd("ifgoto",this.ifGoto,new Array("(","value1","compareOp","value2",")","label"),new Array("String","String","String","String","String","String"),6);
         this.scriptCmds["ifgosub"] = new ScriptCmd("ifgosub",this.ifGoSub,new Array("(","value1","compareOp","value2",")","label"),new Array("String","String","String","String","String","String"),6);
         this.scriptCmds["print"] = new ScriptCmd("print",this.print,new Array("exp1","exp2","exp3","exp4","exp5","exp6"),new Array("String","String","String","String","String","String"),1);
         this.scriptCmds["echo"] = new ScriptCmd("echo",this.echo,new Array("exp1","exp2","exp3","exp4","exp5","exp6"),new Array("String","String","String","String","String","String"),1);
         this.scriptCmds["getindexof"] = new ScriptCmd("getindexof",this.getIndexOf,new Array("iVar","arrayName","searchValue"),new Array("String","String","String"),3);
         this.scriptCmds["split"] = new ScriptCmd("split",this.split,new Array("var","delimiter","stringToSplit"),new Array("String","String","String"),3);
         this.scriptCmds["join"] = new ScriptCmd("join",this.join,new Array("var","arrayName","separator"),new Array("String","String","String"),2);
         this.scriptCmds["addtoarray"] = new ScriptCmd("addtoarray",this.addToArray,new Array("arrayName","index","value"),new Array("String","String","String"),3);
         this.scriptCmds["delete"] = new ScriptCmd("delete",this.cmdDelete,new Array("varName"),new Array("String"),1);
         this.scriptCmds["sleep"] = new ScriptCmd("sleep",this.sleep,new Array("timeStr","allowLongSleep"),new Array("String","Boolean"),1);
         this.scriptCmds["setsilence"] = new ScriptCmd("setsilence",this.setSilence,new Array("silenceFlag"),new Array("Boolean"),0);
         this.scriptCmds["listcommands"] = new ScriptCmd("listcommands",this.listCommands,new Array("filter"),new Array("String"),0);
         this.scriptCmds["info"] = new ScriptCmd("info",this.info,new Array("command"),new Array("String"),1);
         this.scriptCmds["logout"] = new ScriptCmd("logout",this.logout,new Array("timeOut","timeIn"),new Array("String","String"),1);
      }
      
      private function checkForAndHandleSystemVariables(param1:String, param2:Object) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = "";
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         while(true)
         {
            _loc3_ = int(param1.indexOf("$",_loc9_));
            if(_loc3_ == -1)
            {
               break;
            }
            _loc4_ = int(param1.indexOf("$",_loc3_ + 1));
            if(_loc4_ == -1)
            {
               this.logError("Unmatched $ in " + param1);
               return null;
            }
            _loc5_ = int(param1.indexOf("{",_loc3_ + 1));
            if(_loc5_ != -1 && _loc5_ < _loc4_)
            {
               _loc4_ = int(param1.indexOf("$",this.getIndexForMatchingCloseBracket(param1,_loc5_)));
               if(_loc4_ == -1)
               {
                  break;
               }
            }
            _loc6_ = param1.substring(_loc3_ + 1,_loc4_);
            _loc6_ = this.checkForAndHandleUserVariables(_loc6_,param2);
            if(_loc6_ == null)
            {
               return null;
            }
            _loc6_ = this.checkForAndHandleEvalStatements(_loc6_);
            if(_loc6_ == null)
            {
               return null;
            }
            _loc8_ = this.getValue(_loc6_);
            if(_loc8_ == BADOBJECT)
            {
               return null;
            }
            if(_loc8_ == null)
            {
               _loc8_ = "null";
            }
            _loc7_ += param1.substring(_loc9_,_loc3_) + _loc8_.toString();
            _loc9_ = _loc4_ + 1;
         }
         return _loc7_ + param1.substr(_loc9_);
      }
      
      private function ifError(param1:String, param2:String, param3:Array) : void
      {
         var cmd:ScriptCmd;
         var value:String = param1;
         var funcName:String = param2;
         var arr:Array = param3;
         var param:String = null;
         this.suppressError = true;
         try
         {
            param = this.subVarValues(value,this.m_scriptVars);
         }
         catch(error:Error)
         {
         }
         this.suppressError = false;
         if(param != null)
         {
            this.notifyCmdFinish(true);
            return;
         }
         if(arr.length == 0)
         {
            this.logMsg("Depricated: please use \'iferror expression goto label\' instead of \'iferror expression label","#FF8888");
            arr.push(funcName);
            funcName = "goto";
         }
         cmd = null;
         if((cmd = this.getScriptCmd(funcName)) == null)
         {
            cmd = this.m_city._getScriptCmd(funcName);
         }
         if(cmd == null)
         {
            throw new ArgumentError("Invalid command " + funcName + " from within if command");
         }
         if(cmd.hasInvalidArgs(arr))
         {
            throw new ArgumentError("Invalid param at run time " + cmd.cmdName + " " + arr.join(" ") + " from within if command");
         }
         cmd.func.apply(this.m_city,cmd.paramsToArray(arr));
      }
      
      private function runCurrentCmd() : void
      {
         var handler:Function = null;
         var cmdTimer:Timer = null;
         handler = function(param1:TimerEvent):void
         {
            var conn:Connection;
            var cmd:ScriptCommand = null;
            var cmdName:String = null;
            var lastQueueSize:int = 0;
            var sParts:Array = null;
            var event:TimerEvent = param1;
            cmdTimer.delay = 3000;
            if(m_sleeping)
            {
               return;
            }
            if(m_stopped)
            {
               cmdTimer.stop();
               cmdTimer.removeEventListener("timer",handler);
               cmdTimer = null;
               return;
            }
            conn = Connection.getInstance();
            if(!conn.paused && conn.authenticated)
            {
               cmdTimer.stop();
               cmdTimer.removeEventListener("timer",handler);
               cmdTimer = null;
               cmd = getCurrentCommand();
               cmdName = cmd.scriptCmd.cmdName.toLowerCase();
               if(!silence && cmdName != "setsilence")
               {
                  logMsg("Running line " + (m_curCmdIndex + 1) + ": " + cmdName + " " + cmd.params.join(" ").substring(0,50) + "...");
               }
               try
               {
                  lastQueueSize = conn.getSendQueueLength();
                  sParts = cmdName != "iferror" ? substitute(cmd.params,m_scriptVars,cmdName == "if") : cmd.params;
                  if(sParts == null)
                  {
                     throw new ArgumentError("Parameter substitution problem in " + cmd.params.join(" "));
                  }
                  if(cmd.scriptCmd.hasInvalidArgs(sParts))
                  {
                     throw new ArgumentError("Invalid param at run time " + cmdName + " " + sParts.join(" "));
                  }
                  if(cmdName == "set" && cmd.params.length > 1 && sParts[1] == "null" && conn.getSendQueueLength() == lastQueueSize + 1)
                  {
                     createActionResponseListener(conn.getLastCmdInSendQueue(),cmd.params[0]);
                     sParts[1] = "m_city.actionResponse." + sParts[0];
                  }
                  cmd.scriptCmd.func.apply(m_city,cmd.scriptCmd.paramsToArray(sParts));
               }
               catch(argError:ArgumentError)
               {
                  notifyCmdFinish(false,new ScriptError("Problem with parameters in " + cmdName + " command: " + argError.message,-9999));
               }
               catch(err:Error)
               {
                  notifyCmdFinish(false,new ScriptError(err.message,err.errorID));
               }
               ++m_curCmdIndex;
               dispatchEvent(new Event(NEWLINE));
            }
         };
         cmdTimer = new Timer(0);
         cmdTimer.addEventListener("timer",handler);
         cmdTimer.start();
      }
      
      private function handleCityCompleteEvent(param1:CityStateCompleteEvent) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:ScriptError = null;
         if(param1.response is CommandResponse)
         {
            if(param1.response.ok != 1)
            {
               _loc2_ = false;
               _loc3_ = new ScriptError(param1.response.errorMsg,param1.response.ok);
            }
         }
         else if(param1.response is ScriptError)
         {
            _loc2_ = false;
            _loc3_ = param1.response as ScriptError;
         }
         else if(typeof param1.response == "boolean")
         {
            _loc2_ = Boolean(param1.response);
         }
         else
         {
            _loc2_ = false;
            _loc3_ = new ScriptError("\'Command Failed\' response received",-9999);
         }
         this.notifyCmdFinish(_loc2_,_loc3_);
      }
      
      private function startExecUserScript(param1:int = 0) : void
      {
         if(this.m_running)
         {
            return;
         }
         if(param1 <= this.m_script.length && param1 > 0)
         {
            this.m_curCmdIndex = param1 - 1;
         }
         this.m_stopped = false;
         this.m_stack = new Array();
         this.m_subparams = new Array();
         Env.INFINITE_LOOP_LIMIT = 1000000;
         this.m_scriptTimer.start();
      }
      
      public function getVar(param1:String) : *
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.m_scriptVars[param1] == undefined)
         {
            _loc2_ = int(param1.indexOf("["));
            if(_loc2_ != -1 && param1.indexOf("]") == param1.length - 1 && Utils.hasValue(param1.substring(_loc2_ + 1,param1.length - 1)))
            {
               _loc3_ = param1.substring(0,param1.indexOf("["));
               if(this.m_scriptVars[_loc3_] == undefined)
               {
                  return null;
               }
               return this.m_scriptVars[_loc3_][int(param1.substring(_loc2_ + 1,param1.length - 1))];
            }
            if(param1.substr(-7) == ".length")
            {
               param1 = param1.substr(0,param1.length - 7);
               if(this.m_scriptVars[param1].length == undefined)
               {
                  return null;
               }
               return this.m_scriptVars[param1].length;
            }
         }
         return this.m_scriptVars[param1];
      }
      
      private function label(param1:String) : void
      {
         this.m_labelPos[param1] = this.m_curCmdIndex;
         if(!this.silence)
         {
            this.logMsg("Setting label \'" + param1 + "\' on line " + (this.m_curCmdIndex + 1));
         }
         this.notifyCmdFinish(true);
      }
      
      private function doLogout() : void
      {
         var _loc1_:Connection = Connection.getInstance();
         _loc1_.reconnectTimer.stop();
         _loc1_.disconnect();
         this.logMsg("Logout - Disconnected");
         _loc1_.paused = true;
      }
      
      private function cmdIf(param1:Boolean, param2:String, param3:Array) : void
      {
         if(!param1)
         {
            this.notifyCmdFinish(true);
            return;
         }
         var _loc4_:ScriptCmd = this.getScriptCmd(param2);
         if(_loc4_ == null)
         {
            _loc4_ = this.m_city._getScriptCmd(param2);
         }
         if(_loc4_ == null)
         {
            throw new ArgumentError("Invalid command " + param2 + " from within if command");
         }
         param3 = this.substitute(param3,this.m_scriptVars);
         if(param3 == null)
         {
            throw new ArgumentError("Parameter substitution problem in " + this.getCurrentCommand().params.join(" "));
         }
         if(_loc4_.hasInvalidArgs(param3))
         {
            throw new ArgumentError("Invalid param at run time " + _loc4_.cmdName + " " + param3.join(" ") + " from within if command");
         }
         _loc4_.func.apply(this.m_city,_loc4_.paramsToArray(param3));
      }
      
      private function _set_m_script(param1:String) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Deobfuscate code" option in Settings
          * Error type: ClassCastException (class com.jpexs.decompiler.graph.model.CommaExpressionItem cannot be cast to class com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item (com.jpexs.decompiler.graph.model.CommaExpressionItem and com.jpexs.decompiler.flash.abc.avm2.model.NewFunctionAVM2Item are in unnamed module of loader 'app'))
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function getValidatedParams(param1:String) : Array
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = new Array();
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            if(param1.charAt(_loc7_) == ".")
            {
               this.logError("Unexpected . in " + param1 + " at position " + _loc7_);
               return null;
            }
            _loc2_ = int(param1.indexOf(".",_loc7_));
            _loc3_ = int(param1.indexOf("[",_loc7_));
            _loc4_ = int(param1.indexOf("(",_loc7_));
            if(_loc3_ != -1 && _loc4_ != -1)
            {
               if(_loc3_ < _loc4_)
               {
                  _loc4_ = -1;
               }
               else
               {
                  _loc3_ = -1;
               }
            }
            if(_loc2_ != -1)
            {
               if(_loc3_ != -1 && _loc3_ < _loc2_)
               {
                  _loc5_ = this.getIndexForMatchingCloseBracket(param1,_loc3_,"[","]");
                  if(_loc3_ == _loc7_)
                  {
                     this.logError("Expect [ in " + param1 + " at position " + _loc7_);
                     return null;
                  }
                  if(_loc5_ == -1)
                  {
                     this.logError("Unmatch [ in " + param1 + " at position " + _loc3_);
                     return null;
                  }
                  if(_loc5_ < param1.length - 1 && param1.charAt(_loc5_ + 1) != ".")
                  {
                     this.logError("Expect . after ] in " + param1 + " at position " + _loc5_);
                     return null;
                  }
                  _loc2_ = _loc5_ < param1.length - 1 ? _loc5_ + 1 : -1;
               }
               else if(_loc4_ != -1 && _loc4_ < _loc2_)
               {
                  if(_loc4_ == _loc7_)
                  {
                     this.logError("Expect ( in " + param1 + " at position " + _loc7_);
                     return null;
                  }
                  _loc8_ = this.getIndexForMatchingCloseBracket(param1,_loc4_,"(",")");
                  if(_loc8_ == -1)
                  {
                     this.logError("Unmatch ( in " + param1 + " at position " + _loc4_);
                     return null;
                  }
                  if(_loc8_ < param1.length - 1 && param1.charAt(_loc8_ + 1) != ".")
                  {
                     this.logError("Expect . after ) in " + param1 + " at position " + _loc8_);
                     return null;
                  }
                  _loc2_ = _loc8_ < param1.length - 1 ? _loc8_ + 1 : -1;
               }
            }
            if(_loc2_ == -1)
            {
               break;
            }
            _loc6_.push(param1.substring(_loc7_,_loc2_));
            _loc7_ = _loc2_ + 1;
         }
         if(_loc7_ < param1.length)
         {
            _loc6_.push(param1.substring(_loc7_));
         }
         return _loc6_;
      }
   }
}

