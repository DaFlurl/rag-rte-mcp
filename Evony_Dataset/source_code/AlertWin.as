package autoevony.gui
{
   import autoevony.gui.controls.popup.PopUpWinBase;
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
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Spacer;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class AlertWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const confirmIco:Class = AlertWin_confirmIco;
      
      private static const alertIco:Class = AlertWin_alertIco;
      
      public var _AlertWin_Spacer1:Spacer;
      
      private var _790628751alertYesBtn:Button;
      
      private var returnFunc:Function = null;
      
      mx_internal var _watchers:Array = [];
      
      private var _2025600524_baseWin:PopUpWinBase;
      
      private var _1904252127alertNoBtn:Button;
      
      private var returnArgs:Array = null;
      
      public var _AlertWin_Image1:Image;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var closeFunc:Function = null;
      
      private var _410103118alertMsgArea:TextArea;
      
      private var _1919213602showNoBtn:Boolean = false;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":460,
               "height":190,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "id":"_baseWin",
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"windowTitle":"System"};
                  }
               }),new UIComponentDescriptor({
                  "type":HBox,
                  "stylesFactory":function():void
                  {
                     this.verticalAlign = "middle";
                     this.bottom = "18";
                     this.right = "30";
                     this.horizontalAlign = "right";
                     this.horizontalGap = 5;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"alertYesBtn",
                        "events":{"click":"__alertYesBtn_click"},
                        "stylesFactory":function():void
                        {
                           this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"OK",
                              "width":75,
                              "styleName":"REwinOkayBtn"
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Spacer,
                        "id":"_AlertWin_Spacer1",
                        "propertiesFactory":function():Object
                        {
                           return {"width":30};
                        }
                     }),new UIComponentDescriptor({
                        "type":Button,
                        "id":"alertNoBtn",
                        "events":{"click":"__alertNoBtn_click"},
                        "stylesFactory":function():void
                        {
                           this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Cancel",
                              "width":75,
                              "styleName":"REwinCancelBtn"
                           };
                        }
                     })]};
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"_AlertWin_Image1",
                  "stylesFactory":function():void
                  {
                     this.left = "15";
                     this.top = "60";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":50,
                        "height":50
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextArea,
                  "id":"alertMsgArea",
                  "stylesFactory":function():void
                  {
                     this.fontWeight = "bold";
                     this.left = "70";
                     this.right = "25";
                     this.top = "55";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"",
                        "editable":false,
                        "height":85,
                        "styleName":"textBackground"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___AlertWin_Button3_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "2";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"close",
                        "y":0,
                        "toolTip":"Click to close window without applying."
                     };
                  }
               })]
            };
         }
      });
      
      public function AlertWin()
      {
         super();
         mx_internal::_document = this;
         this.width = 460;
         this.height = 190;
         this.addEventListener("creationComplete",this.___AlertWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AlertWin._watcherSetupUtil = param1;
      }
      
      public function __alertNoBtn_click(param1:MouseEvent) : void
      {
         this.onClick(false);
      }
      
      [Bindable(event="propertyChange")]
      public function get _baseWin() : PopUpWinBase
      {
         return this._2025600524_baseWin;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AlertWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AlertWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_AlertWinWatcherSetupUtil");
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
      
      public function updateInfo(param1:String, param2:Function = null, param3:String = "Ok", param4:String = "Cancel", param5:Array = null, param6:String = null, param7:Function = null) : void
      {
         this.returnFunc = param2;
         this.returnArgs = param5;
         this.alertMsgArea.text = param1;
         this.alertYesBtn.label = param3;
         this.alertNoBtn.label = param4;
         if(param4 != "Cancel" && param4 != "No")
         {
            this.alertNoBtn.label = "Cancel";
         }
         this.showNoBtn = param2 != null;
         if(param6 != null)
         {
            this._baseWin.windowTitle = param6;
         }
         if(param6 == null && this.showNoBtn)
         {
            this._baseWin.windowTitle = "Confirm?";
         }
         this.closeFunc = param7;
      }
      
      private function init() : void
      {
         this.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandle);
      }
      
      public function set _baseWin(param1:PopUpWinBase) : void
      {
         var _loc2_:Object = this._2025600524_baseWin;
         if(_loc2_ !== param1)
         {
            this._2025600524_baseWin = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_baseWin",_loc2_,param1));
         }
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.onClick(true);
         }
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.onClick(false);
         }
      }
      
      public function ___AlertWin_Button3_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function _AlertWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return this.showNoBtn;
         },function(param1:Boolean):void
         {
            _AlertWin_Spacer1.visible = param1;
         },"_AlertWin_Spacer1.visible");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showNoBtn;
         },function(param1:Boolean):void
         {
            _AlertWin_Spacer1.includeInLayout = param1;
         },"_AlertWin_Spacer1.includeInLayout");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showNoBtn;
         },function(param1:Boolean):void
         {
            alertNoBtn.visible = param1;
         },"alertNoBtn.visible");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showNoBtn;
         },function(param1:Boolean):void
         {
            alertNoBtn.includeInLayout = param1;
         },"alertNoBtn.includeInLayout");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return !!this.showNoBtn ? confirmIco : alertIco;
         },function(param1:Object):void
         {
            _AlertWin_Image1.source = param1;
         },"_AlertWin_Image1.source");
         result[4] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get alertMsgArea() : TextArea
      {
         return this._410103118alertMsgArea;
      }
      
      private function set showNoBtn(param1:Boolean) : void
      {
         var _loc2_:Object = this._1919213602showNoBtn;
         if(_loc2_ !== param1)
         {
            this._1919213602showNoBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"showNoBtn",_loc2_,param1));
         }
      }
      
      public function set alertNoBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1904252127alertNoBtn;
         if(_loc2_ !== param1)
         {
            this._1904252127alertNoBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alertNoBtn",_loc2_,param1));
         }
      }
      
      public function ___AlertWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      private function get showNoBtn() : Boolean
      {
         return this._1919213602showNoBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get alertNoBtn() : Button
      {
         return this._1904252127alertNoBtn;
      }
      
      public function set alertMsgArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._410103118alertMsgArea;
         if(_loc2_ !== param1)
         {
            this._410103118alertMsgArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alertMsgArea",_loc2_,param1));
         }
      }
      
      private function onClick(param1:Boolean) : void
      {
         if(this.returnArgs == null || this.returnArgs.length == 0)
         {
            this.returnArgs = new Array(param1);
         }
         else
         {
            this.returnArgs.splice(0,0,param1);
         }
         if(this.returnFunc != null)
         {
            this.returnFunc.apply(null,this.returnArgs);
         }
         this.close();
      }
      
      [Bindable(event="propertyChange")]
      public function get alertYesBtn() : Button
      {
         return this._790628751alertYesBtn;
      }
      
      public function __alertYesBtn_click(param1:MouseEvent) : void
      {
         this.onClick(true);
      }
      
      private function close() : void
      {
         this.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandle);
         this.closeFunc.apply(null,[this]);
      }
      
      private function _AlertWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.showNoBtn;
         _loc1_ = this.showNoBtn;
         _loc1_ = this.showNoBtn;
         _loc1_ = this.showNoBtn;
         _loc1_ = this.showNoBtn ? confirmIco : alertIco;
      }
      
      public function set alertYesBtn(param1:Button) : void
      {
         var _loc2_:Object = this._790628751alertYesBtn;
         if(_loc2_ !== param1)
         {
            this._790628751alertYesBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alertYesBtn",_loc2_,param1));
         }
      }
   }
}

