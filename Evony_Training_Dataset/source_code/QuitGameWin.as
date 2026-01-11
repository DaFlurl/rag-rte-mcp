// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.QuitGameWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
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

    public class QuitGameWin extends Canvas 
    {

        public static var instance:QuitGameWin = new (QuitGameWin)();

        private var isFavorite:Boolean = false;
        private var _708816317NoSubmitBtn:Button;
        private var _1271618531YesSubmitBtn:Button;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":250,
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
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"SYSTEM",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                        this.left = "30";
                                        this.right = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "text":"Since you have not registered your Evony account, your game progress won't be saved. Would you like to register and save game?",
                                            "height":100,
                                            "selectable":false
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"YesSubmitBtn",
                        "events":{"click":"__YesSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.left = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"YES",
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"NoSubmitBtn",
                        "events":{"click":"__NoSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.right = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"NO",
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___QuitGameWin_Button3_click"},
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
                    })]
                });
            }
        });
        private var isTryUser:Boolean = false;

        public function QuitGameWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 250;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        public function set YesSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1271618531YesSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1271618531YesSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "YesSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
        }

        private function btnHandle():void
        {
            RegisterInfoWin.show();
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }

        public function set NoSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._708816317NoSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._708816317NoSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "NoSubmitBtn", _local_2, _arg_1));
            };
        }

        public function ___QuitGameWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }


    }
}//package view.ui

