// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.SecurityCodeNotice

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
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

    public class SecurityCodeNotice extends Canvas 
    {

        public static var instance:SecurityCodeNotice = new (SecurityCodeNotice)();

        private var _1039690024notice:Text;
        private var _110843959type1:Canvas;
        private var _1271618531YesSubmitBtn:Button;
        private var _109757064stack:ViewStack;
        private var isTryUser:Boolean = false;
        private var isFavorite:Boolean = false;
        private var _708816317NoSubmitBtn:Button;
        private var _1290918176evtImg:Image;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":650,
                    "height":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "89";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"randeventTextbg",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":73,
                                            "text":"Security Code Update",
                                            "styleName":"randEventTitle",
                                            "x":208
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"iconBg",
                                            "width":115,
                                            "height":115,
                                            "x":67,
                                            "y":51,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"evtImg",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/icon/lock.png"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 5312268;
                                        this.fontSize = 14;
                                        this.top = "187";
                                        this.left = "65.5";
                                        this.right = "65.5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"To better protect our players, we have set up a new Security Code Protection system. We noticed you have not set a Security Code yet. In order to better protect your account, we recommend that you take a few minutes to activate your Security Code Protection!",
                                            "height":170,
                                            "selectable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"stack",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "19";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":640,
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"type1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"YesSubmitBtn",
                                                "events":{"click":"__YesSubmitBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Yes, protect my account now.",
                                                        "styleName":"randEventGreen",
                                                        "x":50
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
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"No thanks.",
                                                        "styleName":"randEventGrey",
                                                        "x":339
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SecurityCodeNotice_Button3_click"},
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

        public function SecurityCodeNotice()
        {
            mx_internal::_document = this;
            this.width = 650;
            this.height = 500;
            this.styleName = "MyWindow";
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


        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        [Bindable(event="propertyChange")]
        public function get stack():ViewStack
        {
            return (this._109757064stack);
        }

        public function ___SecurityCodeNotice_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
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

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        [Bindable(event="propertyChange")]
        public function get evtImg():Image
        {
            return (this._1290918176evtImg);
        }

        public function set evtImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1290918176evtImg;
            if (_local_2 !== _arg_1)
            {
                this._1290918176evtImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "evtImg", _local_2, _arg_1));
            };
        }

        private function btnHandle():void
        {
            if (Context.getInstance().getPlayerBean().isSetSecurityCode)
            {
                ApplySecurityCode.show(0);
            }
            else
            {
                SetSecurityCode.show();
            };
            close();
        }

        public function set stack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._109757064stack;
            if (_local_2 !== _arg_1)
            {
                this._109757064stack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stack", _local_2, _arg_1));
            };
        }

        public function set type1(_arg_1:Canvas):void
        {
            var _local_2:Object = this._110843959type1;
            if (_local_2 !== _arg_1)
            {
                this._110843959type1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type1", _local_2, _arg_1));
            };
        }

        public function set notice(_arg_1:Text):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
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

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get type1():Canvas
        {
            return (this._110843959type1);
        }


    }
}//package view.module.playerInfo

