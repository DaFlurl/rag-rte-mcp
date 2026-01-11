package autoevony.gui.info.Stats
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.gui.info.FormatPopulation_inlineComponent0;
   import autoevony.gui.info.FormatRank_inlineComponent0;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.RankCastleBean;
   import com.evony.common.module.rank.RankCastleResponse;
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
   import mx.controls.ComboBox;
   import mx.controls.DataGrid;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class Cities extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private const PAGESIZE:int = 10;
      
      private var _554043283_searchRankingBtn:Button;
      
      private var _496803498beansArray:ArrayCollection = new ArrayCollection();
      
      private var _1190618133_StatHeroesPageNo:Label;
      
      private var _1511170927_searchRanking:TextInput;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var key:String = "";
      
      private var _254798002sortTypeInput:ComboBox;
      
      mx_internal var _watchers:Array = [];
      
      private var _1223883875_AllianceInfo_ClassFactory0:ClassFactory;
      
      private var _995752784pageNo:int = 1;
      
      private var _480636075keyInput:TextInput;
      
      private var lastSortType:int;
      
      private var _791587407keyInputBtn:Button;
      
      private var _1223883878_AllianceInfo_ClassFactory3:ClassFactory;
      
      private var _577409037totalPage:int = 1;
      
      private const sortKeysArray:ArrayCollection = new ArrayCollection(new Array("Population","Level"));
      
      private var _1148866775jumpto:TextInput;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _60930046_StatCities_DataGrid1:DataGrid;
      
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
                              "id":"_searchRanking",
                              "events":{"enter":"___searchRanking_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":60,
                                    "maxChars":6,
                                    "restrict":"0-9",
                                    "toolTip":"Enter ranking value to search for."
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"_searchRankingBtn",
                              "events":{"click":"___searchRankingBtn_click"},
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
                                 return {"width":7};
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"keyInput",
                              "events":{"enter":"__keyInput_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":80,
                                    "maxChars":10,
                                    "toolTip":"Enter player name to search for."
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"keyInputBtn",
                              "events":{"click":"__keyInputBtn_click"},
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
                                 return {"width":7};
                              }
                           }),new UIComponentDescriptor({
                              "type":ComboBox,
                              "id":"sortTypeInput",
                              "events":{"change":"__sortTypeInput_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"ComboBox",
                                    "height":22
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
                              "events":{"click":"___Cities_Button3_click"},
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
                              "id":"_StatHeroesPageNo",
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"REmainFormText"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___Cities_Button4_click"},
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
                     "id":"_StatCities_DataGrid1",
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
                           "columns":[_Cities_DataGridColumn1_c(),_Cities_DataGridColumn2_c(),_Cities_DataGridColumn3_c(),_Cities_DataGridColumn4_c(),_Cities_DataGridColumn5_c(),_Cities_DataGridColumn6_c()]
                        };
                     }
                  })]};
               }
            })]};
         }
      });
      
      private var lastKey:String = this.key;
      
      private var sortType:int = 1;
      
      public function Cities()
      {
         this.lastSortType = this.sortType;
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___Cities_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Cities._watcherSetupUtil = param1;
      }
      
      private function _iy128() : void
      {
         this.pageNo = Utils.hasValue(this.jumpto.text) ? int(this.jumpto.text) : 0;
         this.key = Utils.trim(this.keyInput.text);
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
      
      private function updateData(param1:Object = null) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         this.sortType = this.sortTypeInput.selectedIndex + 1;
         if(this.lastKey != this.key || this.lastSortType != this.sortType)
         {
            this.pageNo = 1;
         }
         if(param1 != null)
         {
            this.pageNo = 1;
         }
         this.keyInput.setFocus();
         this.fetchPage(this.pageNo,this.sortType,this.key);
         this.lastKey = this.key;
         this.lastSortType = this.sortType;
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
      }
      
      private function _Cities_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.sortKeysArray;
         },function(param1:Object):void
         {
            sortTypeInput.dataProvider = param1;
         },"sortTypeInput.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "/" + this.totalPage;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _StatHeroesPageNo.text = param1;
         },"_StatHeroesPageNo.text");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return this.beansArray;
         },function(param1:Object):void
         {
            _StatCities_DataGrid1.dataProvider = param1;
         },"_StatCities_DataGrid1.dataProvider");
         result[2] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatRank_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceInfo_ClassFactory0.generator = param1;
         },"_AllianceInfo_ClassFactory0.generator");
         result[3] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatPopulation_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceInfo_ClassFactory3.generator = param1;
         },"_AllianceInfo_ClassFactory3.generator");
         result[4] = binding;
         return result;
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
      
      public function __keyInput_enter(param1:FlexEvent) : void
      {
         this._iy128();
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
      
      public function __jumpto_enter(param1:FlexEvent) : void
      {
         this._iy128();
      }
      
      private function _Cities_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceInfo_ClassFactory3 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceInfo_ClassFactory3",this._AllianceInfo_ClassFactory3);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get jumpto() : TextInput
      {
         return this._1148866775jumpto;
      }
      
      private function _Cities_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Name";
         _loc1_.dataField = "name";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      private function _ld288(param1:RankCastleResponse) : void
      {
         var _loc3_:RankCastleBean = null;
         this.beansArray.removeAll();
         if(param1.ok != 1)
         {
            return;
         }
         this.totalPage = param1.totalPage;
         var _loc2_:ObjectProxy = null;
         for each(_loc3_ in param1.beansArray)
         {
            _loc2_ = new ObjectProxy(_loc3_.toObject());
            _loc2_.rawData = _loc3_;
            this.beansArray.addItem(_loc2_);
         }
      }
      
      private function _Cities_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Population";
         _loc1_.dataField = "population";
         _loc1_.width = 0.15;
         _loc1_.itemRenderer = this._Cities_ClassFactory2_i();
         return _loc1_;
      }
      
      private function _Cities_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceInfo_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceInfo_ClassFactory0",this._AllianceInfo_ClassFactory0);
         return _loc1_;
      }
      
      public function ___searchRankingBtn_click(param1:MouseEvent) : void
      {
         this._iy128();
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
      
      public function set keyInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._480636075keyInput;
         if(_loc2_ !== param1)
         {
            this._480636075keyInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"keyInput",_loc2_,param1));
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
      
      public function set keyInputBtn(param1:Button) : void
      {
         var _loc2_:Object = this._791587407keyInputBtn;
         if(_loc2_ !== param1)
         {
            this._791587407keyInputBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"keyInputBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_ClassFactory0() : ClassFactory
      {
         return this._1223883875_AllianceInfo_ClassFactory0;
      }
      
      public function set sortTypeInput(param1:ComboBox) : void
      {
         var _loc2_:Object = this._254798002sortTypeInput;
         if(_loc2_ !== param1)
         {
            this._254798002sortTypeInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sortTypeInput",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get beansArray() : ArrayCollection
      {
         return this._496803498beansArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_ClassFactory3() : ClassFactory
      {
         return this._1223883878_AllianceInfo_ClassFactory3;
      }
      
      public function fetchPage(param1:int, param2:int = 1, param3:String = "") : void
      {
         ActionFactory.getInstance().getRankCommands().getCastleRank(param3,param1,this.PAGESIZE,param2,this._ld288);
         this.jumpto.text = "" + param1;
         this.sortTypeInput.selectedIndex = param2 - 1;
         this.keyInput.text = param3;
         this.keyInput.setSelection(0,param3.length);
      }
      
      [Bindable(event="propertyChange")]
      public function get _searchRankingBtn() : Button
      {
         return this._554043283_searchRankingBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _searchRanking() : TextInput
      {
         return this._1511170927_searchRanking;
      }
      
      private function _Cities_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Rank";
         _loc1_.dataField = "rank";
         _loc1_.width = 0.1;
         _loc1_.itemRenderer = this._Cities_ClassFactory1_i();
         return _loc1_;
      }
      
      private function _Cities_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Alliance";
         _loc1_.dataField = "alliance";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Cities = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Cities_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Stats_CitiesWatcherSetupUtil");
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
      
      public function __keyInputBtn_click(param1:MouseEvent) : void
      {
         this._iy128();
      }
      
      public function ___Cities_Button3_click(param1:MouseEvent) : void
      {
         this.previousPage();
      }
      
      [Bindable(event="propertyChange")]
      public function get keyInput() : TextInput
      {
         return this._480636075keyInput;
      }
      
      public function set beansArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._496803498beansArray;
         if(_loc2_ !== param1)
         {
            this._496803498beansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"beansArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get pageNo() : int
      {
         return this._995752784pageNo;
      }
      
      [Bindable(event="propertyChange")]
      public function get keyInputBtn() : Button
      {
         return this._791587407keyInputBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get sortTypeInput() : ComboBox
      {
         return this._254798002sortTypeInput;
      }
      
      public function ___Cities_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function _Cities_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Lord";
         _loc1_.dataField = "kind";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      public function __sortTypeInput_change(param1:ListEvent) : void
      {
         this._iy128();
      }
      
      public function set _AllianceInfo_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1223883875_AllianceInfo_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._1223883875_AllianceInfo_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function toDebugString() : String
      {
         return "fields: beansArray pageNo totalPage, method: fetchPage(int,[int],[String])" + ", colums: rank name level kind alliance population rawData";
      }
      
      public function set _AllianceInfo_ClassFactory3(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1223883878_AllianceInfo_ClassFactory3;
         if(_loc2_ !== param1)
         {
            this._1223883878_AllianceInfo_ClassFactory3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_ClassFactory3",_loc2_,param1));
         }
      }
      
      public function ___Cities_Button4_click(param1:MouseEvent) : void
      {
         this.nextPage();
      }
      
      public function set _StatHeroesPageNo(param1:Label) : void
      {
         var _loc2_:Object = this._1190618133_StatHeroesPageNo;
         if(_loc2_ !== param1)
         {
            this._1190618133_StatHeroesPageNo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_StatHeroesPageNo",_loc2_,param1));
         }
      }
      
      public function set _searchRankingBtn(param1:Button) : void
      {
         var _loc2_:Object = this._554043283_searchRankingBtn;
         if(_loc2_ !== param1)
         {
            this._554043283_searchRankingBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_searchRankingBtn",_loc2_,param1));
         }
      }
      
      public function set _searchRanking(param1:TextInput) : void
      {
         var _loc2_:Object = this._1511170927_searchRanking;
         if(_loc2_ !== param1)
         {
            this._1511170927_searchRanking = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_searchRanking",_loc2_,param1));
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
      
      public function ___searchRanking_enter(param1:FlexEvent) : void
      {
         this._iy128();
      }
      
      [Bindable(event="propertyChange")]
      public function get _StatHeroesPageNo() : Label
      {
         return this._1190618133_StatHeroesPageNo;
      }
      
      private function _Cities_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.sortKeysArray;
         _loc1_ = "/" + this.totalPage;
         _loc1_ = this.beansArray;
         _loc1_ = FormatRank_inlineComponent0;
         _loc1_ = FormatPopulation_inlineComponent0;
      }
      
      [Bindable(event="propertyChange")]
      public function get totalPage() : int
      {
         return this._577409037totalPage;
      }
      
      private function _Cities_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level";
         _loc1_.dataField = "level";
         _loc1_.width = 0.15;
         return _loc1_;
      }
      
      public function set _StatCities_DataGrid1(param1:DataGrid) : void
      {
         var _loc2_:Object = this._60930046_StatCities_DataGrid1;
         if(_loc2_ !== param1)
         {
            this._60930046_StatCities_DataGrid1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_StatCities_DataGrid1",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _StatCities_DataGrid1() : DataGrid
      {
         return this._60930046_StatCities_DataGrid1;
      }
   }
}

