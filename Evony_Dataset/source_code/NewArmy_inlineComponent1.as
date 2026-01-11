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
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class NewArmy_inlineComponent1 extends HBox
   {
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _1370006693_viewArmyBtn:Button;
      
      public function NewArmy_inlineComponent1()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"_viewArmyBtn",
                  "events":{"click":"___viewArmyBtn_click"},
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
      
      public function ___viewArmyBtn_click(param1:MouseEvent) : void
      {
         parentDocument.onViewArmyBtn(data);
      }
      
      [Bindable(event="propertyChange")]
      public function get _viewArmyBtn() : Button
      {
         return this._1370006693_viewArmyBtn;
      }
      
      public function set _viewArmyBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1370006693_viewArmyBtn;
         if(_loc2_ !== param1)
         {
            this._1370006693_viewArmyBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_viewArmyBtn",_loc2_,param1));
         }
      }
   }
}

