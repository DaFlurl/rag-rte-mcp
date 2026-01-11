package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.info.FormatPrestige_inlineComponent0;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.RankAllianceBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.rank.RankAllianceResponse;
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
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class AllianceList extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var rankType:int = 2;
      
      private var _855813086currentAllianceListPageNo:Label;
      
      private var _630897339_allianceList_DataGrid:DataGrid;
      
      private var _1424234899allianceListPageFwdBtn:Button;
      
      private var _956867668_AllianceList_ClassFactory1:ClassFactory;
      
      private var _1616225942orderSearch:Button;
      
      mx_internal var _watchers:Array = [];
      
      private var pageSize:int = 10;
      
      private var _956867667_AllianceList_ClassFactory0:ClassFactory;
      
      private var _1557013386allianceListPageBckBtn:Button;
      
      private var _577409037totalPage:int = 0;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _1488198711orderNumber:TextInput;
      
      private var _391766279orderName:TextInput;
      
      private var _1320771561curPageNum:int = 1;
      
      private var _762218477nameSearch:Button;
      
      private var _1760738206allianceArray:ArrayCollection = new ArrayCollection();
      
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
                              "type":TextInput,
                              "id":"orderNumber",
                              "events":{"enter":"__orderNumber_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":60,
                                    "maxChars":6,
                                    "restrict":"0-9"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"orderSearch",
                              "events":{"click":"__orderSearch_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Ranking",
                                    "styleName":"REwinBtn"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":5};
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"orderName",
                              "events":{"enter":"__orderName_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":80,
                                    "maxChars":8
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"nameSearch",
                              "events":{"click":"__nameSearch_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Name",
                                    "styleName":"REwinBtn"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":5};
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"percentWidth":100};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"allianceListPageBckBtn",
                              "events":{"click":"__allianceListPageBckBtn_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"previousBtn"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "id":"currentAllianceListPageNo",
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"REmainFormText"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"allianceListPageFwdBtn",
                              "events":{"click":"__allianceListPageFwdBtn_click"},
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
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalGap = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":DataGrid,
                              "id":"_allianceList_DataGrid",
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
                                    "columns":[_AllianceList_DataGridColumn1_c(),_AllianceList_DataGridColumn2_c(),_AllianceList_DataGridColumn3_c(),_AllianceList_DataGridColumn4_c(),_AllianceList_DataGridColumn5_c(),_AllianceList_DataGridColumn6_c(),_AllianceList_DataGridColumn7_c()]
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
      
      public function AllianceList()
      {
         super();
         mx_internal::_document = this;
         this.label = "Alliance List";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___AllianceList_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AllianceList._watcherSetupUtil = param1;
      }
      
      private function _AllianceList_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.curPageNum + "/" + this.totalPage;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            currentAllianceListPageNo.text = param1;
         },"currentAllianceListPageNo.text");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return this.allianceArray;
         },function(param1:Object):void
         {
            _allianceList_DataGrid.dataProvider = param1;
         },"_allianceList_DataGrid.dataProvider");
         result[1] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatPrestige_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceList_ClassFactory0.generator = param1;
         },"_AllianceList_ClassFactory0.generator");
         result[2] = binding;
         binding = new Binding(this,function():Class
         {
            return ViewBtn_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceList_ClassFactory1.generator = param1;
         },"_AllianceList_ClassFactory1.generator");
         result[3] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceListPageBckBtn() : Button
      {
         return this._1557013386allianceListPageBckBtn;
      }
      
      private function _AllianceList_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.curPageNum + "/" + this.totalPage;
         _loc1_ = this.allianceArray;
         _loc1_ = FormatPrestige_inlineComponent0;
         _loc1_ = ViewBtn_inlineComponent0;
      }
      
      private function populateAllianceList(param1:Object = null) : void
      {
         if(this.allianceArray == null || this.allianceArray.length == 0)
         {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null,this.curPageNum,this.pageSize,this.rankType,this.onGetAllianceRank);
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AllianceList = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AllianceList_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceListWatcherSetupUtil");
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
      
      public function __allianceListPageFwdBtn_click(param1:MouseEvent) : void
      {
         this.turnPage("next");
      }
      
      [Bindable(event="propertyChange")]
      public function get curPageNum() : int
      {
         return this._1320771561curPageNum;
      }
      
      private function init() : void
      {
         this.addEventListener(FlexEvent.SHOW,this.updateData);
         this.addEventListener(Event.RENDER,this.onRender);
      }
      
      private function onGetAllianceRank(param1:RankAllianceResponse) : void
      {
         if(param1.ok == CommandResponse.OK_DEFAULT)
         {
            this.allianceArray = param1.beansArray;
            this.totalPage = param1.totalPage;
            this.curPageNum = int(param1.pageNo);
         }
      }
      
      private function _AllianceList_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Alliance";
         _loc1_.dataField = "name";
         _loc1_.width = 0.15;
         return _loc1_;
      }
      
      private function searchOrderByNumber() : void
      {
         var _loc1_:int = 0;
         if(this.orderNumber.text != "")
         {
            _loc1_ = 0;
            if(this.orderNumber.length > 7)
            {
               _loc1_ = this.totalPage;
            }
            else
            {
               _loc1_ = Math.ceil(int(this.orderNumber.text) / this.pageSize);
            }
            if(_loc1_ >= this.totalPage)
            {
               _loc1_ = this.totalPage;
            }
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null,_loc1_,this.pageSize,this.rankType,this.onGetAllianceRank);
         }
      }
      
      private function _AllianceList_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Founder";
         _loc1_.dataField = "createrName";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function searchOrderByName() : void
      {
         if(this.orderName.text != "")
         {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(this.orderName.text,1,this.pageSize,this.rankType,this.onGetAllianceRank);
         }
         else
         {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null,1,this.pageSize,this.rankType,this.onGetAllianceRank);
         }
      }
      
      private function _AllianceList_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "prestige";
         _loc1_.width = 0.2;
         _loc1_.itemRenderer = this._AllianceList_ClassFactory1_i();
         return _loc1_;
      }
      
      private function turnPage(param1:String) : void
      {
         if(param1 == "pre" && this.curPageNum > 1)
         {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null,int(--this.curPageNum),this.pageSize,this.rankType,this.onGetAllianceRank);
         }
         else if(param1 == "next" && this.curPageNum < this.totalPage)
         {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null,int(++this.curPageNum),this.pageSize,this.rankType,this.onGetAllianceRank);
         }
      }
      
      public function set _AllianceList_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._956867667_AllianceList_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._956867667_AllianceList_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceList_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function set _AllianceList_ClassFactory1(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._956867668_AllianceList_ClassFactory1;
         if(_loc2_ !== param1)
         {
            this._956867668_AllianceList_ClassFactory1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceList_ClassFactory1",_loc2_,param1));
         }
      }
      
      public function __orderName_enter(param1:FlexEvent) : void
      {
         this.onRankBtnClick(param1);
      }
      
      private function updateData(param1:Object = null) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         this.populateAllianceList();
      }
      
      [Bindable(event="propertyChange")]
      public function get orderNumber() : TextInput
      {
         return this._1488198711orderNumber;
      }
      
      private function _AllianceList_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceList_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceList_ClassFactory1",this._AllianceList_ClassFactory1);
         return _loc1_;
      }
      
      public function __nameSearch_click(param1:MouseEvent) : void
      {
         this.onRankBtnClick(param1);
      }
      
      public function set curPageNum(param1:int) : void
      {
         var _loc2_:Object = this._1320771561curPageNum;
         if(_loc2_ !== param1)
         {
            this._1320771561curPageNum = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curPageNum",_loc2_,param1));
         }
      }
      
      private function _AllianceList_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceList_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceList_ClassFactory0",this._AllianceList_ClassFactory0);
         return _loc1_;
      }
      
      public function __orderSearch_click(param1:MouseEvent) : void
      {
         this.onRankBtnClick(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get nameSearch() : Button
      {
         return this._762218477nameSearch;
      }
      
      [Bindable(event="propertyChange")]
      public function get _allianceList_DataGrid() : DataGrid
      {
         return this._630897339_allianceList_DataGrid;
      }
      
      public function set currentAllianceListPageNo(param1:Label) : void
      {
         var _loc2_:Object = this._855813086currentAllianceListPageNo;
         if(_loc2_ !== param1)
         {
            this._855813086currentAllianceListPageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentAllianceListPageNo",_loc2_,param1));
         }
      }
      
      public function set nameSearch(param1:Button) : void
      {
         var _loc2_:Object = this._762218477nameSearch;
         if(_loc2_ !== param1)
         {
            this._762218477nameSearch = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"nameSearch",_loc2_,param1));
         }
      }
      
      public function ___AllianceList_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set allianceArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1760738206allianceArray;
         if(_loc2_ !== param1)
         {
            this._1760738206allianceArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get orderSearch() : Button
      {
         return this._1616225942orderSearch;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceList_ClassFactory0() : ClassFactory
      {
         return this._956867667_AllianceList_ClassFactory0;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceList_ClassFactory1() : ClassFactory
      {
         return this._956867668_AllianceList_ClassFactory1;
      }
      
      private function onRankBtnClick(param1:Object) : void
      {
         if(param1.currentTarget != this.orderSearch && param1.currentTarget != this.orderNumber)
         {
            if(param1.currentTarget == this.nameSearch || param1.currentTarget == this.orderName)
            {
               this.searchOrderByName();
            }
         }
         else
         {
            if(this.orderNumber.text == "" || int(this.orderNumber.text) == 0)
            {
               return;
            }
            this.searchOrderByNumber();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get currentAllianceListPageNo() : Label
      {
         return this._855813086currentAllianceListPageNo;
      }
      
      public function __allianceListPageBckBtn_click(param1:MouseEvent) : void
      {
         this.turnPage("pre");
      }
      
      public function set allianceListPageFwdBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1424234899allianceListPageFwdBtn;
         if(_loc2_ !== param1)
         {
            this._1424234899allianceListPageFwdBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceListPageFwdBtn",_loc2_,param1));
         }
      }
      
      private function onRender(param1:Object) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         this.removeEventListener(Event.RENDER,this.onRender);
         this.updateData();
      }
      
      public function set orderSearch(param1:Button) : void
      {
         var _loc2_:Object = this._1616225942orderSearch;
         if(_loc2_ !== param1)
         {
            this._1616225942orderSearch = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"orderSearch",_loc2_,param1));
         }
      }
      
      private function _AllianceList_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Host";
         _loc1_.dataField = "playerName";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _AllianceList_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Members";
         _loc1_.dataField = "member";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceArray() : ArrayCollection
      {
         return this._1760738206allianceArray;
      }
      
      private function _AllianceList_DataGridColumn7_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "View";
         _loc1_.dataField = "name";
         _loc1_.width = 0.12;
         _loc1_.itemRenderer = this._AllianceList_ClassFactory2_i();
         return _loc1_;
      }
      
      private function _AllianceList_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Ranking";
         _loc1_.dataField = "rank";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      public function set orderNumber(param1:TextInput) : void
      {
         var _loc2_:Object = this._1488198711orderNumber;
         if(_loc2_ !== param1)
         {
            this._1488198711orderNumber = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"orderNumber",_loc2_,param1));
         }
      }
      
      public function __orderNumber_enter(param1:FlexEvent) : void
      {
         this.onRankBtnClick(param1);
      }
      
      public function set orderName(param1:TextInput) : void
      {
         var _loc2_:Object = this._391766279orderName;
         if(_loc2_ !== param1)
         {
            this._391766279orderName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"orderName",_loc2_,param1));
         }
      }
      
      public function set allianceListPageBckBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1557013386allianceListPageBckBtn;
         if(_loc2_ !== param1)
         {
            this._1557013386allianceListPageBckBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceListPageBckBtn",_loc2_,param1));
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
      
      [Bindable(event="propertyChange")]
      public function get orderName() : TextInput
      {
         return this._391766279orderName;
      }
      
      [Bindable(event="propertyChange")]
      public function get totalPage() : int
      {
         return this._577409037totalPage;
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceListPageFwdBtn() : Button
      {
         return this._1424234899allianceListPageFwdBtn;
      }
      
      public function set _allianceList_DataGrid(param1:DataGrid) : void
      {
         var _loc2_:Object = this._630897339_allianceList_DataGrid;
         if(_loc2_ !== param1)
         {
            this._630897339_allianceList_DataGrid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_allianceList_DataGrid",_loc2_,param1));
         }
      }
      
      public function showAllianceInfoMsg(param1:Object) : void
      {
         var _loc2_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_INFO_WIN);
         _loc2_.objParam = RankAllianceBean(param1).toObject();
         dispatchEvent(_loc2_);
      }
   }
}

