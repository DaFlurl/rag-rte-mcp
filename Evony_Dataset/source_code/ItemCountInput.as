package autoevony.gui.info.Items
{
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
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ItemCountInput extends HBox
   {
      private var _1042144995_useCountInput:TextInput;
      
      public var parentWin:*;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ItemCountInput()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":85,
                  "height":23,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":TextInput,
                     "id":"_useCountInput",
                     "events":{"change":"___useCountInput_change"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":66,
                           "height":23,
                           "text":"1",
                           "maxChars":10,
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
                              "events":{"click":"___ItemCountInput_Button1_click"},
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
                              "events":{"click":"___ItemCountInput_Button2_click"},
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
         this.width = 85;
         this.height = 23;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      [Bindable(event="propertyChange")]
      public function get _useCountInput() : TextInput
      {
         return this._1042144995_useCountInput;
      }
      
      public function ___useCountInput_change(param1:Event) : void
      {
         this.parentWin.onUseCountChange(param1.currentTarget as TextInput);
      }
      
      public function set _useCountInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1042144995_useCountInput;
         if(_loc2_ !== param1)
         {
            this._1042144995_useCountInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useCountInput",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function ___ItemCountInput_Button1_click(param1:MouseEvent) : void
      {
         this.parentWin.onMaxBtn(this._useCountInput);
      }
      
      public function ___ItemCountInput_Button2_click(param1:MouseEvent) : void
      {
         this.parentWin.onMinBtn(this._useCountInput);
      }
   }
}

