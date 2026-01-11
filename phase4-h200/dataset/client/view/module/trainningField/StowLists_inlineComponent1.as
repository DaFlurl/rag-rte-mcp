// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.StowLists_inlineComponent1

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

    public class StowLists_inlineComponent1 extends HBox 
    {

        private var _969497207radionBtn:RadioButton;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":RadioButton,
                        "id":"radionBtn",
                        "events":{"click":"__radionBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({"selected":false});
                        }
                    })]});
            }
        });
        private var _88844982outerDocument:StowLists;

        public function StowLists_inlineComponent1()
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
        public function get radionBtn():RadioButton
        {
            return (this._969497207radionBtn);
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

        public function __radionBtn_click(_arg_1:MouseEvent):void
        {
            parentDocument.setCoordinate(data);
        }

        public function set radionBtn(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._969497207radionBtn;
            if (_local_2 !== _arg_1)
            {
                this._969497207radionBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radionBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():StowLists
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.trainningField

