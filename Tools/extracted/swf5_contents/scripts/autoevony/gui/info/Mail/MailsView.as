package autoevony.gui.info.Mail
{
   import com.evony.common.constants.MailConstants;
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
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.TabBar;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MailsView extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _3526552sent:MailBox;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _100344454inbox:MailBox;
      
      mx_internal var _watchers:Array = [];
      
      private var _887328209system:MailBox;
      
      private var _113399775write:Compose;
      
      mx_internal var _bindings:Array = [];
      
      private var _241329461mailsInfoTab:TabBar;
      
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
                  this.left = "0";
                  this.right = "0";
                  this.top = "3";
                  this.bottom = "0";
               },
               "propertiesFactory":function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.verticalAlign = "bottom";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "height":22,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":TabBar,
                              "id":"mailsInfoTab",
                              "stylesFactory":function():void
                              {
                                 this.tabStyleName = "REtabBarTab";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "dataProvider":"mailsInfoStack",
                                    "styleName":"REtabBar"
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":ViewStack,
                     "id":"mailsInfoStack",
                     "stylesFactory":function():void
                     {
                        this.borderColor = 2236962;
                        this.borderThickness = 1;
                        this.borderStyle = "solid";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "creationPolicy":"all",
                           "percentHeight":100,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":MailBox,
                              "id":"inbox",
                              "propertiesFactory":function():Object
                              {
                                 return {"label":"Inbox"};
                              }
                           }),new UIComponentDescriptor({
                              "type":MailBox,
                              "id":"system",
                              "propertiesFactory":function():Object
                              {
                                 return {"label":"System"};
                              }
                           }),new UIComponentDescriptor({
                              "type":MailBox,
                              "id":"sent",
                              "propertiesFactory":function():Object
                              {
                                 return {"label":"Sent"};
                              }
                           }),new UIComponentDescriptor({
                              "type":Compose,
                              "id":"write",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "label":"Write",
                                    "styleName":"REmailComposeView"
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
      
      private var _10266686mailsInfoStack:ViewStack;
      
      public function MailsView()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MailsView._watcherSetupUtil = param1;
      }
      
      public function set mailsInfoStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._10266686mailsInfoStack;
         if(_loc2_ !== param1)
         {
            this._10266686mailsInfoStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailsInfoStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get inbox() : MailBox
      {
         return this._100344454inbox;
      }
      
      public function toDebugString() : String
      {
         return "fields: inbox system sent";
      }
      
      [Bindable(event="propertyChange")]
      public function get mailsInfoTab() : TabBar
      {
         return this._241329461mailsInfoTab;
      }
      
      [Bindable(event="propertyChange")]
      public function get mailsInfoStack() : ViewStack
      {
         return this._10266686mailsInfoStack;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MailsView = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MailsView_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_MailsViewWatcherSetupUtil");
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
      
      private function _MailsView_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():int
         {
            return MailConstants.MAIL_RECEIVE;
         },function(param1:int):void
         {
            inbox.mailType = param1;
         },"inbox.mailType");
         result[0] = binding;
         binding = new Binding(this,function():int
         {
            return MailConstants.MAIL_SYSTEM;
         },function(param1:int):void
         {
            system.mailType = param1;
         },"system.mailType");
         result[1] = binding;
         binding = new Binding(this,function():int
         {
            return MailConstants.MAIL_SEND;
         },function(param1:int):void
         {
            sent.mailType = param1;
         },"sent.mailType");
         result[2] = binding;
         return result;
      }
      
      public function set inbox(param1:MailBox) : void
      {
         var _loc2_:Object = this._100344454inbox;
         if(_loc2_ !== param1)
         {
            this._100344454inbox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inbox",_loc2_,param1));
         }
      }
      
      public function set mailsInfoTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._241329461mailsInfoTab;
         if(_loc2_ !== param1)
         {
            this._241329461mailsInfoTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailsInfoTab",_loc2_,param1));
         }
      }
      
      public function set system(param1:MailBox) : void
      {
         var _loc2_:Object = this._887328209system;
         if(_loc2_ !== param1)
         {
            this._887328209system = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"system",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get write() : Compose
      {
         return this._113399775write;
      }
      
      [Bindable(event="propertyChange")]
      public function get sent() : MailBox
      {
         return this._3526552sent;
      }
      
      public function set write(param1:Compose) : void
      {
         var _loc2_:Object = this._113399775write;
         if(_loc2_ !== param1)
         {
            this._113399775write = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"write",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get system() : MailBox
      {
         return this._887328209system;
      }
      
      public function set sent(param1:MailBox) : void
      {
         var _loc2_:Object = this._3526552sent;
         if(_loc2_ !== param1)
         {
            this._3526552sent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sent",_loc2_,param1));
         }
      }
      
      private function _MailsView_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = MailConstants.MAIL_RECEIVE;
         _loc1_ = MailConstants.MAIL_SYSTEM;
         _loc1_ = MailConstants.MAIL_SEND;
      }
   }
}

