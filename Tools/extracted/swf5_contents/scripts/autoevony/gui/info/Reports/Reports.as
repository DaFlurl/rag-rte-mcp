package autoevony.gui.info.Reports
{
   import autoevony.common.ActionFactoryResponse;
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.ReportBean;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.report.ReportListResponse;
   import com.evony.common.module.report.ReportResponse;
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
   import mx.containers.VDividedBox;
   import mx.controls.Button;
   import mx.controls.DataGrid;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Reports extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private const PAGESIZE:int = 10;
      
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
                                 return {"width":15};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___Reports_Button2_click"},
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
                              "id":"myReportPageNo",
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"REmainFormText"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___Reports_Button3_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"nextBtn"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"deleteselected",
                              "events":{"click":"__deleteselected_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Delete"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":10};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"deleteall",
                              "events":{"click":"__deleteall_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Delete All"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":10};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VDividedBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":DataGrid,
                              "id":"dg",
                              "events":{"change":"__dg_change"},
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
                                    "percentHeight":50,
                                    "percentWidth":100,
                                    "resizableColumns":true,
                                    "rowHeight":23,
                                    "selectable":true,
                                    "showHeaders":true,
                                    "sortableColumns":false,
                                    "variableRowHeight":true,
                                    "visible":true,
                                    "wordWrap":false,
                                    "columns":[_Reports_DataGridColumn1_c(),_Reports_DataGridColumn2_c(),_Reports_DataGridColumn3_c(),_Reports_DataGridColumn4_c(),_Reports_DataGridColumn5_c(),_Reports_DataGridColumn6_c()]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"reportInfo",
                              "events":{"link":"__reportInfo_link"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "editable":false,
                                    "enabled":true,
                                    "styleName":"RElogBox",
                                    "percentHeight":50,
                                    "percentWidth":100,
                                    "wordWrap":true
                                 };
                              }
                           })]
                        };
                     }
                  })]};
               }
            })]};
         }
      });
      
      private var _995752784pageNo:int = 1;
      
      mx_internal var _watchers:Array = [];
      
      private var _926048954deleteselected:Button;
      
      private var _1931386510reportType:int;
      
      private var reportPending:int = -1;
      
      private var _3203dg:DataGrid;
      
      private var _577409037totalPage:int = 1;
      
      private var _1148866775jumpto:TextInput;
      
      private var _358707178deleteall:Button;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1472425946reportsArray:ArrayCollection = new ArrayCollection();
      
      private var _838846263update:Button;
      
      private var _1931047938reportInfo:TextArea;
      
      mx_internal var _bindings:Array = [];
      
      private var _250597072myReportPageNo:Label;
      
      private var reportCached:Object = new Object();
      
      public function Reports()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___Reports_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Reports._watcherSetupUtil = param1;
      }
      
      private static function format(param1:String, param2:String, param3:String) : String
      {
         if(param3 == "")
         {
            return "";
         }
         return param1 + " " + param2 + ": " + param3;
      }
      
      [Bindable(event="propertyChange")]
      public function get reportInfo() : TextArea
      {
         return this._1931047938reportInfo;
      }
      
      [Bindable(event="propertyChange")]
      public function get dg() : DataGrid
      {
         return this._3203dg;
      }
      
      private function deleteAll() : void
      {
         ActionFactory.getInstance().getReportCommands().deleteAllReports(this.reportType,this.deleteResponse);
      }
      
      public function set reportInfo(param1:TextArea) : void
      {
         var _loc2_:Object = this._1931047938reportInfo;
         if(_loc2_ !== param1)
         {
            this._1931047938reportInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportInfo",_loc2_,param1));
         }
      }
      
      public function set dg(param1:DataGrid) : void
      {
         var _loc2_:Object = this._3203dg;
         if(_loc2_ !== param1)
         {
            this._3203dg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dg",_loc2_,param1));
         }
      }
      
      public function fetchReport(param1:int) : ActionFactoryResponse
      {
         if(param1 < 0 || param1 > this.reportsArray.length)
         {
            return null;
         }
         if(this.reportCached["xml" + this.reportsArray[param1].id] != undefined)
         {
            return this.reportCached["xml" + this.reportsArray[param1].id];
         }
         ActionFactory.getInstance().getReportCommands().markAsRead(this.reportsArray[param1].id,this._gc827);
         return null;
      }
      
      private function _iy128() : void
      {
         this.pageNo = this.jumpto.text.length > 0 ? int(this.jumpto.text) : 0;
         if(this.pageNo > this.totalPage)
         {
            this.pageNo = this.totalPage;
         }
         if(this.pageNo < 1)
         {
            this.pageNo = 1;
         }
         this.updateData();
      }
      
      private function _Reports_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Type";
         _loc1_.dataField = "typeStr";
         _loc1_.width = 0.075;
         return _loc1_;
      }
      
      private function deleteResponse(param1:CommandResponse) : void
      {
         if(param1.ok == CommandResponse.OK_DEFAULT)
         {
            this.updateData();
            this.reportInfo.htmlText = "";
         }
      }
      
      private function _Reports_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "timeStr";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
         if(this.reportType == ObjConstants.REPORT_TYPE_ARMY)
         {
            addEventListener(Event.RENDER,this._bc516);
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
      
      private function updateData(param1:Object = null) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         if(param1 != null)
         {
            this.pageNo = 1;
         }
         this.fetchPage(this.pageNo);
      }
      
      public function __dg_change(param1:ListEvent) : void
      {
         this._ro876();
      }
      
      public function set reportType(param1:int) : void
      {
         var _loc2_:Object = this._1931386510reportType;
         if(_loc2_ !== param1)
         {
            this._1931386510reportType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportType",_loc2_,param1));
         }
      }
      
      private function _jp80(param1:TextEvent) : void
      {
         navigateToURL(new URLRequest("http://" + param1.text),"_blank");
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Reports = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Reports_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Reports_ReportsWatcherSetupUtil");
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
      
      private function _gc827(param1:ReportResponse) : void
      {
         var _loc6_:String = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            return;
         }
         this._bl149();
         var _loc2_:String = param1.report.attack ? "ATT" : "DEF";
         var _loc3_:XML = new XML(param1.report.content);
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(param1.report.armyType == ObjConstants.ARMY_MISSION_SCOUT)
         {
            _loc4_ = Utils.formatUrl(_loc2_ + " " + param1.report.title + " on " + param1.report.eventTime + " from " + param1.report.startPos + " to " + param1.report.targetPos,_loc3_.@reportUrl);
            if(param1.report.attack && _loc3_.scoutReport.@isSuccess == "true")
            {
               _loc5_ = "  " + CityManager._wd318(_loc3_.scoutReport);
            }
         }
         else if(param1.report.armyType == ObjConstants.ARMY_MISSION_COLONIZE || param1.report.armyType == ObjConstants.ARMY_MISSION_OCCUPY)
         {
            _loc4_ = Utils.formatUrl(_loc2_ + " " + param1.report.title + " on " + param1.report.eventTime + " from " + param1.report.startPos + " to " + param1.report.targetPos,_loc3_.@reportUrl);
            _loc5_ = "  " + Utils.armyReportToString(_loc3_.battleReport);
            _loc5_ = _loc5_ + ("\n " + format("","Honor",_loc3_.battleReport.@honor) + format("","round",_loc3_.battleReport.@round) + format(",","prestige",_loc3_.battleReport.@prestige) + format(",","hero exp",_loc3_.battleReport.@heroExp) + format(",","healing",_loc3_.battleReport.@injuredPer) + format(",","loyalty trend",_loc3_.battleReport.@support) + format(",","outcome",_loc3_.battleReport.@seizeProblem));
            if(_loc3_.battleReport.lootResource.food.toString() != "")
            {
               _loc5_ += "\n  Loot: g:" + _loc3_.battleReport.lootResource.gold + ",f:" + _loc3_.battleReport.lootResource.food + ",w:" + _loc3_.battleReport.lootResource.wood + ",s:" + _loc3_.battleReport.lootResource.stone + ",i:" + _loc3_.battleReport.lootResource.iron;
            }
            if(_loc3_.battleReport.autoHeal.troopUnit.toString() != "")
            {
               _loc5_ += "\n  Auto heal: " + CityManager._ix545(_loc3_.battleReport.autoHeal.troopUnit) + ", gold cost: " + _loc3_.battleReport.autoHeal.@gold;
            }
         }
         else if(param1.report.type == 2)
         {
            _loc6_ = _loc3_.policyReport.@detail;
            if(param1.report.content.indexOf("<") == -1)
            {
               _loc4_ = "@" + param1.report.title + " on " + param1.report.eventTime + " " + param1.report.content;
            }
            else if(_loc6_ != "")
            {
               _loc4_ = "@" + param1.report.title + " on " + param1.report.eventTime + " " + _loc6_;
            }
            else
            {
               _loc4_ = "@" + param1.report.title + " on " + param1.report.eventTime;
               _loc5_ = param1.report.content;
               _loc5_ = _loc5_.split("<").join("[");
               _loc5_ = _loc5_.split(">").join("]");
            }
         }
         this.reportCached[param1.report.id] = Utils.getServerTime();
         this.reportCached["xml" + param1.report.id] = new ActionFactoryResponse(_loc3_);
         this.reportCached["report" + param1.report.id] = _loc4_ + "\n" + _loc5_ + "\n\n" + this.reportCached["xml" + param1.report.id].toDebugString();
         if(this.dg.selectedIndex != -1 && this.dg.selectedItem.id == param1.report.id)
         {
            this.reportsArray[this.dg.selectedIndex].isReadStr = "Y";
            this.dg.invalidateList();
            this.reportInfo.htmlText = this.reportCached["report" + param1.report.id];
         }
      }
      
      public function ___Reports_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get reportType() : int
      {
         return this._1931386510reportType;
      }
      
      private function _Reports_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = "/" + this.totalPage;
         _loc1_ = this.dg.selectedIndex > -1;
         _loc1_ = this.reportsArray.length > 0;
         _loc1_ = this.reportsArray;
      }
      
      private function nextPage() : void
      {
         if(this.pageNo >= this.totalPage)
         {
            return;
         }
         ++this.pageNo;
         this.updateData();
      }
      
      public function ___Reports_Button3_click(param1:MouseEvent) : void
      {
         this.nextPage();
      }
      
      public function __jumpto_enter(param1:FlexEvent) : void
      {
         this._iy128();
      }
      
      public function set reportsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1472425946reportsArray;
         if(_loc2_ !== param1)
         {
            this._1472425946reportsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportsArray",_loc2_,param1));
         }
      }
      
      private function _Reports_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "From";
         _loc1_.dataField = "startPos";
         _loc1_.width = 0.3;
         return _loc1_;
      }
      
      public function __reportInfo_link(param1:TextEvent) : void
      {
         this._jp80(param1);
      }
      
      public function set deleteselected(param1:Button) : void
      {
         var _loc2_:Object = this._926048954deleteselected;
         if(_loc2_ !== param1)
         {
            this._926048954deleteselected = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"deleteselected",_loc2_,param1));
         }
      }
      
      private function _bc516(param1:Object) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         removeEventListener(Event.RENDER,this._bc516);
         this.updateData();
      }
      
      private function _ro876() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            this.reportInfo.htmlText = "";
            return;
         }
         if(this.reportCached["report" + this.dg.selectedItem.id] != undefined)
         {
            this.reportInfo.htmlText = this.reportCached["report" + this.dg.selectedItem.id];
            return;
         }
         this.reportPending = this.dg.selectedItem.id;
         ActionFactory.getInstance().getReportCommands().markAsRead(this.dg.selectedItem.id,this._gc827);
      }
      
      public function __deleteselected_click(param1:MouseEvent) : void
      {
         this.deleteSelected();
      }
      
      public function __deleteall_click(param1:MouseEvent) : void
      {
         this.deleteAll();
      }
      
      [Bindable(event="propertyChange")]
      public function get jumpto() : TextInput
      {
         return this._1148866775jumpto;
      }
      
      public function set myReportPageNo(param1:Label) : void
      {
         var _loc2_:Object = this._250597072myReportPageNo;
         if(_loc2_ !== param1)
         {
            this._250597072myReportPageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myReportPageNo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pageNo() : int
      {
         return this._995752784pageNo;
      }
      
      [Bindable(event="propertyChange")]
      public function get deleteselected() : Button
      {
         return this._926048954deleteselected;
      }
      
      public function set deleteall(param1:Button) : void
      {
         var _loc2_:Object = this._358707178deleteall;
         if(_loc2_ !== param1)
         {
            this._358707178deleteall = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"deleteall",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get deleteall() : Button
      {
         return this._358707178deleteall;
      }
      
      private function _Reports_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Subject";
         _loc1_.dataField = "title";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _Reports_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "To";
         _loc1_.dataField = "targetPos";
         _loc1_.width = 0.3;
         return _loc1_;
      }
      
      private function _la1157(param1:ReportListResponse) : void
      {
         var _loc3_:ReportBean = null;
         this.reportsArray.removeAll();
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            return;
         }
         this.totalPage = param1.totalPage;
         var _loc2_:Object = null;
         for each(_loc3_ in param1.reportsArray)
         {
            _loc2_ = _loc3_.toObject();
            _loc2_.rawData = _loc3_;
            _loc2_.isReadStr = !!_loc3_.isRead ? "Y" : "N";
            _loc2_.typeStr = _loc3_.attack ? "ATT" : "DEF";
            _loc2_.timeStr = _loc3_.eventTime;
            this.reportsArray.addItem(_loc2_);
         }
      }
      
      private function _Reports_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Read";
         _loc1_.dataField = "isReadStr";
         _loc1_.width = 0.075;
         return _loc1_;
      }
      
      public function toDebugString() : String
      {
         return "field: reportsArray, method: fetchPage(int) fetchReport(int), columns: isReadStr typeStr title startPos targetPos timeStr rawData";
      }
      
      private function _ng881() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            return;
         }
         this.reportsArray.removeItemAt(this.dg.selectedIndex);
         ActionFactory.getInstance().getReportCommands().deleteReport("" + this.dg.selectedItem.id);
      }
      
      private function _mg723() : void
      {
         if(this.pageNo <= 1)
         {
            return;
         }
         --this.pageNo;
         this.updateData();
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
      
      public function set jumpto(param1:TextInput) : void
      {
         var _loc2_:Object = this._1148866775jumpto;
         if(_loc2_ !== param1)
         {
            this._1148866775jumpto = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"jumpto",_loc2_,param1));
         }
      }
      
      private function deleteSelected() : void
      {
         if(this.dg.selectedIndex != -1)
         {
            ActionFactory.getInstance().getReportCommands().deleteReport(this.dg.selectedItem.id,this.deleteResponse);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get myReportPageNo() : Label
      {
         return this._250597072myReportPageNo;
      }
      
      public function fetchPage(param1:int) : void
      {
         ActionFactory.getInstance().getReportCommands().receiveReportList(param1,this.PAGESIZE,this.reportType,this._la1157);
         this.jumpto.text = "" + param1;
         this.pageNo = param1;
      }
      
      public function ___Reports_Button2_click(param1:MouseEvent) : void
      {
         this._mg723();
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      private function _bl149() : void
      {
         var _loc2_:String = null;
         var _loc1_:Number = Utils.getServerTime() - 3600 * 1000;
         for(_loc2_ in this.reportCached)
         {
            if(String(_loc2_).indexOf("report") != 0)
            {
               if(this.reportCached[_loc2_] < _loc1_)
               {
                  delete this.reportCached[_loc2_];
                  delete this.reportCached["report" + _loc2_];
                  delete this.reportCached["xml" + _loc2_];
               }
            }
         }
      }
      
      private function _Reports_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "/" + this.totalPage;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            myReportPageNo.text = param1;
         },"myReportPageNo.text");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.dg.selectedIndex > -1;
         },function(param1:Boolean):void
         {
            deleteselected.enabled = param1;
         },"deleteselected.enabled");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.reportsArray.length > 0;
         },function(param1:Boolean):void
         {
            deleteall.enabled = param1;
         },"deleteall.enabled");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return this.reportsArray;
         },function(param1:Object):void
         {
            dg.dataProvider = param1;
         },"dg.dataProvider");
         result[3] = binding;
         return result;
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
      
      public function __update_click(param1:MouseEvent) : void
      {
         this._iy128();
      }
      
      [Bindable(event="propertyChange")]
      public function get totalPage() : int
      {
         return this._577409037totalPage;
      }
      
      [Bindable(event="propertyChange")]
      public function get reportsArray() : ArrayCollection
      {
         return this._1472425946reportsArray;
      }
   }
}

