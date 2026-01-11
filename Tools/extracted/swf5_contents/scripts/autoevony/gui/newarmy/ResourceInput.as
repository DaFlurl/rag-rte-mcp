package autoevony.gui.newarmy
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
   
   public class ResourceInput extends HBox
   {
      private var _960438664rInput:TextInput;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ResourceInput()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {
                  "width":115,
                  "height":23,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":TextInput,
                     "id":"rInput",
                     "events":{"change":"__rInput_change"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":96,
                           "height":23,
                           "text":"0",
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
                              "events":{"click":"___ResourceInput_Button1_click"},
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
                              "events":{"click":"___ResourceInput_Button2_click"},
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
         this.width = 115;
         this.height = 23;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public function ___ResourceInput_Button1_click(param1:MouseEvent) : void
      {
         parentDocument.onMaxBtn(this.rInput);
      }
      
      public function ___ResourceInput_Button2_click(param1:MouseEvent) : void
      {
         parentDocument.onMinBtn(this.rInput);
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set rInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._960438664rInput;
         if(_loc2_ !== param1)
         {
            this._960438664rInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rInput",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get rInput() : TextInput
      {
         return this._960438664rInput;
      }
      
      public function __rInput_change(param1:Event) : void
      {
         parentDocument.onResoChange(param1.currentTarget as TextInput);
      }
   }
}

