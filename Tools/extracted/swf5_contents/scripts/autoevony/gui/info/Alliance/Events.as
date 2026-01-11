package autoevony.gui.info.Alliance
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.AllianceEvent;
   import com.evony.common.module.alliance.AllianceEventListResponse;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.DataGrid;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.DateFormatter;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Events extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1765123250formatDateTime:DateFormatter;
      
      mx_internal var _watchers:Array = [];
      
      private var _995752784pageNo:int = 1;
      
      private var _577409037totalPage:int = 1;
      
      private var _1148866775jumpto:TextInput;
      
      private var _1955651121_AllianceEvents_DataGrid1:DataGrid;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _838846263update:Button;
      
      private var _976185536eventsArray:ArrayCollection = new ArrayCollection();
      
      private var _833068973_WarReportPageNo:Label;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":VBox,
               "stylesFactory":function():void
               {
                  this.horizontalGap = 0;
                  this.verticalGap = 0;
                  this.left = "3";
                  this.right = "3";
                  this.top = "0";
                  this.bottom = "3";
               },
               "propertiesFactory":function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "middle";
                        this.verticalGap = 0;
                        this.horizontalGap = 2;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":32,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":10};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"update",
                              "events":{"click":"__update_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"refreshBtn",
                                    "toolTip":"Refresh"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___Events_Button2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"previousBtn"};
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"jumpto",
                              "events":{"enter":"__jumpto_enter"},
                              "stylesFactory":function():void
                              {
                                 this.textAlign = "right";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "restrict":"0-9",
                                    "maxChars":5,
                                    "width":48,
                                    "toolTip":"Enter page number to jump to that page."
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"_WarReportPageNo",
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"REmainFormText"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___Events_Button3_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"nextBtn"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":5};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DataGrid,
                     "id":"_AllianceEvents_DataGrid1",
                     "stylesFactory":function():void
                     {
                        this.headerStyleName = "columnHeaderSyle";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "styleName":"REdataGrid",
                           "allowDragSelection":false,
                           "allowMultipleSelection":false,
                           "doubleClickEnabled":false,
                           "dragEnabled":false,
                           "draggableColumns":false,
                           "editable":false,
                           "enabled":true,
                           "horizontalScrollPolicy":"off",
                           "minHeight":50,
                           "percentHeight":100,
                           "percentWidth":100,
                           "resizableColumns":true,
                           "rowHeight":23,
                           "selectable":false,
                           "showHeaders":true,
                           "sortableColumns":false,
                           "variableRowHeight":true,
                           "visible":true,
                           "wordWrap":false,
                           "columns":[_Events_DataGridColumn1_c(),_Events_DataGridColumn2_c()]
                        };
                     }
                  })]};
               }
            })]};
         }
      });
      
      public function Events()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._Events_DateFormatter1_i();
         this.addEventListener("creationComplete",this.___Events_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Events._watcherSetupUtil = param1;
      }
      
      public function set eventsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._976185536eventsArray;
         if(_loc2_ !== param1)
         {
            this._976185536eventsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"eventsArray",_loc2_,param1));
         }
      }
      
      internal function _iy128() : void
      {
         this.pageNo = Utils.hasValue(this.jumpto.text) ? int(this.jumpto.text) : 0;
         if(this.pageNo >= this.totalPage)
         {
            this.pageNo = this.totalPage;
         }
         if(this.pageNo <= 1)
         {
            this.pageNo = 1;
         }
         this.updateData();
      }
      
      private function _Events_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Event";
         _loc1_.dataField = "eventName";
         _loc1_.width = 0.77;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      internal function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
      }
      
      internal function updateData(param1:Object = null) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         if(MainScreen.getPlayer().playerInfo.alliance != null)
         {
            if(param1 != null)
            {
               this.pageNo = 1;
            }
            this.fetchPage(this.pageNo);
         }
         else
         {
            this.eventsArray.removeAll();
         }
      }
      
      public function set update(param1:Button) : void
      {
         var _loc2_:Object = this._838846263update;
         if(_loc2_ !== param1)
         {
            this._838846263update = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"update",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Events = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Events_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_EventsWatcherSetupUtil");
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
      
      private function _Events_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = "/" + this.totalPage;
         _loc1_ = this.eventsArray;
      }
      
      public function ___Events_Button2_click(param1:MouseEvent) : void
      {
         this.previousPage();
      }
      
      internal function previousPage() : void
      {
         if(this.pageNo <= 1)
         {
            return;
         }
         --this.pageNo;
         this.updateData();
      }
      
      public function __jumpto_enter(param1:FlexEvent) : void
      {
         this._iy128();
      }
      
      [Bindable(event="propertyChange")]
      public function get _WarReportPageNo() : Label
      {
         return this._833068973_WarReportPageNo;
      }
      
      [Bindable(event="propertyChange")]
      public function get jumpto() : TextInput
      {
         return this._1148866775jumpto;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceEvents_DataGrid1() : DataGrid
      {
         return this._1955651121_AllianceEvents_DataGrid1;
      }
      
      [Bindable(event="propertyChange")]
      public function get formatDateTime() : DateFormatter
      {
         return this._1765123250formatDateTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get pageNo() : int
      {
         return this._995752784pageNo;
      }
      
      [Bindable(event="propertyChange")]
      public function get eventsArray() : ArrayCollection
      {
         return this._976185536eventsArray;
      }
      
      internal function nextPage() : void
      {
         if(this.pageNo >= this.totalPage)
         {
            return;
         }
         ++this.pageNo;
         this.updateData();
      }
      
      private function _Events_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "timeStr";
         _loc1_.width = 0.23;
         return _loc1_;
      }
      
      private function _Events_DateFormatter1_i() : DateFormatter
      {
         var _loc1_:DateFormatter = new DateFormatter();
         this.formatDateTime = _loc1_;
         _loc1_.formatString = "MM/DD/YY JJ:NN:SS";
         return _loc1_;
      }
      
      public function toDebugString() : String
      {
         return "fields: eventsArray pageNo totalPage, method: fetchPage(int), columns: timeStr eventName rawData";
      }
      
      internal function _vm184(param1:AllianceEventListResponse) : void
      {
         var _loc3_:AllianceEvent = null;
         this.eventsArray.removeAll();
         if(param1.ok != 1)
         {
            return;
         }
         this.totalPage = param1.totalPage;
         var _loc2_:Object = null;
         for each(_loc3_ in param1.eventsArray)
         {
            _loc2_ = _loc3_.toObject();
            _loc2_.rawData = _loc3_;
            _loc2_.timeStr = this.formatDateTime.format(new Date(_loc3_.time).toString());
            this.eventsArray.addItem(_loc2_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      public function set jumpto(param1:TextInput) : void
      {
         var _loc2_:Object = this._1148866775jumpto;
         if(_loc2_ !== param1)
         {
            this._1148866775jumpto = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"jumpto",_loc2_,param1));
         }
      }
      
      public function set _WarReportPageNo(param1:Label) : void
      {
         var _loc2_:Object = this._833068973_WarReportPageNo;
         if(_loc2_ !== param1)
         {
            this._833068973_WarReportPageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_WarReportPageNo",_loc2_,param1));
         }
      }
      
      public function set pageNo(param1:int) : void
      {
         var _loc2_:Object = this._995752784pageNo;
         if(_loc2_ !== param1)
         {
            this._995752784pageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pageNo",_loc2_,param1));
         }
      }
      
      public function set _AllianceEvents_DataGrid1(param1:DataGrid) : void
      {
         var _loc2_:Object = this._1955651121_AllianceEvents_DataGrid1;
         if(_loc2_ !== param1)
         {
            this._1955651121_AllianceEvents_DataGrid1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceEvents_DataGrid1",_loc2_,param1));
         }
      }
      
      public function ___Events_Button3_click(param1:MouseEvent) : void
      {
         this.nextPage();
      }
      
      public function set formatDateTime(param1:DateFormatter) : void
      {
         var _loc2_:Object = this._1765123250formatDateTime;
         if(_loc2_ !== param1)
         {
            this._1765123250formatDateTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"formatDateTime",_loc2_,param1));
         }
      }
      
      public function ___Events_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set totalPage(param1:int) : void
      {
         var _loc2_:Object = this._577409037totalPage;
         if(_loc2_ !== param1)
         {
            this._577409037totalPage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"totalPage",_loc2_,param1));
         }
      }
      
      private function _Events_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "/" + this.totalPage;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _WarReportPageNo.text = param1;
         },"_WarReportPageNo.text");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return eventsArray;
         },function(param1:Object):void
         {
            _AllianceEvents_DataGrid1.dataProvider = param1;
         },"_AllianceEvents_DataGrid1.dataProvider");
         result[1] = binding;
         return result;
      }
      
      public function fetchPage(param1:int) : void
      {
         ActionFactory.getInstance().getAllianceCommands().getAllianceEventList(param1,this._vm184);
         this.pageNo = param1;
         this.jumpto.text = "" + this.pageNo;
      }
      
      public function __update_click(param1:MouseEvent) : void
      {
         this._iy128();
      }
      
      [Bindable(event="propertyChange")]
      public function get totalPage() : int
      {
         return this._577409037totalPage;
      }
   }
}

