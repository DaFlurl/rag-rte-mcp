// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.TruceChangeWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
    import com.adobe.crypto.SHA1;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
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

    public class TruceChangeWin extends Canvas implements IBindingClient 
    {

        public static var instance:TruceChangeWin = new (TruceChangeWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _184092112txtStatusDes:TextArea;
        private var _651911789stateSubmitBtn:Button;
        private var _722575234stateChoise:ComboBox;
        private var _2023558323population:Label;
        public var _TruceChangeWin_Label1:Label;
        public var _TruceChangeWin_Label4:Label;
        public var _TruceChangeWin_Label9:Label;
        private var _2001878452statePassword:TextInput;
        private var _1954846600inputS1:TextInput;
        private var _1954846414inputM1:TextInput;
        private var _2095520559playerInfo:PlayerInfoBean;
        private var _1601089390lblCurrentState:Label;
        private var _1954846259inputH1:TextInput;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":300,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"stateSubmitBtn",
                        "events":{"click":"__stateSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "15";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"subTitleButton",
                                "width":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
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
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_TruceChangeWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
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
                            this.left = "20";
                            this.right = "20";
                            this.top = "33";
                            this.bottom = "41";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalGap = 5;
                                        this.bottom = "5";
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
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
                                                                return ({"width":190});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":98});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":98,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextArea,
                                                            "id":"txtStatusDes",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                                this.themeColor = 14135935;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":75,
                                                                    "editable":false,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":98});
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
                                                            "id":"_TruceChangeWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":120});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"stateChoise",
                                                            "events":{"change":"__stateChoise_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":250,
                                                                    "styleName":"ComboBox"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":98});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"text":"from"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"inputH1",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":60,
                                                                    "styleName":"textInput",
                                                                    "maxChars":3,
                                                                    "restrict":"0-9"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"text":"h"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"inputM1",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":60,
                                                                    "styleName":"textInput",
                                                                    "maxChars":3,
                                                                    "restrict":"0-9"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"text":"m"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"inputS1",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":60,
                                                                    "styleName":"textInput",
                                                                    "text":"0",
                                                                    "maxChars":3,
                                                                    "restrict":"0-9"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"text":"s"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":98});
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
                                                            "id":"_TruceChangeWin_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":120});
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
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___TruceChangeWin_Button2_click"},
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
            "label":Lang.msg("休战选项"),
            "data":1
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TruceChangeWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 300;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TruceChangeWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
            };
            instance.reFresh();
        }


        private function _TruceChangeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                stateSubmitBtn.label = _arg_1;
            }, "stateSubmitBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("休战更改状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TruceChangeWin_Label1.text = _arg_1;
            }, "_TruceChangeWin_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                population.text = _arg_1;
            }, "population.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("正常");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lblCurrentState.text = _arg_1;
            }, "lblCurrentState.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改状态描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                txtStatusDes.text = _arg_1;
            }, "txtStatusDes.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("修改状态") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TruceChangeWin_Label4.text = _arg_1;
            }, "_TruceChangeWin_Label4.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (choiseArr);
            }, function (_arg_1:Object):void
            {
                stateChoise.dataProvider = _arg_1;
            }, "stateChoise.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("输入密码") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TruceChangeWin_Label9.text = _arg_1;
            }, "_TruceChangeWin_Label9.text");
            result[7] = binding;
            return (result);
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
        public function get inputS1():TextInput
        {
            return (this._1954846600inputS1);
        }

        [Bindable(event="propertyChange")]
        public function get stateChoise():ComboBox
        {
            return (this._722575234stateChoise);
        }

        override public function initialize():void
        {
            var target:TruceChangeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TruceChangeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_TruceChangeWinWatcherSetupUtil");
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
        public function get stateSubmitBtn():Button
        {
            return (this._651911789stateSubmitBtn);
        }

        public function set inputM1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1954846414inputM1;
            if (_local_2 !== _arg_1)
            {
                this._1954846414inputM1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputM1", _local_2, _arg_1));
            };
        }

        public function set inputS1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1954846600inputS1;
            if (_local_2 !== _arg_1)
            {
                this._1954846600inputS1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputS1", _local_2, _arg_1));
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

        public function set population(_arg_1:Label):void
        {
            var _local_2:Object = this._2023558323population;
            if (_local_2 !== _arg_1)
            {
                this._2023558323population = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _local_2, _arg_1));
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

        public function set statePassword(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2001878452statePassword;
            if (_local_2 !== _arg_1)
            {
                this._2001878452statePassword = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statePassword", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get choiseArr():Array
        {
            return (this._863317264choiseArr);
        }

        private function btnHandle():void
        {
            if (statePassword.text != "")
            {
                if (stateChoise.selectedItem.data != 0)
                {
                    if (((!(inputH1.text == "")) && (!(inputM1.text == ""))))
                    {
                        ActionFactory.getInstance().getTruceCommands().changeDreamTruceTime(int(inputH1.text), int(inputM1.text), int(inputS1.text), SHA1.hash(statePassword.text), changeTruceResponse);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("请输入时间"));
                    };
                }
                else
                {
                    if (stateChoise.selectedItem.data == 0)
                    {
                        ActionFactory.getInstance().getTruceCommands().cancelDreamTruce(SHA1.hash(statePassword.text), setNormalResponse);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("请选择您要更改的状态"), null);
                    };
                };
            }
            else
            {
                AlertWin.show(Lang.msg("请输入密码"), null);
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        [Bindable(event="propertyChange")]
        public function get txtStatusDes():TextArea
        {
            return (this._184092112txtStatusDes);
        }

        private function reFresh():void
        {
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            this.statePassword.text = "";
            this.inputH1.text = "";
            this.inputM1.text = "";
            this.onStageChangeChoose();
        }

        public function __stateSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        [Bindable(event="propertyChange")]
        public function get inputH1():TextInput
        {
            return (this._1954846259inputH1);
        }

        public function __statePassword_enter(_arg_1:FlexEvent):void
        {
            btnHandle();
        }

        private function _TruceChangeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("更改");
            _local_1 = Lang.msg("休战更改状态");
            _local_1 = Lang.msg("当前状态");
            _local_1 = Lang.msg("正常");
            _local_1 = Lang.msg("更改状态描述");
            _local_1 = (Lang.msg("修改状态") + ": ");
            _local_1 = choiseArr;
            _local_1 = (Lang.msg("输入密码") + ": ");
        }

        public function ___TruceChangeWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get inputM1():TextInput
        {
            return (this._1954846414inputM1);
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get statePassword():TextInput
        {
            return (this._2001878452statePassword);
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
        public function get population():Label
        {
            return (this._2023558323population);
        }

        public function set txtStatusDes(_arg_1:TextArea):void
        {
            var _local_2:Object = this._184092112txtStatusDes;
            if (_local_2 !== _arg_1)
            {
                this._184092112txtStatusDes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtStatusDes", _local_2, _arg_1));
            };
        }

        private function changeTruceResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (PlayerInfoWin.instance != null)
                {
                    PlayerInfoWin.instance.refresh();
                };
                AlertWin.show(Lang.msg("时间段休战修改成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __stateChoise_change(_arg_1:ListEvent):void
        {
            onStageChangeChoose();
        }

        private function onStageChangeChoose():void
        {
            if (stateChoise.selectedIndex == 0)
            {
                txtStatusDes.text = Lang.msg("正常状态描述");
                inputH1.enabled = false;
                inputM1.enabled = false;
                inputS1.enabled = false;
            }
            else
            {
                if (stateChoise.selectedIndex == 1)
                {
                    txtStatusDes.text = Lang.msg("时间段休战描述");
                    inputH1.enabled = true;
                    inputM1.enabled = true;
                    inputS1.enabled = true;
                };
            };
        }

        private function setNormalResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (PlayerInfoWin.instance != null)
                {
                    PlayerInfoWin.instance.refresh();
                };
                AlertWin.show(Lang.msg("时间段休战取消成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get lblCurrentState():Label
        {
            return (this._1601089390lblCurrentState);
        }

        public function set inputH1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1954846259inputH1;
            if (_local_2 !== _arg_1)
            {
                this._1954846259inputH1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputH1", _local_2, _arg_1));
            };
        }


    }
}//package view.module.playerInfo

