package autoevony.gui.info.Mail
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.MailBean;
   import com.evony.common.module.mail.MailListResponse;
   import com.evony.common.module.mail.MailResponse;
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
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MailBox extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _441028067mailsArray:ArrayCollection = new ArrayCollection();
      
      private var _855813086currentAllianceListPageNo:Label;
      
      mx_internal var _watchers:Array = [];
      
      private const PAGESIZE:int = 10;
      
      private var _995752784pageNo:int = 1;
      
      private var _10267247mailType:int;
      
      private var mailCached:Object = new Object();
      
      private var _3203dg:DataGrid;
      
      private var _577409037totalPage:int = 1;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _108401386reply:Button;
      
      private var _10813447mailBody:TextArea;
      
      private var _838846263update:Button;
      
      private var mailPending:int = -1;
      
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
                                 return {"width":15};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___MailBox_Button2_click"},
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
                              "events":{"click":"___MailBox_Button3_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {"styleName":"nextBtn"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Spacer,
                              "propertiesFactory":function():Object
                              {
                                 return {"width":80};
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"reply",
                              "events":{"click":"__reply_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Reply",
                                    "styleName":"REwinBtn"
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
                              "events":{"click":"___MailBox_Button5_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Delete",
                                    "styleName":"REwinBtn"
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
                                    "columns":[_MailBox_DataGridColumn1_c(),_MailBox_DataGridColumn2_c(),_MailBox_DataGridColumn3_c(),_MailBox_DataGridColumn4_c(),_MailBox_DataGridColumn5_c()]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":TextArea,
                              "id":"mailBody",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "editable":false,
                                    "styleName":"RElogBox",
                                    "percentHeight":50,
                                    "percentWidth":100
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
      
      public function MailBox()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___MailBox_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MailBox._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get mailBody() : TextArea
      {
         return this._10813447mailBody;
      }
      
      public function set mailBody(param1:TextArea) : void
      {
         var _loc2_:Object = this._10813447mailBody;
         if(_loc2_ !== param1)
         {
            this._10813447mailBody = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailBody",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get dg() : DataGrid
      {
         return this._3203dg;
      }
      
      private function _MailBox_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.pageNo + "/" + this.totalPage;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            currentAllianceListPageNo.text = param1;
         },"currentAllianceListPageNo.text");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.mailType == 1;
         },function(param1:Boolean):void
         {
            reply.visible = param1;
         },"reply.visible");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return this.mailsArray;
         },function(param1:Object):void
         {
            dg.dataProvider = param1;
         },"dg.dataProvider");
         result[2] = binding;
         return result;
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
      
      public function set reply(param1:Button) : void
      {
         var _loc2_:Object = this._108401386reply;
         if(_loc2_ !== param1)
         {
            this._108401386reply = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reply",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MailBox = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MailBox_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_MailBoxWatcherSetupUtil");
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
      
      private function onDeleteBtn() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            return;
         }
         ActionFactory.getInstance().getMailCommands().deleteMail("" + this.dg.selectedItem.mailid);
         this.mailsArray.removeItemAt(this.dg.selectedIndex);
         this.mailBody.text = "";
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
      
      private function onReplyBtn() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            return;
         }
         var _loc1_:MailsView = parentDocument as MailsView;
         _loc1_.mailsInfoStack.selectedIndex = 3;
         _loc1_.write._clearAll();
         _loc1_.write._subject.text = "Reply:" + this.dg.selectedItem.title;
         _loc1_.write._receivers.text = this.dg.selectedItem.sender;
         _loc1_.write._message.setFocus();
      }
      
      private function onSelectMail() : void
      {
         if(this.dg.selectedIndex == -1)
         {
            this.mailBody.text = "";
            return;
         }
         if(this.mailCached["mail" + this.dg.selectedItem.mailid] != undefined)
         {
            this.mailBody.text = this.mailCached["mail" + this.dg.selectedItem.mailid];
            return;
         }
         this.mailPending = this.dg.selectedItem.mailid;
         ActionFactory.getInstance().getMailCommands().readMail(this.dg.selectedItem.mailid,this.onReadMailResponse);
      }
      
      public function __reply_click(param1:MouseEvent) : void
      {
         this.onReplyBtn();
      }
      
      public function __dg_change(param1:ListEvent) : void
      {
         this.onSelectMail();
      }
      
      [Bindable(event="propertyChange")]
      public function get mailsArray() : ArrayCollection
      {
         return this._441028067mailsArray;
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
      
      private function previousPage() : void
      {
         if(this.pageNo <= 1)
         {
            return;
         }
         --this.pageNo;
         this.updateData();
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
      
      private function _MailBox_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Time";
         _loc1_.dataField = "receiveTimeStr";
         _loc1_.width = 0.22;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get pageNo() : int
      {
         return this._995752784pageNo;
      }
      
      private function init() : void
      {
         addEventListener(FlexEvent.SHOW,this.updateData);
         if(this.mailType == 1)
         {
            addEventListener(Event.RENDER,this.onRender);
         }
      }
      
      private function onRefeshBtn() : void
      {
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
      
      private function _MailBox_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "To";
         _loc1_.dataField = "receiver";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function set mailsArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._441028067mailsArray;
         if(_loc2_ !== param1)
         {
            this._441028067mailsArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailsArray",_loc2_,param1));
         }
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
      
      private function cleanupCache() : void
      {
         var _loc2_:String = null;
         var _loc1_:Number = Utils.getServerTime() - 3600 * 1000;
         for(_loc2_ in this.mailCached)
         {
            if(String(_loc2_).indexOf("mail") != 0)
            {
               if(this.mailCached[_loc2_] <= _loc1_)
               {
                  delete this.mailCached[_loc2_];
                  delete this.mailCached["mail" + _loc2_];
               }
            }
         }
      }
      
      public function ___MailBox_Button5_click(param1:MouseEvent) : void
      {
         this.onDeleteBtn();
      }
      
      public function ___MailBox_Button3_click(param1:MouseEvent) : void
      {
         this.nextPage();
      }
      
      public function toDebugString() : String
      {
         return "fields: mailsArray pageNo totalPage, method: fetchPage(int), columns: isReadStr receiveTimeStr sender receiver title rawData";
      }
      
      private function onReadMailResponse(param1:MailResponse) : void
      {
         if(param1.ok != 1)
         {
            return;
         }
         this.cleanupCache();
         this.mailCached["mail" + param1.mailid] = "Subject: " + param1.title + "\n\n" + param1.content;
         this.mailCached[param1.mailid] = Utils.getServerTime();
         if(this.dg.selectedIndex != -1 && this.dg.selectedItem.mailid == param1.mailid)
         {
            this.mailsArray[this.dg.selectedIndex].isReadStr = "Y";
            this.dg.invalidateList();
            this.mailBody.text = this.mailCached["mail" + param1.mailid];
         }
      }
      
      public function set mailType(param1:int) : void
      {
         var _loc2_:Object = this._10267247mailType;
         if(_loc2_ !== param1)
         {
            this._10267247mailType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailType",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get update() : Button
      {
         return this._838846263update;
      }
      
      private function onRender(param1:Object) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         removeEventListener(Event.RENDER,this.onRender);
         this.updateData();
      }
      
      [Bindable(event="propertyChange")]
      public function get mailType() : int
      {
         return this._10267247mailType;
      }
      
      [Bindable(event="propertyChange")]
      public function get currentAllianceListPageNo() : Label
      {
         return this._855813086currentAllianceListPageNo;
      }
      
      private function _MailBox_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.pageNo + "/" + this.totalPage;
         _loc1_ = this.mailType == 1;
         _loc1_ = this.mailsArray;
      }
      
      private function onMailListResponse(param1:MailListResponse) : void
      {
         var _loc4_:MailBean = null;
         if(param1.ok != 1)
         {
            return;
         }
         var _loc2_:Object = null;
         var _loc3_:Boolean = true;
         for each(_loc4_ in param1.mailsArray)
         {
            if(_loc3_)
            {
               _loc3_ = false;
               this.mailsArray.removeAll();
               this.pageNo = param1.pageNo;
               this.totalPage = param1.totalPage;
            }
            if(_loc4_.type_id == this.mailType)
            {
               _loc2_ = _loc4_.toObject();
               _loc2_.rawData = _loc4_;
               _loc2_.isReadStr = !!_loc4_.isRead ? "Y" : "N";
               _loc2_.receiveTimeStr = _loc4_.receiveTime;
               this.mailsArray.addItem(_loc2_);
            }
         }
      }
      
      private function _MailBox_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Read";
         _loc1_.dataField = "isReadStr";
         _loc1_.width = 0.08;
         return _loc1_;
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
      
      private function _MailBox_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "From";
         _loc1_.dataField = "sender";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function ___MailBox_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function fetchPage(param1:int) : void
      {
         ActionFactory.getInstance().getMailCommands().receiveMailList(param1,this.mailType,this.PAGESIZE,this.onMailListResponse);
         this.pageNo = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get reply() : Button
      {
         return this._108401386reply;
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
      
      private function _MailBox_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Subject";
         _loc1_.dataField = "title";
         _loc1_.width = 0.6;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      public function __update_click(param1:MouseEvent) : void
      {
         this.onRefeshBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get totalPage() : int
      {
         return this._577409037totalPage;
      }
      
      public function ___MailBox_Button2_click(param1:MouseEvent) : void
      {
         this.previousPage();
      }
   }
}

