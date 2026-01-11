package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.info.FormatPopulation_inlineComponent0;
   import autoevony.gui.info.FormatPrestige_inlineComponent0;
   import autoevony.gui.info.FormatRanking_inlineComponent0;
   import autoevony.player.Map;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.module.alliance.AllianceMembersResponse;
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
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.DateFormatter;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class AllianceMembers extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1765123250formatDateTime:DateFormatter;
      
      private var _1809330466_AllianceMembers_ClassFactory0:ClassFactory;
      
      mx_internal var _watchers:Array = [];
      
      private var _1809330468_AllianceMembers_ClassFactory2:ClassFactory;
      
      private var _481919168membersArray:ArrayCollection = new ArrayCollection();
      
      public var _AllianceMembers_DataGrid1:DataGrid;
      
      private var _1809330467_AllianceMembers_ClassFactory1:ClassFactory;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1809330469_AllianceMembers_ClassFactory3:ClassFactory;
      
      private var _1366077706memberLevel:int = 0;
      
      public var _AllianceMembers_Button2:Button;
      
      public var _AllianceMembers_Button3:Button;
      
      public var _AllianceMembers_Button4:Button;
      
      public var _AllianceMembers_Button5:Button;
      
      public var _AllianceMembers_Button6:Button;
      
      public var _AllianceMembers_Button7:Button;
      
      mx_internal var _bindings:Array = [];
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
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
                  return {
                     "horizontalScrollPolicy":"off",
                     "verticalScrollPolicy":"off",
                     "childDescriptors":[new UIComponentDescriptor({
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
                              "horizontalScrollPolicy":"off",
                              "verticalScrollPolicy":"off",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Spacer,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"width":10};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "events":{"click":"___AllianceMembers_Button1_click"},
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
                                    return {"width":25};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_AllianceMembers_Button2",
                                 "events":{"click":"___AllianceMembers_Button2_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Invite"
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
                                 "id":"_AllianceMembers_Button3",
                                 "events":{"click":"___AllianceMembers_Button3_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Pending Apps"
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
                                 "id":"_AllianceMembers_Button4",
                                 "events":{"click":"___AllianceMembers_Button4_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinCancelBtn",
                                       "label":"Expel Member"
                                    };
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
                        "id":"_AllianceMembers_DataGrid1",
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
                              "columns":[_AllianceMembers_DataGridColumn1_c(),_AllianceMembers_DataGridColumn2_c(),_AllianceMembers_DataGridColumn3_c(),_AllianceMembers_DataGridColumn4_c(),_AllianceMembers_DataGridColumn5_c(),_AllianceMembers_DataGridColumn6_c(),_AllianceMembers_DataGridColumn7_c(),_AllianceMembers_DataGridColumn8_c()]
                           };
                        }
                     }),new UIComponentDescriptor({
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
                              "horizontalScrollPolicy":"off",
                              "verticalScrollPolicy":"off",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Spacer,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"width":10};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "id":"_AllianceMembers_Button5",
                                 "events":{"click":"___AllianceMembers_Button5_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinCancelBtn",
                                       "label":"Quit Alliance"
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
                                 "id":"_AllianceMembers_Button6",
                                 "events":{"click":"___AllianceMembers_Button6_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Resignation"
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
                                 "id":"_AllianceMembers_Button7",
                                 "events":{"click":"___AllianceMembers_Button7_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Relinquish Host"
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
                     })]
                  };
               }
            })]};
         }
      });
      
      public function AllianceMembers()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this._AllianceMembers_DateFormatter1_i();
         this.addEventListener("creationComplete",this.___AllianceMembers_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AllianceMembers._watcherSetupUtil = param1;
      }
      
      public function set membersArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._481919168membersArray;
         if(_loc2_ !== param1)
         {
            this._481919168membersArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"membersArray",_loc2_,param1));
         }
      }
      
      private function _AllianceMembers_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Position";
         _loc1_.dataField = "allianceLevel";
         _loc1_.width = 0.15;
         return _loc1_;
      }
      
      public function showMembersMsg(param1:Object) : void
      {
         var _loc2_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_MEMBER_INFO);
         _loc2_.objParam = param1;
         dispatchEvent(_loc2_);
      }
      
      public function ___AllianceMembers_Button1_click(param1:MouseEvent) : void
      {
         this.updateData();
      }
      
      public function ___AllianceMembers_Button3_click(param1:MouseEvent) : void
      {
         this.onPendingAppsBtn();
      }
      
      public function ___AllianceMembers_Button7_click(param1:MouseEvent) : void
      {
         this.onRelinquishHost();
      }
      
      private function updateData(param1:Object = null) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         if(MainScreen.getPlayer().playerInfo.alliance != null)
         {
            ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
         }
         else
         {
            this.membersArray = new ArrayCollection();
         }
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
         if(MainScreen.getPlayer() != null && MainScreen.getPlayer().playerInfo.alliance != null)
         {
            this.setMemberLevel(MainScreen.getPlayer().playerInfo.levelId);
         }
      }
      
      private function _AllianceMembers_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "prestige";
         _loc1_.width = 0.2;
         _loc1_.itemRenderer = this._AllianceMembers_ClassFactory2_i();
         return _loc1_;
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
      
      private function retireMember() : void
      {
         var _loc1_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_EXPEL_MEMBER);
         _loc1_.membersArray = this.membersArray;
         dispatchEvent(_loc1_);
      }
      
      private function _AllianceMembers_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceMembers_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceMembers_ClassFactory1",this._AllianceMembers_ClassFactory1);
         return _loc1_;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AllianceMembers = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AllianceMembers_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceMembersWatcherSetupUtil");
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
      
      private function onRelinquishHost() : void
      {
         if(this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_CHANGE_HOST));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceMembers_ClassFactory2() : ClassFactory
      {
         return this._1809330468_AllianceMembers_ClassFactory2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceMembers_ClassFactory3() : ClassFactory
      {
         return this._1809330469_AllianceMembers_ClassFactory3;
      }
      
      private function _AllianceMembers_ClassFactory4_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceMembers_ClassFactory3 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceMembers_ClassFactory3",this._AllianceMembers_ClassFactory3);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceMembers_ClassFactory0() : ClassFactory
      {
         return this._1809330466_AllianceMembers_ClassFactory0;
      }
      
      private function _AllianceMembers_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Ranking";
         _loc1_.dataField = "ranking";
         _loc1_.width = 0.1;
         _loc1_.itemRenderer = this._AllianceMembers_ClassFactory1_i();
         return _loc1_;
      }
      
      private function _AllianceMembers_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Cities";
         _loc1_.dataField = "castleCount";
         _loc1_.width = 0.08;
         return _loc1_;
      }
      
      private function onPendingAppsBtn() : void
      {
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_PENDING_APPLICATIONS));
      }
      
      private function _AllianceMembers_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Player";
         _loc1_.dataField = "userName";
         _loc1_.width = 0.21;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceMembers_ClassFactory1() : ClassFactory
      {
         return this._1809330467_AllianceMembers_ClassFactory1;
      }
      
      public function ___AllianceMembers_Button5_click(param1:MouseEvent) : void
      {
         this.onQuitAllianceBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get formatDateTime() : DateFormatter
      {
         return this._1765123250formatDateTime;
      }
      
      [Bindable(event="propertyChange")]
      private function get memberLevel() : int
      {
         return this._1366077706memberLevel;
      }
      
      public function set _AllianceMembers_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1809330466_AllianceMembers_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._1809330466_AllianceMembers_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceMembers_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function set _AllianceMembers_ClassFactory1(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1809330467_AllianceMembers_ClassFactory1;
         if(_loc2_ !== param1)
         {
            this._1809330467_AllianceMembers_ClassFactory1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceMembers_ClassFactory1",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get membersArray() : ArrayCollection
      {
         return this._481919168membersArray;
      }
      
      public function toDebugString() : String
      {
         return "fields: membersArray, method: fetchPage(), columns: userName allianceLevel ranking prestige castleCount population lastLoginTimeStr";
      }
      
      public function ___AllianceMembers_Button2_click(param1:MouseEvent) : void
      {
         this.onInviteBtn();
      }
      
      public function setMemberLevel(param1:int) : void
      {
         this.memberLevel = param1;
      }
      
      private function _AllianceMembers_DataGridColumn7_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Last On";
         _loc1_.dataField = "lastLoginTimeStr";
         _loc1_.width = 0.2;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _AllianceMembers_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button2.enabled = param1;
         },"_AllianceMembers_Button2.enabled");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button3.enabled = param1;
         },"_AllianceMembers_Button3.enabled");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button4.visible = param1;
         },"_AllianceMembers_Button4.visible");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return this.membersArray;
         },function(param1:Object):void
         {
            _AllianceMembers_DataGrid1.dataProvider = param1;
         },"_AllianceMembers_DataGrid1.dataProvider");
         result[3] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatRanking_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceMembers_ClassFactory0.generator = param1;
         },"_AllianceMembers_ClassFactory0.generator");
         result[4] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatPrestige_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceMembers_ClassFactory1.generator = param1;
         },"_AllianceMembers_ClassFactory1.generator");
         result[5] = binding;
         binding = new Binding(this,function():Class
         {
            return FormatPopulation_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceMembers_ClassFactory2.generator = param1;
         },"_AllianceMembers_ClassFactory2.generator");
         result[6] = binding;
         binding = new Binding(this,function():Class
         {
            return ViewMemberBtn_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceMembers_ClassFactory3.generator = param1;
         },"_AllianceMembers_ClassFactory3.generator");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE && this.membersArray.length == 1;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button5.enabled = param1;
         },"_AllianceMembers_Button5.enabled");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button6.enabled = param1;
         },"_AllianceMembers_Button6.enabled");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE && this.membersArray.length != 1;
         },function(param1:Boolean):void
         {
            _AllianceMembers_Button7.enabled = param1;
         },"_AllianceMembers_Button7.enabled");
         result[10] = binding;
         return result;
      }
      
      private function _AllianceMembers_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceMembers_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceMembers_ClassFactory0",this._AllianceMembers_ClassFactory0);
         return _loc1_;
      }
      
      private function _AllianceMembers_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         _loc1_ = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         _loc1_ = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE;
         _loc1_ = this.membersArray;
         _loc1_ = FormatRanking_inlineComponent0;
         _loc1_ = FormatPrestige_inlineComponent0;
         _loc1_ = FormatPopulation_inlineComponent0;
         _loc1_ = ViewMemberBtn_inlineComponent0;
         _loc1_ = this.memberLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE && this.membersArray.length == 1;
         _loc1_ = this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE;
         _loc1_ = this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE && this.membersArray.length != 1;
      }
      
      private function onResignationBtn() : void
      {
         if(this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to resign from your position as " + MainScreen.getPlayer().playerInfo.allianceLevel + "?",this.onClickOk_resignForAlliance,"Yes","Cancel"));
         }
      }
      
      public function ___AllianceMembers_Button6_click(param1:MouseEvent) : void
      {
         this.onResignationBtn();
      }
      
      public function ___AllianceMembers_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___AllianceMembers_Button4_click(param1:MouseEvent) : void
      {
         this.retireMember();
      }
      
      public function set _AllianceMembers_ClassFactory2(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1809330468_AllianceMembers_ClassFactory2;
         if(_loc2_ !== param1)
         {
            this._1809330468_AllianceMembers_ClassFactory2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceMembers_ClassFactory2",_loc2_,param1));
         }
      }
      
      public function set _AllianceMembers_ClassFactory3(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1809330469_AllianceMembers_ClassFactory3;
         if(_loc2_ !== param1)
         {
            this._1809330469_AllianceMembers_ClassFactory3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceMembers_ClassFactory3",_loc2_,param1));
         }
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
      
      private function onClickOk_sayByetoAlliance(param1:Boolean) : void
      {
         if(param1)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance();
         }
      }
      
      public function fetchPage(param1:Object = null) : void
      {
         this.updateData();
      }
      
      private function _wn1051(param1:AllianceMembersResponse) : void
      {
         var _loc3_:PlayerInfoBean = null;
         var _loc2_:ObjectProxy = null;
         this.membersArray.removeAll();
         if(param1.ok != 1)
         {
            return;
         }
         for each(_loc3_ in param1.membersArray)
         {
            _loc2_ = new ObjectProxy(_loc3_.toObject());
            _loc2_.lastLoginTimeStr = this.formatDateTime.format(new Date(_loc3_.lastLoginTime).toString());
            _loc2_.titleStr = Map.TITLES.getItemAt(_loc3_.titleId);
            _loc2_.label = "Office: " + _loc3_.office + "\n" + "Title: " + _loc2_.titleStr + " " + _loc3_.castleCount + "/" + (1 + _loc3_.titleId) + "\n" + "Flag: " + _loc3_.flag + "\n" + "Sex: " + (_loc3_.sex == 0 ? "M" : "F") + "\n" + "Honor " + _loc3_.honor + "\n";
            this.membersArray.addItem(_loc2_);
         }
      }
      
      private function onInviteBtn() : void
      {
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_INVITE_MEMBER));
      }
      
      private function onClickOk_resignForAlliance(param1:Boolean) : void
      {
         if(param1)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().resignForAlliance();
         }
      }
      
      private function onQuitAllianceBtn() : void
      {
         if(this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"If you quit, this alliance will be deleted. Are you sure you want to quit?",this.onClickOk_sayByetoAlliance,"Yes","Cancel"));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"If you quit this alliance, you will have to wait 24 hours before you can rejoin. Are you sure you want to quit?",this.onClickOk_sayByetoAlliance,"Yes","Cancel"));
         }
      }
      
      private function _AllianceMembers_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Population";
         _loc1_.dataField = "population";
         _loc1_.width = 0.14;
         _loc1_.itemRenderer = this._AllianceMembers_ClassFactory3_i();
         return _loc1_;
      }
      
      private function _AllianceMembers_DataGridColumn8_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "View";
         _loc1_.dataField = "userName";
         _loc1_.width = 0.1;
         _loc1_.itemRenderer = this._AllianceMembers_ClassFactory4_i();
         return _loc1_;
      }
      
      private function _AllianceMembers_DateFormatter1_i() : DateFormatter
      {
         var _loc1_:DateFormatter = new DateFormatter();
         this.formatDateTime = _loc1_;
         _loc1_.formatString = "MM/DD/YY JJ:NN";
         return _loc1_;
      }
      
      private function _AllianceMembers_ClassFactory3_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceMembers_ClassFactory2 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceMembers_ClassFactory2",this._AllianceMembers_ClassFactory2);
         return _loc1_;
      }
   }
}

