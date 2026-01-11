package autoevony.gui.info.Alliance
{
   import autoevony.gui.MainScreen;
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
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.styles.*;
   
   public class JoinButton_inlineComponent0 extends VBox
   {
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function JoinButton_inlineComponent0()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":VBox,
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
                  "events":{"click":"___JoinButton_inlineComponent0_Button1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Join",
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
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function ___JoinButton_inlineComponent0_Button1_click(param1:MouseEvent) : void
      {
         MainScreen.getInstance()._accountInfo.allianceInfo.acceptInvitationForAlliance(data);
      }
   }
}

