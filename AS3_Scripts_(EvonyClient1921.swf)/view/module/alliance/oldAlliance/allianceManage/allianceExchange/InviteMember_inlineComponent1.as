// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.InviteMember_inlineComponent1

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.controls.Label;
    import mx.events.PropertyChangeEvent;

    public class InviteMember_inlineComponent1 extends Label 
    {

        private var _88844982outerDocument:InviteMember;

        public function InviteMember_inlineComponent1()
        {
            this.text = "Unavailable";
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():InviteMember
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            super.initialize();
        }

        public function set outerDocument(_arg_1:InviteMember):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

