// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HeroDescribeWin

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
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

    public class HeroDescribeWin extends Canvas 
    {

        public static var instancePopup:HeroDescribeWin;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "height":300,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":8,
                                "text":"Info",
                                "styleName":"funtionWindowTitle",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HeroDescribeWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"desc",
                        "stylesFactory":function ():void
                        {
                            this.backgroundAlpha = 0;
                            this.borderStyle = "none";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "editable":false,
                                "selectable":false,
                                "y":69,
                                "styleName":"ParamgraphText1",
                                "height":191
                            });
                        }
                    })]
                });
            }
        });
        private var _3079825desc:TextArea;

        public function HeroDescribeWin()
        {
            mx_internal::_document = this;
            this.width = 400;
            this.height = 300;
        }

        public static function show(_arg_1:String):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (HeroDescribeWin)();
            };
            if (!instancePopup.isPopUp)
            {
                PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            };
            if ((Application.application.width - instancePopup.width) > 0)
            {
                instancePopup.x = (((Application.application.width - instancePopup.width) / 2) - 150);
                instancePopup.y = (((Application.application.height - instancePopup.height) / 2) - 30);
                PopUpManager.bringToFront(instancePopup);
            }
            else
            {
                PopUpManager.centerPopUp(instancePopup);
            };
            instancePopup.desc.text = _arg_1;
        }


        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ___HeroDescribeWin_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set desc(_arg_1:TextArea):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get desc():TextArea
        {
            return (this._3079825desc);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.module.herosMansion

