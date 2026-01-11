// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel_inlineComponent1

package autoevony.gui
{
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
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

    public class CityPanel_inlineComponent1 extends HBox 
    {

        private var lastTime:Number = 0;
        private var _1589444121_abandonValleyBtn:Button;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_abandonValleyBtn",
                        "events":{"click":"___abandonValleyBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Abandon",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });

        public function CityPanel_inlineComponent1()
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

        private function btnClickAbandonValley(_arg_1:int):void
        {
            var _local_2:Number = new Date().getTime();
            if (_local_2 < (this.lastTime + 3000))
            {
                return;
            };
            this.lastTime = _local_2;
            parentDocument._onAbandonFieldBtn(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get _abandonValleyBtn():Button
        {
            return (this._1589444121_abandonValleyBtn);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function ___abandonValleyBtn_click(_arg_1:MouseEvent):void
        {
            this.btnClickAbandonValley(data.col5);
        }

        public function set _abandonValleyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1589444121_abandonValleyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1589444121_abandonValleyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_abandonValleyBtn", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui

