package autoevony.gui.info
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.SimpleNpcHeroBean;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.module.npchero.NpcHeroListResponse;
   import com.evony.common.module.quest.QuestListResponse;
   import com.evony.common.module.rank.RankHeroResponse;
   import com.evony.common.module.rank.RankPlayerResponse;
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
   
   public class HistoricalHeroes extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _619242552heroInfo:TextArea;
      
      private var playerStatsPageNumber:int = 1;
      
      private var _1439439020_HistoricalHeroes_DataGrid2:DataGrid;
      
      mx_internal var _watchers:Array = [];
      
      private var _480636075keyInput:TextInput;
      
      private var heroCached:Object = new Object();
      
      private var pendingItem:SimpleNpcHeroBean = null;
      
      private var selectedItem:SimpleNpcHeroBean = null;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _61177572hearsayArray:ArrayCollection = new ArrayCollection();
      
      private var _566991471searchArray:ArrayCollection = new ArrayCollection();
      
      private var key:String = "";
      
      private var _838846263update:Button;
      
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
                              "id":"keyInput",
                              "events":{"enter":"__keyInput_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "maxChars":30,
                                    "width":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"update",
                              "events":{"click":"__update_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Search"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":30};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___HistoricalHeroes_Button2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Hearsay"
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
                              "events":{"click":"___HistoricalHeroes_Button3_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Buy Details"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___HistoricalHeroes_Button4_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"REwinBtn",
                                    "label":"Accept Task"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "bottom";
                        this.verticalGap = 0;
                        this.horizontalGap = 2;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "width":200,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":DataGrid,
                                       "id":"_HistoricalHeroes_DataGrid1",
                                       "events":{"change":"___HistoricalHeroes_DataGrid1_change"},
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
                                             "selectable":true,
                                             "showHeaders":true,
                                             "sortableColumns":true,
                                             "variableRowHeight":true,
                                             "visible":true,
                                             "wordWrap":false,
                                             "columns":[_HistoricalHeroes_DataGridColumn1_c()]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":DataGrid,
                                       "id":"_HistoricalHeroes_DataGrid2",
                                       "events":{"change":"___HistoricalHeroes_DataGrid2_change"},
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
                                             "selectable":true,
                                             "showHeaders":true,
                                             "sortableColumns":true,
                                             "variableRowHeight":true,
                                             "visible":true,
                                             "wordWrap":false,
                                             "columns":[_HistoricalHeroes_DataGridColumn2_c()]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":VBox,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentHeight":100,
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":TextArea,
                                       "id":"heroInfo",
                                       "stylesFactory":function():void
                                       {
                                          this.fontFamily = "DejaVu Sans";
                                          this.fontSize = 12;
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "percentHeight":100,
                                             "editable":false,
                                             "styleName":"txtAreaStyle"
                                          };
                                       }
                                    })]
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
      
      private var _1439439021_HistoricalHeroes_DataGrid1:DataGrid;
      
      public function HistoricalHeroes()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___HistoricalHeroes_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         HistoricalHeroes._watcherSetupUtil = param1;
      }
      
      public function ownerInfo(param1:SimpleNpcHeroBean) : String
      {
         if(this.heroCached["hero" + param1.npcid] != undefined)
         {
            return this.heroCached["hero" + param1.npcid];
         }
         this.pendingItem = param1;
         ActionFactory.getInstance().getRankCommands().getHeroRank(param1.name,1,10,1,this.fncGetHeroStatsInfo);
         return null;
      }
      
      private function _HistoricalHeroes_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Search";
         _loc1_.dataField = "name";
         return _loc1_;
      }
      
      public function ___HistoricalHeroes_DataGrid1_change(param1:ListEvent) : void
      {
         this._ia1257(param1);
      }
      
      private function _en1274(param1:QuestListResponse) : void
      {
         if(param1.ok != 1)
         {
            this._jm820("Capture historical hero quest failed: " + param1.msg + "\n\n" + this.heroInfo.text,this.selectedItem);
         }
         else
         {
            this._jm820("Capture historical hero quest created" + "\n\n" + this.heroInfo.text,this.selectedItem);
         }
      }
      
      private function _HistoricalHeroes_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.hearsayArray;
         _loc1_ = this.searchArray;
      }
      
      private function _en178() : void
      {
         var _loc1_:Number = Utils.getServerTime() - 3600 * 1000;
         var _loc2_:String = null;
         for(_loc2_ in this.heroCached)
         {
            if(_loc2_.indexOf("hero") != 0)
            {
               if(this.heroCached[_loc2_] < _loc1_)
               {
                  delete this.heroCached[_loc2_];
                  delete this.heroCached["hero" + _loc2_];
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _HistoricalHeroes_DataGrid2() : DataGrid
      {
         return this._1439439020_HistoricalHeroes_DataGrid2;
      }
      
      [Bindable(event="propertyChange")]
      public function get searchArray() : ArrayCollection
      {
         return this._566991471searchArray;
      }
      
      private function fncGetOwnerStatsInfo(param1:RankPlayerResponse) : void
      {
         if(param1.ok != 1)
         {
            this.playerStatsPageNumber = 1;
            return;
         }
         if(this.pendingItem == null)
         {
            this.playerStatsPageNumber = 1;
            return;
         }
         var _loc2_:* = null;
         var _loc3_:* = "\n";
         var _loc4_:String = this.heroCached["hero" + this.pendingItem.npcid];
         var _loc5_:String = _loc4_.substring(_loc4_.indexOf("Owner: ") + 7,_loc4_.indexOf(",  Level: "));
         var _loc6_:Array = ["Civilian","Knight","Baronet","Baron","Viscount","Earl","Marquis","Duke","Furstin","Prinzessin"];
         if(Version.isTraceOn())
         {
            trace(_loc5_);
         }
         for each(_loc2_ in param1.beansArray)
         {
            if(Version.isTraceOn())
            {
               trace(_loc2_.toString());
            }
            if(_loc2_.userName == _loc5_)
            {
               _loc3_ = _loc3_ + "\nAlliance: " + _loc2_.alliance + ",  Rank: " + _loc2_.ranking + ",  Prestige: " + _loc2_.prestige + ",  Honor: " + _loc2_.honor + ",  \nStarSet: " + _loc2_.starlv + ",  Cities: " + _loc2_.castleCount + ",  Population: " + _loc2_.population + ",  Title: " + _loc6_[_loc2_.titleId] + ",  \nOffice: " + _loc2_.office + ",  Flag: " + _loc2_.flag + "\n";
               break;
            }
         }
         if(_loc3_ == "")
         {
            this.playerStatsPageNumber += 1;
            ActionFactory.getInstance().getRankCommands().getPlayerRank(_loc5_,this.playerStatsPageNumber,10,2,this.fncGetOwnerStatsInfo);
            return;
         }
         this.playerStatsPageNumber = 1;
         this._en178();
         this.heroCached[this.pendingItem.npcid] = Utils.getServerTime();
         this.heroCached["hero" + this.pendingItem.npcid] = _loc4_ + _loc3_;
         if(this.pendingItem == this.selectedItem)
         {
            this.displayHero(this.selectedItem);
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:HistoricalHeroes = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._HistoricalHeroes_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_HistoricalHeroesWatcherSetupUtil");
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
      
      public function set update(param1:Button) : void
      {
         var _loc2_:Object = this._838846263update;
         if(_loc2_ !== param1)
         {
            this._838846263update = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"update",_loc2_,param1));
         }
      }
      
      public function ___HistoricalHeroes_Button2_click(param1:MouseEvent) : void
      {
         this.hearsay();
      }
      
      public function ___HistoricalHeroes_Button4_click(param1:MouseEvent) : void
      {
         this.acceptTask();
      }
      
      private function _dy970() : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         this.key = Utils.trim(this.keyInput.text);
         this.keyInput.text = this.key;
         this.keyInput.setSelection(0,this.key.length);
         this.keyInput.setFocus();
         var _loc1_:* = this.getCastleIdWithValidInn();
         if(_loc1_ == -1)
         {
            this._jm820("You need an inn level 5 or higher!");
            return;
         }
         ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByFilter(this.key,_loc1_,this._qn461);
      }
      
      private function fncGetHeroStatsInfo(param1:RankHeroResponse) : void
      {
         var _loc4_:* = undefined;
         if(param1.ok != 1)
         {
            return;
         }
         if(this.pendingItem == null)
         {
            return;
         }
         var _loc2_:String = null;
         var _loc3_:* = "";
         for each(_loc4_ in param1.beansArray)
         {
            if(_loc4_.name == this.pendingItem.name)
            {
               _loc2_ = "Owner: " + _loc4_.kind + ",  Level: " + _loc4_.grade + ",  Stats(Pol/Att/Int):" + _loc4_.management + "/" + _loc4_.power + "/" + _loc4_.stratagem;
               if(_loc4_.grade > 100)
               {
                  _loc3_ = _loc2_;
                  break;
               }
               if(_loc3_ != "")
               {
                  _loc3_ += "\n";
               }
               _loc3_ += _loc2_;
            }
         }
         if(_loc3_ == "")
         {
            _loc3_ = "none";
         }
         this._en178();
         this.heroCached[this.pendingItem.npcid] = Utils.getServerTime();
         this.heroCached["hero" + this.pendingItem.npcid] = _loc3_;
         if(this.pendingItem == this.selectedItem)
         {
            this.displayHero(this.selectedItem);
         }
         this.playerStatsPageNumber = 1;
         ActionFactory.getInstance().getRankCommands().getPlayerRank(_loc4_.kind,this.playerStatsPageNumber,10,2,this.fncGetOwnerStatsInfo);
      }
      
      public function set searchArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._566991471searchArray;
         if(_loc2_ !== param1)
         {
            this._566991471searchArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"searchArray",_loc2_,param1));
         }
      }
      
      public function __keyInput_enter(param1:FlexEvent) : void
      {
         this._dy970();
      }
      
      public function set _HistoricalHeroes_DataGrid1(param1:DataGrid) : void
      {
         var _loc2_:Object = this._1439439021_HistoricalHeroes_DataGrid1;
         if(_loc2_ !== param1)
         {
            this._1439439021_HistoricalHeroes_DataGrid1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_HistoricalHeroes_DataGrid1",_loc2_,param1));
         }
      }
      
      public function search(param1:String = "") : void
      {
         this.keyInput.text = param1;
         this._dy970();
      }
      
      [Bindable(event="propertyChange")]
      public function get keyInput() : TextInput
      {
         return this._480636075keyInput;
      }
      
      public function set _HistoricalHeroes_DataGrid2(param1:DataGrid) : void
      {
         var _loc2_:Object = this._1439439020_HistoricalHeroes_DataGrid2;
         if(_loc2_ !== param1)
         {
            this._1439439020_HistoricalHeroes_DataGrid2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_HistoricalHeroes_DataGrid2",_loc2_,param1));
         }
      }
      
      public function freeHearsay(param1:Object = null) : void
      {
         removeEventListener(FlexEvent.SHOW,this.freeHearsay);
         var _loc2_:int = this.getCastleIdWithValidInn();
         if(_loc2_ == -1)
         {
            this._jm820("You need an inn level 5 or higher!");
            return;
         }
         ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosList(_loc2_,this._nr1016);
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.freeHearsay);
      }
      
      public function acceptTask() : void
      {
         var _loc1_:int = this.getCastleIdWithValidInn();
         if(_loc1_ == -1)
         {
            this._jm820("You need an inn level 5 or higher!");
            return;
         }
         if(this.selectedItem == null)
         {
            return;
         }
         ActionFactory.getInstance().getQuestCommands().accept(this.selectedItem.npcid,_loc1_,this._en1274);
      }
      
      private function _ia1257(param1:ListEvent) : void
      {
         this.displayHero(param1.currentTarget.dataProvider[param1.rowIndex]);
      }
      
      public function hearsay() : void
      {
         var _loc1_:int = this.getCastleIdWithValidInn();
         if(_loc1_ == -1)
         {
            this._jm820("You need an inn level 5 or higher!");
            return;
         }
         ActionFactory.getInstance().getNpcHeroCommand().getNpcHerosListByMoney(_loc1_,this._nr1016);
      }
      
      private function _wk155(param1:NpcHeroListResponse) : void
      {
         var _loc4_:SimpleNpcHeroBean = null;
         var _loc5_:SimpleNpcHeroBean = null;
         if(param1.ok != 1)
         {
            this._jm820("Error: " + param1.msg);
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = true;
         for each(_loc4_ in param1.simpleNpcHerosArray)
         {
            _loc2_ = false;
            for each(_loc5_ in this.searchArray)
            {
               if(_loc2_)
               {
                  break;
               }
               if(_loc5_.npcid == _loc4_.npcid)
               {
                  _loc2_ = true;
                  _loc5_.introduce = _loc4_.introduce;
                  _loc5_.introduce2 = _loc4_.introduce2;
               }
            }
            for each(_loc5_ in this.hearsayArray)
            {
               if(_loc2_)
               {
                  break;
               }
               if(_loc5_.npcid == _loc4_.npcid)
               {
                  _loc2_ = true;
                  _loc5_.introduce = _loc4_.introduce;
                  _loc5_.introduce2 = _loc4_.introduce2;
               }
            }
            if(!_loc2_)
            {
               this.searchArray.addItem(_loc4_);
            }
            if(_loc3_)
            {
               this.displayHero(_loc4_);
            }
            _loc3_ = false;
         }
      }
      
      public function set hearsayArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._61177572hearsayArray;
         if(_loc2_ !== param1)
         {
            this._61177572hearsayArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hearsayArray",_loc2_,param1));
         }
      }
      
      private function _HistoricalHeroes_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Hearsay";
         _loc1_.dataField = "name";
         return _loc1_;
      }
      
      private function _qn461(param1:NpcHeroListResponse) : void
      {
         var _loc2_:* = undefined;
         if(param1.ok != 1)
         {
            this._jm820("Error: " + param1.msg);
            return;
         }
         this.searchArray.removeAll();
         for each(_loc2_ in param1.simpleNpcHerosArray)
         {
            this.searchArray.addItem(_loc2_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get heroInfo() : TextArea
      {
         return this._619242552heroInfo;
      }
      
      public function toDebugString() : String
      {
         return "field: searchArray, hearsayArray, method: search([String]), hearsay(), freeHearsay(), displayHero(SimpleNpcHeroBean), buyDetails([int]), acceptTask(), ownerInfo(SimpleNpcHeroBean)";
      }
      
      public function ___HistoricalHeroes_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      private function _jm820(param1:String, param2:SimpleNpcHeroBean = null) : void
      {
         this.heroInfo.text = param1;
         this.selectedItem = param2;
      }
      
      public function set heroInfo(param1:TextArea) : void
      {
         var _loc2_:Object = this._619242552heroInfo;
         if(_loc2_ !== param1)
         {
            this._619242552heroInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroInfo",_loc2_,param1));
         }
      }
      
      public function ___HistoricalHeroes_DataGrid2_change(param1:ListEvent) : void
      {
         this._ia1257(param1);
      }
      
      public function buyDetails(param1:int = -1) : void
      {
         var _loc2_:int = this.getCastleIdWithValidInn();
         if(_loc2_ == -1)
         {
            this._jm820("You need an inn level 5 or higher!");
            return;
         }
         if(param1 == -1 && this.selectedItem != null)
         {
            param1 = this.selectedItem.npcid;
         }
         if(param1 == -1)
         {
            return;
         }
         ActionFactory.getInstance().getNpcHeroCommand().getNpcHeroInfroByID(param1,_loc2_,this._wk155);
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
      
      private function _HistoricalHeroes_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return hearsayArray;
         },function(param1:Object):void
         {
            _HistoricalHeroes_DataGrid1.dataProvider = param1;
         },"_HistoricalHeroes_DataGrid1.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return searchArray;
         },function(param1:Object):void
         {
            _HistoricalHeroes_DataGrid2.dataProvider = param1;
         },"_HistoricalHeroes_DataGrid2.dataProvider");
         result[1] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _HistoricalHeroes_DataGrid1() : DataGrid
      {
         return this._1439439021_HistoricalHeroes_DataGrid1;
      }
      
      private function _nr1016(param1:NpcHeroListResponse) : void
      {
         var _loc2_:* = undefined;
         if(param1.ok != 1)
         {
            this._jm820("Error: " + param1.msg);
            return;
         }
         this.hearsayArray.removeAll();
         for each(_loc2_ in param1.simpleNpcHerosArray)
         {
            this.hearsayArray.addItem(_loc2_);
         }
      }
      
      public function displayHero(param1:SimpleNpcHeroBean) : void
      {
         var _loc2_:String = "\n" + param1.name + ", id: " + param1.npcid;
         if(this.heroCached["hero" + param1.npcid] == undefined)
         {
            this.pendingItem = param1;
            ActionFactory.getInstance().getRankCommands().getHeroRank(param1.name,1,10,1,this.fncGetHeroStatsInfo);
         }
         else
         {
            _loc2_ += "\n\n[OWNERSHIP]  (from Statistics)\n" + this.heroCached["hero" + param1.npcid];
         }
         _loc2_ += "\n\n[INN KEEPER]\n" + param1.introduce2 + "\n\n[HISTORY]\n" + param1.introduce;
         this._jm820(_loc2_,param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get hearsayArray() : ArrayCollection
      {
         return this._61177572hearsayArray;
      }
      
      public function __update_click(param1:MouseEvent) : void
      {
         this._dy970();
      }
      
      public function ___HistoricalHeroes_Button3_click(param1:MouseEvent) : void
      {
         this.buyDetails();
      }
      
      private function getCastleIdWithValidInn() : int
      {
         var _loc4_:CityState = null;
         var _loc1_:int = 0;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         for each(_loc4_ in MainScreen.getCities())
         {
            _loc1_ = int(_loc4_.cityManager.getBuildingLevel(BuildingConstants.TYPE_TAVERN));
            if(_loc1_ >= 5)
            {
               if(_loc1_ == 10)
               {
                  return _loc4_.castle.id;
               }
               if(_loc3_ < _loc1_)
               {
                  _loc3_ = _loc1_;
                  _loc2_ = _loc4_.castle.id;
               }
            }
         }
         return _loc2_;
      }
   }
}

