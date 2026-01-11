// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.RegisterInfoWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import view.MainWin;
    import com.evony.util.JSUtil;
    import com.evony.Lang;
    import com.evony.util.InputTextFilter;
    import com.evony.util.InputTextControl;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import mx.utils.StringUtil;
    import com.adobe.crypto.SHA1;
    import com.adobe.crypto.MD5;
    import com.evony.client.action.ActionFactory;
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

    public class RegisterInfoWin extends Canvas implements IBindingClient 
    {

        public static var instance:RegisterInfoWin = new (RegisterInfoWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1744190588regiserpass:TextInput;
        public var _RegisterInfoWin_Label2:Label;
        public var _RegisterInfoWin_Label3:Label;
        private var _266141700user_txt:TextInput;
        public var _RegisterInfoWin_Label4:Label;
        private var _848782841SaveSubmitBtn:Button;
        private var _274626191regiserRepass:TextInput;
        private var flag:Boolean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":250,
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
                            this.top = "4";
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
                                            "text":"SYSTEM",
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
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_RegisterInfoWin_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"loginPaneTextStyle",
                                            "x":10,
                                            "y":25,
                                            "width":179
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"user_txt",
                                    "events":{
                                        "enter":"__user_txt_enter",
                                        "change":"__user_txt_change"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":204,
                                            "y":20,
                                            "styleName":"loginInput",
                                            "width":177,
                                            "height":28
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_RegisterInfoWin_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"loginPaneTextStyle",
                                            "x":89,
                                            "y":63,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"regiserpass",
                                    "events":{
                                        "enter":"__regiserpass_enter",
                                        "change":"__regiserpass_change"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "displayAsPassword":true,
                                            "x":204,
                                            "y":60,
                                            "styleName":"loginInput",
                                            "width":177,
                                            "height":28,
                                            "maxChars":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_RegisterInfoWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"loginPaneTextStyle",
                                            "x":36,
                                            "y":104,
                                            "width":153
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"regiserRepass",
                                    "events":{
                                        "enter":"__regiserRepass_enter",
                                        "change":"__regiserRepass_change"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "displayAsPassword":true,
                                            "x":204,
                                            "y":100,
                                            "styleName":"loginInput",
                                            "width":177,
                                            "height":28,
                                            "maxChars":20
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"SaveSubmitBtn",
                        "events":{"click":"__SaveSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.left = "185";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Save",
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___RegisterInfoWin_Button2_click"},
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

        public function RegisterInfoWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 250;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            RegisterInfoWin._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function show(_arg_1:Boolean=true):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.flag = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get user_txt():TextInput
        {
            return (this._266141700user_txt);
        }

        private function saveHandle():void
        {
            registerHandle();
        }

        [Bindable(event="propertyChange")]
        public function get SaveSubmitBtn():Button
        {
            return (this._848782841SaveSubmitBtn);
        }

        public function set SaveSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._848782841SaveSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._848782841SaveSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SaveSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get regiserRepass():TextInput
        {
            return (this._274626191regiserRepass);
        }

        override public function initialize():void
        {
            var target:RegisterInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _RegisterInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_RegisterInfoWinWatcherSetupUtil");
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

        private function checkRegisterInfo(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                EvonyClient.isTryUser = false;
                Context.getInstance().saveGame = true;
                MainWin.instance.saveGameBtn.visible = false;
                JSUtil.getInstance().exitGameSet(false);
                RegisterInfoWin.close();
                if (flag)
                {
                    AddFavoriteWin.show();
                }
                else
                {
                    AlertWin.show("Save game successfully.");
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set regiserRepass(_arg_1:TextInput):void
        {
            var _local_2:Object = this._274626191regiserRepass;
            if (_local_2 !== _arg_1)
            {
                this._274626191regiserRepass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "regiserRepass", _local_2, _arg_1));
            };
        }

        private function validateEmail(_arg_1:String):Boolean
        {
            var _local_2:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var _local_3:Object = _local_2.exec(_arg_1);
            if (_local_3 == null)
            {
                return (false);
            };
            return (true);
        }

        private function registerHandle():void
        {
            if ((((this.user_txt.text == "") || (this.regiserpass.text == "")) || (this.regiserRepass.text == "")))
            {
                AlertWin.show(Lang.msg("输入不能为空"), null);
                return;
            };
            if (!validateEmail(this.user_txt.text))
            {
                AlertWin.show(Lang.msg("邮箱格式不正确"), null);
                return;
            };
            if (this.regiserpass.text.length < 6)
            {
                AlertWin.show(Lang.msg("密码不能少于六位"), null);
                return;
            };
            if (InputTextFilter.isChinese(this.regiserpass.text))
            {
                AlertWin.show(Lang.msg("密码不合法"));
                return;
            };
            if (this.regiserpass.text != this.regiserRepass.text)
            {
                AlertWin.show(Lang.msg("确认密码不正确"), null);
                return;
            };
            saveUnregisterInfo();
        }

        private function _RegisterInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (Lang.msg("用户名") + ":");
            _local_1 = (Lang.msg("密码") + ":");
            _local_1 = (Lang.msg("确认密码") + ":");
        }

        public function __regiserpass_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        public function __user_txt_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
        }

        public function __regiserRepass_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        public function __regiserRepass_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
        }

        public function ___RegisterInfoWin_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function _RegisterInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("用户名") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RegisterInfoWin_Label2.text = _arg_1;
            }, "_RegisterInfoWin_Label2.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("密码") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RegisterInfoWin_Label3.text = _arg_1;
            }, "_RegisterInfoWin_Label3.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("确认密码") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RegisterInfoWin_Label4.text = _arg_1;
            }, "_RegisterInfoWin_Label4.text");
            result[2] = binding;
            return (result);
        }

        private function saveUnregisterInfo():void
        {
            var _local_1:String = StringUtil.trim(this.user_txt.text);
            var _local_2:String = StringUtil.trim(this.regiserpass.text);
            var _local_3:String = ((SHA1.hash(_local_2) + "=") + MD5.hash(_local_2));
            ActionFactory.getInstance().getCommonCommands().saveUnregisteredPlayer(_local_1, _local_3, checkRegisterInfo);
        }

        public function __user_txt_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        public function __regiserpass_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
        }

        public function __SaveSubmitBtn_click(_arg_1:MouseEvent):void
        {
            saveHandle();
        }

        public function set regiserpass(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1744190588regiserpass;
            if (_local_2 !== _arg_1)
            {
                this._1744190588regiserpass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "regiserpass", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get regiserpass():TextInput
        {
            return (this._1744190588regiserpass);
        }

        public function set user_txt(_arg_1:TextInput):void
        {
            var _local_2:Object = this._266141700user_txt;
            if (_local_2 !== _arg_1)
            {
                this._266141700user_txt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "user_txt", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

