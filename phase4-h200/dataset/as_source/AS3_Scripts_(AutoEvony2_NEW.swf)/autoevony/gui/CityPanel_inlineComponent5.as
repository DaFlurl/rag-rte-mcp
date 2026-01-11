// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel_inlineComponent5

package autoevony.gui
{
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Spacer;
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

    public class CityPanel_inlineComponent5 extends HBox 
    {

        private var lastTime:Number = 0;
        private var _3202804hire:Button;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Spacer,
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":3});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"hire",
                        "events":{"click":"__hire_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":true,
                                "label":"Hire",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });

        public function CityPanel_inlineComponent5()
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
            };
        }

        public function set hire(_arg_1:Button):void
        {
            var _local_2:Object = this._3202804hire;
            if (_local_2 !== _arg_1)
            {
                this._3202804hire = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hire", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hire():Button
        {
            return (this._3202804hire);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        private function _btnClickHireHero(_arg_1:String):void
        {
            var _local_2:Date = new Date();
            if (_local_2.getTime() < (this.lastTime + 3000))
            {
                return;
            };
            this.lastTime = _local_2.getTime();
            parentDocument._hireHero(_arg_1);
        }

        public function __hire_click(_arg_1:MouseEvent):void
        {
            this._btnClickHireHero(data.col1);
        }


    }
}//package autoevony.gui

