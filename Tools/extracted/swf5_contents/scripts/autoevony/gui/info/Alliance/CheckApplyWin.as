package autoevony.gui.info.Alliance
{
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.AllianceAddPlayerByUserInfoBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
   import com.evony.common.module.alliance.AllianceUserAddResponse;
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
   import mx.controls.Button;
   import mx.controls.DataGrid;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.DateFormatter;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CheckApplyWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1765123250formatDateTime:DateFormatter;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
      
      public var _CheckApplyWin_DataGrid1:DataGrid;
      
      mx_internal var _watchers:Array = [];
      
      private var closeFunc:Function = null;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":410,
               "width":790,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"windowTitle":"Applications to Join"};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "30";
                     this.top = "55";
                     this.bottom = "5";
                     this.right = "30";
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
                              this.bottom = "7";
                              this.right = "10";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CheckApplyWin_Button1_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.bottom = "7";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Return",
                                          "styleName":"REwinBtn",
                                          "width":75,
                                          "x":250
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":DataGrid,
                           "id":"_CheckApplyWin_DataGrid1",
                           "stylesFactory":function():void
                           {
                              this.borderStyle = "solid";
                              this.bottom = "36";
                              this.top = "0";
                              this.headerStyleName = "columnHeaderSyle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"REdataGrid",
                                 "draggableColumns":false,
                                 "percentWidth":100,
                                 "resizableColumns":false,
                                 "selectable":false,
                                 "sortableColumns":false,
                                 "x":0,
                                 "columns":[_CheckApplyWin_DataGridColumn1_c(),_CheckApplyWin_DataGridColumn2_c(),_CheckApplyWin_DataGridColumn3_c(),_CheckApplyWin_DataGridColumn4_c(),_CheckApplyWin_DataGridColumn5_c(),_CheckApplyWin_DataGridColumn6_c()]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___CheckApplyWin_Button2_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "2";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"close"};
                  }
               })]
            };
         }
      });
      
      public var _CheckApplyWin_ClassFactory1:ClassFactory;
      
      public function CheckApplyWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 410;
         this.width = 790;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._CheckApplyWin_DateFormatter1_i();
         this.addEventListener("creationComplete",this.___CheckApplyWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CheckApplyWin._watcherSetupUtil = param1;
      }
      
      private function _CheckApplyWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.unionArray;
         _loc1_ = CheckApply_inlineComponent2;
         _loc1_ = this.propertiesObj;
      }
      
      private function get propertiesObj() : Object
      {
         return {"outerDocument":this};
      }
      
      public function showMembersMsg(param1:Object, param2:Boolean) : void
      {
         if(param2)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByLeader(param1.userName);
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().cancelagreeComeinAlliance(param1.userName);
         }
      }
      
      public function ___CheckApplyWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function _CheckApplyWin_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Player";
         _loc1_.dataField = "userName";
         _loc1_.width = 120;
         return _loc1_;
      }
      
      private function _CheckApplyWin_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Ranking";
         _loc1_.dataField = "rank_formatted";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function _CheckApplyWin_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "prestige_formatted";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function _CheckApplyWin_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Cities";
         _loc1_.dataField = "castleCount";
         _loc1_.width = 80;
         return _loc1_;
      }
      
      private function onAgreeComeInAllianceList(param1:AllianceUserAddResponse) : void
      {
         var _loc2_:Object = null;
         var _loc3_:AllianceAddPlayerByUserInfoBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            _loc2_ = new Object();
            this.unionArray = new ArrayCollection();
            for each(_loc3_ in param1.allianceAddPlayerByUserInfoBeanListArray)
            {
               _loc2_ = _loc3_.toObject();
               _loc2_.applyTimeStr = this.formatDateTime.format(new Date(_loc3_.inviteTime).toString());
               _loc2_.prestige_formatted = Utils.formatInt(_loc3_.prestige);
               _loc2_.rank_formatted = Utils.formatInt(_loc3_.rank);
               this.unionArray.addItem(_loc2_);
            }
         }
      }
      
      private function _CheckApplyWin_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Action";
         _loc1_.dataField = "userName";
         _loc1_.itemRenderer = this._CheckApplyWin_ClassFactory1_i();
         return _loc1_;
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST,this.onAgreeComeInAllianceList);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER,this.onAgreeComeInByLeader);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE,this.onCancelAgreeComeIn);
         if(this.initialized)
         {
            this.refresh();
         }
      }
      
      private function _CheckApplyWin_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Apply Time";
         _loc1_.dataField = "applyTimeStr";
         _loc1_.width = 140;
         return _loc1_;
      }
      
      private function _CheckApplyWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.unionArray;
         },function(param1:Object):void
         {
            _CheckApplyWin_DataGrid1.dataProvider = param1;
         },"_CheckApplyWin_DataGrid1.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Class
         {
            return CheckApply_inlineComponent2;
         },function(param1:Class):void
         {
            _CheckApplyWin_ClassFactory1.generator = param1;
         },"_CheckApplyWin_ClassFactory1.generator");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return this.propertiesObj;
         },function(param1:Object):void
         {
            _CheckApplyWin_ClassFactory1.properties = param1;
         },"_CheckApplyWin_ClassFactory1.properties");
         result[2] = binding;
         return result;
      }
      
      private function onAgreeComeInByLeader(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CheckApplyWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CheckApplyWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil");
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
      
      public function refresh() : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
      }
      
      private function onCancelAgreeComeIn(param1:AllianceUserAddResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
         }
      }
      
      public function updateInfo(param1:Function = null) : void
      {
         this.closeFunc = param1;
      }
      
      public function ___CheckApplyWin_Button1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _CheckApplyWin_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CheckApplyWin_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_CheckApplyWin_ClassFactory1",this._CheckApplyWin_ClassFactory1);
         return _loc1_;
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
      
      private function _CheckApplyWin_DateFormatter1_i() : DateFormatter
      {
         var _loc1_:DateFormatter = new DateFormatter();
         this.formatDateTime = _loc1_;
         _loc1_.formatString = "MM/DD/YY JJ:NN";
         return _loc1_;
      }
      
      public function ___CheckApplyWin_Button2_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function set unionArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1515842358unionArray;
         if(_loc2_ !== param1)
         {
            this._1515842358unionArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"unionArray",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get formatDateTime() : DateFormatter
      {
         return this._1765123250formatDateTime;
      }
      
      [Bindable(event="propertyChange")]
      private function get unionArray() : ArrayCollection
      {
         return this._1515842358unionArray;
      }
      
      private function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST,this.onAgreeComeInAllianceList);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER,this.onAgreeComeInByLeader);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE,this.onCancelAgreeComeIn);
         this.closeFunc.apply(null,[this]);
      }
   }
}

