// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.newarmy.ResourceInput

package autoevony.gui.newarmy
{
    import mx.containers.HBox;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
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

    public class ResourceInput extends HBox 
    {

        private var _960438664rInput:TextInput;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":115,
                    "height":23,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"rInput",
                        "events":{"change":"__rInput_change"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":96,
                                "height":23,
                                "text":"0",
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
                                    "events":{"click":"___ResourceInput_Button1_click"},
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
                                    "events":{"click":"___ResourceInput_Button2_click"},
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

        public function ResourceInput()
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
            this.width = 115;
            this.height = 23;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public function ___ResourceInput_Button1_click(_arg_1:MouseEvent):void
        {
            parentDocument.onMaxBtn(this.rInput);
        }

        public function ___ResourceInput_Button2_click(_arg_1:MouseEvent):void
        {
            parentDocument.onMinBtn(this.rInput);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function set rInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._960438664rInput;
            if (_local_2 !== _arg_1)
            {
                this._960438664rInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rInput():TextInput
        {
            return (this._960438664rInput);
        }

        public function __rInput_change(_arg_1:Event):void
        {
            parentDocument.onResoChange((_arg_1.currentTarget as TextInput));
        }


    }
}//package autoevony.gui.newarmy

