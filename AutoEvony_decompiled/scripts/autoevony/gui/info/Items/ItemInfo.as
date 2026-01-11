package autoevony.gui.info.Items
{
   import autoevony.common.Items;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import com.evony.common.beans.ItemBean;
   import com.evony.eum.ItemEum;
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
   
   use namespace mx_internal;
   
   public class ItemInfo extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _watchers:Array = [];
      
      private var _1948713978filterOptions:ArrayCollection = new ArrayCollection([{
         "label":"All",
         "data":null
      },{
         "label":"Items",
         "data":"Items"
      },{
         "label":"Chests",
         "data":"Chest"
      },{
         "label":"Resources",
         "data":"Resource"
      },{
         "label":"Angel & Devil Items",
         "data":"Angel/Devil"
      },{
         "label":"Stratagems",
         "data":"Stratagem"
      },{
         "label":"Teleporters",
         "data":"Teleporters"
      },{
         "label":"Troop Packs",
         "data":"Troops"
      },{
         "label":"Produce",
         "data":"Produce"
      },{
         "label":"Speed Ups",
         "data":"Speed Up"
      },{
         "label":"Materials",
         "data":"Materials"
      },{
         "label":"Medals",
         "data":"Medal"
      },{
         "label":"HH Quests",
         "data":"Quests"
      }]);
      
      private var _480636075keyInput:TextInput;
      
      private var _1425640839itemsArray:ArrayCollection = new ArrayCollection();
      
      private var _1174855070_ItemInfo_DataGrid1:DataGrid;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _445142669_selectFilter:ComboBox;
      
      private var _244722591_Iteminfo_ClassFactory0:ClassFactory;
      
      private var _838846263update:Button;
      
      private var key:String = "";
      
      mx_internal var _bindings:Array = [];
      
      private var selectedType:String = null;
      
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
                                 return {"width":5};
                              }
                           }),new UIComponentDescriptor({
                              "type":TextInput,
                              "id":"keyInput",
                              "events":{"enter":"__keyInput_enter"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "maxChars":10,
                                    "width":80
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
                                    "label":"Update"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":50};
                              }
                           }),new UIComponentDescriptor({
                              "type":Label,
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "text":"View by Type: ",
                                    "styleName":"newArmyTroop"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":ComboBox,
                              "id":"_selectFilter",
                              "events":{"change":"___selectFilter_change"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":155,
                                    "styleName":"ComboBox"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":DataGrid,
                     "id":"_ItemInfo_DataGrid1",
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
                           "sortableColumns":true,
                           "variableRowHeight":true,
                           "visible":true,
                           "wordWrap":false,
                           "columns":[_ItemInfo_DataGridColumn1_c(),_ItemInfo_DataGridColumn2_c(),_ItemInfo_DataGridColumn3_c(),_ItemInfo_DataGridColumn4_c(),_ItemInfo_DataGridColumn5_c()]
                        };
                     }
                  })]};
               }
            })]};
         }
      });
      
      public function ItemInfo()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___ItemInfo_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ItemInfo._watcherSetupUtil = param1;
      }
      
      public function set itemsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1425640839itemsArray;
         if(_loc2_ !== param1)
         {
            this._1425640839itemsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemsArray",_loc2_,param1));
         }
      }
      
      public function _onViewItemBtn(param1:Object) : void
      {
         var _loc2_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.VIEW_ITEM_INFO_WIN);
         _loc2_.args = [param1];
         dispatchEvent(_loc2_);
      }
      
      private function set filterOptions(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1948713978filterOptions;
         if(_loc2_ !== param1)
         {
            this._1948713978filterOptions = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"filterOptions",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get filterOptions() : ArrayCollection
      {
         return this._1948713978filterOptions;
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
      }
      
      private function _ItemInfo_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Desc";
         _loc1_.dataField = "desc";
         _loc1_.width = 0.46;
         _loc1_.showDataTips = true;
         return _loc1_;
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
         var _loc8_:ItemBean = null;
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         this.key = Utils.trim(this.keyInput.text).toLowerCase();
         this.keyInput.text = this.key;
         this.keyInput.setSelection(0,this.key.length);
         this.keyInput.setFocus();
         if(this.key == "")
         {
            this.itemsArray.sort = null;
            this.itemsArray.refresh();
         }
         else
         {
            this._selectFilter.selectedIndex = 0;
            this.selectedType = null;
         }
         this.itemsArray.removeAll();
         var _loc2_:Object = new Object();
         var _loc3_:Object = null;
         var _loc4_:ItemEum = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Boolean = this.selectedType != null && (this.selectedType == "Angel/Devil" || this.selectedType == "Materials" || this.selectedType == "Medal" || this.selectedType == "Troops" || this.selectedType == "Produce" || this.selectedType == "Resource" || this.selectedType == "Teleporters");
         for each(_loc8_ in MainScreen.getPlayer().itemsArray)
         {
            if(_loc8_.id != null)
            {
               _loc4_ = Items.getItemEumById(_loc8_.id);
               if(_loc4_ != null)
               {
                  _loc3_ = _loc4_.toObject();
               }
               else
               {
                  _loc3_ = new ItemEum().toObject();
                  _loc3_.name = _loc8_.id;
                  _loc3_.id = _loc8_.id;
                  _loc3_.desc = "miscellaneous or undefined item";
                  _loc3_.itemDesc = "miscellaneous or undefined item";
               }
               _loc3_.count = _loc8_.count;
               _loc3_.maxCount = _loc8_.maxCount;
               _loc3_.minCount = _loc8_.minCount;
               _loc3_.label = _loc3_.itemDesc as String;
               _loc5_ = (_loc3_.name as String).toLowerCase();
               if(this.selectedType == null)
               {
                  if(_loc5_.indexOf(this.key) == -1)
                  {
                     continue;
                  }
               }
               else
               {
                  _loc6_ = _loc7_ ? Items.getCommonType(_loc3_.itemType,_loc3_.id) : Items.getCommonType(_loc3_.itemType);
                  if(_loc6_ == null)
                  {
                     continue;
                  }
                  if(this.key != "")
                  {
                     if(_loc5_.indexOf(this.key) != -1 || _loc6_ != this.selectedType)
                     {
                        continue;
                     }
                  }
                  else if(_loc6_ != this.selectedType)
                  {
                     continue;
                  }
               }
               _loc2_[_loc5_] = 1;
               this.itemsArray.addItem(_loc3_);
            }
         }
         if(this.selectedType == null && this.itemsArray.length > 0 && MainScreen.getPlayer().playerInfo.medal > 0)
         {
            _loc3_ = new ItemEum().toObject();
            _loc3_.name = "Cents";
            _loc3_.id = "evony.game.coins";
            _loc3_.desc = "Game coins used to purchase goods and items from the shop.";
            _loc3_.count = MainScreen.getPlayer().playerInfo.medal;
            _loc3_.maxCount = 0;
            _loc3_.minCount = 0;
            _loc3_.label = _loc3_.itemDesc as String;
            _loc3_.iconUrl = "images/items/medals.png";
            this.itemsArray.addItem(_loc3_);
         }
         if(this.key == "" && this.selectedType == null || Items.externalItemNames == null)
         {
            return;
         }
         for each(_loc4_ in Items.externalItemNames)
         {
            _loc5_ = _loc4_.name.toLowerCase();
            if(_loc2_[_loc5_] == undefined)
            {
               if(this.selectedType == null)
               {
                  if(_loc5_.indexOf(this.key) == -1)
                  {
                     continue;
                  }
               }
               else
               {
                  _loc6_ = _loc7_ ? Items.getCommonType(_loc4_.itemType,_loc4_.id) : Items.getCommonType(_loc4_.itemType);
                  if(_loc6_ == null)
                  {
                     continue;
                  }
                  if(this.key != "")
                  {
                     if(_loc5_.indexOf(this.key) != -1 || _loc6_ != this.selectedType)
                     {
                        continue;
                     }
                  }
                  else if(_loc6_ != this.selectedType)
                  {
                     continue;
                  }
               }
               _loc2_[_loc5_] = 1;
               _loc3_ = _loc4_.toObject();
               _loc3_.name = _loc4_.name;
               _loc3_.count = 0;
               _loc3_.maxCount = 0;
               _loc3_.minCount = 0;
               _loc3_.label = _loc3_.itemDesc as String;
               this.itemsArray.addItem(_loc3_);
            }
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ItemInfo = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ItemInfo_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_ItemInfoWatcherSetupUtil");
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
      
      private function _ItemInfo_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.filterOptions;
         _loc1_ = this.itemsArray;
         _loc1_ = ItemViewBtn_inlineComponent0;
      }
      
      private function _ItemInfo_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Count";
         _loc1_.dataField = "count";
         _loc1_.width = 0.09;
         return _loc1_;
      }
      
      public function __keyInput_enter(param1:FlexEvent) : void
      {
         this.updateData();
      }
      
      private function _ItemInfo_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._Iteminfo_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_Iteminfo_ClassFactory0",this._Iteminfo_ClassFactory0);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get keyInput() : TextInput
      {
         return this._480636075keyInput;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Iteminfo_ClassFactory0() : ClassFactory
      {
         return this._244722591_Iteminfo_ClassFactory0;
      }
      
      public function set _ItemInfo_DataGrid1(param1:DataGrid) : void
      {
         var _loc2_:Object = this._1174855070_ItemInfo_DataGrid1;
         if(_loc2_ !== param1)
         {
            this._1174855070_ItemInfo_DataGrid1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ItemInfo_DataGrid1",_loc2_,param1));
         }
      }
      
      public function set _Iteminfo_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._244722591_Iteminfo_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._244722591_Iteminfo_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Iteminfo_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function toDebugString() : String
      {
         return "field: itemsArray, method: fetchPage([String]), columns: id name desc itemDesc count price";
      }
      
      private function _ItemInfo_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Name";
         _loc1_.dataField = "name";
         _loc1_.width = 0.3;
         return _loc1_;
      }
      
      private function _ItemInfo_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Price";
         _loc1_.dataField = "price";
         _loc1_.width = 0.07;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      private function _ItemInfo_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Action";
         _loc1_.dataField = "name";
         _loc1_.width = 0.08;
         _loc1_.itemRenderer = this._ItemInfo_ClassFactory1_i();
         return _loc1_;
      }
      
      public function ___ItemInfo_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _ItemInfo_DataGrid1() : DataGrid
      {
         return this._1174855070_ItemInfo_DataGrid1;
      }
      
      public function ___selectFilter_change(param1:ListEvent) : void
      {
         this.keyInput.text = "";
         this.selectedType = this._selectFilter.selectedItem.data;
         this.updateData(null);
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
      
      public function set _selectFilter(param1:ComboBox) : void
      {
         var _loc2_:Object = this._445142669_selectFilter;
         if(_loc2_ !== param1)
         {
            this._445142669_selectFilter = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectFilter",_loc2_,param1));
         }
      }
      
      public function fetchPage(param1:String = "") : void
      {
         this.keyInput.text = param1;
         this._selectFilter.selectedIndex = 0;
         this.selectedType = null;
         this.updateData();
      }
      
      private function _ItemInfo_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.filterOptions;
         },function(param1:Object):void
         {
            _selectFilter.dataProvider = param1;
         },"_selectFilter.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return this.itemsArray;
         },function(param1:Object):void
         {
            _ItemInfo_DataGrid1.dataProvider = param1;
         },"_ItemInfo_DataGrid1.dataProvider");
         result[1] = binding;
         binding = new Binding(this,function():Class
         {
            return ItemViewBtn_inlineComponent0;
         },function(param1:Class):void
         {
            _Iteminfo_ClassFactory0.generator = param1;
         },"_Iteminfo_ClassFactory0.generator");
         result[2] = binding;
         return result;
      }
      
      public function __update_click(param1:MouseEvent) : void
      {
         this.updateData();
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectFilter() : ComboBox
      {
         return this._445142669_selectFilter;
      }
      
      [Bindable(event="propertyChange")]
      public function get itemsArray() : ArrayCollection
      {
         return this._1425640839itemsArray;
      }
   }
}

