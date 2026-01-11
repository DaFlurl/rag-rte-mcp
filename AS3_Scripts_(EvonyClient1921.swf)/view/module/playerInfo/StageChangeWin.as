// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.StageChangeWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.CheckBox;
    import mx.containers.VBox;
    import mx.controls.ComboBox;
    import mx.validators.NumberValidator;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Image;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.adobe.crypto.SHA1;
    import view.ui.AddFundWin;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.events.ReplayEvent;
    import view.ui.AlertWin;
    import com.evony.common.module.furlough.FurloughResponse;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.beans.BuffBean;
    import view.MainWin;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import mx.binding.BindingManager;
    import mx.events.ListEvent;
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

    use namespace mx_internal;

    public class StageChangeWin extends Canvas implements IBindingClient 
    {

        public static var instance:StageChangeWin = new (StageChangeWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _184092112txtStatusDes:Text;
        private var _651911789stateSubmitBtn:Button;
        private var _276830801cboxAutoExtend:CheckBox;
        private var _95474270desVb:VBox;
        private var _722575234stateChoise:ComboBox;
        private var _313192969numberValidator:NumberValidator;
        private var _26330323lblDays:Label;
        private var _2023558323population:Label;
        private var _2001878452statePassword:TextInput;
        private var _847767552_currState:String;
        private var _1879242324edtDays:TextInput;
        private var _2095520559playerInfo:PlayerInfoBean;
        public var _StageChangeWin_Label1:Label;
        private var _1601089390lblCurrentState:Label;
        public var _StageChangeWin_Label4:Label;
        public var _StageChangeWin_Label5:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":615,
                    "height":400,
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
                                    "id":"_StageChangeWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"stateSubmitBtn",
                        "events":{"click":"__stateSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "45";
                            this.right = "54";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"Blue75",
                                "width":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "63";
                            this.bottom = "41";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"desVb",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalGap = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":243,
                                            "width":535,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "x":0,
                                            "y":10,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"population",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":148,
                                                                    "styleName":"winTitleFont",
                                                                    "height":20
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"lblCurrentState",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":190,
                                                                    "styleName":"winTitleFont"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "source":"images/Controls/tab/line.png",
                                                        "percentWidth":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":98,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"txtStatusDes",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                                this.color = 0xFFFFFF;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":528,
                                                                    "height":115,
                                                                    "styleName":"ParamgraphText3",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "source":"images/Controls/tab/line.png",
                                                        "width":545,
                                                        "height":0
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":525,
                                                        "height":33.692307,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_StageChangeWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":148.5,
                                                                    "styleName":"winTitleFont"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"statePassword",
                                                            "events":{"enter":"__statePassword_enter"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":190,
                                                                    "displayAsPassword":true,
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_StageChangeWin_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":148.5,
                                                                    "styleName":"winTitleFont"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"stateChoise",
                                                            "events":{"change":"__stateChoise_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":190,
                                                                    "styleName":"ParamgraphText2"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"lblDays",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":60,
                                                                    "visible":false,
                                                                    "includeInLayout":false,
                                                                    "styleName":"winTitleFont"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"edtDays",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":34,
                                                                    "visible":false,
                                                                    "includeInLayout":false,
                                                                    "text":"2",
                                                                    "restrict":"0-9",
                                                                    "maxChars":6
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"cboxAutoExtend",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "45";
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":42,
                                "styleName":"CheckBox",
                                "selected":true,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___StageChangeWin_Button2_click"},
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
        private var _863317264choiseArr:Array = new Array({
            "label":Lang.msg("正常"),
            "data":0
        }, {
            "label":Lang.msg("免战"),
            "data":1
        }, {
            "label":Lang.msg("休假"),
            "data":2
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function StageChangeWin()
        {
            mx_internal::_document = this;
            this.width = 615;
            this.height = 400;
            _StageChangeWin_NumberValidator1_i();
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            StageChangeWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:String):void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
            instance._currState = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get edtDays():TextInput
        {
            return (this._1879242324edtDays);
        }

        public function set stateChoise(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._722575234stateChoise;
            if (_local_2 !== _arg_1)
            {
                this._722575234stateChoise = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stateChoise", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get numberValidator():NumberValidator
        {
            return (this._313192969numberValidator);
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

        private function useGoods(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (UIUtil.checkItem("player.peace.1", 1))
                {
                    ActionFactory.getInstance().getCityCommands().setStopWarState("player.peace.1", SHA1.hash(statePassword.text), useGoodsResponse);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        override public function initialize():void
        {
            var target:StageChangeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _StageChangeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_StageChangeWinWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get stateChoise():ComboBox
        {
            return (this._722575234stateChoise);
        }

        public function set numberValidator(_arg_1:NumberValidator):void
        {
            var _local_2:Object = this._313192969numberValidator;
            if (_local_2 !== _arg_1)
            {
                this._313192969numberValidator = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numberValidator", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stateSubmitBtn():Button
        {
            return (this._651911789stateSubmitBtn);
        }

        private function onFurloughCommandsResponse(_arg_1:FurloughResponse):void
        {
            if (_arg_1.ok == 1)
            {
                Context.getInstance().setPlayerBean(_arg_1.playerBean);
                ResponseDispatcher.getInstance().dispatchEvent(new ReplayEvent(ReplayEvent.REPLAYGAME));
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set population(_arg_1:Label):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
            };
        }

        private function set choiseArr(_arg_1:Array):void
        {
            var _local_2:Object = this._863317264choiseArr;
            if (_local_2 !== _arg_1)
            {
                this._863317264choiseArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "choiseArr", _local_2, _arg_1));
            };
        }

        public function set cboxAutoExtend(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._276830801cboxAutoExtend;
            if (_local_2 !== _arg_1)
            {
                this._276830801cboxAutoExtend = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cboxAutoExtend", _local_2, _arg_1));
            };
        }

        private function btnHandle():void
        {
            var _local_1:Boolean;
            var _local_2:int;
            var _local_3:int;
            var _local_4:ItemBean;
            var _local_5:Number;
            var _local_6:Boolean;
            var _local_7:PlayerBean;
            var _local_8:BuffBean;
            if (statePassword.text != "")
            {
                if (stateChoise.selectedItem.data == 1)
                {
                    _local_1 = false;
                    _local_2 = Context.getInstance().getPlayerBean().castlesArray.length;
                    _local_3 = 0;
                    while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
                    {
                        _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                        if (((_local_4.id == "player.peace.1") && (_local_4.count >= 1)))
                        {
                            _local_1 = true;
                            break;
                        };
                        _local_3++;
                    };
                    if (_local_1)
                    {
                        ActionFactory.getInstance().getCityCommands().setStopWarState("player.peace.1", SHA1.hash(statePassword.text), useGoodsResponse);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("物品不足确定购买"), useGoods);
                    };
                }
                else
                {
                    if (stateChoise.selectedIndex == 2)
                    {
                        _local_5 = parseInt(edtDays.text);
                        _local_6 = cboxAutoExtend.selected;
                        if (((_local_5 < 2) || (edtDays.text.length == 0)))
                        {
                            AlertWin.show(Lang.msg("休假天数提示"), null);
                        }
                        else
                        {
                            _local_7 = Context.getInstance().getPlayerBean();
                            if (_local_7.enemyArmysArray.length > 0)
                            {
                                AlertWin.show(Lang.msg("UnderAttackingAlert"), onAttackAlertReturn, "Yes", "No");
                            }
                            else
                            {
                                ActionFactory.getInstance().getFurloughCommands().isFurlought(playerInfo.id, _local_5, SHA1.hash(this.statePassword.text), _local_6, onFurloughCommandsResponse);
                            };
                        };
                    }
                    else
                    {
                        ActionFactory.getInstance().getCommonCommands().delUniteServerPeaceStatus();
                        PlayerInfoWin.instance.stateStr.text = "Normal";
                        _local_3 = 0;
                        while (_local_3 < Context.getInstance().getPlayerBean().buffsArray.length)
                        {
                            _local_8 = (Context.getInstance().getPlayerBean().buffsArray[_local_3] as BuffBean);
                            if (_local_8.typeId == "PlayerPeaceUniteServerBuff")
                            {
                                Context.getInstance().getPlayerBean().buffsArray.removeItemAt(_local_3);
                                break;
                            };
                            _local_3++;
                        };
                        MainWin.instance.buff.bar.refreshBuff();
                        onClose();
                    };
                };
            }
            else
            {
                AlertWin.show(Lang.msg("请输入密码"), null);
            };
        }

        public function set stateSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._651911789stateSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._651911789stateSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stateSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get choiseArr():Array
        {
            return (this._863317264choiseArr);
        }

        private function _StageChangeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("更改状态");
            _local_1 = Lang.msg("更改");
            _local_1 = edtDays;
            _local_1 = Lang.msg("当前状态");
            _local_1 = this._currState;
            _local_1 = Lang.msg("更改状态描述");
            _local_1 = (((Context.getInstance().facebookUser) ? "Please input ‘Confirm’ to apply" : Lang.msg("输入密码")) + ": ");
            _local_1 = (Lang.msg("修改状态") + ": ");
            _local_1 = choiseArr;
            _local_1 = (Lang.msg("天数") + ":");
            _local_1 = Lang.msg("自动续期");
        }

        [Bindable(event="propertyChange")]
        public function get lblDays():Label
        {
            return (this._26330323lblDays);
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        public function set statePassword(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2001878452statePassword;
            if (_local_2 !== _arg_1)
            {
                this._2001878452statePassword = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statePassword", _local_2, _arg_1));
            };
        }

        private function onAttackAlertReturn(_arg_1:Boolean):void
        {
            var _local_2:Number;
            var _local_3:Boolean;
            if (_arg_1)
            {
                _local_2 = parseInt(edtDays.text);
                _local_3 = cboxAutoExtend.selected;
                ActionFactory.getInstance().getFurloughCommands().isFurlought(playerInfo.id, _local_2, SHA1.hash(this.statePassword.text), _local_3, onFurloughCommandsResponse);
            };
        }

        [Bindable(event="propertyChange")]
        public function get txtStatusDes():Text
        {
            return (this._184092112txtStatusDes);
        }

        [Bindable(event="propertyChange")]
        private function get _currState():String
        {
            return (this._847767552_currState);
        }

        private function reFresh():void
        {
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            this.statePassword.text = "";
            this.onStageChangeChoose();
        }

        public function __stateSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        private function _StageChangeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StageChangeWin_Label1.text = _arg_1;
            }, "_StageChangeWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                stateSubmitBtn.label = _arg_1;
            }, "stateSubmitBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (edtDays);
            }, function (_arg_1:Object):void
            {
                numberValidator.source = _arg_1;
            }, "numberValidator.source");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                population.text = _arg_1;
            }, "population.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._currState;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lblCurrentState.text = _arg_1;
            }, "lblCurrentState.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改状态描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                txtStatusDes.text = _arg_1;
            }, "txtStatusDes.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((Context.getInstance().facebookUser) ? "Please input ‘Confirm’ to apply" : Lang.msg("输入密码")) + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StageChangeWin_Label4.text = _arg_1;
            }, "_StageChangeWin_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("修改状态") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StageChangeWin_Label5.text = _arg_1;
            }, "_StageChangeWin_Label5.text");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (choiseArr);
            }, function (_arg_1:Object):void
            {
                stateChoise.dataProvider = _arg_1;
            }, "stateChoise.dataProvider");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("天数") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lblDays.text = _arg_1;
            }, "lblDays.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("自动续期");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cboxAutoExtend.label = _arg_1;
            }, "cboxAutoExtend.label");
            result[10] = binding;
            return (result);
        }

        public function __statePassword_enter(_arg_1:FlexEvent):void
        {
            btnHandle();
        }

        public function set desVb(_arg_1:VBox):void
        {
            var _local_2:Object = this._95474270desVb;
            if (_local_2 !== _arg_1)
            {
                this._95474270desVb = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desVb", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get population():Label
        {
            return (this._2023558323population);
        }

        private function setNormalResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (PlayerInfoWin.instance != null)
                {
                    PlayerInfoWin.instance.refresh();
                };
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get statePassword():TextInput
        {
            return (this._2001878452statePassword);
        }

        [Bindable(event="propertyChange")]
        public function get cboxAutoExtend():CheckBox
        {
            return (this._276830801cboxAutoExtend);
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        public function set lblDays(_arg_1:Label):void
        {
            var _local_2:Object = this._26330323lblDays;
            if (_local_2 !== _arg_1)
            {
                this._26330323lblDays = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lblDays", _local_2, _arg_1));
            };
        }

        public function set lblCurrentState(_arg_1:Label):void
        {
            var _local_2:Object = this._1601089390lblCurrentState;
            if (_local_2 !== _arg_1)
            {
                this._1601089390lblCurrentState = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lblCurrentState", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get desVb():VBox
        {
            return (this._95474270desVb);
        }

        public function set edtDays(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1879242324edtDays;
            if (_local_2 !== _arg_1)
            {
                this._1879242324edtDays = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "edtDays", _local_2, _arg_1));
            };
        }

        private function set _currState(_arg_1:String):void
        {
            var _local_2:Object = this._847767552_currState;
            if (_local_2 !== _arg_1)
            {
                this._847767552_currState = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_currState", _local_2, _arg_1));
            };
        }

        private function _StageChangeWin_NumberValidator1_i():NumberValidator
        {
            var _local_1:NumberValidator = new NumberValidator();
            numberValidator = _local_1;
            _local_1.domain = "int";
            _local_1.property = "text";
            BindingManager.executeBindings(this, "numberValidator", numberValidator);
            _local_1.initialized(this, "numberValidator");
            return (_local_1);
        }

        private function onStageChangeChoose():void
        {
            if (stateChoise.selectedIndex == 2)
            {
                cboxAutoExtend.visible = true;
                lblDays.visible = true;
                edtDays.visible = true;
                lblDays.includeInLayout = true;
                edtDays.includeInLayout = true;
                stateChoise.width = 100;
                txtStatusDes.text = Lang.msg("休假状态更改");
            }
            else
            {
                cboxAutoExtend.visible = false;
                lblDays.visible = false;
                edtDays.visible = false;
                lblDays.includeInLayout = false;
                edtDays.includeInLayout = false;
                stateChoise.width = 190;
                txtStatusDes.text = Lang.msg("更改状态描述");
            };
        }

        private function canUseGood(_arg_1:String):Boolean
        {
            var _local_4:ItemBean;
            var _local_2:Boolean;
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                if (((_local_4.id == _arg_1) && (_local_4.count >= 1)))
                {
                    _local_2 = true;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get lblCurrentState():Label
        {
            return (this._1601089390lblCurrentState);
        }

        private function useGoodsResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功使用外交书"), null);
                PlayerInfoWin.instance.refresh();
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set txtStatusDes(_arg_1:Text):void
        {
            var _local_2:Object = this._184092112txtStatusDes;
            if (_local_2 !== _arg_1)
            {
                this._184092112txtStatusDes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtStatusDes", _local_2, _arg_1));
            };
        }

        public function __stateChoise_change(_arg_1:ListEvent):void
        {
            onStageChangeChoose();
        }

        public function ___StageChangeWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }


    }
}//package view.module.playerInfo

