// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FbBarTooltip

package view.ui
{
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import view.ViewMessage;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import view.MainWin;
    import mx.events.PropertyChangeEvent;
    import view.RandomEventWin;
    import com.evony.Context;
    import flash.external.ExternalInterface;
    import mx.managers.BrowserManager;
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

    public class FbBarTooltip extends BaseTooltip 
    {

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.left = "5";
                            this.right = "5";
                            this.top = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tooltip",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FbBarTooltip_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Send Gift",
                                            "styleName":"chatPopupBtn",
                                            "width":119
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FbBarTooltip_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Messages",
                                            "styleName":"chatPopupBtn",
                                            "width":119
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FbBarTooltip_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Visit Empire",
                                            "styleName":"chatPopupBtn",
                                            "width":119
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FbBarTooltip_Button4_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"More",
                                            "styleName":"chatPopupBtn",
                                            "width":119
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _3237038info:Object = new Object();

        public function FbBarTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "doubleLineBlue";
        }

        private function upHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get info():Object
        {
            return (this._3237038info);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ReadVisitMessage():void
        {
            PopUpManager.removePopUp(this);
            ViewMessage.show(info);
        }

        public function ___FbBarTooltip_Button1_click(_arg_1:MouseEvent):void
        {
            SendGift();
        }

        public function ___FbBarTooltip_Button2_click(_arg_1:MouseEvent):void
        {
            ReadVisitMessage();
        }

        private function SendGift():void
        {
            PopUpManager.removePopUp(this);
            navigateToURL(new URLRequest(((((((GameConfig.instance.SendGiftUrl + "?SID=") + info.server) + "&TargetFbuid=") + info.fbid) + "&SelfSID=") + GameConfig.instance.serverID)), "_blank");
        }

        public function showMore():void
        {
            PopUpManager.removePopUp(this);
            NeighborInfo.show(info);
        }

        override public function refresh():void
        {
            MainWin.instance.addEventListener(MouseEvent.MOUSE_UP, upHandle);
        }

        public function set info(_arg_1:Object):void
        {
            var _local_2:Object = this._3237038info;
            if (_local_2 !== _arg_1)
            {
                this._3237038info = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "info", _local_2, _arg_1));
            };
        }

        public function ___FbBarTooltip_Button3_click(_arg_1:MouseEvent):void
        {
            VisitEmpire();
        }

        public function ___FbBarTooltip_Button4_click(_arg_1:MouseEvent):void
        {
            showMore();
        }

        private function VisitEmpire():void
        {
            var _local_3:String;
            var _local_4:String;
            RandomEventWin.show(5);
            PopUpManager.removePopUp(this);
            var _local_1:String = Context.getInstance().fbUrl;
            var _local_2:RegExp = /type=facebook&/gi;
            _local_1 = _local_1.replace("type=facebook&", "type=fbVisit&");
            _local_1 = ((((((_local_1 + "&TargetFbuid=") + info.fbid) + "&TargetFbUserName=") + info.name) + "&FromServer=") + GameConfig.instance.serverID);
            _local_3 = (((("http://" + info.server) + ".evony.com/s.html?loginid=") + Context.getInstance().EncryptParam(_local_1)) + "&adv=www_evony_com_inde&FBS=1&_Vt=NVE");
            if (ExternalInterface.available)
            {
                _local_4 = ExternalInterface.call("getPageUrl");
            };
            if (_local_4 == null)
            {
                _local_4 = ("" + BrowserManager.getInstance().url);
            };
            if (_local_4.indexOf("gsvn.evony.com") >= 0)
            {
                _local_3 = (("/s.html?loginid=" + Context.getInstance().EncryptParam(_local_1)) + "&adv=www_evony_com_inde&FBS=1&_Vt=NVE");
            };
            navigateToURL(new URLRequest(_local_3), "VisitEmpire");
        }


    }
}//package view.ui

