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
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class CityPanel_inlineComponent1 extends HBox
   {
      
      private var lastTime:Number = 0;
      
      private var _1589444121_abandonValleyBtn:Button;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function CityPanel_inlineComponent1()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"_abandonValleyBtn",
                  "events":{"click":"___abandonValleyBtn_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Abandon",
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
            this.paddingLeft = 3;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
      }
      
      private function btnClickAbandonValley(param1:int) : void
      {
         var _loc2_:Number = Number(new Date().getTime());
         if(_loc2_ < this.lastTime + 3000)
         {
            return;
         }
         this.lastTime = _loc2_;
         parentDocument._onAbandonFieldBtn(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _abandonValleyBtn() : Button
      {
         return this._1589444121_abandonValleyBtn;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function ___abandonValleyBtn_click(param1:MouseEvent) : void
      {
         this.btnClickAbandonValley(data.col5);
      }
      
      public function set _abandonValleyBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1589444121_abandonValleyBtn;
         if(_loc2_ !== param1)
         {
            this._1589444121_abandonValleyBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_abandonValleyBtn",_loc2_,param1));
         }
      }
   }
}

