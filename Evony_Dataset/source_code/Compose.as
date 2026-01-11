package autoevony.gui.info.Mail
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.constants.MailConstants;
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
   import mx.containers.Canvas;
   import mx.containers.Form;
   import mx.containers.FormItem;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Compose extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _490339309_subject:TextInput;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindings:Array = [];
      
      private var _1897462166_alliance:CheckBox;
      
      mx_internal var _watchers:Array = [];
      
      public var _Compose_Label2:Label;
      
      private var _1815989521_status:Label;
      
      private var _981817656_message:TextArea;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":Form,
               "propertiesFactory":function():Object
               {
                  return {
                     "percentWidth":100,
                     "percentHeight":100,
                     "childDescriptors":[new UIComponentDescriptor({
                        "type":FormItem,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Alliance:",
                              "percentWidth":100,
                              "styleName":"REmainFormText",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":HBox,
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "percentWidth":100,
                                       "childDescriptors":[new UIComponentDescriptor({
                                          "type":CheckBox,
                                          "id":"_alliance",
                                          "propertiesFactory":function():Object
                                          {
                                             return {"styleName":"REcheckBox"};
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Label,
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "text":"(2 speakers needed)",
                                                "styleName":"REmainFormText"
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
                                          "events":{"click":"___Compose_Button1_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"REwinBtn",
                                                "label":"Fetch Members"
                                             };
                                          }
                                       })]
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":FormItem,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Receivers:",
                              "percentWidth":100,
                              "percentHeight":10,
                              "styleName":"REmainFormText",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":TextArea,
                                 "id":"_receivers",
                                 "events":{"change":"___receivers_change"},
                                 "stylesFactory":function():void
                                 {
                                    this.borderStyle = "inset";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "percentWidth":100,
                                       "percentHeight":100,
                                       "styleName":"RElogBox"
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":FormItem,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":23,
                              "label":"Subject:",
                              "styleName":"REmainFormText",
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"_subject",
                                 "events":{"change":"___subject_change"},
                                 "stylesFactory":function():void
                                 {
                                    this.fontWeight = "normal";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "percentWidth":100,
                                       "percentHeight":100,
                                       "styleName":"textInput"
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":FormItem,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Message:",
                              "percentHeight":80,
                              "percentWidth":100,
                              "styleName":"REmainFormText",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Compose_Label2",
                                 "stylesFactory":function():void
                                 {
                                    this.color = 16777215;
                                    this.fontSize = 12;
                                    this.fontFamily = "DejaVu Sans";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "percentWidth":100,
                                       "height":20
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextArea,
                                 "id":"_message",
                                 "events":{"change":"___message_change"},
                                 "stylesFactory":function():void
                                 {
                                    this.borderStyle = "inset";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "percentWidth":100,
                                       "percentHeight":100,
                                       "styleName":"RElogBox"
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function():void
                        {
                           this.horizontalAlign = "right";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "percentWidth":100,
                              "height":25,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Spacer,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"width":85};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "events":{"click":"___Compose_Button2_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Send"
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
                                 "events":{"click":"___Compose_Button3_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "styleName":"REwinBtn",
                                       "label":"Reset"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Spacer,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"width":20};
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Label,
                        "id":"_status",
                        "stylesFactory":function():void
                        {
                           this.color = 16777215;
                           this.fontSize = 12;
                           this.fontFamily = "DejaVu Sans";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "percentWidth":100,
                              "height":20,
                              "text":""
                           };
                        }
                     })]
                  };
               }
            })]};
         }
      });
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _789426459_receivers:TextArea;
      
      public function Compose()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Compose._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _subject() : TextInput
      {
         return this._490339309_subject;
      }
      
      public function ___Compose_Button1_click(param1:MouseEvent) : void
      {
         this.fetchMembers();
      }
      
      public function set _alliance(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1897462166_alliance;
         if(_loc2_ !== param1)
         {
            this._1897462166_alliance = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_alliance",_loc2_,param1));
         }
      }
      
      public function ___Compose_Button3_click(param1:MouseEvent) : void
      {
         this._clearAll();
      }
      
      [Bindable(event="propertyChange")]
      public function get _receivers() : TextArea
      {
         return this._789426459_receivers;
      }
      
      private function send() : void
      {
         var _loc4_:String = null;
         this._receivers.text = Utils.trim(this._receivers.text);
         this._message.text = Utils.trim(this._message.text);
         this._subject.text = Utils.trim(this._subject.text);
         if(this._subject.text == "" && this._message.text == "")
         {
            this._status.text = "Error: Cannot send empty message";
            return;
         }
         var _loc1_:Array = this._receivers.text.split(",");
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc1_[_loc2_] = Utils.trim(_loc1_[_loc2_]);
            if(_loc1_[_loc2_] == "")
            {
               _loc1_.splice(_loc2_--,1);
            }
            _loc2_++;
         }
         if(this._alliance.selected)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().messagesForAllianceMember(this._subject.text,this._message.text,AllianceConstants.ALLIANCE_GROUP_MAIL,this._wv832);
            this._clearAll();
            this._status.text = "Alliance mail(s) sent, please verify sending status in Sent box.";
            return;
         }
         if(_loc1_.length == 0)
         {
            this._status.text = "Error: No receiver(s)";
            return;
         }
         if(_loc1_.length > 20)
         {
            this._status.text = "Error: Too many receivers, server does not let you send 20+ mails each hour";
            return;
         }
         if(this._subject.text == "" && this._message.text == "")
         {
            this._status.text = "Error: Cannot send empty message";
            return;
         }
         var _loc3_:Function = _loc1_.length != 1 ? null : this._wv832;
         for each(_loc4_ in _loc1_)
         {
            ActionFactory.getInstance().getMailCommands().sendMail(_loc4_,this._subject.text,this._message.text,_loc3_);
         }
         this._clearAll();
         this._status.text = "Mail(s) sent, please verify sending status in Sent box.";
      }
      
      private function _Compose_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return !_alliance.selected;
         },function(param1:Boolean):void
         {
            _receivers.enabled = param1;
         },"_receivers.enabled");
         result[0] = binding;
         binding = new Binding(this,function():int
         {
            return MailConstants.TITLE_LIMIT;
         },function(param1:int):void
         {
            _subject.maxChars = param1;
         },"_subject.maxChars");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = MailConstants.CONTENT_LIMIT + " characters max";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _Compose_Label2.text = param1;
         },"_Compose_Label2.text");
         result[2] = binding;
         binding = new Binding(this,function():int
         {
            return MailConstants.CONTENT_LIMIT;
         },function(param1:int):void
         {
            _message.maxChars = param1;
         },"_message.maxChars");
         result[3] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:Compose = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._Compose_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_ComposeWatcherSetupUtil");
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
      public function get _status() : Label
      {
         return this._1815989521_status;
      }
      
      private function _wv832(param1:Object) : void
      {
         if(param1.ok != 1)
         {
            this._status.text = "Error: " + param1.msg;
         }
         else
         {
            this._status.text = "Message has been sent";
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _alliance() : CheckBox
      {
         return this._1897462166_alliance;
      }
      
      public function set _receivers(param1:TextArea) : void
      {
         var _loc2_:Object = this._789426459_receivers;
         if(_loc2_ !== param1)
         {
            this._789426459_receivers = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_receivers",_loc2_,param1));
         }
      }
      
      public function set _message(param1:TextArea) : void
      {
         var _loc2_:Object = this._981817656_message;
         if(_loc2_ !== param1)
         {
            this._981817656_message = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_message",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _message() : TextArea
      {
         return this._981817656_message;
      }
      
      private function _Compose_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = !this._alliance.selected;
         _loc1_ = MailConstants.TITLE_LIMIT;
         _loc1_ = MailConstants.CONTENT_LIMIT + " characters max";
         _loc1_ = MailConstants.CONTENT_LIMIT;
      }
      
      public function set _status(param1:Label) : void
      {
         var _loc2_:Object = this._1815989521_status;
         if(_loc2_ !== param1)
         {
            this._1815989521_status = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_status",_loc2_,param1));
         }
      }
      
      public function ___message_change(param1:Event) : void
      {
         this._status.text = "";
      }
      
      public function ___subject_change(param1:Event) : void
      {
         this._status.text = "";
      }
      
      private function _wn1051(param1:AllianceMembersResponse) : void
      {
         var _loc3_:PlayerInfoBean = null;
         if(param1.ok != 1)
         {
            return;
         }
         var _loc2_:* = "";
         for each(_loc3_ in param1.membersArray)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += ", ";
            }
            _loc2_ += _loc3_.userName;
         }
         this._receivers.text = _loc2_;
      }
      
      public function set _subject(param1:TextInput) : void
      {
         var _loc2_:Object = this._490339309_subject;
         if(_loc2_ !== param1)
         {
            this._490339309_subject = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_subject",_loc2_,param1));
         }
      }
      
      public function _clearAll() : void
      {
         this._receivers.text = "";
         this._subject.text = "";
         this._message.text = "";
         this._status.text = "";
         this._alliance.selected = false;
         this._receivers.enabled = true;
      }
      
      public function ___receivers_change(param1:Event) : void
      {
         this._status.text = "";
      }
      
      public function ___Compose_Button2_click(param1:MouseEvent) : void
      {
         this.send();
      }
      
      private function fetchMembers() : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         if(MainScreen.getPlayer().playerInfo.alliance == null)
         {
            this._status.text = "Error: You are not in any alliance";
            return;
         }
         ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
      }
   }
}

