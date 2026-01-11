// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.UnlockSecurityCode

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.controls.Button;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.common.module.CommandResponse;
    import view.castleList.ColonyInfoWin;
    import view.module.office.GiveupCastle;
    import view.module.barrack.SWDisband;
    import view.module.herosMansion.HeroProperties;
    import view.module.office.AdjustmentCess;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import mx.managers.PopUpManager;
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

    public class UnlockSecurityCode extends Canvas 
    {

        public static var instance:UnlockSecurityCode = new (UnlockSecurityCode)();

        private var _2020316904flagSubmitBtn:Button;
        private var _79017872optionId:int;
        private var _2095520559playerInfo:PlayerInfoBean;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":540,
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
                                            "text":"Unlock Security Code",
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
                            this.top = "60";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"flagSubmitBtn",
                                    "events":{"click":"__flagSubmitBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.top = "10";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Unlock This Operation",
                                            "toolTip":"Unlock this protected operation with your Security Code.",
                                            "styleName":"y165",
                                            "width":220
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___UnlockSecurityCode_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.top = "10";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Unlock All Operation",
                                            "toolTip":"Unlock all protected operations with your Security Code.",
                                            "styleName":"y165",
                                            "width":220
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "10";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":380,
                                            "htmlText":"Will only be effective during this session and will end at logout.",
                                            "styleName":"ParamgraphText1",
                                            "selectable":false
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UnlockSecurityCode_Button3_click"},
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

        public function UnlockSecurityCode()
        {
            mx_internal::_document = this;
            this.width = 540;
            this.height = 200;
        }

        public static function show(_arg_1:int):void
        {
            instance.optionId = _arg_1;
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        private function onResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (optionId == 1)
                {
                    ColonyInfoWin.instance.abandon();
                }
                else
                {
                    if (optionId == 2)
                    {
                        GiveupCastle.instancePopup.giveUpCastle();
                    }
                    else
                    {
                        if (optionId == 4)
                        {
                            SWDisband.instance.troopDisband();
                        }
                        else
                        {
                            if (optionId == 8)
                            {
                                HeroProperties.instance.onAlertClose(true);
                            }
                            else
                            {
                                if (optionId == 16)
                                {
                                    AdjustmentCess.instancePopup.submitHandle();
                                };
                            };
                        };
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
            close();
        }

        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(1);
        }

        public function reFresh():void
        {
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
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

        private function set optionId(_arg_1:int):void
        {
            var _local_2:Object = this._79017872optionId;
            if (_local_2 !== _arg_1)
            {
                this._79017872optionId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "optionId", _local_2, _arg_1));
            };
        }

        private function btnHandle(_arg_1:int):void
        {
            if (_arg_1 == 1)
            {
                ActionFactory.getInstance().getSecurityCommands().setUnlockOption(optionId, onResponse);
            }
            else
            {
                ActionFactory.getInstance().getSecurityCommands().setUnlockOption(31, onResponse);
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
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

        [Bindable(event="propertyChange")]
        private function get optionId():int
        {
            return (this._79017872optionId);
        }

        private function close():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___UnlockSecurityCode_Button2_click(_arg_1:MouseEvent):void
        {
            btnHandle(2);
        }

        public function ___UnlockSecurityCode_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }


    }
}//package view.module.playerInfo

