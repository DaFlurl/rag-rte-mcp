package autoevony.gui.info.Alliance
{
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.AllianceAddPlayerInfoBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceInviteBeanResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
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
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.formatters.DateFormatter;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class AllianceInviteMemberWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public var _AllianceInviteMemberWin_DataGrid1:DataGrid;
      
      private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
      
      mx_internal var _watchers:Array = [];
      
      private var _1765123250formatDateTime:DateFormatter;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var closeFunc:Function = null;
      
      public var _AllianceInviteMemberWin_ClassFactory1:ClassFactory;
      
      public var _AllianceInviteMemberWin_ClassFactory2:ClassFactory;
      
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
                     return {"windowTitle":"Manage Invitations"};
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
                           "type":DataGrid,
                           "id":"_AllianceInviteMemberWin_DataGrid1",
                           "stylesFactory":function():void
                           {
                              this.top = "33";
                              this.bottom = "36";
                              this.left = "1";
                              this.right = "1";
                              this.headerStyleName = "columnHeaderSyle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"REdataGrid",
                                 "draggableColumns":false,
                                 "resizableColumns":false,
                                 "selectable":false,
                                 "sortableColumns":false,
                                 "columns":[_AllianceInviteMemberWin_DataGridColumn1_c(),_AllianceInviteMemberWin_DataGridColumn2_c(),_AllianceInviteMemberWin_DataGridColumn3_c(),_AllianceInviteMemberWin_DataGridColumn4_c(),_AllianceInviteMemberWin_DataGridColumn5_c(),_AllianceInviteMemberWin_DataGridColumn6_c(),_AllianceInviteMemberWin_DataGridColumn7_c()]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "events":{"click":"___AllianceInviteMemberWin_Button1_click"},
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
                                 "x":616.5
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.top = "5";
                              this.left = "5";
                              this.verticalAlign = "top";
                              this.horizontalGap = 5;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "text":"Enter Player Name:",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"inviteNames",
                                    "events":{"enter":"__inviteNames_enter"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"textInput"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceInviteMemberWin_Button2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Invite",
                                          "styleName":"REwinBtn",
                                          "width":75
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___AllianceInviteMemberWin_Button3_click"},
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
      
      private var _1519929921inviteNames:TextInput;
      
      public function AllianceInviteMemberWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 410;
         this.width = 790;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._AllianceInviteMemberWin_DateFormatter1_i();
         this.addEventListener("creationComplete",this.___AllianceInviteMemberWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AllianceInviteMemberWin._watcherSetupUtil = param1;
      }
      
      public function showMembersMsg(param1:Object) : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().canceladdUsertoAlliance(param1.userName);
      }
      
      private function _AllianceInviteMemberWin_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceInviteMemberWin_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceInviteMemberWin_ClassFactory1",this._AllianceInviteMemberWin_ClassFactory1);
         return _loc1_;
      }
      
      private function inviteIn() : void
      {
         if(this.inviteNames.text == null || this.inviteNames.text == "")
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You must enter a valid player name."));
            return;
         }
         ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(this.inviteNames.text);
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AllianceInviteMemberWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AllianceInviteMemberWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceInviteMemberWinWatcherSetupUtil");
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
      
      private function _AllianceInviteMemberWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.unionArray;
         },function(param1:Object):void
         {
            _AllianceInviteMemberWin_DataGrid1.dataProvider = param1;
         },"_AllianceInviteMemberWin_DataGrid1.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Class
         {
            return InviteMember_inlineComponent1;
         },function(param1:Class):void
         {
            _AllianceInviteMemberWin_ClassFactory1.generator = param1;
         },"_AllianceInviteMemberWin_ClassFactory1.generator");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return this.propertiesObj;
         },function(param1:Object):void
         {
            _AllianceInviteMemberWin_ClassFactory1.properties = param1;
         },"_AllianceInviteMemberWin_ClassFactory1.properties");
         result[2] = binding;
         binding = new Binding(this,function():Class
         {
            return CancelInviteMember_inlineComponent0;
         },function(param1:Class):void
         {
            _AllianceInviteMemberWin_ClassFactory2.generator = param1;
         },"_AllianceInviteMemberWin_ClassFactory2.generator");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return this.propertiesObj;
         },function(param1:Object):void
         {
            _AllianceInviteMemberWin_ClassFactory2.properties = param1;
         },"_AllianceInviteMemberWin_ClassFactory2.properties");
         result[4] = binding;
         return result;
      }
      
      public function ___AllianceInviteMemberWin_Button2_click(param1:MouseEvent) : void
      {
         this.inviteIn();
      }
      
      private function _AllianceInviteMemberWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.unionArray;
         _loc1_ = InviteMember_inlineComponent1;
         _loc1_ = this.propertiesObj;
         _loc1_ = CancelInviteMember_inlineComponent0;
         _loc1_ = this.propertiesObj;
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELADD_USERTO_ALLIANCE,this.onCancleAddUserToAlliance);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE,this.onAddUserToAlliance);
         if(this.initialized)
         {
            this.refresh();
         }
         this.inviteNames.setFocus();
      }
      
      public function ___AllianceInviteMemberWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function onAddUserToAllianceList(param1:AllianceInviteBeanResponse) : void
      {
         var _loc2_:Object = null;
         var _loc3_:AllianceAddPlayerInfoBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + "\nPlayer list isn\'t refreshed"));
         }
         else
         {
            _loc2_ = new Object();
            this.unionArray.removeAll();
            for each(_loc3_ in param1.allianceAddPlayerInfoBeanListArray)
            {
               _loc2_ = _loc3_.toObject();
               _loc2_.inviteTimeStr = this.formatDateTime.format(new Date(_loc3_.inviteTime).toString());
               _loc2_.prestige_formatted = Utils.formatInt(_loc3_.prestige);
               _loc2_.rank_formatted = Utils.formatInt(_loc3_.rank);
               this.unionArray.addItem(_loc2_);
            }
         }
      }
      
      public function updateInfo(param1:Function = null) : void
      {
         this.closeFunc = param1;
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
      
      private function _AllianceInviteMemberWin_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Ranking";
         _loc1_.dataField = "rank_formatted";
         _loc1_.width = 80;
         return _loc1_;
      }
      
      private function _AllianceInviteMemberWin_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "State";
         _loc1_.width = 120;
         _loc1_.itemRenderer = this._AllianceInviteMemberWin_ClassFactory1_i();
         return _loc1_;
      }
      
      private function _AllianceInviteMemberWin_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Invite Time";
         _loc1_.dataField = "inviteTimeStr";
         return _loc1_;
      }
      
      private function onCancleAddUserToAlliance(param1:AllianceInviteBeanResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
         }
      }
      
      private function _AllianceInviteMemberWin_DateFormatter1_i() : DateFormatter
      {
         var _loc1_:DateFormatter = new DateFormatter();
         this.formatDateTime = _loc1_;
         _loc1_.formatString = "MM/DD/YY JJ:NN";
         return _loc1_;
      }
      
      private function get propertiesObj() : Object
      {
         return {"outerDocument":this};
      }
      
      public function ___AllianceInviteMemberWin_Button1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _AllianceInviteMemberWin_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._AllianceInviteMemberWin_ClassFactory2 = _loc1_;
         BindingManager.executeBindings(this,"_AllianceInviteMemberWin_ClassFactory2",this._AllianceInviteMemberWin_ClassFactory2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get unionArray() : ArrayCollection
      {
         return this._1515842358unionArray;
      }
      
      public function ___AllianceInviteMemberWin_Button3_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get inviteNames() : TextInput
      {
         return this._1519929921inviteNames;
      }
      
      public function refresh() : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
      }
      
      private function onAddUserToAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            this.inviteNames.text == "";
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(this.onAddUserToAllianceList);
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
      
      private function _AllianceInviteMemberWin_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Player";
         _loc1_.dataField = "userName";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function _AllianceInviteMemberWin_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "prestige_formatted";
         _loc1_.width = 80;
         return _loc1_;
      }
      
      private function _AllianceInviteMemberWin_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Inviter";
         _loc1_.dataField = "invitePerson";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_CANCELADD_USERTO_ALLIANCE,this.onCancleAddUserToAlliance);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE,this.onAddUserToAlliance);
         this.closeFunc.apply(null,[this]);
      }
      
      private function _AllianceInviteMemberWin_DataGridColumn7_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Cancel";
         _loc1_.dataField = "userName";
         _loc1_.width = 100;
         _loc1_.itemRenderer = this._AllianceInviteMemberWin_ClassFactory2_i();
         return _loc1_;
      }
      
      public function set inviteNames(param1:TextInput) : void
      {
         var _loc2_:Object = this._1519929921inviteNames;
         if(_loc2_ !== param1)
         {
            this._1519929921inviteNames = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inviteNames",_loc2_,param1));
         }
      }
      
      public function __inviteNames_enter(param1:FlexEvent) : void
      {
         this.inviteIn();
      }
   }
}

