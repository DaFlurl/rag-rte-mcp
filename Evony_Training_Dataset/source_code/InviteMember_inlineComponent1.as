// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.InviteMember_inlineComponent1

package autoevony.gui.info.Alliance
{
    import mx.controls.Label;
    import mx.events.PropertyChangeEvent;

    public class InviteMember_inlineComponent1 extends Label 
    {

        private var _88844982outerDocument:AllianceInviteMemberWin;

        public function InviteMember_inlineComponent1()
        {
            this.text = "Unavailable";
        }

        override public function initialize():void
        {
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():AllianceInviteMemberWin
        {
            return (this._88844982outerDocument);
        }

        public function set outerDocument(_arg_1:AllianceInviteMemberWin):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui.info.Alliance

