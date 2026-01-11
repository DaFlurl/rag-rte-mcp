// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.GiveupCastle

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.Context;
    import view.module.playerInfo.UnlockSecurityCode;
    import view.module.playerInfo.ApplySecurityCode;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import com.adobe.crypto.SHA1;
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
    import view.module.playerInfo.*;
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

    public class GiveupCastle extends Canvas implements IBindingClient 
    {

        public static var instancePopup:GiveupCastle;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        public var _GiveupCastle_Label1:Label;
        public var _GiveupCastle_Label2:Label;
        public var _GiveupCastle_Label3:Label;
        private var castleId:int;
        public var _GiveupCastle_TextArea1:TextArea;
        private var _691506344curCastle:CastleBean;
        private var _1092797764closeBtn:Button;
        private var _114190243castleName:String;
        private var _567062120passwordText:TextInput;
        private var _1446942000giveUpBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":254,
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
                                    "id":"_GiveupCastle_Label1",
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
                            this.top = "53";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "67";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "44";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "4";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_GiveupCastle_TextArea1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388,
                                            "height":55,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "75";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "width":388
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_GiveupCastle_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 14;
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "y":60,
                                            "width":380
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.verticalCenter = "41";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_GiveupCastle_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.textAlign = "center";
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"passwordText",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":126,
                                                        "displayAsPassword":true,
                                                        "styleName":"textInput",
                                                        "maxChars":20
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":193,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"giveUpBtn",
                                    "events":{"click":"__giveUpBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"closeBtn",
                                    "events":{"click":"__closeBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___GiveupCastle_Button3_click"},
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

        public function GiveupCastle()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 254;
            this.addEventListener("creationComplete", ___GiveupCastle_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GiveupCastle._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:CastleBean, _arg_2:int, _arg_3:String):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (GiveupCastle)();
            };
            MinePopupManager.instance.addPopup(instancePopup, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instancePopup.passwordText.text = "";
            instancePopup.setCastleId(_arg_2);
            instancePopup.setCastleName(_arg_3);
            instancePopup.castleBean = _arg_1;
        }


        private function giveUpCastleResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功放弃城池"), null);
                if (this.parent != null)
                {
                    this.passwordText.text = "";
                    this.visible = false;
                };
            }
            else
            {
                if (_arg_1.ok == -200)
                {
                    if (Context.getInstance().bLoginSecurityCode)
                    {
                        UnlockSecurityCode.show(2);
                    }
                    else
                    {
                        ApplySecurityCode.show(2);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg, null);
                };
            };
        }

        private function closeWindow(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        public function set closeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1092797764closeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1092797764closeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeBtn", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:GiveupCastle;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GiveupCastle_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_GiveupCastleWatcherSetupUtil");
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

        public function init():void
        {
            passwordText.text = "";
        }

        public function ___GiveupCastle_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get castleName():String
        {
            return (this._114190243castleName);
        }

        public function giveUpCastle():void
        {
            if (this.castleId == Context.getInstance().getCurCastle().id)
            {
                AlertWin.show(Lang.msg("不能废弃当前城"), null);
                return;
            };
            if (passwordText.text != "")
            {
                if (((Context.getInstance().facebookUser) && (!(passwordText.text.toUpperCase() == "DELETE"))))
                {
                    return;
                };
                instance = ResponseDispatcher.getInstance();
                instance.addEventListener(ResponseDispatcher.CITY_GIVEUP_CASTLE, giveUpCastleResponse, false, 0, true);
                ActionFactory.getInstance().getCityCommands().giveupCastle(SHA1.hash(passwordText.text), castleId);
            }
            else
            {
                AlertWin.show(Lang.msg("密码不能为空"), null);
            };
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        public function setCastleName(_arg_1:String):void
        {
            this.castleName = _arg_1;
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            closeWindow(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get giveUpBtn():Button
        {
            return (this._1446942000giveUpBtn);
        }

        public function setCastleId(_arg_1:int):void
        {
            this.castleId = _arg_1;
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        private function set castleName(_arg_1:String):void
        {
            var _local_2:Object = this._114190243castleName;
            if (_local_2 !== _arg_1)
            {
                this._114190243castleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        public function ___GiveupCastle_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function set passwordText(_arg_1:TextInput):void
        {
            var _local_2:Object = this._567062120passwordText;
            if (_local_2 !== _arg_1)
            {
                this._567062120passwordText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "passwordText", _local_2, _arg_1));
            };
        }

        private function _GiveupCastle_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("废弃城池");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiveupCastle_Label1.text = _arg_1;
            }, "_GiveupCastle_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("废弃城池将彻底失去该城池");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiveupCastle_TextArea1.text = _arg_1;
            }, "_GiveupCastle_TextArea1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((Lang.msg("确认废弃城池") + " <font color='#ff0000'>") + this.castleName) + "</font> ?");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiveupCastle_Label2.htmlText = _arg_1;
            }, "_GiveupCastle_Label2.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().facebookUser) ? "Please input DELETE to confirm" : Lang.msg("输入密码"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiveupCastle_Label3.text = _arg_1;
            }, "_GiveupCastle_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("废弃");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                giveUpBtn.label = _arg_1;
            }, "giveUpBtn.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("关闭");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                closeBtn.label = _arg_1;
            }, "closeBtn.label");
            result[5] = binding;
            return (result);
        }

        private function _GiveupCastle_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("废弃城池");
            _local_1 = Lang.msg("废弃城池将彻底失去该城池");
            _local_1 = (((Lang.msg("确认废弃城池") + " <font color='#ff0000'>") + this.castleName) + "</font> ?");
            _local_1 = ((Context.getInstance().facebookUser) ? "Please input DELETE to confirm" : Lang.msg("输入密码"));
            _local_1 = Lang.msg("废弃");
            _local_1 = Lang.msg("关闭");
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function __giveUpBtn_click(_arg_1:MouseEvent):void
        {
            giveUpCastle();
        }

        public function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        public function set giveUpBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1446942000giveUpBtn;
            if (_local_2 !== _arg_1)
            {
                this._1446942000giveUpBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giveUpBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get passwordText():TextInput
        {
            return (this._567062120passwordText);
        }


    }
}//package view.module.office

