// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.StopWar

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import com.evony.eum.ItemEum;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Button;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.beans.BuffBean;
    import com.evony.Context;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import com.adobe.crypto.SHA1;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
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

    public class StopWar extends Canvas implements IBindingClient 
    {

        private static var instance:StopWar = new (StopWar)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var Goodsid:String = "";
        private var _2001878452statePassword:TextInput;
        private var buffFlag:Boolean;
        private var _1954846600inputS1:TextInput;
        private var _2116180394itemEum:ItemEum;
        private var _1954846414inputM1:TextInput;
        public var _StopWar_TextArea1:TextArea;
        private var _1954846259inputH1:TextInput;
        public var _StopWar_Label7:Label;
        public var _StopWar_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":207,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":2,
                                "text":"Dream Truce",
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_StopWar_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "104";
                            this.bottom = "17";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"labelWithBackGround",
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___StopWar_Button1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":362.5,
                                "y":0,
                                "styleName":"close"
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
                                    "id":"_StopWar_Label2",
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
                            this.top = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":64,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.top = "3";
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
                                            "y":35,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_StopWar_Label7",
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
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___StopWar_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.top = "33";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"OK",
                                            "styleName":"subTitleButton"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___StopWar_Button3_click"},
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
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function StopWar()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 207;
            this.addEventListener("creationComplete", ___StopWar_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            StopWar._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:String):void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance);
            };
            PopUpManager.centerPopUp(instance);
            instance.refresh();
            instance.Goodsid = _arg_1;
            instance.itemEum = ItemEumDefine.getItemEum(instance.Goodsid);
        }


        private function checkBuff():void
        {
            var _local_1:BuffBean;
            buffFlag = false;
            for each (_local_1 in Context.getInstance().getPlayerBean().buffsArray)
            {
                if (_local_1.typeId == "DreamTruceBuff")
                {
                    buffFlag = true;
                    break;
                };
            };
            if (buffFlag)
            {
                inputH1.editable = false;
                inputM1.editable = false;
                inputS1.editable = false;
            }
            else
            {
                inputH1.editable = true;
                inputM1.editable = true;
                inputS1.editable = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function get inputS1():TextInput
        {
            return (this._1954846600inputS1);
        }

        override public function initialize():void
        {
            var target:StopWar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _StopWar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_StopWarWatcherSetupUtil");
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

        public function set inputM1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1954846414inputM1;
            if (_local_2 !== _arg_1)
            {
                this._1954846414inputM1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputM1", _local_2, _arg_1));
            };
        }

        private function init():void
        {
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

        public function set inputS1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1954846600inputS1;
            if (_local_2 !== _arg_1)
            {
                this._1954846600inputS1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inputS1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemEum():ItemEum
        {
            return (this._2116180394itemEum);
        }

        public function ___StopWar_Button1_click(_arg_1:MouseEvent):void
        {
            hide();
        }

        private function _StopWar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.itemEum.itemDesc;
            _local_1 = Lang.msg("输入密码");
            _local_1 = (((Context.getInstance().facebookUser) ? "Please input ‘Confirm’ to apply" : Lang.msg("输入密码")) + ": ");
        }

        public function ___StopWar_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get inputH1():TextInput
        {
            return (this._1954846259inputH1);
        }

        public function ___StopWar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function __statePassword_enter(_arg_1:FlexEvent):void
        {
            changeZone();
        }

        [Bindable(event="propertyChange")]
        public function get inputM1():TextInput
        {
            return (this._1954846414inputM1);
        }

        private function set itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function refresh():void
        {
            instance.inputH1.text = "";
            instance.inputM1.text = "";
            instance.statePassword.text = "";
            checkBuff();
        }

        [Bindable(event="propertyChange")]
        public function get statePassword():TextInput
        {
            return (this._2001878452statePassword);
        }

        public function ___StopWar_Button2_click(_arg_1:MouseEvent):void
        {
            changeZone();
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

        private function _StopWar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemEum.itemDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StopWar_TextArea1.text = _arg_1;
            }, "_StopWar_TextArea1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("输入密码");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StopWar_Label2.text = _arg_1;
            }, "_StopWar_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((Context.getInstance().facebookUser) ? "Please input ‘Confirm’ to apply" : Lang.msg("输入密码")) + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _StopWar_Label7.text = _arg_1;
            }, "_StopWar_Label7.text");
            result[2] = binding;
            return (result);
        }

        private function changeZone():void
        {
            if (statePassword.text != "")
            {
                if ((((!(inputH1.text == "")) && (!(inputM1.text == ""))) || (buffFlag)))
                {
                    ActionFactory.getInstance().getTruceCommands().setDreamTruce(int(inputH1.text), int(inputM1.text), int(inputS1.text), SHA1.hash(statePassword.text), setTruceResponse);
                    hide();
                }
                else
                {
                    AlertWin.show(Lang.msg("请输入时间"), null);
                };
            }
            else
            {
                AlertWin.show(Lang.msg("请输入密码"));
            };
        }

        private function setTruceResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                MyTreasure.instance.refresh();
                AlertWin.show(Lang.msg("休战时间设置成功"), null);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }


    }
}//package view.module.playerInfo

