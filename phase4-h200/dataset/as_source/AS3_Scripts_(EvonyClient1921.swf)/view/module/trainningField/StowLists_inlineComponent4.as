// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.StowLists_inlineComponent4

package view.module.trainningField
{
    import mx.containers.HBox;
    import mx.controls.RadioButton;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class StowLists_inlineComponent4 extends HBox 
    {

        private var _88844982outerDocument:StowLists;
        private var _10357705radionBtn2:RadioButton;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":RadioButton,
                        "id":"radionBtn2",
                        "events":{"click":"__radionBtn2_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({"selected":false});
                        }
                    })]});
            }
        });

        public function StowLists_inlineComponent4()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
            };
            this.percentWidth = 100;
        }

        [Bindable(event="propertyChange")]
        public function get radionBtn2():RadioButton
        {
            return (this._10357705radionBtn2);
        }

        public function set outerDocument(_arg_1:StowLists):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function __radionBtn2_click(_arg_1:MouseEvent):void
        {
            parentDocument.setCoordinate(data);
        }

        public function set radionBtn2(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._10357705radionBtn2;
            if (_local_2 !== _arg_1)
            {
                this._10357705radionBtn2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radionBtn2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():StowLists
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.trainningField

