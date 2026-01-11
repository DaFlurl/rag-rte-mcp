package autoevony.gui.info.Alliance
{
   import mx.controls.Label;
   import mx.events.PropertyChangeEvent;
   
   public class InviteMember_inlineComponent1 extends Label
   {
      
      private var _88844982outerDocument:AllianceInviteMemberWin;
      
      public function InviteMember_inlineComponent1()
      {
         super();
         this.text = "Unavailable";
      }
      
      override public function initialize() : void
      {
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get outerDocument() : AllianceInviteMemberWin
      {
         return this._88844982outerDocument;
      }
      
      public function set outerDocument(param1:AllianceInviteMemberWin) : void
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

