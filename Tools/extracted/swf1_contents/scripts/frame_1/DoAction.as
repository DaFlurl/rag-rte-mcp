function MovieClip()
{
}
function XMLSocket()
{
   if(getSWFVersion() >= 10)
   {
      this.timeout = 20000;
   }
}
function AsBroadcaster()
{
}
function Color(target)
{
   this.target = target;
   ASSetPropFlags(this,null,7);
}
function NetConnection()
{
   this.isConnected = false;
   ASSetPropFlags(this,null,7);
   ASnative(2100,200)(this);
}
function NetStream(connection)
{
   function OnCreate(nStream)
   {
      this.nStream = nStream;
   }
   ASnative(2101,200)(this,connection,0);
   var _loc2_ = OnCreate.prototype;
   _loc2_.onResult = function(streamId)
   {
      ASnative(2101,201)(this.nStream,streamId);
   };
   _loc2_.onStatus = function(info)
   {
      this.nStream.onStatus(info);
   };
   connection.call("createStream",new OnCreate(this));
}
function Camera()
{
}
function Microphone()
{
}
function SharedObject()
{
}
function ContextMenuItem(capt, cb, sepBefore, enab, vis)
{
   this.caption = capt;
   this.onSelect = cb;
   this.separatorBefore = sepBefore != undefined ? sepBefore : false;
   this.enabled = enab != undefined ? enab : true;
   this.visible = vis != undefined ? vis : true;
}
function ContextMenu(cb)
{
   this.onSelect = cb;
   this.builtInItems = {save:true,zoom:true,quality:true,play:true,loop:true,rewind:true,forward_back:true,print:true};
   this.customItems = new Array();
}
function Error(m)
{
   if(typeof m != "undefined")
   {
      this.message = m;
   }
}
function AsSetupError(s)
{
   var _loc6_ = s.split(",");
   var _loc3_ = 0;
   while(_loc3_ < _loc6_.length)
   {
      var _loc4_ = _loc6_[_loc3_];
      var _loc5_ = function(m)
      {
         this.message = m;
      };
      var _loc2_ = new Error();
      _loc5_.prototype = _loc2_;
      _loc2_.name = _loc4_;
      _loc2_.message = _loc4_;
      _loc3_ = _loc3_ + 1;
   }
}
function AssetCache()
{
}
function RemoteLSOUsage()
{
}
ASSetPropFlags = ASnative(1,0);
ASSetNative = ASnative(4,0);
ASSetNativeAccessor = ASnative(4,1);
escape = ASnative(100,0);
unescape = ASnative(100,1);
parseInt = ASnative(100,2);
parseFloat = ASnative(100,3);
trace = ASnative(100,4);
updateAfterEvent = ASnative(9,0);
isNaN = ASnative(200,18);
isFinite = ASnative(200,19);
setInterval = ASnative(250,0);
clearInterval = clearTimeout = ASnative(250,1);
setTimeout = ASnative(250,2);
showRedrawRegions = ASnative(1021,1);
addRequestHeader = function(key, value)
{
   if(typeof _global._customHeaders == "undefined")
   {
      _global._customHeaders = new Array();
   }
   if(typeof key == "string" && typeof value == "string")
   {
      _global._customHeaders.push(key,value);
   }
   else if(key instanceof Array)
   {
      var _loc2_ = 0;
      while(_loc2_ < key.length)
      {
         if(_loc2_ + 1 < key.length)
         {
            addRequestHeader(key[_loc2_],key[_loc2_ + 1]);
         }
         _loc2_ += 2;
      }
   }
};
clearRequestHeaders = function()
{
   _global._customHeaders = undefined;
};
var o = Object.prototype;
ASSetNative(o,101,"6watch,6unwatch,6addProperty,valueOf,toString,6hasOwnProperty,6isPrototypeOf,6isPropertyEnumerable");
o.toLocaleString = function()
{
   return this.toString();
};
Object.registerClass = ASnative(101,8);
ASSetPropFlags(o,null,3);
ASSetPropFlags(Object,null,7);
var o = Function.prototype;
ASSetNative(o,101,"6call,6apply",10);
ASSetPropFlags(o,null,3);
Number = ASconstructor(106,2);
var o = Number.prototype;
ASSetNative(o,106,"valueOf,toString");
ASSetPropFlags(o,null,3);
var o = Number;
o.NaN = NaN;
o.POSITIVE_INFINITY = Infinity;
o.NEGATIVE_INFINITY = - Infinity;
o.MIN_VALUE = 4.9e-324;
o.MAX_VALUE = 1.7976931348623157e+308;
ASSetPropFlags(o,null,7);
Boolean = ASconstructor(107,2);
var o = Boolean.prototype;
ASSetNative(o,107,"valueOf,toString");
ASSetPropFlags(o,null,3);
Date = ASconstructor(103,256);
var o = Date.prototype;
ASSetNative(o,103,"getFullYear,getYear,getMonth,getDate,getDay,getHours,getMinutes,getSeconds,getMilliseconds,setFullYear,setMonth,setDate,setHours,setMinutes,setSeconds,setMilliseconds,getTime,setTime,getTimezoneOffset,toString,setYear");
ASSetNative(o,103,"getUTCFullYear,getUTCYear,getUTCMonth,getUTCDate,getUTCDay,getUTCHours,getUTCMinutes,getUTCSeconds,getUTCMilliseconds,setUTCFullYear,setUTCMonth,setUTCDate,setUTCHours,setUTCMinutes,setUTCSeconds,setUTCMilliseconds",128);
o.valueOf = o.getTime;
Date.UTC = ASnative(103,257);
ASSetPropFlags(o,null,3);
ASSetPropFlags(Date,null,7);
String = ASconstructor(251,0);
var o = String.prototype;
ASSetNative(o,251,"valueOf,toString,toUpperCase,toLowerCase,charAt,charCodeAt,concat,indexOf,lastIndexOf,slice,substring,split,substr",1);
String.fromCharCode = ASnative(251,14);
ASSetPropFlags(o,null,3);
ASSetPropFlags(String,null,3);
Array = ASconstructor(252,0);
var o = Array.prototype;
ASSetNative(o,252,"push,pop,concat,shift,unshift,slice,join,splice,toString,sort,reverse,sortOn",1);
ASSetPropFlags(o,null,3);
var o = Array;
o.CASEINSENSITIVE = 1;
o.DESCENDING = 2;
o.UNIQUESORT = 4;
o.RETURNINDEXEDARRAY = 8;
o.NUMERIC = 16;
Math = {E:2.718281828459045,LN10:2.302585092994046,LN2:0.6931471805599453,LOG10E:0.4342944819032518,LOG2E:1.4426950408889634,PI:3.141592653589793,SQRT1_2:0.7071067811865476,SQRT2:1.4142135623730951};
ASSetNative(Math,200,"abs,min,max,sin,cos,atan2,tan,exp,log,sqrt,round,random,floor,ceil,atan,asin,acos,pow");
ASSetPropFlags(Math,null,7);
Sound = ASconstructor(500,17);
var o = Sound.prototype;
ASSetNative(o,500,"getPan,getTransform,getVolume,setPan,setTransform,setVolume,stop,attachSound,start,6getDuration,6setDuration,6getPosition,6setPosition,6loadSound,6getBytesLoaded,6getBytesTotal,9areSoundsInaccessible");
ASSetPropFlags(o,null,7);
ASSetNativeAccessor(o,500,"checkPolicyFile",18);
ASSetPropFlags(o,"checkPolicyFile",3);
var o = MovieClip.prototype;
o.useHandCursor = true;
o.enabled = true;
ASSetNativeAccessor(o,900,"tabIndex",200);
ASSetNativeAccessor(o,900,"_lockroot",300);
ASSetNativeAccessor(o,900,"8cacheAsBitmap,8opaqueBackground,8scrollRect",401);
ASSetNativeAccessor(o,900,"8filters,8transform",417);
ASSetNativeAccessor(o,900,"8blendMode",500);
ASSetNativeAccessor(o,900,"8forceSmoothing",502);
ASSetNativeAccessor(o,901,"8scale9Grid",12);
o.meth = function(method)
{
   method = method.toLowerCase();
   if(method == "get")
   {
      return 1;
   }
   if(method == "post")
   {
      return 2;
   }
   return 0;
};
o.getURL = function(url, window, method)
{
   if(typeof window == "undefined")
   {
      window = "";
   }
   var _loc3_ = this.meth(method);
   tellTarget(this._target)
   {
      if(_loc3_ == 0)
      {
         getURL(url,window);
      }
      else if(_loc3_ == 1)
      {
         getURL(url,window,"GET");
      }
      else
      {
         getURL(url,window,"POST");
      }
   }
};
o.unloadMovie = function()
{
   unloadMovie(this._target);
};
o.loadVariables = function(url, method)
{
   var _loc3_ = this.meth(method);
   tellTarget(this._target)
   {
      if(_loc3_ == 0)
      {
         loadVariables(url,_target);
      }
      else if(_loc3_ == 1)
      {
         loadVariables(url,_target,"GET");
      }
      else
      {
         loadVariables(url,_target,"POST");
      }
   }
};
o.loadMovie = function(url, method)
{
   var _loc3_ = this.meth(method);
   tellTarget(this._target)
   {
      if(_loc3_ == 0)
      {
         loadMovie(url,_target);
      }
      else if(_loc3_ == 1)
      {
         loadMovie(url,_target,"GET");
      }
      else
      {
         loadMovie(url,_target,"POST");
      }
   }
};
ASSetNative(o,900,"attachMovie,swapDepths,localToGlobal,globalToLocal,hitTest,getBounds,getBytesTotal,getBytesLoaded,6attachAudio,6attachVideo,6getDepth,6setMask,play,stop,nextFrame,prevFrame,gotoAndPlay,gotoAndStop,duplicateMovieClip,removeMovieClip,startDrag,stopDrag,7getNextHighestDepth,7getInstanceAtDepth,getSWFVersion,8attachBitmap,8getRect");
ASSetNative(o,901,"6createEmptyMovieClip,6beginFill,6beginGradientFill,6moveTo,6lineTo,6curveTo,6lineStyle,6endFill,6clear,8lineGradientStyle,8beginMeshFill,8beginBitmapFill");
o.createTextField = ASnative(104,200);
ASSetPropFlags(o,null,3);
XMLNode = ASconstructor(253,0);
var o = XMLNode.prototype;
ASSetNative(o,253,"cloneNode,removeNode,insertBefore,appendChild,hasChildNodes,toString,getNamespaceForPrefix,getPrefixForNamespace",1);
XML = ASconstructor(253,9);
XML.prototype = new XMLNode(1,"");
var o = XML.prototype;
ASSetNative(o,253,"createElement,createTextNode,parseXML",10);
o.load = ASnative(301,0);
o.send = ASnative(301,1);
o.sendAndLoad = ASnative(301,2);
o.onLoad = function()
{
};
o.onData = function(src)
{
   if(src == undefined)
   {
      this.onLoad(false);
   }
   else
   {
      this.parseXML(src);
      this.loaded = true;
      this.onLoad(true);
   }
};
o.getBytesLoaded = function()
{
   return this._bytesLoaded;
};
o.getBytesTotal = function()
{
   return this._bytesTotal;
};
o.addRequestHeader = function(key, value)
{
   if(typeof this._customHeaders == "undefined")
   {
      this._customHeaders = new Array();
      ASSetPropFlags(this,"_customHeaders",131);
   }
   if(typeof key == "string" && typeof value == "string")
   {
      this._customHeaders.push(key,value);
   }
   else if(key instanceof Array)
   {
      var _loc2_ = 0;
      while(_loc2_ < key.length)
      {
         if(_loc2_ + 1 < key.length)
         {
            this.addRequestHeader(key[_loc2_],key[_loc2_ + 1]);
         }
         _loc2_ += 2;
      }
   }
};
LoadVars = ASconstructor(253,13);
var o = LoadVars.prototype;
ASSetNative(o,301,"load,send,sendAndLoad,decode");
o.getBytesLoaded = function()
{
   return this._bytesLoaded;
};
o.getBytesTotal = function()
{
   return this._bytesTotal;
};
o.toString = function()
{
   var _loc2_ = [];
   for(var _loc3_ in this)
   {
      _loc2_.push(escape(_loc3_) + "=" + escape(this[_loc3_]));
   }
   return _loc2_.join("&");
};
o.contentType = "application/x-www-form-urlencoded";
o.onLoad = function()
{
};
o.onData = function(src)
{
   if(src == undefined)
   {
      this.onLoad(false);
   }
   else
   {
      this.decode(src);
      this.loaded = true;
      this.onLoad(true);
   }
};
o.addRequestHeader = function(key, value)
{
   if(typeof this._customHeaders == "undefined")
   {
      this._customHeaders = new Array();
      ASSetPropFlags(this,"_customHeaders",131);
   }
   if(typeof key == "string" && typeof value == "string")
   {
      this._customHeaders.push(key,value);
   }
   else if(key instanceof Array)
   {
      var _loc2_ = 0;
      while(_loc2_ < key.length)
      {
         if(_loc2_ + 1 < key.length)
         {
            this.addRequestHeader(key[_loc2_],key[_loc2_ + 1]);
         }
         _loc2_ += 2;
      }
   }
};
ASSetPropFlags(o,null,131);
var o = XMLSocket.prototype;
ASSetNative(o,400,"connect,send,close");
o.onData = function(src)
{
   this.onXML(new XML(src));
};
o.getTimeout = function()
{
   return this.timeout;
};
o.setTimeout = function(value)
{
   this.timeout = value;
};
ASSetPropFlags(o,null,3);
var o = AsBroadcaster;
o.broadcastMessage = ASnative(101,12);
o.addListener = function(x)
{
   this.removeListener(x);
   this._listeners.push(x);
   return true;
};
o.removeListener = function(x)
{
   var _loc3_ = this._listeners;
   var _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      if(_loc3_[_loc2_] == x)
      {
         _loc3_.splice(_loc2_,1);
         return true;
      }
      _loc2_ = _loc2_ + 1;
   }
   return false;
};
o.initialize = function(o)
{
   o.broadcastMessage = ASnative(101,12);
   o.addListener = AsBroadcaster.addListener;
   o.removeListener = AsBroadcaster.removeListener;
   o._listeners = [];
   ASSetPropFlags(o,"broadcastMessage,addListener,removeListener,_listeners",131);
};
ASSetPropFlags(o,null,131);
Selection = {};
ASSetNative(Selection,600,"getBeginIndex,getEndIndex,getCaretIndex,getFocus,setFocus,setSelection");
AsBroadcaster.initialize(Selection);
ASSetPropFlags(Selection,null,7);
var o = Color.prototype;
ASSetNative(o,700,"setRGB,setTransform,getRGB,getTransform");
ASSetPropFlags(o,null,7);
Mouse = {};
ASSetNative(Mouse,5,"show,hide,setTrailer,setTrailerPosition,setTrailerMode");
AsBroadcaster.initialize(Mouse);
ASSetPropFlags(Mouse,null,7);
Key = {ALT:18,ENTER:13,SPACE:32,UP:38,DOWN:40,LEFT:37,RIGHT:39,PGUP:33,PGDN:34,HOME:36,END:35,TAB:9,CONTROL:17,SHIFT:16,ESCAPE:27,INSERT:45,DELETEKEY:46,BACKSPACE:8,CAPSLOCK:20};
ASSetNative(Key,800,"getAscii,getCode,isDown,isToggled,isAccessible");
AsBroadcaster.initialize(Key);
ASSetPropFlags(Key,null,7);
Button = ASconstructor(105,0);
var o = Button.prototype;
o.useHandCursor = true;
o.enabled = true;
o.getDepth = ASnative(105,3);
ASSetNativeAccessor(o,105,"8scale9Grid,8filters,8cacheAsBitmap,8blendMode",4);
TextField = ASconstructor(104,0);
var o = TextField.prototype;
ASSetNative(o,104,"6replaceSel,6getTextFormat,6setTextFormat,6removeTextField,6getNewTextFormat,6setNewTextFormat,6getDepth,7replaceText",100);
AsBroadcaster.initialize(o);
ASSetPropFlags(o,null,131);
TextField.getFontList = ASnative(104,201);
ASSetPropFlags(TextField,null,131);
ASSetNativeAccessor(o,104,"8gridFitType,8antiAliasType,8thickness,8sharpness,8filters",300);
TextField.StyleSheet = ASconstructor(113,0);
var o = TextField.StyleSheet.prototype;
o._copy = function(o)
{
   if(typeof o != "object")
   {
      return null;
   }
   var _loc2_ = {};
   for(var _loc3_ in o)
   {
      _loc2_[_loc3_] = o[_loc3_];
   }
   return _loc2_;
};
o.getStyle = function(n)
{
   return this._copy(this._css[n]);
};
o.setStyle = function(n, s)
{
   if(!this._css)
   {
      this._css = {};
   }
   var _loc2_ = typeof o;
   if(_loc2_ == "object" || _loc2_ == "null" || _loc2_ == "undefined")
   {
      this._css[n] = this._copy(s);
      this.doTransform(n);
      this.update();
   }
};
o.clear = function()
{
   this._css = {};
   this._styles = {};
   this.update();
};
o.getStyleNames = function()
{
   var _loc2_ = [];
   for(var _loc3_ in this._css)
   {
      _loc2_.push(_loc3_);
   }
   return _loc2_;
};
o.doTransform = function(n)
{
   var _loc2_ = this.transform(this._css[n]);
   if(!this._styles)
   {
      this._styles = {};
   }
   this._styles[n] = _loc2_;
};
o.transform = function(o)
{
   if(o == null)
   {
      return null;
   }
   var _loc2_ = new TextFormat();
   var _loc4_ = o.textAlign;
   if(_loc4_)
   {
      _loc2_.align = _loc4_;
   }
   _loc4_ = o.fontSize;
   if(_loc4_)
   {
      _loc4_ = parseInt(_loc4_);
      if(_loc4_ > 0)
      {
         _loc2_.size = _loc4_;
      }
   }
   _loc4_ = o.textDecoration;
   if(_loc4_ == "none")
   {
      _loc2_.underline = false;
   }
   else if(_loc4_ == "underline")
   {
      _loc2_.underline = true;
   }
   _loc4_ = o.marginLeft;
   if(_loc4_)
   {
      _loc2_.leftMargin = parseInt(_loc4_);
   }
   _loc4_ = o.marginRight;
   if(_loc4_)
   {
      _loc2_.rightMargin = parseInt(_loc4_);
   }
   _loc4_ = o.leading;
   if(_loc4_)
   {
      _loc2_.leading = parseInt(_loc4_);
   }
   _loc4_ = o.kerning;
   if(_loc4_ == "true")
   {
      _loc2_.kerning = 1;
   }
   else if(_loc4_ == "false")
   {
      _loc2_.kerning = 0;
   }
   else
   {
      _loc2_.kerning = parseInt(_loc4_);
   }
   _loc4_ = o.letterSpacing;
   if(_loc4_)
   {
      _loc2_.letterSpacing = parseInt(_loc4_);
   }
   _loc4_ = o.fontFamily;
   if(_loc4_)
   {
      _loc2_.font = this.parseCSSFontFamily(_loc4_);
   }
   _loc2_.display = o.display;
   _loc4_ = o.fontWeight;
   if(_loc4_ == "bold")
   {
      _loc2_.bold = true;
   }
   else if(_loc4_ == "normal")
   {
      _loc2_.bold = false;
   }
   _loc4_ = o.fontStyle;
   if(_loc4_ == "italic")
   {
      _loc2_.italic = true;
   }
   else if(_loc4_ == "normal")
   {
      _loc2_.italic = false;
   }
   _loc4_ = o.textIndent;
   if(_loc4_)
   {
      _loc2_.indent = parseInt(_loc4_);
   }
   _loc4_ = o.color;
   if(_loc4_)
   {
      _loc4_ = this.parseColor(_loc4_);
      if(_loc4_ != null)
      {
         _loc2_.color = _loc4_;
      }
   }
   return _loc2_;
};
o.parseCSS = function(s)
{
   var _loc2_ = this.parseCSSInternal(s);
   if(typeof _loc2_ == "null")
   {
      return false;
   }
   if(!this._css)
   {
      this._css = {};
   }
   for(var _loc3_ in _loc2_)
   {
      this._css[_loc3_] = this._copy(_loc2_[_loc3_]);
      this.doTransform(_loc3_);
   }
   this.update();
   return true;
};
o.parse = o.parseCSS;
o.load = ASnative(301,0);
o.onLoad = function()
{
};
o.onData = function(src)
{
   if(src == undefined)
   {
      this.onLoad(false);
   }
   else
   {
      var _loc2_ = this.parse(src);
      this.loaded = _loc2_;
      this.onLoad(_loc2_);
   }
};
ASSetNative(o,113,"7update,7parseCSSInternal,7parseCSSFontFamily,7parseColor",100);
ASSetPropFlags(o,null,1027);
ASSetPropFlags(TextField,"StyleSheet",1027);
TextFormat = ASconstructor(110,0);
Stage = {width:0,height:0,scaleMode:0,align:""};
ASSetNativeAccessor(Stage,666,"scaleMode,align,width,height,showMenu,displayState",1);
ASSetNativeAccessor(Stage,666,"9fullScreenSourceRect,9fullScreenHeight,9fullScreenWidth,10wmodeGPU",100);
AsBroadcaster.initialize(Stage);
Video = ASconstructor(667,0);
var o = Video.prototype;
ASSetNative(o,667,"6attachVideo,6clear",1);
ASSetPropFlags(o,null,3);
Accessibility = {};
ASSetNative(Accessibility,1999,"6isActive,6sendEvent,6updateProperties");
ASSetPropFlags(Accessibility,null,6);
var o = NetConnection.prototype;
o.proxyType = "none";
o.addProperty("connectedProxyType",ASnative(2100,4),null);
o.addProperty("usingTLS",ASnative(2100,5),null);
o.addProperty("protocol",ASnative(2100,6),null);
ASSetNative(o,2100,"6connect,6close,6call,6addHeader");
o.addProperty("nearNonce",ASnative(2100,9),null);
o.addProperty("farNonce",ASnative(2100,10),null);
ASSetPropFlags(o,null,3);
var o = NetStream.prototype;
o.publish = function(name, type)
{
   var _loc3_ = arguments.length;
   if(_loc3_ == 1)
   {
      ASnative(2101,202)(this,"publish",null,name);
   }
   else
   {
      ASnative(2101,202)(this,"publish",null,name,type);
   }
};
o.play = function(name, start, len, reset)
{
   var _loc3_ = arguments.length;
   if(_loc3_ == 1)
   {
      ASnative(2101,202)(this,"play",null,name);
   }
   else if(_loc3_ == 2)
   {
      ASnative(2101,202)(this,"play",null,name,start * 1000);
   }
   else if(_loc3_ == 3)
   {
      ASnative(2101,202)(this,"play",null,name,start * 1000,len * 1000);
   }
   else
   {
      ASnative(2101,202)(this,"play",null,name,start * 1000,len * 1000,reset);
   }
};
o.play2 = function(argsObject)
{
   ASnative(2101,202)(this,"play2",null,argsObject);
};
o.receiveAudio = function(flag)
{
   ASnative(2101,202)(this,"receiveAudio",null,flag);
};
o.receiveVideo = function(flag)
{
   ASnative(2101,202)(this,"receiveVideo",null,flag);
};
o.pause = function(flag)
{
   ASnative(2101,202)(this,"pause",null,flag,this.time * 1000);
};
o.seek = function(offset)
{
   ASnative(2101,202)(this,"seek",null,offset * 1000);
};
o.onPeerConnect = function(subscriber)
{
   return true;
};
ASSetNative(o,2101,"6close,6attachAudio,6attachVideo,6send,6setBufferTime");
ASSetNative(o,2101,"10getInfo",343);
ASSetNativeAccessor(o,2101,"checkPolicyFile",5);
ASSetNativeAccessor(o,2101,"10maxPauseBufferTime",400);
ASSetNativeAccessor(o,2101,"10backBufferTime",450);
ASSetPropFlags(o,null,3);
Camera["get"] = function(index)
{
   return ASnative(2102,200)(index);
};
Camera.addProperty("names",ASnative(2102,201),null);
var o = Camera.prototype;
ASSetNative(o,2102,"6setMode,6setQuality,6setKeyFrameInterval,6setMotionLevel,6setLoopback,6setCursor");
ASSetPropFlags(o,null,3);
SoundCodec = {NELLYMOSER:"NellyMoser",SPEEX:"Speex"};
Microphone["get"] = function(index)
{
   return ASnative(2104,200)(index);
};
Microphone.addProperty("names",ASnative(2104,201),null);
var o = Microphone.prototype;
ASSetNative(o,2104,"6setSilenceLevel,6setRate,6setGain,6setUseEchoSuppression,10setCodec,10setFramesPerPacket,10setEncodeQuality");
ASSetPropFlags(o,null,3);
SharedObject.getLocal = function(name, localPath, secure)
{
   var _loc1_ = ASnative(2106,202)(name,localPath,secure);
   if(!_loc1_)
   {
      _loc1_ = new SharedObject();
      if(!ASnative(2106,204)(_loc1_,name,localPath,secure))
      {
         return null;
      }
   }
   return _loc1_;
};
SharedObject.getRemote = function(name, remotePath, options, secure)
{
   var _loc1_ = ASnative(2106,203)(name,remotePath,options,secure);
   if(!_loc1_)
   {
      _loc1_ = new SharedObject();
      if(!ASnative(2106,205)(_loc1_,name,remotePath,options,secure))
      {
         return null;
      }
   }
   return _loc1_;
};
SharedObject.deleteAll = function(url)
{
   return ASnative(2106,206)(url);
};
SharedObject.getDiskUsage = function(url)
{
   return ASnative(2106,207)(url);
};
ASSetPropFlags(SharedObject,"deleteAll,getDiskUsage",1);
var o = SharedObject.prototype;
ASSetNative(o,2106,"6connect,6send,6flush,6close,6getSize,6setFps,6clear");
ASSetPropFlags(o,null,3);
System = {};
System.capabilities = {hasAudio:true,hasMP3:true,hasAudio:true,hasMP3:true,hasAudioEncoder:true,hasVideoEncoder:true,hasTLS:false,screenResolutionX:800,screenResolutionY:600,screenDPI:72,screenColor:"color",pixelAspectRatio:1,hasAccessibility:true,Query:ASnative(11,0)};
System.capabilities.Query();
delete System.capabilities.Query;
ASSetNativeAccessor(System.capabilities,11,"_internal",1);
ASSetPropFlags(System.capabilities,"_internal",7);
System.Product = function(strName)
{
   this.name = strName;
   ASSetPropFlags(this,null,7);
};
var o = System.Product.prototype;
o.isRunning = function()
{
   return ASnative(2201,0)(this.name);
};
o.isInstalled = function()
{
   return ASnative(2201,1)(this.name);
};
o.launch = function()
{
   if(arguments.length > 0)
   {
      return ASnative(2201,2)(this.name,arguments[0]);
   }
   return ASnative(2201,2)(this.name);
};
o.download = function()
{
   if(arguments.length > 0)
   {
      if(arguments.length == 1)
      {
         return ASnative(2201,3)(this,this.name,arguments[0]);
      }
      var _loc4_ = "";
      if(arguments[2] instanceof Array)
      {
         var _loc3_ = 0;
         while(_loc3_ < arguments[2].length)
         {
            if(this.validate(arguments[2][_loc3_]) != true)
            {
               return false;
            }
            _loc4_ += arguments[2][_loc3_] + "/";
            _loc3_ = _loc3_ + 1;
         }
      }
      if(this.validate(arguments[1]) == true)
      {
         _loc4_ += arguments[1];
         return ASnative(2201,3)(this,this.name,arguments[0],_loc4_);
      }
      return false;
   }
   return ASnative(2201,3)(this,this.name);
};
o.validate = function(str)
{
   var _loc3_ = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-_";
   var _loc2_ = str.length;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_)
   {
      if(_loc3_.indexOf(str.charAt(_loc1_)) == -1)
      {
         return false;
      }
      _loc1_ = _loc1_ + 1;
   }
   return true;
};
o.installedVersion = function()
{
   return ASnative(2201,4)(this.name);
};
ASSetPropFlags(o,null,3);
System.showSettings = ASnative(2107,0);
ASSetNativeAccessor(System,2107,"exactSettings",1);
ASSetPropFlags(System,"exactSettings",128);
ASSetNativeAccessor(System,2107,"useCodepage",3);
flash = {};
ASSetPropFlags(_global,"flash",4096);
flash.text = {};
flash.text.TextRenderer = ASconstructor(2150,0);
var textRenderer = flash.text.TextRenderer;
ASSetNative(textRenderer,2150,"8setAdvancedAntialiasingTable",1);
ASSetNativeAccessor(textRenderer,2150,"8maxLevel",4);
ASSetNativeAccessor(textRenderer,2150,"8displayMode",10);
var o = new Object();
System.security = o;
ASSetNative(o,12,"allowDomain,7allowInsecureDomain,loadPolicyFile,chooseLocalSwfPath,escapeDomain");
System.security.addProperty("sandboxType",ASnative(12,5),null);
System.security.PolicyFileResolver = function()
{
};
var o = System.security.PolicyFileResolver.prototype;
ASSetNative(o,15,"resolve");
AsBroadcaster.initialize(o);
System.setClipboard = ASnative(1066,0);
System.IME = {ALPHANUMERIC_FULL:"ALPHANUMERIC_FULL",ALPHANUMERIC_HALF:"ALPHANUMERIC_HALF",CHINESE:"CHINESE",JAPANESE_HIRAGANA:"JAPANESE_HIRAGANA",JAPANESE_KATAKANA_FULL:"JAPANESE_KATAKANA_FULL",JAPANESE_KATAKANA_HALF:"JAPANESE_KATAKANA_HALF",KOREAN:"KOREAN",UNKNOWN:"UNKNOWN"};
ASSetNative(System.IME,13,"8getEnabled,8setEnabled,8getConversionMode,8setConversionMode,8setCompositionString,8doConversion");
AsBroadcaster.initialize(System.IME);
ASSetPropFlags(System.IME,null,7);
LocalConnection = ASconstructor(2200,6);
var o = LocalConnection.prototype;
ASSetNative(o,2200,"6connect,6send,6close,6domain");
ASSetNativeAccessor(o,2200,"10isPerUser",4);
ASSetPropFlags(o,null,3);
var o = ContextMenuItem.prototype;
o.copy = function()
{
   var _loc2_ = new ContextMenuItem();
   _loc2_.caption = this.caption;
   _loc2_.onSelect = this.onSelect;
   _loc2_.separatorBefore = this.separatorBefore;
   _loc2_.enabled = this.enabled;
   _loc2_.visible = this.visible;
   return _loc2_;
};
ASSetPropFlags(o,null,1027);
var o = ContextMenu.prototype;
o.copy = function()
{
   var _loc3_ = new ContextMenu();
   _loc3_.onSelect = this.onSelect;
   _loc3_.builtInItems = this.builtInItems;
   _loc3_.customItems = new Array();
   var _loc2_ = 0;
   while(_loc2_ < this.customItems.length)
   {
      _loc3_.customItems.push(this.customItems[_loc2_].copy());
      _loc2_ = _loc2_ + 1;
   }
   return _loc3_;
};
o.hideBuiltInItems = function()
{
   this.builtInItems = {save:false,zoom:false,quality:false,play:false,loop:false,rewind:false,forward_back:false,print:false};
};
ASSetPropFlags(o,null,1027);
var o = Error.prototype;
o.name = o.message = "Error";
o.toString = function()
{
   return this.message;
};
AsSetupError("EvalError,ReferenceError,SyntaxError,TypeError,URIError");
MovieClipLoader = ASconstructor(112,0);
var o = MovieClipLoader.prototype;
ASSetNative(o,112,"7loadClip,7getProgress,7unloadClip",100);
AsBroadcaster.initialize(o);
ASSetPropFlags(o,null,1027);
PrintJob = ASconstructor(111,0);
var o = PrintJob.prototype;
ASSetNative(o,111,"7start,7addPage,7send",100);
ASSetPropFlags(o,null,1027);
TextSnapshot = ASconstructor(1067,0);
MovieClip.prototype.getTextSnapshot = function()
{
   return new TextSnapshot(this);
};
ASSetPropFlags(MovieClip.prototype,"getTextSnapshot",131);
ASSetNative(TextSnapshot.prototype,1067,"6getCount,6setSelected,6getSelected,6getText,6getSelectedText,6hitTestTextNearPos,6findText,6setSelectColor,6getTextRunInfo",1);
flash.display = {};
flash.display.BitmapData = ASconstructor(1100,0);
var o = flash.display.BitmapData;
o.RED_CHANNEL = 1;
o.GREEN_CHANNEL = 2;
o.BLUE_CHANNEL = 4;
o.ALPHA_CHANNEL = 8;
ASSetNative(o,1100,"8loadBitmap",40);
var o = flash.display.BitmapData.prototype;
ASSetNativeAccessor(o,1100,"8width,8height,8rectangle,8transparent",100);
ASSetNative(o,1100,"8getPixel,8setPixel,8fillRect,8copyPixels,8applyFilter,8scroll,8threshold,8draw,8pixelDissolve,8getPixel32,8setPixel32,8floodFill,8getColorBoundsRect,8perlinNoise,8colorTransform,8hitTest,8paletteMap,8merge,8noise,8copyChannel,8clone,8dispose,8generateFilterRect,8compare",1);
flash.filters = {};
var o = flash.filters.BitmapFilter = ASconstructor(1112,0);
ASSetNative(o.prototype,1112,"8clone",1);
flash.filters.DropShadowFilter = ASconstructor(1101,0);
flash.filters.DropShadowFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1101,"8distance,8angle,8color,8alpha,8quality,8inner,8knockout,8blurX,8blurY,8strength,8hideObject",1);
flash.filters.BlurFilter = ASconstructor(1102,0);
flash.filters.BlurFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1102,"8blurX,8blurY,8quality",1);
flash.filters.GlowFilter = ASconstructor(1103,0);
flash.filters.GlowFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1103,"8color,8alpha,8quality,8inner,8knockout,8blurX,8blurY,8strength",1);
flash.filters.BevelFilter = ASconstructor(1107,0);
flash.filters.BevelFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1107,"8distance,8angle,8highlightColor,8highlightAlpha,8shadowColor,8shadowAlpha,8quality,8strength,8knockout,8blurX,8blurY,8type",1);
flash.filters.GradientGlowFilter = ASconstructor(1108,0);
flash.filters.GradientGlowFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1108,"8distance,8angle,8colors,8alphas,8ratios,8blurX,8blurY,8quality,8strength,8knockout,8type",1);
flash.filters.GradientBevelFilter = ASconstructor(1108,1000);
flash.filters.GradientBevelFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1108,"8distance,8angle,8colors,8alphas,8ratios,8blurX,8blurY,8quality,8strength,8knockout,8type",1);
flash.filters.ConvolutionFilter = ASconstructor(1109,0);
flash.filters.ConvolutionFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1109,"8matrixX,8matrixY,8matrix,8divisor,8bias,8preserveAlpha,8clamp,8color,8alpha",1);
flash.filters.ColorMatrixFilter = ASconstructor(1110,0);
flash.filters.ColorMatrixFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1110,"8matrix",1);
var o = flash.filters.DisplacementMapFilter = ASconstructor(1111,0);
flash.filters.DisplacementMapFilter.prototype = o = new flash.filters.BitmapFilter();
ASSetNativeAccessor(o,1111,"8mapBitmap,8mapPoint,8componentX,8componentY,8scaleX,8scaleY,8mode,8color,8alpha",1);
flash.geom = {};
flash.geom.Rectangle = function(p1, p2, p3, p4)
{
   var _loc3_ = arguments.length;
   if(!_loc3_)
   {
      this.setEmpty();
   }
   else
   {
      this.x = p1;
      this.y = p2;
      this.width = p3;
      this.height = p4;
   }
};
var o = flash.geom.Rectangle.prototype;
o.clone = function()
{
   return new flash.geom.Rectangle(this.x,this.y,this.width,this.height);
};
o.setEmpty = function()
{
   this.x = this.y = this.width = this.height = 0;
};
o.isEmpty = function()
{
   return this.width <= 0 || this.height <= 0;
};
o.addProperty("left",function()
{
   return this.x;
}
,function(newx)
{
   this.width += this.x - newx;
   this.x = newx;
}
);
o.addProperty("right",function()
{
   return this.x + this.width;
}
,function(newr)
{
   this.width = newr - this.x;
}
);
o.addProperty("top",function()
{
   return this.y;
}
,function(newy)
{
   this.height += this.y - newy;
   this.y = newy;
}
);
o.addProperty("bottom",function()
{
   return this.y + this.height;
}
,function(newb)
{
   this.height = newb - this.y;
}
);
o.addProperty("topLeft",function()
{
   return new flash.geom.Point(this.x,this.y);
}
,function(value)
{
   this.width += this.x - value.x;
   this.height += this.y - value.y;
   this.x = value.x;
   this.y = value.y;
}
);
o.addProperty("bottomRight",function()
{
   return new flash.geom.Point(this.x + this.width,this.y + this.height);
}
,function(value)
{
   this.width = value.x - this.x;
   this.height = value.y - this.y;
}
);
o.addProperty("size",function()
{
   return new flash.geom.Point(this.width,this.height);
}
,function(value)
{
   this.width = value.x;
   this.height = value.y;
}
);
o.inflate = function(dx, dy)
{
   this.x -= dx;
   this.width += 2 * dx;
   this.y -= dy;
   this.height += 2 * dy;
};
o.inflatePoint = function(pt)
{
   this.x -= pt.x;
   this.width += 2 * pt.x;
   this.y -= pt.y;
   this.height += 2 * pt.y;
};
o.offset = function(dx, dy)
{
   this.x += dx;
   this.y += dy;
};
o.offsetPoint = function(pt)
{
   this.x += pt.x;
   this.y += pt.y;
};
o.contains = function(x, y)
{
   return x >= this.x && x < this.x + this.width && y >= this.y && y < this.y + this.height;
};
o.containsPoint = function(pt)
{
   return pt.x >= this.x && pt.x < this.x + this.width && pt.y >= this.y && pt.y < this.y + this.height;
};
o.containsRectangle = function(rect)
{
   var _loc4_ = rect.x + rect.width;
   var _loc6_ = rect.y + rect.height;
   var _loc3_ = this.x + this.width;
   var _loc5_ = this.y + this.height;
   return rect.x >= this.x && rect.x < _loc3_ && rect.y >= this.y && rect.y < _loc5_ && _loc4_ > this.x && _loc4_ <= _loc3_ && _loc6_ > this.y && _loc6_ <= _loc5_;
};
o.intersection = function(toIntersect)
{
   var _loc2_ = new flash.geom.Rectangle();
   if(this.isEmpty() || toIntersect.isEmpty())
   {
      _loc2_.setEmpty();
      return _loc2_;
   }
   _loc2_.x = Math.max(this.x,toIntersect.x);
   _loc2_.y = Math.max(this.y,toIntersect.y);
   _loc2_.width = Math.min(this.x + this.width,toIntersect.x + toIntersect.width) - _loc2_.x;
   _loc2_.height = Math.min(this.y + this.height,toIntersect.y + toIntersect.height) - _loc2_.y;
   if(_loc2_.width <= 0 || _loc2_.height <= 0)
   {
      _loc2_.setEmpty();
   }
   return _loc2_;
};
o.intersects = function(toIntersect)
{
   return !this.intersection(toIntersect).isEmpty();
};
o.union = function(toUnion)
{
   if(this.isEmpty())
   {
      return toUnion.clone();
   }
   if(toUnion.isEmpty())
   {
      return this.clone();
   }
   var _loc2_ = new flash.geom.Rectangle();
   _loc2_.x = Math.min(this.x,toUnion.x);
   _loc2_.y = Math.min(this.y,toUnion.y);
   _loc2_.width = Math.max(this.x + this.width,toUnion.x + toUnion.width) - _loc2_.x;
   _loc2_.height = Math.max(this.y + this.height,toUnion.y + toUnion.height) - _loc2_.y;
   return _loc2_;
};
o.equals = function(toCompare)
{
   return toCompare instanceof flash.geom.Rectangle && toCompare.x == this.x && toCompare.y == this.y && toCompare.width == this.width && toCompare.height == this.height;
};
o.toString = function()
{
   return "(x=" + this.x + ", y=" + this.y + ", w=" + this.width + ", h=" + this.height + ")";
};
flash.geom.Point = function(p1, p2)
{
   var _loc3_ = arguments.length;
   if(!_loc3_)
   {
      this.x = this.y = 0;
   }
   else
   {
      this.x = p1;
      this.y = p2;
   }
};
var o = flash.geom.Point;
o.distance = function(pt1, pt2)
{
   return pt1.subtract(pt2).length;
};
o.polar = function(len, angle)
{
   return new flash.geom.Point(len * Math.cos(angle),len * Math.sin(angle));
};
o.interpolate = function(pt1, pt2, f)
{
   return new flash.geom.Point(pt2.x + f * (pt1.x - pt2.x),pt2.y + f * (pt1.y - pt2.y));
};
var o = flash.geom.Point.prototype;
o.addProperty("length",function()
{
   return Math.sqrt(this.x * this.x + this.y * this.y);
}
,function(newlen)
{
}
);
o.clone = function()
{
   return new flash.geom.Point(this.x,this.y);
};
o.offset = function(dx, dy)
{
   this.x += dx;
   this.y += dy;
};
o.equals = function(toCompare)
{
   return toCompare instanceof flash.geom.Point && toCompare.x == this.x && toCompare.y == this.y;
};
o.subtract = function(v)
{
   return new flash.geom.Point(this.x - v.x,this.y - v.y);
};
o.add = function(v)
{
   return new flash.geom.Point(this.x + v.x,this.y + v.y);
};
o.normalize = function(thickness)
{
   var _loc2_ = this.length;
   if(_loc2_ > 0)
   {
      _loc2_ = thickness / _loc2_;
      this.x *= _loc2_;
      this.y *= _loc2_;
   }
};
o.toString = function()
{
   return "(x=" + this.x + ", y=" + this.y + ")";
};
flash.geom.Matrix = function(pa, pb, pc, pd, ptx, pty)
{
   var _loc3_ = arguments.length;
   if(!_loc3_)
   {
      this.identity();
   }
   else
   {
      this.a = pa;
      this.b = pb;
      this.c = pc;
      this.d = pd;
      this.tx = ptx;
      this.ty = pty;
   }
};
var o = flash.geom.Matrix.prototype;
o.concat = function(m)
{
   var _loc7_ = undefined;
   var _loc8_ = undefined;
   var _loc3_ = undefined;
   var _loc4_ = undefined;
   var _loc6_ = undefined;
   var _loc5_ = undefined;
   _loc7_ = this.a * m.a;
   _loc4_ = this.d * m.d;
   _loc8_ = _loc3_ = 0;
   _loc6_ = this.tx * m.a + m.tx;
   _loc5_ = this.ty * m.d + m.ty;
   if(this.b != 0 || this.c != 0 || m.b != 0 || m.c != 0)
   {
      _loc7_ += this.b * m.c;
      _loc4_ += this.c * m.b;
      _loc8_ += this.a * m.b + this.b * m.d;
      _loc3_ += this.c * m.a + this.d * m.c;
      _loc6_ += this.ty * m.c;
      _loc5_ += this.tx * m.b;
   }
   this.a = _loc7_;
   this.b = _loc8_;
   this.c = _loc3_;
   this.d = _loc4_;
   this.tx = _loc6_;
   this.ty = _loc5_;
};
o.invert = function()
{
   if(this.b == 0 && this.c == 0)
   {
      this.a = 1 / this.a;
      this.d = 1 / this.d;
      this.b = this.c = 0;
      this.tx = (- this.a) * this.tx;
      this.ty = (- this.d) * this.ty;
   }
   else
   {
      var _loc6_ = undefined;
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      _loc6_ = this.a;
      _loc5_ = this.b;
      _loc4_ = this.c;
      _loc3_ = this.d;
      _loc2_ = _loc6_ * _loc3_ - _loc5_ * _loc4_;
      if(_loc2_ == 0)
      {
         this.identity();
         return undefined;
      }
      _loc2_ = 1 / _loc2_;
      this.a = _loc3_ * _loc2_;
      this.b = (- _loc5_) * _loc2_;
      this.c = (- _loc4_) * _loc2_;
      this.d = _loc6_ * _loc2_;
      var _loc7_ = this.deltaTransformPoint(new flash.geom.Point(this.tx,this.ty));
      this.tx = - _loc7_.x;
      this.ty = - _loc7_.y;
   }
};
o.createBox = function(scaleX, scaleY, rotation, x, y)
{
   var _loc3_ = arguments.length;
   var _loc6_ = 0;
   if(_loc3_ > 2)
   {
      _loc6_ = rotation;
   }
   var _loc5_ = 0;
   if(_loc3_ > 3)
   {
      _loc5_ = x;
   }
   var _loc4_ = 0;
   if(_loc3_ > 4)
   {
      _loc4_ = y;
   }
   this.identity();
   this.rotate(rotation);
   this.scale(scaleX,scaleY);
   this.tx = _loc5_;
   this.ty = _loc4_;
};
o.createGradientBox = function(width, height, rotation, x, y)
{
   var _loc3_ = arguments.length;
   var _loc6_ = 0;
   if(_loc3_ > 2)
   {
      _loc6_ = rotation;
   }
   var _loc5_ = 0;
   if(_loc3_ > 3)
   {
      _loc5_ = x;
   }
   var _loc4_ = 0;
   if(_loc3_ > 4)
   {
      _loc4_ = y;
   }
   this.createBox(width / 1638.4,height / 1638.4,_loc6_,_loc5_ + width / 2,_loc4_ + height / 2);
};
o.clone = function()
{
   return new flash.geom.Matrix(this.a,this.b,this.c,this.d,this.tx,this.ty);
};
o.identity = function()
{
   this.a = this.d = 1;
   this.b = this.c = 0;
   this.tx = this.ty = 0;
};
o.rotate = function(radians)
{
   var _loc3_ = Math.cos(radians);
   var _loc2_ = Math.sin(radians);
   var _loc4_ = new flash.geom.Matrix(_loc3_,_loc2_,- _loc2_,_loc3_,0,0);
   this.concat(_loc4_);
};
o.translate = function(dx, dy)
{
   this.tx += dx;
   this.ty += dy;
};
o.scale = function(sx, sy)
{
   var _loc2_ = new flash.geom.Matrix(sx,0,0,sy,0,0);
   this.concat(_loc2_);
};
o.deltaTransformPoint = function(pt)
{
   return new flash.geom.Point(this.a * pt.x + this.c * pt.y,this.d * pt.y + this.b * pt.x);
};
o.transformPoint = function(pt)
{
   return new flash.geom.Point(this.a * pt.x + this.c * pt.y + this.tx,this.d * pt.y + this.b * pt.x + this.ty);
};
o.toString = function()
{
   return "(a=" + this.a + ", b=" + this.b + ", c=" + this.c + ", d=" + this.d + ", tx=" + this.tx + ", ty=" + this.ty + ")";
};
flash.geom.ColorTransform = ASconstructor(1105,0);
var o = flash.geom.ColorTransform.prototype;
ASSetNativeAccessor(o,1105,"8alphaMultiplier,8redMultiplier,8greenMultiplier,8blueMultiplier,8alphaOffset,8redOffset,8greenOffset,8blueOffset,8rgb",101);
ASSetNative(o,1105,"8concat",1);
o.toString = function()
{
   return "(redMultiplier=" + this.redMultiplier + ", greenMultiplier=" + this.greenMultiplier + ", blueMultiplier=" + this.blueMultiplier + ", alphaMultiplier=" + this.alphaMultiplier + ", redOffset=" + this.redOffset + ", greenOffset=" + this.greenOffset + ", blueOffset=" + this.blueOffset + ", alphaOffset=" + this.alphaOffset + ")";
};
flash.geom.Transform = ASconstructor(1106,0);
ASSetNativeAccessor(flash.geom.Transform.prototype,1106,"8matrix,8concatenatedMatrix,8colorTransform,8concatenatedColorTransform,8pixelBounds",101);
ASSetNative(AssetCache,2401,"6purge,6getDiskUsage",206);
ASSetPropFlags(AssetCache,"purge,getDiskUsage",1);
RemoteLSOUsage.getURLPageSupport = function()
{
   return ASnative(2198,101)();
};
ASSetPropFlags(RemoteLSOUsage,"getURLPageSupport",1);
flash.net = {};
flash.net.FileReference = function()
{
   ASnative(2204,200)(this);
   this._listeners = [];
};
var o = flash.net.FileReference.prototype;
AsBroadcaster.initialize(o);
ASSetNative(o,2204,"8browse,8upload,8download,8cancel,8convertToPPT,8deleteConvertedPPT");
ASSetPropFlags(o,null,3);
flash.net.FileReferenceList = function()
{
   this.fileList = new Array();
   this._listeners = [];
};
var o = flash.net.FileReferenceList.prototype;
AsBroadcaster.initialize(o);
ASSetNative(o,2205,"8browse");
ASSetPropFlags(o,null,3);
flash.external = {};
flash.external.ExternalInterface = function()
{
};
ASSetNative(flash.external.ExternalInterface,14,"8_initJS,8_objectID,8_addCallback,8_evalJS,8_callOut,8_escapeXML,8_unescapeXML,8_jsQuoteString");
ASSetNativeAccessor(flash.external.ExternalInterface,14,"8available",100);
flash.external.ExternalInterface.addCallback = function(functionName, instance, method)
{
   if(method && flash.external.ExternalInterface.available)
   {
      flash.external.ExternalInterface._initJS();
      var _loc3_ = function(request)
      {
         return flash.external.ExternalInterface._callIn(instance,method,request);
      };
      var _loc1_ = flash.external.ExternalInterface._addCallback(functionName,_loc3_);
      if(_loc1_)
      {
         var _loc2_ = flash.external.ExternalInterface._objectID();
         if(_loc2_ != null)
         {
            flash.external.ExternalInterface._evalJS("__flash__addCallback(document.getElementById(\"" + _loc2_ + "\"), \"" + functionName + "\");");
         }
      }
      return _loc1_;
   }
   return false;
};
flash.external.ExternalInterface.call = function(functionName)
{
   if(flash.external.ExternalInterface.available)
   {
      flash.external.ExternalInterface._initJS();
      var _loc3_ = "try { ";
      var _loc4_ = flash.external.ExternalInterface._objectID();
      if(_loc4_ != null)
      {
         _loc3_ += "document.getElementById(\"" + _loc4_ + "\").SetReturnValue(";
      }
      _loc3_ += "__flash__toXML(" + functionName + "(";
      var _loc2_ = 1;
      while(_loc2_ < arguments.length)
      {
         if(_loc2_ != 1)
         {
            _loc3_ += ",";
         }
         _loc3_ += flash.external.ExternalInterface._toJS(arguments[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      _loc3_ += ")) ";
      if(_loc4_ != null)
      {
         _loc3_ += ")";
      }
      _loc3_ += "; } catch (e) { ";
      if(_loc4_ != null)
      {
         _loc3_ += "document.getElementById(\"" + _loc4_ + "\").SetReturnValue(\"<undefined/>\");";
      }
      else
      {
         _loc3_ += "\"<undefined/>\";";
      }
      _loc3_ += " }";
      var _loc5_ = flash.external.ExternalInterface._evalJS(_loc3_);
      if(_loc5_ == null)
      {
         var _loc7_ = "<invoke name=\"" + functionName + "\" returntype=\"xml\">" + flash.external.ExternalInterface._argumentsToXML(arguments) + "</invoke>";
         _loc5_ = flash.external.ExternalInterface._callOut(_loc7_);
      }
      if(_loc5_ == null)
      {
         return null;
      }
      var _loc6_ = new XML();
      _loc6_.ignoreWhite = true;
      _loc6_.parseXML(_loc5_);
      return flash.external.ExternalInterface._toAS(_loc6_.firstChild);
   }
   return null;
};
flash.external.ExternalInterface._callIn = function(instance, method, request)
{
   var _loc2_ = new XML();
   _loc2_.ignoreWhite = true;
   _loc2_.parseXML(request);
   var _loc3_ = null;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.firstChild.childNodes.length)
   {
      if(_loc2_.firstChild.childNodes[_loc1_].nodeName == "arguments")
      {
         _loc3_ = _loc2_.firstChild.childNodes[_loc1_];
         break;
      }
      _loc1_ = _loc1_ + 1;
   }
   var _loc4_ = method.apply(instance,flash.external.ExternalInterface._argumentsToAS(_loc3_));
   return _loc2_.firstChild.attributes.returntype != "javascript" ? flash.external.ExternalInterface._toXML(_loc4_) : flash.external.ExternalInterface._toJS(_loc4_);
};
flash.external.ExternalInterface._arrayToXML = function(obj)
{
   var _loc3_ = "<array>";
   var _loc1_ = 0;
   while(_loc1_ < obj.length)
   {
      _loc3_ += "<property id=\"" + _loc1_ + "\">" + flash.external.ExternalInterface._toXML(obj[_loc1_]) + "</property>";
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_ + "</array>";
};
flash.external.ExternalInterface._argumentsToXML = function(obj)
{
   var _loc3_ = "<arguments>";
   var _loc1_ = 1;
   while(_loc1_ < obj.length)
   {
      _loc3_ += flash.external.ExternalInterface._toXML(obj[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_ + "</arguments>";
};
flash.external.ExternalInterface._objectToXML = function(obj)
{
   var _loc2_ = "<object>";
   for(var _loc3_ in obj)
   {
      _loc2_ += "<property id=\"" + _loc3_ + "\">" + flash.external.ExternalInterface._toXML(obj[_loc3_]) + "</property>";
   }
   return _loc2_ + "</object>";
};
flash.external.ExternalInterface._toXML = function(value)
{
   var _loc2_ = typeof value;
   if(_loc2_ == "string")
   {
      return "<string>" + flash.external.ExternalInterface._escapeXML(value) + "</string>";
   }
   if(_loc2_ == "undefined")
   {
      return "<undefined/>";
   }
   if(_loc2_ == "number")
   {
      return "<number>" + value + "</number>";
   }
   if(value == null)
   {
      return "<null/>";
   }
   if(_loc2_ == "boolean")
   {
      return !value ? "<false/>" : "<true/>";
   }
   if(value.hasOwnProperty("length"))
   {
      return flash.external.ExternalInterface._arrayToXML(value);
   }
   if(_loc2_ == "object")
   {
      return flash.external.ExternalInterface._objectToXML(value);
   }
   return "<null/>";
};
flash.external.ExternalInterface._objectToAS = function(obj)
{
   var _loc3_ = {};
   var _loc1_ = 0;
   while(_loc1_ < obj.childNodes.length)
   {
      if(obj.childNodes[_loc1_].nodeName == "property")
      {
         _loc3_[obj.childNodes[_loc1_].attributes.id] = flash.external.ExternalInterface._toAS(obj.childNodes[_loc1_].firstChild);
      }
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
};
flash.external.ExternalInterface._arrayToAS = function(obj)
{
   var _loc3_ = [];
   var _loc1_ = 0;
   while(_loc1_ < obj.childNodes.length)
   {
      _loc3_[obj.childNodes[_loc1_].attributes.id] = flash.external.ExternalInterface._toAS(obj.childNodes[_loc1_].firstChild);
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
};
flash.external.ExternalInterface._toAS = function(obj)
{
   var type = obj.nodeName;
   if(type == "number")
   {
      return Number(obj.firstChild.toString());
   }
   if(type == "string")
   {
      if(getSWFVersion() > 8 && String(obj.firstChild) == "null")
      {
         return flash.external.ExternalInterface._unescapeXML("");
      }
      return flash.external.ExternalInterface._unescapeXML(String(obj.firstChild));
   }
   if(type == "false")
   {
      return false;
   }
   if(type == "true")
   {
      return true;
   }
   if(type == "null")
   {
      return null;
   }
   if(type == "undefined")
   {
      return undefined;
   }
   if(type == "object")
   {
      return flash.external.ExternalInterface._objectToAS(obj);
   }
   if(type == "array")
   {
      return flash.external.ExternalInterface._arrayToAS(obj);
   }
   if(type == "class")
   {
      return eval(String(obj.firstChild));
   }
   return undefined;
};
flash.external.ExternalInterface._argumentsToAS = function(obj)
{
   var _loc3_ = [];
   var _loc1_ = 0;
   while(_loc1_ < obj.childNodes.length)
   {
      _loc3_.push(flash.external.ExternalInterface._toAS(obj.childNodes[_loc1_]));
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
};
flash.external.ExternalInterface._arrayToJS = function(value)
{
   var _loc2_ = "[";
   var _loc1_ = 0;
   while(_loc1_ < value.length)
   {
      if(_loc1_ != 0)
      {
         _loc2_ += ",";
      }
      _loc2_ += flash.external.ExternalInterface._toJS(value[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   return _loc2_ + "]";
};
flash.external.ExternalInterface._objectToJS = function(value)
{
   var _loc1_ = "({";
   var _loc2_ = true;
   for(var _loc4_ in value)
   {
      if(!_loc2_)
      {
         _loc1_ += ",";
      }
      _loc2_ = false;
      _loc1_ += _loc4_ + ":" + flash.external.ExternalInterface._toJS(value[_loc4_]);
   }
   return _loc1_ + "})";
};
flash.external.ExternalInterface._toJS = function(value)
{
   if(typeof value == "string")
   {
      return "\"" + flash.external.ExternalInterface._jsQuoteString(flash.external.ExternalInterface._unescapeXML(value)) + "\"";
   }
   if(typeof value == "object")
   {
      if(value instanceof Array)
      {
         return flash.external.ExternalInterface._arrayToJS(value);
      }
      return flash.external.ExternalInterface._objectToJS(value);
   }
   return String(value);
};
ASSetPropFlags(flash.external.ExternalInterface,null,4103);
flash.automation = {};
flash.automation.StageCapture = ASconstructor(2700,100);
var o = flash.automation.StageCapture.prototype;
ASSetNative(o,2700,"capture,cancel,getFileNameBase,setFileNameBase,getClipRect,setClipRect,listenForStageCapture,valueOf,toString");
ASSetPropFlags(o,null,3);
flash.automation.ActionGenerator = function()
{
};
var o = flash.automation.ActionGenerator.prototype;
ASSetNative(o,2800,"generateAction,generateActions,valueOf,toString");
ASSetPropFlags(ActionGenerator,null,7);
flash.automation.Configuration = function()
{
};
var o = flash.automation.Configuration.prototype;
ASSetNative(o,2900,"getTestAutomationConfiguration,getDeviceConfiguration,setDeviceConfiguration,valueOf,toString");
ASSetPropFlags(Configuration,null,7);
var o = null;
