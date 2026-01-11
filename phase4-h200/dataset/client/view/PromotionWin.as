// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.PromotionWin

package view
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
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

    public class PromotionWin extends Canvas 
    {

        public static var instance:PromotionWin = new (PromotionWin)();

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":600,
                    "height":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
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
                                        return ({"source":"images/promotion1.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"YesSubmitBtn",
                                    "events":{"click":"__YesSubmitBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.bottom = "80";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PromotionBtn",
                                            "x":140
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
                                        this.right = "100";
                                        this.bottom = "80";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PromotionAcceptBtn"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___PromotionWin_Button3_click"},
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
        private var _708816317NoSubmitBtn:Button;
        private var _1271618531YesSubmitBtn:Button;
        private var _1290918176evtImg:Image;

        public function PromotionWin()
        {
            mx_internal::_document = this;
            this.width = 600;
            this.height = 500;
            this.styleName = "MyWindow";
        }

        public static function close():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function btnHandle():void
        {
            navigateToURL(new URLRequest(((GameConfig.instance.addFund + "&hugeSavings=1&user=") + Context.getInstance().userName)), "_blank");
        }


        [Bindable(event="propertyChange")]
        public function get evtImg():Image
        {
            return (this._1290918176evtImg);
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

        public function ___PromotionWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
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

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        public function show():void
        {
            if (Context.getInstance().needUserGuide)
            {
                return;
            };
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainWin.instance.allWindowsFrame, true);
                MinePopupManager.instance.centerPopUp();
            };
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


    }
}//package view

