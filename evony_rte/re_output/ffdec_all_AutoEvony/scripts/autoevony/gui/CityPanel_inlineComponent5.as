package autoevony.gui
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
   import mx.controls.Button;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class CityPanel_inlineComponent5 extends HBox
   {
      
      private var lastTime:Number = 0;
      
      private var _3202804hire:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function CityPanel_inlineComponent5()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Spacer,
                  "propertiesFactory":function():Object
                  {
                     return {"width":3};
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"hire",
                  "events":{"click":"__hire_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":true,
                        "label":"Hire",
                        "styleName":"REwinBtn"
                     };
                  }
               })]};
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
         };
      }
      
      public function set hire(param1:Button) : void
      {
         var _loc2_:Object = this._3202804hire;
         if(_loc2_ !== param1)
         {
            this._3202804hire = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hire",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hire() : Button
      {
         return this._3202804hire;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function _btnClickHireHero(param1:String) : void
      {
         var _loc2_:Date = new Date();
         if(_loc2_.getTime() < this.lastTime + 3000)
         {
            return;
         }
         this.lastTime = _loc2_.getTime();
         parentDocument._hireHero(param1);
      }
      
      public function __hire_click(param1:MouseEvent) : void
      {
         this._btnClickHireHero(data.col1);
      }
   }
}

