// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Items.ItemCountInput

package autoevony.gui.info.Items
{
    import mx.containers.HBox;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.Event;
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

    public class ItemCountInput extends HBox 
    {

        private var _1042144995_useCountInput:TextInput;
        public var parentWin:*;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":85,
                    "height":23,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"_useCountInput",
                        "events":{"change":"___useCountInput_change"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":66,
                                "height":23,
                                "text":"1",
                                "maxChars":10,
                                "restrict":"0-9",
                                "styleName":"textInput"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 1;
                            this.paddingLeft = 0;
                            this.paddingRight = 0;
                            this.paddingTop = 0;
                            this.paddingBottom = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":19,
                                "height":23,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ItemCountInput_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":19,
                                            "height":11,
                                            "focusEnabled":false,
                                            "styleName":"REnumStepUpBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ItemCountInput_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":19,
                                            "height":11,
                                            "focusEnabled":false,
                                            "styleName":"REnumStepDnBtn"
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });

        public function ItemCountInput()
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
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
            this.width = 85;
            this.height = 23;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        [Bindable(event="propertyChange")]
        public function get _useCountInput():TextInput
        {
            return (this._1042144995_useCountInput);
        }

        public function ___useCountInput_change(_arg_1:Event):void
        {
            this.parentWin.onUseCountChange((_arg_1.currentTarget as TextInput));
        }

        public function set _useCountInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1042144995_useCountInput;
            if (_local_2 !== _arg_1)
            {
                this._1042144995_useCountInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useCountInput", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function ___ItemCountInput_Button1_click(_arg_1:MouseEvent):void
        {
            this.parentWin.onMaxBtn(this._useCountInput);
        }

        public function ___ItemCountInput_Button2_click(_arg_1:MouseEvent):void
        {
            this.parentWin.onMinBtn(this._useCountInput);
        }


    }
}//package autoevony.gui.info.Items

