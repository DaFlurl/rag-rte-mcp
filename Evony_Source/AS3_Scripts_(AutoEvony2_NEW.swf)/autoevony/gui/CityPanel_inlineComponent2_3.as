// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel_inlineComponent2_3

package autoevony.gui
{
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class CityPanel_inlineComponent2_3 extends HBox 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_heroViewBtn",
                        "events":{"click":"___heroViewBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"View",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });
        private var _1211475550_heroViewBtn:Button;

        public function CityPanel_inlineComponent2_3()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalGap = 0;
                this.verticalGap = 0;
                this.paddingLeft = 3;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function set _heroViewBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1211475550_heroViewBtn;
            if (_local_2 !== _arg_1)
            {
                this._1211475550_heroViewBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_heroViewBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _heroViewBtn():Button
        {
            return (this._1211475550_heroViewBtn);
        }

        public function ___heroViewBtn_click(_arg_1:MouseEvent):void
        {
            parentDocument._onViewHeroBtn(data.col7);
        }


    }
}//package autoevony.gui

