package autoevony.gui.info.Alliance
{
   import flash.events.MouseEvent;
   import mx.containers.HBox;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   public class CheckApply_inlineComponent2 extends HBox
   {
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":HBox,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":CheckOutBtn,
               "events":{"click":"___CheckApply_inlineComponent2_CheckOutBtn1_click"},
               "propertiesFactory":function():Object
               {
                  return {"label":"Approve"};
               }
            }),new UIComponentDescriptor({
               "type":CheckOutBtn,
               "events":{"click":"___CheckApply_inlineComponent2_CheckOutBtn2_click"},
               "propertiesFactory":function():Object
               {
                  return {"label":"Disapprove"};
               }
            })]};
         }
      });
      
      private var _88844982outerDocument:CheckApplyWin;
      
      public function CheckApply_inlineComponent2()
      {
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function ___CheckApply_inlineComponent2_CheckOutBtn1_click(param1:MouseEvent) : void
      {
         this.outerDocument.showMembersMsg(data,true);
      }
      
      public function ___CheckApply_inlineComponent2_CheckOutBtn2_click(param1:MouseEvent) : void
      {
         this.outerDocument.showMembersMsg(data,false);
      }
      
      [Bindable(event="propertyChange")]
      public function get outerDocument() : CheckApplyWin
      {
         return this._88844982outerDocument;
      }
      
      public function set outerDocument(param1:CheckApplyWin) : void
      {
         var _loc2_:Object = this._88844982outerDocument;
         if(_loc2_ !== param1)
         {
            this._88844982outerDocument = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"outerDocument",_loc2_,param1));
         }
      }
   }
}

