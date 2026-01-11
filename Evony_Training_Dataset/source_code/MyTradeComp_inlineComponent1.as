// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.MyTradeComp_inlineComponent1

package view.module.market
{
    import mx.containers.HBox;
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

    public class MyTradeComp_inlineComponent1 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CancelBtn,
                        "events":{"click":"___MyTradeComp_inlineComponent1_CancelBtn1_click"}
                    })]});
            }
        });
        private var _88844982outerDocument:MyTradeComp;

        public function MyTradeComp_inlineComponent1()
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
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function set outerDocument(_arg_1:MyTradeComp):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        public function ___MyTradeComp_inlineComponent1_CancelBtn1_click(_arg_1:MouseEvent):void
        {
            parentDocument.onCancleClick(data);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():MyTradeComp
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.market

