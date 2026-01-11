// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.ExpelMemberWin

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import autoevony.gui.AccountInfo;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import mx.events.FlexEvent;
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

    public class ExpelMemberWin extends Canvas 
    {

        private var _1693934272retireMemberName:TextInput;
        private var closeFunc:Function = null;
        private var _775009873_AllianceRetire_Button1:Button;
        private var _677560724_AllianceRetire_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":200,
                    "width":440,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Expel Member"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AllianceRetire_Label2",
                        "stylesFactory":function ():void
                        {
                            this.top = "70";
                            this.left = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Enter the member name to expel",
                                "selectable":false,
                                "styleName":"PropertyName1",
                                "width":285
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"retireMemberName",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "70";
                            this.left = "25";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"textInput"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AllianceRetire_Button1",
                        "events":{"click":"___AllianceRetire_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "30";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"OK",
                                "styleName":"REwinOkayBtn",
                                "width":75
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ExpelMemberWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"close",
                                "y":0
                            });
                        }
                    })]
                });
            }
        });
        private var membersArray:ArrayCollection = new ArrayCollection();

        public function ExpelMemberWin()
        {
            mx_internal::_document = this;
            this.height = 200;
            this.width = 440;
            this.addEventListener("creationComplete", this.___ExpelMemberWin_Canvas1_creationComplete);
        }

        [Bindable(event="propertyChange")]
        public function get retireMemberName():TextInput
        {
            return (this._1693934272retireMemberName);
        }

        public function ___ExpelMemberWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE, this.onKickOutMemberFromAlliance);
            this.retireMemberName.setFocus();
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceRetire_Button1():Button
        {
            return (this._775009873_AllianceRetire_Button1);
        }

        private function submitRetire():void
        {
            if (((this.retireMemberName.text == null) || (this.retireMemberName.text == "")))
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You must enter a valid player name."));
                return;
            };
            var _local_1:PlayerInfoBean;
            var _local_2:int;
            while (_local_2 < this.membersArray.length)
            {
                _local_1 = (this.membersArray[_local_2] as PlayerInfoBean);
                if (_local_1.userName != this.retireMemberName.text)
                {
                    if (_local_2 >= (this.membersArray.length - 1))
                    {
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "This player is not in your alliance."));
                    };
                }
                else
                {
                    if (_local_1.levelId == AllianceConstants.LAST_POWER_FOR_ALLIANCE)
                    {
                        ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.retireMemberName.text);
                    }
                    else
                    {
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Are you sure you want to expel this Officer from the alliance?", this.onClickOk, "Yes"));
                    };
                    return;
                };
                _local_2++;
            };
        }

        public function set retireMemberName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1693934272retireMemberName;
            if (_local_2 !== _arg_1)
            {
                this._1693934272retireMemberName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "retireMemberName", _local_2, _arg_1));
            };
        }

        public function updateInfo(_arg_1:ArrayCollection, _arg_2:Function=null):void
        {
            this.membersArray = _arg_1;
            this.closeFunc = _arg_2;
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        private function onKickOutMemberFromAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Expelled member successfully."));
                AccountInfo.getInstance().allianceInfo.members.fetchPage();
                this.close();
            };
        }

        private function onClickOk(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.retireMemberName.text);
            };
        }

        public function ___ExpelMemberWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function set _AllianceRetire_Button1(_arg_1:Button):void
        {
            var _local_2:Object = this._775009873_AllianceRetire_Button1;
            if (_local_2 !== _arg_1)
            {
                this._775009873_AllianceRetire_Button1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceRetire_Button1", _local_2, _arg_1));
            };
        }

        public function set _AllianceRetire_Label2(_arg_1:Label):void
        {
            var _local_2:Object = this._677560724_AllianceRetire_Label2;
            if (_local_2 !== _arg_1)
            {
                this._677560724_AllianceRetire_Label2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceRetire_Label2", _local_2, _arg_1));
            };
        }

        public function close():void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE, this.onKickOutMemberFromAlliance);
            this.closeFunc.apply(null, [this]);
        }

        public function ___AllianceRetire_Button1_click(_arg_1:MouseEvent):void
        {
            this.submitRetire();
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceRetire_Label2():Label
        {
            return (this._677560724_AllianceRetire_Label2);
        }


    }
}//package autoevony.gui.info.Alliance

