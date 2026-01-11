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
   
   public class CityPanel_inlineComponent2_3 extends HBox
   {
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1211475550_heroViewBtn:Button;
      
      public function CityPanel_inlineComponent2_3()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"_heroViewBtn",
                  "events":{"click":"___heroViewBtn_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"View",
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
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set _heroViewBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1211475550_heroViewBtn;
         if(_loc2_ !== param1)
         {
            this._1211475550_heroViewBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_heroViewBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _heroViewBtn() : Button
      {
         return this._1211475550_heroViewBtn;
      }
      
      public function ___heroViewBtn_click(param1:MouseEvent) : void
      {
         parentDocument._onViewHeroBtn(data.col7);
      }
   }
}

