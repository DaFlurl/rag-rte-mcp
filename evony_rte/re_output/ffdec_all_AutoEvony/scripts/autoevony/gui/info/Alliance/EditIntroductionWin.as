package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.AccountInfo;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.IndexAllianceInfoBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
   import com.evony.common.module.alliance.HasAllianceResponse;
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
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class EditIntroductionWin extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1981656776textInputName:TextInput;
      
      private var _1515842358unionArray:IndexAllianceInfoBean;
      
      mx_internal var _watchers:Array = [];
      
      private var _584275598_Introduct_Label2:Label;
      
      private var _1237230191_Introduct_Button1:Button;
      
      private var _1753466763allianceIntro:TextArea;
      
      private var _1606154441allianceNote:TextArea;
      
      private var _584275599_Introduct_Label3:Label;
      
      private var _1315418018exitBtn:Button;
      
      private var _584275600_Introduct_Label4:Label;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _584275601_Introduct_Label5:Label;
      
      private var closeFunc:Function = null;
      
      mx_internal var _bindings:Array = [];
      
      private var _1237230192_Introduct_Button2:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":435,
               "width":619,
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
                     return {"windowTitle":"Edit Introduction/Notice"};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "21";
                     this.top = "62";
                     this.bottom = "0";
                     this.right = "21";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"allianceIntro",
                        "stylesFactory":function():void
                        {
                           this.top = "65";
                           this.left = "5";
                           this.right = "5";
                           this.bottom = "210";
                           this.textAlign = "left";
                           this.paddingLeft = 5;
                           this.paddingTop = 3;
                           this.paddingRight = 5;
                           this.paddingBottom = 3;
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "maxChars":200,
                              "styleName":"inputArea"
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"allianceNote",
                        "stylesFactory":function():void
                        {
                           this.top = "205";
                           this.left = "5";
                           this.right = "5";
                           this.bottom = "45";
                           this.textAlign = "left";
                           this.paddingLeft = 5;
                           this.paddingTop = 3;
                           this.paddingRight = 5;
                           this.paddingBottom = 3;
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "maxChars":200,
                              "styleName":"inputArea"
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Introduct_Button1",
                        "events":{"click":"___Introduct_Button1_click"},
                        "stylesFactory":function():void
                        {
                           this.bottom = "15";
                           this.right = "135";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"OK",
                              "styleName":"REwinOkayBtn",
                              "width":75
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Introduct_Button2",
                        "events":{"click":"___Introduct_Button2_click"},
                        "stylesFactory":function():void
                        {
                           this.bottom = "15";
                           this.right = "30";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Cancel",
                              "styleName":"REwinCancelBtn",
                              "width":75
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function():void
                        {
                           this.left = "5";
                           this.top = "0";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":30,
                              "width":245,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Introduct_Label1",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.left = "5";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "text":"Alliance Name: ",
                                       "styleName":"PropertyName1",
                                       "width":110
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"textInputName",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.left = "115";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "enabled":false,
                                       "styleName":"textInput",
                                       "width":130
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function():void
                        {
                           this.left = "5";
                           this.top = "35";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":30,
                              "width":310,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Introduct_Label2",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.left = "5";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "text":"Introduction",
                                       "styleName":"PropertyName1",
                                       "width":115
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Introduct_Label3",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.right = "5";
                                    this.fontWeight = "normal";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "text":"[200 characters max]",
                                       "styleName":"PropertyName1",
                                       "width":194
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function():void
                        {
                           this.left = "5";
                           this.top = "175";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":30,
                              "width":275,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Introduct_Label4",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.left = "5";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "text":"Alliance Notice",
                                       "styleName":"PropertyName1",
                                       "width":130
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_Introduct_Label5",
                                 "stylesFactory":function():void
                                 {
                                    this.verticalCenter = "0";
                                    this.right = "5";
                                    this.fontWeight = "normal";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "text":"[200 characters max]",
                                       "styleName":"PropertyName1"
                                    };
                                 }
                              })]
                           };
                        }
                     })]};
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"exitBtn",
                  "events":{"click":"__exitBtn_click"},
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
      
      private var _584275597_Introduct_Label1:Label;
      
      public function EditIntroductionWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 435;
         this.width = 619;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___EditIntroductionWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         EditIntroductionWin._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get exitBtn() : Button
      {
         return this._1315418018exitBtn;
      }
      
      public function ___EditIntroductionWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __exitBtn_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Label1() : Label
      {
         return this._584275597_Introduct_Label1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Label2() : Label
      {
         return this._584275598_Introduct_Label2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Label3() : Label
      {
         return this._584275599_Introduct_Label3;
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE,this.onSetAllInfoForAlliance);
         if(this.initialized)
         {
            this.refresh();
         }
      }
      
      private function onSetAllInfoForAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this._Introduct_Button1.enabled = true;
            this._Introduct_Button2.enabled = true;
            this.allianceIntro.enabled = true;
            this.allianceNote.enabled = true;
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance(AccountInfo.getInstance().allianceInfo.onHasAlliance);
            this.close();
         }
      }
      
      public function set allianceNote(param1:TextArea) : void
      {
         var _loc2_:Object = this._1606154441allianceNote;
         if(_loc2_ !== param1)
         {
            this._1606154441allianceNote = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceNote",_loc2_,param1));
         }
      }
      
      public function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE,this.onSetAllInfoForAlliance);
         this.closeFunc.apply(null,[this]);
      }
      
      public function set _Introduct_Label2(param1:Label) : void
      {
         var _loc2_:Object = this._584275598_Introduct_Label2;
         if(_loc2_ !== param1)
         {
            this._584275598_Introduct_Label2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Label2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Button2() : Button
      {
         return this._1237230192_Introduct_Button2;
      }
      
      public function updateInfo(param1:Function = null) : void
      {
         this.closeFunc = param1;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:EditIntroductionWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._EditIntroductionWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_EditIntroductionWinWatcherSetupUtil");
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
      
      public function set _Introduct_Label4(param1:Label) : void
      {
         var _loc2_:Object = this._584275600_Introduct_Label4;
         if(_loc2_ !== param1)
         {
            this._584275600_Introduct_Label4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Label4",_loc2_,param1));
         }
      }
      
      public function set _Introduct_Label1(param1:Label) : void
      {
         var _loc2_:Object = this._584275597_Introduct_Label1;
         if(_loc2_ !== param1)
         {
            this._584275597_Introduct_Label1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Label1",_loc2_,param1));
         }
      }
      
      private function set unionArray(param1:IndexAllianceInfoBean) : void
      {
         var _loc2_:Object = this._1515842358unionArray;
         if(_loc2_ !== param1)
         {
            this._1515842358unionArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"unionArray",_loc2_,param1));
         }
      }
      
      public function set _Introduct_Label3(param1:Label) : void
      {
         var _loc2_:Object = this._584275599_Introduct_Label3;
         if(_loc2_ !== param1)
         {
            this._584275599_Introduct_Label3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Label3",_loc2_,param1));
         }
      }
      
      public function ___Introduct_Button1_click(param1:MouseEvent) : void
      {
         this.onSubmit();
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Label4() : Label
      {
         return this._584275600_Introduct_Label4;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Label5() : Label
      {
         return this._584275601_Introduct_Label5;
      }
      
      public function set _Introduct_Label5(param1:Label) : void
      {
         var _loc2_:Object = this._584275601_Introduct_Label5;
         if(_loc2_ !== param1)
         {
            this._584275601_Introduct_Label5 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Label5",_loc2_,param1));
         }
      }
      
      public function set exitBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1315418018exitBtn;
         if(_loc2_ !== param1)
         {
            this._1315418018exitBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"exitBtn",_loc2_,param1));
         }
      }
      
      private function onIsHasAlliance(param1:HasAllianceResponse) : void
      {
         if(param1.ok == CommandResponse.OK_DEFAULT)
         {
            this.unionArray = param1.indexAllianceInfoBean;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceNote() : TextArea
      {
         return this._1606154441allianceNote;
      }
      
      [Bindable(event="propertyChange")]
      public function get textInputName() : TextInput
      {
         return this._1981656776textInputName;
      }
      
      [Bindable(event="propertyChange")]
      private function get unionArray() : IndexAllianceInfoBean
      {
         return this._1515842358unionArray;
      }
      
      public function set _unionArray(param1:IndexAllianceInfoBean) : void
      {
         this.unionArray = param1;
      }
      
      public function set textInputName(param1:TextInput) : void
      {
         var _loc2_:Object = this._1981656776textInputName;
         if(_loc2_ !== param1)
         {
            this._1981656776textInputName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"textInputName",_loc2_,param1));
         }
      }
      
      private function onSubmit() : void
      {
         this._Introduct_Button1.enabled = false;
         this._Introduct_Button2.enabled = false;
         this.allianceIntro.enabled = false;
         this.allianceNote.enabled = false;
         ActionFactory.getInstance().getAllianceManagementCommands().setAllInfoForAlliance(this.textInputName.text,this.allianceIntro.text,this.allianceNote.text);
      }
      
      public function ___Introduct_Button2_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function refresh() : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance(this.onIsHasAlliance);
         this.allianceIntro.setFocus();
      }
      
      public function set _Introduct_Button2(param1:Button) : void
      {
         var _loc2_:Object = this._1237230192_Introduct_Button2;
         if(_loc2_ !== param1)
         {
            this._1237230192_Introduct_Button2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Button2",_loc2_,param1));
         }
      }
      
      public function set _Introduct_Button1(param1:Button) : void
      {
         var _loc2_:Object = this._1237230191_Introduct_Button1;
         if(_loc2_ !== param1)
         {
            this._1237230191_Introduct_Button1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_Introduct_Button1",_loc2_,param1));
         }
      }
      
      private function _EditIntroductionWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.unionArray.allianceInfo;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            allianceIntro.text = param1;
         },"allianceIntro.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.unionArray.allianceNote;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            allianceNote.text = param1;
         },"allianceNote.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.unionArray.allianceName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            textInputName.text = param1;
         },"textInputName.text");
         result[2] = binding;
         return result;
      }
      
      public function set allianceIntro(param1:TextArea) : void
      {
         var _loc2_:Object = this._1753466763allianceIntro;
         if(_loc2_ !== param1)
         {
            this._1753466763allianceIntro = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceIntro",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceIntro() : TextArea
      {
         return this._1753466763allianceIntro;
      }
      
      [Bindable(event="propertyChange")]
      public function get _Introduct_Button1() : Button
      {
         return this._1237230191_Introduct_Button1;
      }
      
      private function _EditIntroductionWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.unionArray.allianceInfo;
         _loc1_ = this.unionArray.allianceNote;
         _loc1_ = this.unionArray.allianceName;
      }
   }
}

