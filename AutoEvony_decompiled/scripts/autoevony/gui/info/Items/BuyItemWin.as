package autoevony.gui.info.Items
{
   import autoevony.common.Utils;
   import autoevony.gui.MainScreen;
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
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class BuyItemWin extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _327260383_useBtnArea:HBox;
      
      public var _BuyItemWin_Label2:Label;
      
      mx_internal var _watchers:Array = [];
      
      private var _344839367_closeWinBtn:Button;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var onBuyItem:Function = null;
      
      private var _1177034077itemData:ObjectProxy = null;
      
      private var closeFunc:Function = null;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":115,
               "width":500,
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
                     return {"windowTitle":"Buy Items"};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "height":115,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "15";
                              this.top = "50";
                              this.right = "15";
                              this.bottom = "15";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "5";
                                       this.bottom = "5";
                                       this.horizontalGap = 5;
                                       this.verticalGap = 0;
                                       this.horizontalAlign = "right";
                                       this.verticalAlign = "middle";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":245,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"How many to buy?",
                                                   "styleName":"newArmyTroop"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ItemCountInput,
                                             "id":"_buyCountInput1"
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "260";
                                       this.top = "5";
                                       this.right = "80";
                                       this.bottom = "5";
                                       this.horizontalGap = 5;
                                       this.verticalGap = 0;
                                       this.horizontalAlign = "left";
                                       this.verticalAlign = "middle";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_BuyItemWin_Label2",
                                             "propertiesFactory":function():Object
                                             {
                                                return {"styleName":"newArmyTroop"};
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_useBtnArea",
                                    "stylesFactory":function():void
                                    {
                                       this.top = "5";
                                       this.right = "5";
                                       this.bottom = "5";
                                       this.horizontalGap = 5;
                                       this.verticalGap = 0;
                                       this.horizontalAlign = "right";
                                       this.verticalAlign = "middle";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_buyBtn",
                                             "events":{"click":"___buyBtn_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Buy",
                                                   "styleName":"REwinBtn"
                                                };
                                             }
                                          })]
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
                  "id":"_closeWinBtn",
                  "events":{"click":"___closeWinBtn_click"},
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
      
      private var _957284175_buyCountInput1:ItemCountInput;
      
      private var _1330884373_buyBtn:Button;
      
      public function BuyItemWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 115;
         this.width = 500;
         this.addEventListener("creationComplete",this.___BuyItemWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         BuyItemWin._watcherSetupUtil = param1;
      }
      
      private function init() : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _buyBtn() : Button
      {
         return this._1330884373_buyBtn;
      }
      
      private function _BuyItemWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this;
         _loc1_ = this.enableBuyBtn(this.itemData.price);
         _loc1_ = "  Cost: " + Utils.formatInt(this.itemData.price * int(this._buyCountInput1._useCountInput.text)) + " cents";
         _loc1_ = this.enableBuyBtn(this.itemData.price) && int(this._buyCountInput1._useCountInput.text) >= 1;
      }
      
      public function updateInfo(param1:Array, param2:Function) : void
      {
         this.itemData = param1[0];
         this.onBuyItem = param1[1];
         this.closeFunc = param2;
      }
      
      private function moveCursorToEnd(param1:TextInput) : void
      {
         var txtCtrl:TextInput = param1;
         Utils.callLater(50,function():void
         {
            var _loc1_:int = txtCtrl.text.length;
            if(txtCtrl.selectionEndIndex != _loc1_ || txtCtrl.selectionBeginIndex != _loc1_)
            {
               txtCtrl.selectionEndIndex = txtCtrl.selectionBeginIndex = _loc1_;
            }
         });
      }
      
      public function set _buyCountInput1(param1:ItemCountInput) : void
      {
         var _loc2_:Object = this._957284175_buyCountInput1;
         if(_loc2_ !== param1)
         {
            this._957284175_buyCountInput1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_buyCountInput1",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:BuyItemWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._BuyItemWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil");
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
      public function get _useBtnArea() : HBox
      {
         return this._327260383_useBtnArea;
      }
      
      internal function onMaxBtn(param1:TextInput) : void
      {
         param1.text = "" + Math.floor(MainScreen.getPlayer().playerInfo.medal / this.itemData.price);
         param1.setFocus();
         this.moveCursorToEnd(param1);
      }
      
      public function set _buyBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1330884373_buyBtn;
         if(_loc2_ !== param1)
         {
            this._1330884373_buyBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_buyBtn",_loc2_,param1));
         }
      }
      
      private function _BuyItemWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return this;
         },function(param1:*):void
         {
            _buyCountInput1.parentWin = param1;
         },"_buyCountInput1.parentWin");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.enableBuyBtn(this.itemData.price);
         },function(param1:Boolean):void
         {
            _buyCountInput1.enabled = param1;
         },"_buyCountInput1.enabled");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "  Cost: " + Utils.formatInt(this.itemData.price * int(_buyCountInput1._useCountInput.text)) + " cents";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _BuyItemWin_Label2.text = param1;
         },"_BuyItemWin_Label2.text");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Boolean(this.enableBuyBtn(this.itemData.price)) && int(_buyCountInput1._useCountInput.text) >= 1;
         },function(param1:Boolean):void
         {
            _buyBtn.enabled = param1;
         },"_buyBtn.enabled");
         result[3] = binding;
         return result;
      }
      
      private function onBuyBtn() : void
      {
         this._buyBtn.enabled = false;
         if(int(this._buyCountInput1._useCountInput.text) < 1)
         {
            return;
         }
         this._closeWinBtn.enabled = false;
         Utils.callLater(1500,this.close);
         this.onBuyItem.apply(null,[int(this._buyCountInput1._useCountInput.text)]);
      }
      
      [Bindable(event="propertyChange")]
      public function get _closeWinBtn() : Button
      {
         return this._344839367_closeWinBtn;
      }
      
      private function set itemData(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._1177034077itemData;
         if(_loc2_ !== param1)
         {
            this._1177034077itemData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemData",_loc2_,param1));
         }
      }
      
      public function set _useBtnArea(param1:HBox) : void
      {
         var _loc2_:Object = this._327260383_useBtnArea;
         if(_loc2_ !== param1)
         {
            this._327260383_useBtnArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useBtnArea",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _buyCountInput1() : ItemCountInput
      {
         return this._957284175_buyCountInput1;
      }
      
      internal function onUseCountChange(param1:TextInput) : void
      {
         param1.text = "" + int(param1.text);
         if(int(param1.text) == 0)
         {
            if(MainScreen.getPlayer().playerInfo.medal - this.itemData.price >= 0)
            {
               param1.text = "" + 1;
            }
            this.moveCursorToEnd(param1);
         }
         else if(int(param1.text) < 0)
         {
            this.onMinBtn(param1);
         }
         else if(int(param1.text) > Math.floor(MainScreen.getPlayer().playerInfo.medal / this.itemData.price))
         {
            param1.text = "" + Math.floor(MainScreen.getPlayer().playerInfo.medal / this.itemData.price);
         }
      }
      
      private function enableBuyBtn(param1:int) : Boolean
      {
         return MainScreen.getPlayer().playerInfo.medal - param1 >= 0;
      }
      
      [Bindable(event="propertyChange")]
      private function get itemData() : ObjectProxy
      {
         return this._1177034077itemData;
      }
      
      public function ___BuyItemWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      internal function onMinBtn(param1:TextInput) : void
      {
         param1.text = "" + (MainScreen.getPlayer().playerInfo.medal - this.itemData.price >= 0 ? 1 : 0);
         param1.setFocus();
         this.moveCursorToEnd(param1);
      }
      
      public function ___closeWinBtn_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function set _closeWinBtn(param1:Button) : void
      {
         var _loc2_:Object = this._344839367_closeWinBtn;
         if(_loc2_ !== param1)
         {
            this._344839367_closeWinBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_closeWinBtn",_loc2_,param1));
         }
      }
      
      private function close() : void
      {
         this.itemData = null;
         this.onBuyItem = null;
         this.closeFunc.apply(null,[this]);
      }
      
      public function ___buyBtn_click(param1:MouseEvent) : void
      {
         this.onBuyBtn();
      }
   }
}

