// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.CancelSecurityCode

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.containers.VBox;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
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

    public class CancelSecurityCode extends Canvas 
    {

        public static var instance:CancelSecurityCode = new (CancelSecurityCode)();

        private var _2095520559playerInfo:PlayerInfoBean;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":200,
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
                                            "text":"Security Code",
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
                            this.top = "70";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":110,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"buildingDescNewBox",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":360,
                                                        "htmlText":"To cancel the Security Code reset, click on the Abort Cancellation Process button.  Your security code will remain what it was before you began the reset.",
                                                        "styleName":"ParamgraphText1",
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"flagSubmitBtn",
                        "events":{"click":"__flagSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "30";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Abort Cancellation Process",
                                "toolTip":"If you should remember your Security Code during the 72 hour wait time, you may abort the cancellation process.",
                                "styleName":"y165",
                                "width":260
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CancelSecurityCode_Button2_click"},
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
        private var _2020316904flagSubmitBtn:Button;
        private var _3145580flag:int;

        public function CancelSecurityCode()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 200;
        }

        public static function show(_arg_1:int):void
        {
            instance.flag = _arg_1;
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            removeHandle();
        }

        public function reFresh():void
        {
        }

        private function removeHandle():void
        {
            AlertWin.show("Abort the cancellation process, are you sure to continue?", onClick, "Ok", "Cancel", null);
        }

        [Bindable(event="propertyChange")]
        private function get flag():int
        {
            return (this._3145580flag);
        }

        [Bindable(event="propertyChange")]
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        public function ___CancelSecurityCode_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function onClick(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getSecurityCommands().cancelRemovingSecurityCodeProcess(onRemoveResponse);
            };
        }

        private function onRemoveResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().bCancelSecurityCode = false;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
            onClose();
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function set flagSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2020316904flagSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._2020316904flagSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagSubmitBtn", _local_2, _arg_1));
            };
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function set flag(_arg_1:int):void
        {
            var _local_2:Object = this._3145580flag;
            if (_local_2 !== _arg_1)
            {
                this._3145580flag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _local_2, _arg_1));
            };
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }


    }
}//package view.module.playerInfo

