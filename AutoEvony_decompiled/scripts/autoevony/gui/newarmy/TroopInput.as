package autoevony.gui.newarmy
{
   import autoevony.common.Utils;
   import autoevony.gui.controls.themes.ThemeManager;
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
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class TroopInput extends HBox implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const WARN_APPEND:String = "The entered value is unsafe and will get 0% heal rate if all die in the battle!";
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      private var _903180362tInput:TextInput;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var type:int;
      
      public function TroopInput()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":80,
                  "height":23,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":TextInput,
                     "id":"tInput",
                     "events":{"change":"__tInput_change"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":61,
                           "height":23,
                           "text":"0",
                           "restrict":"0-9",
                           "styleName":"textInput"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":VBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 0;
                        this.verticalGap = 1;
                        this.paddingLeft = 0;
                        this.paddingRight = 0;
                        this.paddingTop = 0;
                        this.paddingBottom = 0;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":19,
                           "height":23,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___TroopInput_Button1_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":19,
                                    "height":11,
                                    "focusEnabled":false,
                                    "styleName":"REnumStepUpBtn"
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "events":{"click":"___TroopInput_Button2_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":19,
                                    "height":11,
                                    "focusEnabled":false,
                                    "styleName":"REnumStepDnBtn"
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.horizontalGap = 0;
            this.verticalGap = 0;
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
         this.width = 80;
         this.height = 23;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___TroopInput_HBox1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         TroopInput._watcherSetupUtil = param1;
      }
      
      private function _TroopInput_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = parentDocument._applyStygandrsBannerOfTheHorde.selected ? 7 : 6;
      }
      
      public function set tInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._903180362tInput;
         if(_loc2_ !== param1)
         {
            this._903180362tInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tInput",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:TroopInput = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._TroopInput_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_newarmy_TroopInputWatcherSetupUtil");
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
      
      private function init() : void
      {
         this.type = Utils.troopAbrNames.indexOf(this.id.substr(7).toLowerCase());
      }
      
      public function ___TroopInput_Button1_click(param1:MouseEvent) : void
      {
         parentDocument.onMaxBtn(this.tInput);
         this.onChange();
      }
      
      public function ___TroopInput_Button2_click(param1:MouseEvent) : void
      {
         parentDocument.onMinBtn(this.tInput);
         this.onChange();
      }
      
      private function _TroopInput_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():int
         {
            return parentDocument._applyStygandrsBannerOfTheHorde.selected ? 7 : 6;
         },function(param1:int):void
         {
            tInput.maxChars = param1;
         },"tInput.maxChars");
         result[0] = binding;
         return result;
      }
      
      private function onChange() : void
      {
         var _loc1_:Number = int(this.tInput.text) * Utils.TROOP_EXP_VALUES[this.type];
         if(Math.floor(_loc1_ / 2147483647) % 2 == 0)
         {
            this.tInput.setStyle("backgroundColor","#" + int(ThemeManager.getStyle("." + this.tInput.styleName,"backgroundColor")).toString(16).toUpperCase());
            this.tInput.toolTip = int(this.tInput.text) != 0 ? "(safe) " + "\n-" + Utils.formatNum(int(this.tInput.text) - Math.floor(_loc1_ % 2147483647 / Utils.TROOP_EXP_VALUES[this.type]) != 0 ? Math.floor(_loc1_ % 2147483647 / Utils.TROOP_EXP_VALUES[this.type]) + 1 : 0) + "  +" + Utils.formatNum(Math.floor((2147483647 - _loc1_ % 2147483647) / Utils.TROOP_EXP_VALUES[this.type])) : "";
         }
         else
         {
            this.tInput.setStyle("backgroundColor","#CC7776");
            this.tInput.toolTip = "(unsafe)\n-" + Utils.formatNum(Math.floor(_loc1_ % 2147483647 / Utils.TROOP_EXP_VALUES[this.type]) + 1) + "  +" + Utils.formatNum(Math.floor((2147483647 - _loc1_ % 2147483647) / Utils.TROOP_EXP_VALUES[this.type])) + "\n\n" + WARN_APPEND;
         }
      }
      
      public function ___TroopInput_HBox1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function __tInput_change(param1:Event) : void
      {
         parentDocument.onTroopChange(param1.currentTarget as TextInput);
         this.onChange();
      }
      
      [Bindable(event="propertyChange")]
      public function get tInput() : TextInput
      {
         return this._903180362tInput;
      }
   }
}

