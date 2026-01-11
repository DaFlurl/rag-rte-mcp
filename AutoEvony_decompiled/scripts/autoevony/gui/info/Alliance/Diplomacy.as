package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.info.FormatHonor_inlineComponent0;
   import autoevony.gui.info.FormatPrestige_inlineComponent0;
   import autoevony.gui.info.FormatRank_inlineComponent0;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.UnitAlliance;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceFriendshipResponse;
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
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.DataGrid;
   import mx.controls.Spacer;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class Diplomacy extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1452549567relationListArray:ArrayCollection = new ArrayCollection();
      
      private var _1366077706memberLevel:int = 0;
      
      private var _1191572447selector:ViewStack;
      
      mx_internal var _watchers:Array = [];
      
      private var _208958744_AllianceDiplo_ClassFactory1:ClassFactory;
      
      private var _208958745_AllianceDiplo_ClassFactory2:ClassFactory;
      
      private var _208958743_AllianceDiplo_ClassFactory0:ClassFactory;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _1412433860_MyAlliance_DataGrid1:DataGrid;
      
      private var _838846263update:Button;
      
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
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":5};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"selector",
                     "stylesFactory":function():void
                     {
                        this.borderStyle = "none";
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
                                    "percentWidth":100,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":DataGrid,
                                       "id":"_MyAlliance_DataGrid1",
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
                                             "columns":[_Diplomacy_DataGridColumn1_c(),_Diplomacy_DataGridColumn2_c(),_Diplomacy_DataGridColumn3_c(),_Diplomacy_DataGridColumn4_c(),_Diplomacy_DataGridColumn5_c(),_Diplomacy_DataGridColumn6_c(),_Diplomacy_DataGridColumn7_c(),_Diplomacy_DataGridColumn8_c()]
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
      
      mx_internal var _bindings:Array = [];
      
      public var _Diplomacy_ClassFactory4:ClassFactory;
      
      public function Diplomacy()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___Diplomacy_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Diplomacy._watcherSetupUtil = param1;
      }
      
      private function _Diplomacy_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceDiplo_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceDiplo_ClassFactory0",this._AllianceDiplo_ClassFactory0);
         return _loc1_;
      }
      
      private function _Diplomacy_ClassFactory3_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceDiplo_ClassFactory2 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceDiplo_ClassFactory2",this._AllianceDiplo_ClassFactory2);
         return _loc1_;
      }
      
      private function _Diplomacy_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.relationListArray;
         },function(param1:Object):void
         {
            _MyAlliance_DataGrid1.dataProvider = param1;
         },"_MyAlliance_DataGrid1.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatRank_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceDiplo_ClassFactory0.generator = param1;
         },"_AllianceDiplo_ClassFactory0.generator");
         result[1] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatPrestige_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceDiplo_ClassFactory1.generator = param1;
         },"_AllianceDiplo_ClassFactory1.generator");
         result[2] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatHonor_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceDiplo_ClassFactory2.generator = param1;
         },"_AllianceDiplo_ClassFactory2.generator");
         result[3] = binding;
         binding = new Binding(this,function():Class
         {
            return CancelDiploBtn_inlineComponent0;
         },function(param1:Class):void
         {
            _Diplomacy_ClassFactory4.generator = param1;
         },"_Diplomacy_ClassFactory4.generator");
         result[4] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      private function get memberLevel() : int
      {
         return this._1366077706memberLevel;
      }
      
      public function set relationListArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1452549567relationListArray;
         if(_loc2_ !== param1)
         {
            this._1452549567relationListArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"relationListArray",_loc2_,param1));
         }
      }
      
      public function set _MyAlliance_DataGrid1(param1:DataGrid) : void
      {
         var _loc2_:Object = this._1412433860_MyAlliance_DataGrid1;
         if(_loc2_ !== param1)
         {
            this._1412433860_MyAlliance_DataGrid1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_MyAlliance_DataGrid1",_loc2_,param1));
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
         if(MainScreen.getPlayer().playerInfo.alliance != null)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
         }
         else
         {
            this.relationListArray.removeAll();
         }
      }
      
      public function cancelRelation(param1:Object) : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().dropAllianceFriendshipRelation(param1["allianceName"]);
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Diplomacy = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Diplomacy_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_DiplomacyWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      public function get _AllianceDiplo_ClassFactory2() : ClassFactory
      {
         return this._208958745_AllianceDiplo_ClassFactory2;
      }
      
      private function handleAllianceFriendshipResponse(param1:AllianceFriendshipResponse) : void
      {
         var _loc3_:UnitAlliance = null;
         if(param1.ok != 1)
         {
            return;
         }
         var _loc2_:ObjectProxy = null;
         this.relationListArray.removeAll();
         for each(_loc3_ in param1.friendlyListArray)
         {
            _loc2_ = new ObjectProxy(_loc3_.toObject());
            _loc2_.relation = "Friendly";
            _loc2_.prestige = _loc3_.aPrestigeCount;
            _loc2_.showCancelBtn = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE;
            this.relationListArray.addItem(_loc2_);
         }
         for each(_loc3_ in param1.middleListArray)
         {
            _loc2_ = new ObjectProxy(_loc3_.toObject());
            _loc2_.relation = "Neutral";
            _loc2_.prestige = _loc3_.aPrestigeCount;
            _loc2_.showCancelBtn = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE;
            this.relationListArray.addItem(_loc2_);
         }
         for each(_loc3_ in param1.enemyListArray)
         {
            _loc2_ = new ObjectProxy(_loc3_.toObject());
            _loc2_.relation = "Hostile";
            _loc2_.prestige = _loc3_.aPrestigeCount;
            _loc2_.showCancelBtn = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE;
            this.relationListArray.addItem(_loc2_);
         }
      }
      
      private function onDropAllianceFriendshipRelation(param1:AllianceFriendshipResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Diplomatic relationship is cancelled successfully."));
            ActionFactory.getInstance().getAllianceManagementCommands().getAllianceFriendshipList();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceDiplo_ClassFactory0() : ClassFactory
      {
         return this._208958743_AllianceDiplo_ClassFactory0;
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST,this.handleAllianceFriendshipResponse);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION,this.onDropAllianceFriendshipRelation);
         if(MainScreen.getPlayer() != null && MainScreen.getPlayer().playerInfo.alliance != null)
         {
            this.setMemberLevel(MainScreen.getPlayer().playerInfo.levelId);
         }
         addEventListener(FlexEvent.SHOW,this.updateData);
         addEventListener(Event.RENDER,this._bc516);
      }
      
      private function set memberLevel(param1:int) : void
      {
         var _loc2_:Object = this._1366077706memberLevel;
         if(_loc2_ !== param1)
         {
            this._1366077706memberLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"memberLevel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceDiplo_ClassFactory1() : ClassFactory
      {
         return this._208958744_AllianceDiplo_ClassFactory1;
      }
      
      private function _Diplomacy_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Relation";
         _loc1_.dataField = "relation";
         _loc1_.width = 0.18;
         return _loc1_;
      }
      
      private function _Diplomacy_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Members";
         _loc1_.dataField = "memberCount";
         _loc1_.width = 0.15;
         return _loc1_;
      }
      
      public function set _AllianceDiplo_ClassFactory2(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._208958745_AllianceDiplo_ClassFactory2;
         if(_loc2_ !== param1)
         {
            this._208958745_AllianceDiplo_ClassFactory2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceDiplo_ClassFactory2",_loc2_,param1));
         }
      }
      
      private function _Diplomacy_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "prestige";
         _loc1_.width = 0.25;
         _loc1_.itemRenderer = this._Diplomacy_ClassFactory2_i();
         return _loc1_;
      }
      
      private function _Diplomacy_DataGridColumn8_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = " ";
         _loc1_.dataField = "allianceName";
         _loc1_.width = 0.2;
         _loc1_.itemRenderer = this._Diplomacy_ClassFactory4_i();
         return _loc1_;
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
      
      public function set _AllianceDiplo_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._208958743_AllianceDiplo_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._208958743_AllianceDiplo_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceDiplo_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function set selector(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1191572447selector;
         if(_loc2_ !== param1)
         {
            this._1191572447selector = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selector",_loc2_,param1));
         }
      }
      
      private function _Diplomacy_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceDiplo_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceDiplo_ClassFactory1",this._AllianceDiplo_ClassFactory1);
         return _loc1_;
      }
      
      public function setMemberLevel(param1:int) : void
      {
         this.memberLevel = param1;
         this.updateData();
      }
      
      public function toDebugString() : String
      {
         return "fields: relationListArray allianceAddPlayerbyLeaderInfoBeanListArray allianceWanted, method: fetchPage(), columns: allianceName relation rank memberCount leaderName prestige honor rawData";
      }
      
      [Bindable(event="propertyChange")]
      public function get _MyAlliance_DataGrid1() : DataGrid
      {
         return this._1412433860_MyAlliance_DataGrid1;
      }
      
      private function _Diplomacy_ClassFactory4_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._Diplomacy_ClassFactory4 = _loc1_;
         BindingManager.executeBindings(this,"_Diplomacy_ClassFactory4",this._Diplomacy_ClassFactory4);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get relationListArray() : ArrayCollection
      {
         return this._1452549567relationListArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      public function set _AllianceDiplo_ClassFactory1(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._208958744_AllianceDiplo_ClassFactory1;
         if(_loc2_ !== param1)
         {
            this._208958744_AllianceDiplo_ClassFactory1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceDiplo_ClassFactory1",_loc2_,param1));
         }
      }
      
      private function _Diplomacy_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.relationListArray;
         _loc1_ = FormatRank_inlineComponent0;
         _loc1_ = FormatPrestige_inlineComponent0;
         _loc1_ = FormatHonor_inlineComponent0;
         _loc1_ = CancelDiploBtn_inlineComponent0;
      }
      
      public function ___Diplomacy_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get selector() : ViewStack
      {
         return this._1191572447selector;
      }
      
      private function _Diplomacy_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Alliance";
         _loc1_.dataField = "allianceName";
         _loc1_.width = 0.22;
         return _loc1_;
      }
      
      private function _Diplomacy_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Rank";
         _loc1_.dataField = "rank";
         _loc1_.width = 0.15;
         _loc1_.itemRenderer = this._Diplomacy_ClassFactory1_i();
         return _loc1_;
      }
      
      private function _Diplomacy_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Host";
         _loc1_.dataField = "leaderName";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      private function _Diplomacy_DataGridColumn7_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Honor";
         _loc1_.dataField = "honor";
         _loc1_.width = 0.25;
         _loc1_.itemRenderer = this._Diplomacy_ClassFactory3_i();
         return _loc1_;
      }
      
      public function fetchPage() : void
      {
         this.updateData();
      }
      
      public function __update_click(param1:MouseEvent) : void
      {
         this.updateData();
      }
   }
}

