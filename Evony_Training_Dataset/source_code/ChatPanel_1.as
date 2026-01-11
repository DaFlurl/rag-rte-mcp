package autoevony.gui
{
   import autoevony.cmds.Commands;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.management.CityManager;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.constants.CommonConstants;
   import com.evony.common.server.events.AllianceChatMsg;
   import com.evony.common.server.events.ChannelChatMsg;
   import com.evony.common.server.events.PrivateChatMessage;
   import com.evony.common.server.events.SystemInfoMsg;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.TabBar;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.controls.tabBarClasses.Tab;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class ChatPanel extends VBox implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static var maintMin:int = -1;
      
      public static var maintMax:int = -1;
      
      private var _1437393061chatText:TextInput;
      
      private var _94416770cache:ObjectProxy;
      
      mx_internal var _watchers:Array;
      
      private var chatHistory:Array;
      
      private var _739104029chatTab:TabBar;
      
      private var commander:Commands = null;
      
      private var _739096780chatLog:TextArea;
      
      private var lastPrivateChatFromUser:String = "";
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1659559965clearChatLogBtn:Button;
      
      private var currentHistory:int = 0;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function ChatPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":603,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "bottom";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":22,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TabBar,
                              "id":"chatTab",
                              "events":{
                                 "creationComplete":"__chatTab_creationComplete",
                                 "itemClick":"__chatTab_itemClick"
                              },
                              "stylesFactory":function():void
                              {
                                 this.tabStyleName = "REtabBarTab";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"REtabBar"};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "events":{
                        "rollOver":"___ChatPanel_Canvas1_rollOver",
                        "rollOut":"___ChatPanel_Canvas1_rollOut"
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"chatLog",
                              "events":{"link":"__chatLog_link"},
                              "stylesFactory":function():void
                              {
                                 this.left = "0";
                                 this.right = "0";
                                 this.top = "0";
                                 this.bottom = "0";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REchatBox",
                                    "editable":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"clearChatLogBtn",
                              "events":{"click":"__clearChatLogBtn_click"},
                              "stylesFactory":function():void
                              {
                                 this.top = "10";
                                 this.right = "27";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"clearLogBtn",
                                    "visible":false
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "middle";
                        this.verticalGap = 0;
                        this.horizontalGap = 3;
                        this.paddingLeft = 0;
                        this.paddingRight = 0;
                        this.paddingTop = 0;
                        this.paddingBottom = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":30,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"chatText",
                              "events":{"keyUp":"__chatText_keyUp"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "editable":true,
                                    "maxChars":150,
                                    "styleName":"chatInput",
                                    "percentWidth":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___ChatPanel_Button2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Send",
                                    "styleName":"REwinBtn"
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.chatHistory = new Array("");
         this._94416770cache = new ObjectProxy({
            "aChatText":"",
            "pChatText":"",
            "wChatText":"",
            "systemText":"",
            "commandText":"",
            "emptyStr":""
         });
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.verticalGap = 0;
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
         this.width = 603;
         this.percentHeight = 100;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___ChatPanel_VBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ChatPanel._watcherSetupUtil = param1;
      }
      
      public function getCommander() : Commands
      {
         return this.commander;
      }
      
      private function set cache(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._94416770cache;
         if(_loc2_ !== param1)
         {
            this._94416770cache = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cache",_loc2_,param1));
         }
      }
      
      private function setScrollPos(param1:TextArea) : void
      {
         var target:TextArea = param1;
         Utils.callLater(50,function():void
         {
            target.verticalScrollPosition = target.maxVerticalScrollPosition;
         });
      }
      
      public function __clearChatLogBtn_click(param1:MouseEvent) : void
      {
         this.clear(true,["aChatText","pChatText","wChatText","systemText","commandText"][this.chatTab.selectedIndex],true);
      }
      
      public function ___ChatPanel_VBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function init() : void
      {
         var _loc1_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc1_.addEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG,this.evtSystemInfoMsg);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_WORLD_CHAT_MSG,this.evtWorldChatMsg);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_CHANNEL_CHAT_MSG,this.evtChannelChatMsg);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_ALLIANCE_CHAT_MSG,this.evtAllianceChatMsg);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_PRIVATE_CHAT_MESSAGE,this.evtPrivateChatMessage);
         this.commander = new Commands(this.cmdLogMsg);
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ChatPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ChatPanel_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_ChatPanelWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      public function ___ChatPanel_Canvas1_rollOut(param1:MouseEvent) : void
      {
         this.clearChatLogBtn.visible = false;
      }
      
      public function evtWorldChatMsg(param1:ChannelChatMsg) : void
      {
         var _loc2_:String = "[World]";
         var _loc3_:String = "#222222";
         if(param1.ownitemid == 7 || param1.ownitemid == 8)
         {
            _loc2_ = "[Staff]";
            _loc3_ = "#156510";
         }
         if(param1.fromUser.indexOf("Gove") > -1)
         {
            _loc3_ = "#F05A00";
         }
         this.showNewMsg("wChatText","[" + this._kh627(param1.fromUser,_loc3_) + "]: " + param1.msg,_loc3_,true,_loc2_);
         if(this.chatTab.selectedIndex != 2)
         {
            this.chatTab.getChildren()[2].setStyle("fontStyle","italic");
         }
      }
      
      public function showNewMsg(param1:String, param2:String, param3:String = "#000000", param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:int = 0;
         this.cache[param1] += "<font color=\'" + (param3 != "#000000" ? param3 : "#006666") + "\'>" + (param4 ? param5 + "&lt;" + Utils.getChatTimeStr(Utils.getServerTime()) + "&gt;</font>" : Utils.getLogTimeStr(Utils.getServerTime()) + "</font> ") + "<font color=\'" + param3 + "\'>" + param2.replace(/\r\n?|\n|<br>/gi,"\n") + "</font>\n";
         var _loc6_:int = int(this.cache[param1].length);
         if((param1 == "aChatText" || param1 == "pChatText" || param1 == "wChatText") && _loc6_ > 96000 || param1 == "systemText" && _loc6_ > 96000 || param1 == "commandText" && _loc6_ > 256000)
         {
            this.cache[param1] = this.cache[param1].substr(this.cache[param1].indexOf("\n",8000));
         }
         _loc7_ = this.chatTab.selectedIndex;
         if(_loc7_ == 0 && param1 == "aChatText" || _loc7_ == 1 && param1 == "pChatText" || _loc7_ == 2 && param1 == "wChatText" || _loc7_ == 3 && param1 == "systemText" || _loc7_ == 4 && param1 == "commandText")
         {
            this.setScrollPos(this.chatLog);
         }
      }
      
      private function newKeyUpEvent(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER && Utils.trim(this.chatText.text).length > 0)
         {
            this.chatHistory[this.chatHistory.length - 1] = this.chatText.text;
            this.chatHistory.push("");
            this.currentHistory = this.chatHistory.length - 1;
            this._os197();
         }
         else if(param1.keyCode == Keyboard.UP && this.currentHistory >= 1)
         {
            this.chatHistory[this.currentHistory] = this.chatText.text;
            --this.currentHistory;
            this.chatText.text = this.chatHistory[this.currentHistory];
            if(this.chatText.text.substr(0,2) != "/\'")
            {
               if(this.chatText.text.substr(0,1) != "/")
               {
                  this.chatText.selectionBeginIndex = 0;
               }
               else
               {
                  this.chatText.selectionBeginIndex = this.chatText.text.indexOf(" ",1) + 1;
               }
            }
            else
            {
               this.chatText.selectionBeginIndex = this.chatText.text.indexOf("\' ",2) + 2;
            }
            this.chatText.selectionEndIndex = this.chatText.text.length;
         }
         else if(param1.keyCode == Keyboard.DOWN && this.currentHistory < this.chatHistory.length - 1)
         {
            this.chatHistory[this.currentHistory] = this.chatText.text;
            ++this.currentHistory;
            this.chatText.text = this.chatHistory[this.currentHistory];
            if(this.chatText.text.substr(0,2) != "/\'")
            {
               if(this.chatText.text.substr(0,1) != "/")
               {
                  this.chatText.selectionBeginIndex = 0;
               }
               else
               {
                  this.chatText.selectionBeginIndex = this.chatText.text.indexOf(" ",1) + 1;
               }
            }
            else
            {
               this.chatText.selectionBeginIndex = this.chatText.text.indexOf("\' ",2) + 2;
            }
            this.chatText.selectionEndIndex = this.chatText.text.length;
         }
      }
      
      public function evtSystemInfoMsg(param1:SystemInfoMsg) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:String = param1.msg;
         _loc2_ = _loc2_.replace(/<[^<]*>/g,"");
         _loc2_ = _loc2_.replace(/<[^<]*>/g,"");
         _loc2_ = _loc2_.replace(/<[^<]*>/g,"");
         var _loc3_:Array = _loc2_.split(" ");
         if(_loc3_.length > 1 && (_loc3_[1] == "Bid" || _loc3_[1] == "Offer" || _loc3_[1] == "Troops" && _loc3_[2] == "returned"))
         {
            return;
         }
         if(_loc3_.length > 1 && _loc3_[1] == "Defeat")
         {
            _loc3_.splice(0,1);
            parentDocument.logMsg(_loc3_.join(" "));
            return;
         }
         var _loc4_:Boolean = _loc3_.length >= 5 && (_loc3_[0] == "Lord" || _loc3_[0] == "Lady") && _loc3_[_loc3_.length - 2] == "from" && _loc3_[_loc3_.length - 1] == "Amulet!";
         var _loc5_:Boolean = _loc3_.length >= 8 && _loc3_[0] == "Hurrah!" && _loc3_[_loc3_.length - 3] == "equipment";
         if((_loc4_ || _loc5_) && param1.tV)
         {
            return;
         }
         this.showNewMsg("systemText",_loc2_);
         if(this.chatTab.selectedIndex != 3)
         {
            this.chatTab.getChildren()[3].setStyle("fontStyle","italic");
         }
         if(_loc4_ || _loc5_ && !(_loc3_[_loc3_.length - 1] == "Lv:14" || _loc3_[_loc3_.length - 1] == "Lv:15"))
         {
            return;
         }
         if(_loc2_.search(/maintenance/i) > 0)
         {
            parentDocument.logMsg("MAINTENANCE: " + _loc2_);
            _loc6_ = Utils.getStringBetween(_loc2_,"due in "," minutes");
            _loc7_ = Utils.getStringBetween(_loc2_,"minutes "," seconds");
            if(_loc6_ != null && _loc7_ != null && Utils.hasValue(_loc6_) && Utils.hasValue(_loc7_))
            {
               CityManager.setEstMaintDownTime(60 * int(_loc6_) + int(_loc7_));
            }
            if(_loc6_ != null && Utils.hasValue(_loc6_) && int(_loc6_) < 5)
            {
               if(parentDocument._dx1146(3600))
               {
                  parentDocument.scheduleUnpauseTimer(Utils.rand((int(_loc6_) + 10) * 60 * 1000,(int(_loc6_) + 15) * 60 * 1000));
               }
               else
               {
                  _loc8_ = maintMin == -1 ? 30 : maintMin;
                  _loc9_ = maintMax == -1 ? 40 : maintMax;
                  parentDocument.scheduleUnpauseTimer(Utils.rand(_loc8_ * 60 * 1000,_loc9_ * 60 * 1000));
               }
               parentDocument.logMsg("Click on Resume to resume the program manually. Make sure you don\'t resume when the server is still down, though.");
               CityManager.deletePlayerTiming("attack");
            }
         }
         else
         {
            this.showNewMsg("wChatText","SYSTEM: " + _loc2_,"#4377F9");
            this.showNewMsg("aChatText","SYSTEM: " + _loc2_,"#3F3F3F");
            if(this.chatTab.selectedIndex != 0)
            {
               this.chatTab.getChildren()[0].setStyle("fontStyle","italic");
            }
            if(this.chatTab.selectedIndex != 2)
            {
               this.chatTab.getChildren()[2].setStyle("fontStyle","italic");
            }
         }
      }
      
      private function handleLogLinkEvent(param1:TextEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param1.currentTarget == this.chatLog && this.chatTab.selectedIndex < 4)
         {
            _loc2_ = param1.text;
            if(_loc2_.indexOf(" ") != -1)
            {
               _loc2_ = "\'" + _loc2_ + "\'";
            }
            _loc3_ = Utils.trim(this.chatText.text);
            if(_loc3_.length == 0 || _loc3_.charAt(0) != "/")
            {
               this.chatText.text = "/" + _loc2_ + " " + _loc3_;
               this.chatText.selectionBeginIndex = 0;
               this.chatText.selectionEndIndex = _loc2_.length + 2;
               this.chatText.setFocus();
               return;
            }
            _loc4_ = 0;
            if(_loc3_.length > 1 && _loc3_.charAt(1) == "\'")
            {
               _loc4_ = _loc3_.indexOf("\'",2) + 1;
               if(_loc4_ == 0)
               {
                  _loc4_ = 2;
               }
            }
            else
            {
               _loc4_ = _loc3_.indexOf(" ",1) + 1;
               if(_loc4_ == 0)
               {
                  _loc4_ = _loc3_.length;
               }
            }
            this.chatText.text = "/" + _loc2_ + " " + Utils.trim(_loc3_.substring(_loc4_));
            this.chatText.selectionBeginIndex = 0;
            this.chatText.selectionEndIndex = _loc2_.length + 2;
            this.chatText.setFocus();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get chatText() : TextInput
      {
         return this._1437393061chatText;
      }
      
      public function __chatText_keyUp(param1:KeyboardEvent) : void
      {
         this.newKeyUpEvent(param1);
      }
      
      private function uninit() : void
      {
         var _loc1_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG,this.evtSystemInfoMsg);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_WORLD_CHAT_MSG,this.evtWorldChatMsg);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CHANNEL_CHAT_MSG,this.evtChannelChatMsg);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_ALLIANCE_CHAT_MSG,this.evtAllianceChatMsg);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_PRIVATE_CHAT_MESSAGE,this.evtPrivateChatMessage);
         this.commander = null;
      }
      
      private function _ChatPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = ["Alliance Chat","Private Chat","World Chat","System","Commands"];
         _loc1_ = this.chatTab.selectedIndex == 0 ? this.cache.aChatText : (this.chatTab.selectedIndex == 1 ? this.cache.pChatText : (this.chatTab.selectedIndex == 2 ? this.cache.wChatText : (this.chatTab.selectedIndex == 3 ? this.cache.systemText : (this.chatTab.selectedIndex == 4 ? this.cache.commandText : this.cache.emtpyStr))));
         _loc1_ = "Clear all entries from the " + (this.chatTab.selectedIndex == 0 ? "Alliance Chat" : (this.chatTab.selectedIndex == 1 ? "Private Chat" : (this.chatTab.selectedIndex == 2 ? "World Chat" : (this.chatTab.selectedIndex == 3 ? "System" : "Commands")))) + " Log";
      }
      
      private function _os197() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = Utils.trim(this.chatText.text);
         if(_loc1_.length > 0)
         {
            if(_loc1_.charAt(0) == "\\")
            {
               this.commander.doCmd(Utils.trim(_loc1_.substr(1)));
            }
            else if(_loc1_.charAt(0) == "/")
            {
               _loc2_ = null;
               _loc3_ = null;
               if(_loc1_.charAt(1) == "\'")
               {
                  _loc2_ = _loc1_.substr(2,_loc1_.indexOf("\'",2) - 2);
                  _loc3_ = _loc1_.substr(_loc2_.length + 4,_loc1_.length - (_loc2_.length + 4));
               }
               else
               {
                  if(_loc1_.indexOf(" ",1) != -1)
                  {
                     _loc2_ = _loc1_.substr(1,_loc1_.indexOf(" ",1) - 1);
                     _loc3_ = _loc1_.substr(_loc2_.length + 1,_loc1_.length - 1 - _loc2_.length);
                  }
                  else
                  {
                     _loc2_ = _loc1_.substr(1);
                     _loc3_ = "";
                  }
                  if(_loc2_ == "r")
                  {
                     _loc2_ = this.lastPrivateChatFromUser;
                  }
                  if(_loc2_ == "")
                  {
                     return;
                  }
               }
               if(_loc3_ == "")
               {
                  return;
               }
               this.lastPrivateChatFromUser = _loc2_;
               if(_loc3_.charAt(0) == " ")
               {
                  _loc3_ = _loc3_.slice(1);
               }
               ActionFactory.getInstance().getCommonCommands().privateChat(_loc2_,_loc3_);
               this.showWhisperInChats(this.lastPrivateChatFromUser,_loc3_,"To");
            }
            else if(this.chatTab.selectedIndex == 2)
            {
               ActionFactory.getInstance().getCommonCommands().worldChat(this.chatText.text,0);
            }
            else if(this.chatTab.selectedIndex == 0)
            {
               ActionFactory.getInstance().getCommonCommands().allianceChat(this.chatText.text,0);
            }
            this.chatText.text = "";
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get cache() : ObjectProxy
      {
         return this._94416770cache;
      }
      
      public function set chatLog(param1:TextArea) : void
      {
         var _loc2_:Object = this._739096780chatLog;
         if(_loc2_ !== param1)
         {
            this._739096780chatLog = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatLog",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get chatTab() : TabBar
      {
         return this._739104029chatTab;
      }
      
      public function ___ChatPanel_Button2_click(param1:MouseEvent) : void
      {
         this._os197();
      }
      
      private function _ChatPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return ["Alliance Chat","Private Chat","World Chat","System","Commands"];
         },function(param1:Object):void
         {
            chatTab.dataProvider = param1;
         },"chatTab.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.chatTab.selectedIndex == 0 ? this.cache.aChatText : (this.chatTab.selectedIndex == 1 ? this.cache.pChatText : (this.chatTab.selectedIndex == 2 ? this.cache.wChatText : (this.chatTab.selectedIndex == 3 ? this.cache.systemText : (this.chatTab.selectedIndex == 4 ? this.cache.commandText : this.cache.emtpyStr))));
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            chatLog.htmlText = param1;
         },"chatLog.htmlText");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "Clear all entries from the " + (this.chatTab.selectedIndex == 0 ? "Alliance Chat" : (this.chatTab.selectedIndex == 1 ? "Private Chat" : (this.chatTab.selectedIndex == 2 ? "World Chat" : (this.chatTab.selectedIndex == 3 ? "System" : "Commands")))) + " Log";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            clearChatLogBtn.toolTip = param1;
         },"clearChatLogBtn.toolTip");
         result[2] = binding;
         return result;
      }
      
      public function __chatTab_itemClick(param1:ItemClickEvent) : void
      {
         this.onLogTabClick(this.chatTab,param1.relatedObject);
      }
      
      public function evtChannelChatMsg(param1:ChannelChatMsg) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "#333333";
         if(param1.channel == CommonConstants.CHAT_CHANNEL_BEGINNER && param1.fromUser as String != MainScreen.getPlayer().playerInfo.userName)
         {
            _loc2_ = "";
            _loc3_ = "#333333";
            if(param1.ownitemid == 7 || param1.ownitemid == 8)
            {
               _loc2_ = "[Staff]";
               _loc3_ = "#156510";
            }
            this.showNewMsg("wChatText","[" + this._kh627(param1.fromUser,_loc3_) + "]: " + param1.msg,_loc3_,true,_loc2_);
            if(this.chatTab.selectedIndex != 2)
            {
               this.chatTab.getChildren()[2].setStyle("fontStyle","italic");
            }
         }
         else if(param1.channel != CommonConstants.CHAT_CHANNEL_WORLD)
         {
            if(param1.channel != CommonConstants.CHAT_CHANNEL_ALLIANCE)
            {
               if(param1.channel != CommonConstants.CHAT_CHANNEL_TRADE)
               {
                  if(param1.channel != CommonConstants.CHAT_CHANNEL_ZONE)
                  {
                  }
               }
            }
         }
         else
         {
            this.evtWorldChatMsg(param1);
         }
      }
      
      public function clear(param1:Boolean, param2:String, param3:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to clear this log window?",this.clear,"Clear Log","Cancel",[param2]));
            return;
         }
         this.cache[param2] = "";
      }
      
      public function evtPrivateChatMessage(param1:PrivateChatMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.fromUser != MainScreen.getPlayer().playerInfo.userName && this.chatAcept(param1.fromUser))
         {
            this.lastPrivateChatFromUser = param1.fromUser;
            _loc2_ = "[Whisper]";
            _loc3_ = "#6A44AF";
            if(param1.ownitemid == 7 || param1.ownitemid == 8)
            {
               _loc2_ = "[Staff]";
               _loc3_ = "#156510";
            }
            if(param1.chatType == PrivateChatMessage.GM_CHAT)
            {
               _loc3_ = "#FF0000";
            }
            this.showWhisperInChats(param1.fromUser,param1.msg,"From",true,_loc3_,_loc2_);
         }
      }
      
      public function set chatText(param1:TextInput) : void
      {
         var _loc2_:Object = this._1437393061chatText;
         if(_loc2_ !== param1)
         {
            this._1437393061chatText = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatText",_loc2_,param1));
         }
      }
      
      public function set chatTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._739104029chatTab;
         if(_loc2_ !== param1)
         {
            this._739104029chatTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatTab",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get chatLog() : TextArea
      {
         return this._739096780chatLog;
      }
      
      public function set clearChatLogBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1659559965clearChatLogBtn;
         if(_loc2_ !== param1)
         {
            this._1659559965clearChatLogBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"clearChatLogBtn",_loc2_,param1));
         }
      }
      
      private function onTabBarComplete(param1:TabBar) : void
      {
         var _loc2_:Tab = null;
         for each(_loc2_ in param1.getChildren())
         {
            if(_loc2_.label == "Alliance Chat")
            {
               _loc2_.setStyle("themeColor","#7AAAFF");
               _loc2_.setStyle("color","#7AAAFF");
               _loc2_.setStyle("textRollOverColor","#7AAAFF");
            }
            else if(_loc2_.label == "Private Chat")
            {
               _loc2_.setStyle("themeColor","#B973FF");
               _loc2_.setStyle("color","#B973FF");
               _loc2_.setStyle("textRollOverColor","#B973FF");
            }
            else if(_loc2_.label == "System")
            {
               _loc2_.setStyle("themeColor","#EE5555");
               _loc2_.setStyle("color","#EE5555");
               _loc2_.setStyle("textRollOverColor","#EE5555");
            }
            else if(_loc2_.label == "Commands")
            {
               _loc2_.setStyle("themeColor","#00DA00");
               _loc2_.setStyle("color","#00DA00");
               _loc2_.setStyle("textRollOverColor","#00DA00");
            }
            else
            {
               _loc2_.setStyle("themeColor","#FFFFFF");
               _loc2_.setStyle("color","#FFFFFF");
               _loc2_.setStyle("textRollOverColor","#FFFFFF");
            }
         }
      }
      
      private function chatAcept(param1:String) : Boolean
      {
         var _loc2_:PlayerInfoBean = null;
         if(MainScreen.getPlayer().blockBeansArray.length > 0)
         {
            for each(_loc2_ in MainScreen.getPlayer().blockBeansArray)
            {
               if(param1 == _loc2_.userName)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      [Bindable(event="propertyChange")]
      public function get clearChatLogBtn() : Button
      {
         return this._1659559965clearChatLogBtn;
      }
      
      public function ___ChatPanel_Canvas1_rollOver(param1:MouseEvent) : void
      {
         this.clearChatLogBtn.visible = true;
      }
      
      public function __chatLog_link(param1:TextEvent) : void
      {
         this.handleLogLinkEvent(param1);
      }
      
      public function evtAllianceChatMsg(param1:AllianceChatMsg) : void
      {
         var _loc2_:String = "[Alliance]";
         var _loc3_:String = "#4377F9";
         if(param1.ownitemid == 7 || param1.ownitemid == 8)
         {
            _loc2_ = "[Staff]";
            _loc3_ = "#156510";
         }
         this.showNewMsg("aChatText"," [" + this._kh627(param1.fromUser,_loc3_) + "]: " + param1.msg,_loc3_,true,_loc2_);
         if(this.chatTab.selectedIndex != 0)
         {
            this.chatTab.getChildren()[0].setStyle("fontStyle","italic");
         }
      }
      
      public function showWhisperInChats(param1:String, param2:String, param3:String, param4:Boolean = false, param5:String = "#6A44AF", param6:String = "[Whisper]") : void
      {
         param2 = param2.split(">").join("&gt;").split("<").join("&lt;");
         this.showNewMsg("pChatText",param3 + " [" + this._kh627(param1,param5) + "]: " + param2,param5,true,param6);
         if(param4 && this.chatTab.selectedIndex != 1)
         {
            this.chatTab.getChildren()[1].setStyle("fontStyle","italic");
         }
         this.showNewMsg("aChatText",param3 + " [" + this._kh627(param1,param5) + "]: " + param2,param5,true,param6);
         this.showNewMsg("wChatText",param3 + " [" + this._kh627(param1,param5) + "]: " + param2,param5,true,param6);
      }
      
      private function cmdLogMsg(param1:String) : void
      {
         this.showNewMsg("commandText"," " + param1,"#095E5D");
         if(this.chatTab.selectedIndex != 4)
         {
            this.chatTab.getChildren()[4].setStyle("fontStyle","italic");
         }
      }
      
      private function onLogTabClick(param1:TabBar, param2:Object) : void
      {
         var _loc3_:Tab = null;
         for each(_loc3_ in param1.getChildren())
         {
            if(_loc3_ == param2)
            {
               _loc3_.setStyle("fontStyle","normal");
               _loc3_.setStyle("fontWeight","bold");
            }
            else
            {
               _loc3_.setStyle("fontWeight","normal");
            }
         }
         this.setScrollPos(this.chatLog);
      }
      
      public function __chatTab_creationComplete(param1:FlexEvent) : void
      {
         this.onTabBarComplete(this.chatTab);
      }
      
      private function _kh627(param1:String, param2:String) : String
      {
         return Utils.formatUrl(param1,param1,param2);
      }
   }
}

