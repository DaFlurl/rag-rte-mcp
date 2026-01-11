// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.CheckApply_inlineComponent2

package autoevony.gui.info.Alliance
{
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;

    public class CheckApply_inlineComponent2 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutBtn,
                        "events":{"click":"___CheckApply_inlineComponent2_CheckOutBtn1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({"label":"Approve"});
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckOutBtn,
                        "events":{"click":"___CheckApply_inlineComponent2_CheckOutBtn2_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({"label":"Disapprove"});
                        }
                    })]});
            }
        });
        private var _88844982outerDocument:CheckApplyWin;

        public function CheckApply_inlineComponent2()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function ___CheckApply_inlineComponent2_CheckOutBtn1_click(_arg_1:MouseEvent):void
        {
            this.outerDocument.showMembersMsg(data, true);
        }

        public function ___CheckApply_inlineComponent2_CheckOutBtn2_click(_arg_1:MouseEvent):void
        {
            this.outerDocument.showMembersMsg(data, false);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():CheckApplyWin
        {
            return (this._88844982outerDocument);
        }

        public function set outerDocument(_arg_1:CheckApplyWin):void
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

