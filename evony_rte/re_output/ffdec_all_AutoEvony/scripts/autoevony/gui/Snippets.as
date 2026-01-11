package autoevony.gui
{
   import autoevony.common.Utils;
   import autoevony.management.CityManager;
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
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Snippets extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const SAMPLETEXT:String = "# Define snippet \'sample\', to be used with \'include sample\' in goal or script" + "\n[sample]" + "\nconfig npc:1";
      
      private static const DEFAULTTEXT:String = "# Define default snippet for new or captured towns or towns with empty goal" + "\n[default]" + "\nconfig comfort:1,trade:0,gate:0.5" + "\ntroop a:200000,warr:1000,wo:1000,p:1000,sw:1000,cav:1000" + "\nfortification ab:1000\n";
      
      internal static const SETALLGOALS:String = "SetAllGoals";
      
      internal static const SAVEALLEVENT:String = "SaveAll";
      
      internal static var isInitialized:Boolean = false;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "creationPolicy":"all",
               "childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextArea,
                           "id":"snippetsTextArea",
                           "events":{"change":"__snippetsTextArea_change"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "styleName":"txtAreaStyle"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 0;
                              this.verticalAlign = "middle";
                              this.paddingLeft = 5;
                              this.paddingRight = 5;
                              this.paddingTop = 0;
                              this.paddingBottom = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":28,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Save File",
                                          "toolTip":"Save all currently entered Snippets to a text file."
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":5};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Load File",
                                          "toolTip":"Load Snippets from a text file into the Snippets window."
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":20};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button3_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Set Snippets",
                                          "toolTip":"Activate currently entered Snippets"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":5};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button4_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Save",
                                          "toolTip":"Save changes to currently entered Snippets"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":15};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button5_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Load",
                                          "toolTip":"Load last saved Snippets"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":15};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button6_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Save All",
                                          "toolTip":"Save all Goals, Scripts and Snippets"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":5};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___Snippets_Button7_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"REwinBtn",
                                          "label":"Set All Goals",
                                          "toolTip":"Set all Goals for all cities at once"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"status",
                           "stylesFactory":function():void
                           {
                              this.color = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":20,
                                 "percentWidth":100
                              };
                           }
                        })]
                     };
                  }
               })]
            };
         }
      });
      
      private var _892481550status:Text;
      
      private var _504392816snippetsTextArea:TextArea;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _watchers:Array = [];
      
      private var lastSavedFileName:String = null;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var LastLoadedFileName:String = null;
      
      mx_internal var _bindings:Array = [];
      
      private var snippets:Object = null;
      
      public function Snippets()
      {
         super();
         mx_internal::_document = this;
         this.creationPolicy = "all";
         this.percentHeight = 100;
         this.percentWidth = 100;
         this.addEventListener("creationComplete",this.___Snippets_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Snippets._watcherSetupUtil = param1;
      }
      
      public function ___Snippets_Button3_click(param1:MouseEvent) : void
      {
         this.setSnippets();
      }
      
      public function ___Snippets_Button4_click(param1:MouseEvent) : void
      {
         this.saveSnippets();
      }
      
      public function ___Snippets_Button6_click(param1:MouseEvent) : void
      {
         this.saveAll();
      }
      
      public function ___Snippets_Button2_click(param1:MouseEvent) : void
      {
         this.onLoadFromFile();
      }
      
      public function ___Snippets_Button5_click(param1:MouseEvent) : void
      {
         this.loadSnippets();
      }
      
      private function onLoadFromFile() : void
      {
         var loadFile:FileReference = null;
         var selectedHandler:Function = null;
         var canceledHandler:Function = null;
         var completeHandler:Function = null;
         var errorHandler:Function = null;
         loadFile = null;
         selectedHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.SELECT,selectedHandler);
            loadFile.removeEventListener(Event.CANCEL,canceledHandler);
            loadFile.addEventListener(Event.COMPLETE,completeHandler);
            loadFile.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            loadFile.load();
         };
         canceledHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.SELECT,selectedHandler);
            loadFile.removeEventListener(Event.CANCEL,canceledHandler);
            if(Version.isTraceOn())
            {
               trace("The file load has been canceled. " + param1);
            }
            loadFile = null;
         };
         completeHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.COMPLETE,completeHandler);
            loadFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            var _loc2_:ByteArray = loadFile.data;
            LastLoadedFileName = loadFile.name;
            updateTarget(_loc2_.readUTFBytes(_loc2_.bytesAvailable).replace(/\r\n?|\n/g,"\n"));
            status.text = "The contents of file \"" + loadFile.name + "\" was successfully loaded to the snippets window.";
            loadFile = null;
         };
         errorHandler = function(param1:IOErrorEvent):void
         {
            loadFile.removeEventListener(Event.COMPLETE,completeHandler);
            loadFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            if(Version.isTraceOn())
            {
               trace("Error loading file : " + param1.text);
            }
            status.text = "An error occured while loading the file. " + param1;
            loadFile = null;
         };
         loadFile = new FileReference();
         loadFile.addEventListener(Event.SELECT,selectedHandler);
         loadFile.addEventListener(Event.CANCEL,canceledHandler);
         loadFile.browse([new FileFilter("Text File","*.txt;*.text")]);
      }
      
      private function _Snippets_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            status.text = param1;
         },"status.text");
         result[0] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Snippets = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Snippets_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_SnippetsWatcherSetupUtil");
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
      
      private function saveSnippets(param1:Boolean = false) : void
      {
         if(this.snippetsTextArea == null)
         {
            return;
         }
         var _loc2_:SharedObject = SharedObject.getLocal("snippets");
         _loc2_.data.now = this.snippetsTextArea.text;
         if(_loc2_.flush() != SharedObjectFlushStatus.FLUSHED)
         {
            this.status.text = "SAVING PROBLEM: " + this.status + ", you may need to increase flash local storage";
         }
         else if(!param1)
         {
            this.status.text = "Snippets have been saved successfully";
         }
      }
      
      public function getTrimmedSnippetCmdLines(param1:Array, param2:int = 20, param3:int = 10000) : Array
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < param1.length)
         {
            _loc4_ = Utils.trim(param1[_loc9_]);
            if(_loc4_.substr(0,11) == "includeurl " || _loc4_.substr(0,12) == "includefile ")
            {
               _loc8_.push(_loc4_);
            }
            else
            {
               if(_loc4_.indexOf("//") != -1)
               {
                  _loc4_ = Utils.trim(_loc4_.substr(0,_loc4_.indexOf("//")));
               }
               if(!(_loc4_.length == 0 || _loc4_.charAt(0) == "#"))
               {
                  if(_loc4_ != "include")
                  {
                     if(_loc4_.substr(0,8) == "include ")
                     {
                        if(param2 <= 0)
                        {
                           this.status.text = "ERROR: Too many recursions in snippets";
                           return null;
                        }
                        _loc5_ = _loc4_.substr(8).toLowerCase();
                        if(this.snippets[_loc5_] == undefined)
                        {
                           this.status.text = "ERROR: no snippet \'" + _loc5_ + "\' found";
                           return null;
                        }
                        _loc6_ = this.getTrimmedSnippetCmdLines(this.snippets[_loc5_],param2 - 1,param3);
                        if(_loc6_ == null)
                        {
                           this.status.text = "ERROR: processing snippet \'" + _loc5_ + "\'";
                           return null;
                        }
                        if(_loc6_.length > param3)
                        {
                           this.status.text = "ERROR: snippet " + _loc5_ + " is too large. It has more than " + param3 + " lines";
                           return null;
                        }
                        for each(_loc7_ in _loc6_)
                        {
                           _loc8_.push(_loc7_);
                        }
                     }
                     else
                     {
                        _loc8_.push(_loc4_);
                     }
                  }
               }
            }
            _loc9_++;
         }
         return _loc8_;
      }
      
      public function init() : void
      {
         this.loadSnippets();
         this.setSnippets();
         isInitialized = true;
      }
      
      public function ___Snippets_Button7_click(param1:MouseEvent) : void
      {
         this.setAllGoals();
      }
      
      public function set snippetsTextArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._504392816snippetsTextArea;
         if(_loc2_ !== param1)
         {
            this._504392816snippetsTextArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"snippetsTextArea",_loc2_,param1));
         }
      }
      
      private function setAllGoals(param1:Object = null) : void
      {
         parentDocument.dispatchEvent(new Event(SETALLGOALS));
         this.status.text = "All goals have been set";
      }
      
      private function _Snippets_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = "";
      }
      
      internal function saveAll(param1:Object = null) : void
      {
         if(param1 == null)
         {
            this.status.text = "Save all goals and scripts and various internal data";
            CityManager.cleanUpAndFlushAllTimingLists();
            parentDocument.dispatchEvent(new Event(SAVEALLEVENT));
         }
         else
         {
            this.saveSnippets(true);
         }
      }
      
      public function ___Snippets_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set status(param1:Text) : void
      {
         var _loc2_:Object = this._892481550status;
         if(_loc2_ !== param1)
         {
            this._892481550status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"status",_loc2_,param1));
         }
      }
      
      private function formatTextArea() : void
      {
         this.snippetsTextArea.setStyle("color","#FFFFFF");
         this.snippetsTextArea.setStyle("fontFamily","DejaVu Sans");
      }
      
      [Bindable(event="propertyChange")]
      public function get status() : Text
      {
         return this._892481550status;
      }
      
      private function onSaveToFile() : void
      {
         var outputFileName:String;
         var outputText:String;
         var completedHandler:Function;
         var saveFile:FileReference = null;
         var canceledHandler:Function = null;
         var errorHandler:Function = null;
         if(this.snippetsTextArea == null || this.snippetsTextArea.text == "")
         {
            return;
         }
         outputText = this.snippetsTextArea.text.replace(/\r\n?|\n/g,"\r\n");
         outputFileName = "";
         saveFile = null;
         if(this.lastSavedFileName != null && this.lastSavedFileName != "")
         {
            outputFileName = this.lastSavedFileName;
         }
         else if(this.LastLoadedFileName != null && this.LastLoadedFileName != "")
         {
            outputFileName = this.LastLoadedFileName;
         }
         else
         {
            outputFileName = MainScreen.getPlayer().playerInfo.userName + "_snippets.txt";
         }
         saveFile = new FileReference();
         completedHandler = function(param1:Event):void
         {
            saveFile.removeEventListener(Event.COMPLETE,removeEventListener);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            lastSavedFileName = saveFile.name;
            status.text = "The file \"" + saveFile.name + "\" has been saved successfully.";
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("The Snippets file has been saved successfully. " + param1);
            }
         };
         canceledHandler = function(param1:Event):void
         {
            saveFile.removeEventListener(Event.COMPLETE,removeEventListener);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("The Snippets file save has been canceled. " + param1);
            }
         };
         errorHandler = function(param1:IOErrorEvent):void
         {
            saveFile.removeEventListener(Event.COMPLETE,removeEventListener);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("An error occured while saving the Snippets file. " + param1);
            }
         };
         try
         {
            saveFile.addEventListener(Event.COMPLETE,completedHandler);
            saveFile.addEventListener(Event.CANCEL,canceledHandler);
            saveFile.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile.save(outputText,outputFileName);
         }
         catch(error:Error)
         {
            this.status.text = error;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get snippetsTextArea() : TextArea
      {
         return this._504392816snippetsTextArea;
      }
      
      private function setSnippets(param1:Boolean = false) : void
      {
         var _loc7_:String = null;
         var _loc2_:Array = this.snippetsTextArea.text.split(/\r|\n/);
         var _loc3_:Object = new Object();
         var _loc4_:String = null;
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         for each(_loc7_ in _loc2_)
         {
            _loc7_ = Utils.trim(_loc7_);
            if(_loc7_.charAt(0) == "[" && _loc7_.charAt(_loc7_.length - 1) == "]")
            {
               if(_loc4_ != null)
               {
                  _loc6_.push(_loc4_);
                  _loc3_[_loc4_] = _loc5_;
               }
               _loc4_ = _loc7_.substr(1,_loc7_.length - 2).toLowerCase();
               _loc5_ = new Array();
            }
            else
            {
               _loc5_.push(_loc7_);
            }
         }
         if(_loc4_ != null)
         {
            _loc3_[_loc4_] = _loc5_;
            _loc6_.push(_loc4_);
         }
         this.snippets = _loc3_;
         if(_loc3_["default"] == undefined)
         {
            if(param1)
            {
               this.status.text = "WARNING: [default] snippet is not defined, !!!";
            }
            else
            {
               this.snippetsTextArea.text = DEFAULTTEXT + "\n" + this.snippetsTextArea.text;
               this.setSnippets(true);
            }
         }
         else if(_loc6_.length > 0)
         {
            this.status.text = "Snippet(s) found: " + _loc6_.join(" ");
         }
      }
      
      private function updateTarget(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.snippetsTextArea.text = param1;
      }
      
      private function loadSnippets(param1:Object = null) : void
      {
         var _loc2_:SharedObject = null;
         if(this.snippetsTextArea == null)
         {
            Utils.callLater(50,this.loadSnippets);
         }
         else
         {
            _loc2_ = SharedObject.getLocal("snippets");
            this.snippetsTextArea.text = _loc2_.data.now;
            if(this.snippetsTextArea.text == "")
            {
               this.snippetsTextArea.text = DEFAULTTEXT + "\n" + SAMPLETEXT;
            }
         }
      }
      
      public function ___Snippets_Button1_click(param1:MouseEvent) : void
      {
         this.onSaveToFile();
      }
      
      public function __snippetsTextArea_change(param1:Event) : void
      {
         this.formatTextArea();
      }
   }
}

