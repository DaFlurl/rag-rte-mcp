package autoevony.gui.info.Alliance
{
   import autoevony.common.ActionFactoryResponse;
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.management.CityManager;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.MilitarySituation;
   import com.evony.common.module.alliance.MilitarySituationListResponse;
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
   
   public class WarReport extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _watchers:Array = [];
      
      private const PAGESIZE:int = 10;
      
      private var _995752784pageNo:int = 1;
      
      private var _313472292situationsArray:ArrayCollection = new ArrayCollection();
      
      private var _3203dg:DataGrid;
      
      private var _577409037totalPage:int = 1;
      
      private var _1148866775jumpto:TextInput;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _838846263update:Button;
      
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
                              "events":{"click":"___WarReport_Button2_click"},
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
                              "events":{"click":"___WarReport_Button3_click"},
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
                     "type":VDividedBox,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
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
                                    "minHeight":30,
                                    "percentHeight":55,
                                    "percentWidth":100,
                                    "resizableColumns":true,
                                    "rowHeight":23,
                                    "selectable":true,
                                    "showHeaders":true,
                                    "sortableColumns":false,
                                    "variableRowHeight":true,
                                    "visible":true,
                                    "wordWrap":false,
                                    "columns":[_WarReport_DataGridColumn1_c(),_WarReport_DataGridColumn2_c(),_WarReport_DataGridColumn3_c(),_WarReport_DataGridColumn4_c()]
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
                                    "percentHeight":45,
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
      
      private var _1931047938reportInfo:TextArea;
      
      public function WarReport()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___WarReport_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         WarReport._watcherSetupUtil = param1;
      }
      
      private static function format(param1:String, param2:String, param3:String) : String
      {
         if(param3 == "")
         {
            return "";
         }
         return param1 + " " + param2 + ": " + param3;
      }
      
      public function ___WarReport_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
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
      
      private function _WarReport_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Subject";
         _loc1_.dataField = "eventName";
         _loc1_.width = 0.63;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _iy128() : void
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
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:WarReport = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._WarReport_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_WarReportWatcherSetupUtil");
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
      
      private function updateData(param1:Object = null) : void
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
            this.situationsArray.removeAll();
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
      
      public function __dg_change(param1:ListEvent) : void
      {
         this._ro876();
      }
      
      private function _jp80(param1:TextEvent) : void
      {
         navigateToURL(new URLRequest("http://" + param1.text),"_blank");
      }
      
      private function nextPage() : void
      {
         if(this.pageNo >= this.totalPage)
         {
            return;
         }
         this.pageNo += 1;
         this.updateData();
      }
      
      [Bindable(event="propertyChange")]
      public function get situationsArray() : ArrayCollection
      {
         return this._313472292situationsArray;
      }
      
      private function previousPage() : void
      {
         if(this.pageNo <= 1)
         {
            return;
         }
         --this.pageNo;
         this.updateData();
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
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
      
      public function ___WarReport_Button3_click(param1:MouseEvent) : void
      {
         this.nextPage();
      }
      
      [Bindable(event="propertyChange")]
      public function get jumpto() : TextInput
      {
         return this._1148866775jumpto;
      }
      
      public function __reportInfo_link(param1:TextEvent) : void
      {
         this._jp80(param1);
      }
      
      private function _ro876() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            this.reportInfo.htmlText = "";
            return;
         }
         this.reportInfo.htmlText = this.dg.selectedItem.info + "\n\n\n" + this.dg.selectedItem.xml.toDebugString();
      }
      
      private function _WarReport_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "timeStr";
         _loc1_.width = 0.3;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get pageNo() : int
      {
         return this._995752784pageNo;
      }
      
      public function set situationsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._313472292situationsArray;
         if(_loc2_ !== param1)
         {
            this._313472292situationsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"situationsArray",_loc2_,param1));
         }
      }
      
      private function _WarReport_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Type";
         _loc1_.dataField = "typeStr";
         _loc1_.width = 0.12;
         return _loc1_;
      }
      
      private function _WarReport_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Other alliances";
         _loc1_.dataField = "otherAllianceName";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function toDebugString() : String
      {
         return "fields: situationsArray pageNo totalPage, method: fetchPage(int), columns: typeStr eventName otherAllianceName xml rawData";
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
      
      public function set pageNo(param1:int) : void
      {
         var _loc2_:Object = this._995752784pageNo;
         if(_loc2_ !== param1)
         {
            this._995752784pageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pageNo",_loc2_,param1));
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
      
      public function set totalPage(param1:int) : void
      {
         var _loc2_:Object = this._577409037totalPage;
         if(_loc2_ !== param1)
         {
            this._577409037totalPage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"totalPage",_loc2_,param1));
         }
      }
      
      public function ___WarReport_Button2_click(param1:MouseEvent) : void
      {
         this.previousPage();
      }
      
      private function _WarReport_bindingsSetup() : Array
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
            return this.situationsArray;
         },function(param1:Object):void
         {
            dg.dataProvider = param1;
         },"dg.dataProvider");
         result[1] = binding;
         return result;
      }
      
      public function fetchPage(param1:int) : void
      {
         this.pageNo = param1;
         ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(this.pageNo,this.PAGESIZE,this._ma393);
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
      
      private function _ma393(param1:MilitarySituationListResponse) : void
      {
         var _loc5_:MilitarySituation = null;
         this.situationsArray.removeAll();
         if(param1.ok != 1)
         {
            return;
         }
         var _loc2_:Object = null;
         var _loc3_:XML = null;
         var _loc4_:String = null;
         this.totalPage = param1.totalPage;
         for each(_loc5_ in param1.situationsArray)
         {
            _loc2_ = _loc5_.toObject();
            _loc2_.rawData = _loc5_;
            _loc3_ = new XML(_loc5_.xml_data);
            _loc2_.xml = new ActionFactoryResponse(_loc3_);
            _loc2_.typeStr = _loc5_.attack ? "ATT" : "DEF";
            if(_loc5_.startPos.length > 0)
            {
               _loc2_.eventName = _loc5_.startPos + " " + _loc5_.eventName;
            }
            _loc2_.timeStr = _loc5_.time;
            _loc4_ = Utils.armyReportToString(_loc3_.battleReport,true);
            _loc4_ = _loc4_ + ("\n\n " + format("","Honor",_loc3_.battleReport.@honor) + format("","round",_loc3_.battleReport.@round) + format(",","prestige",_loc3_.battleReport.@prestige) + format(",","hero exp",_loc3_.battleReport.@heroExp) + format(",","healing",_loc3_.battleReport.@injuredPer) + format(",","loyalty trend",_loc3_.battleReport.@support) + format(",","outcome",_loc3_.battleReport.@seizeProblem));
            if(_loc3_.battleReport.lootResource.food.toString() != "")
            {
               _loc4_ += "\n  Loot: g:" + _loc3_.battleReport.lootResource.gold + ",f:" + _loc3_.battleReport.lootResource.food + ",w:" + _loc3_.battleReport.lootResource.wood + ",s:" + _loc3_.battleReport.lootResource.stone + ",i:" + _loc3_.battleReport.lootResource.iron;
            }
            if(_loc3_.battleReport.autoHeal.troopUnit.toString() != "")
            {
               _loc4_ += "\n  Auto heal: " + CityManager._ix545(_loc3_.battleReport.autoHeal.troopUnit) + ", gold cost: " + _loc3_.battleReport.autoHeal.@gold;
            }
            _loc2_.info = Utils.formatUrl(_loc2_.typeStr + " " + _loc5_.otherAllianceName + " " + _loc5_.eventName + " on " + _loc5_.time + "  from " + _loc5_.startPos + " " + _loc3_.battleReport.attackTroop.@king + " to " + _loc5_.targetPos + " " + _loc3_.battleReport.defendTroop.@king,_loc3_.@reportUrl) + "<br><br>" + _loc4_;
            this.situationsArray.addItem(_loc2_);
         }
      }
      
      private function _WarReport_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = "/" + this.totalPage;
         _loc1_ = this.situationsArray;
      }
   }
}

