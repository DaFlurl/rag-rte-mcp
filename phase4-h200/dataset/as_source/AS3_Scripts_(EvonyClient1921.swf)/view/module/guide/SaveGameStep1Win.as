// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.SaveGameStep1Win

package view.module.guide
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import view.MainWin;
    import com.evony.util.JSUtil;
    import view.ui.TargetCount;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import mx.events.PropertyChangeEvent;
    import com.adobe.crypto.SHA1;
    import com.adobe.crypto.MD5;
    import com.evony.Lang;
    import com.evony.util.InputTextFilter;
    import mx.utils.StringUtil;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.evony.util.FbUtil;
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

    public class SaveGameStep1Win extends Canvas implements IBindingClient 
    {

        private static var instance:SaveGameStep1Win;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1744190588regiserpass:TextInput;
        private var password:String;
        private var _385585197passwordError:Label;
        private var _1294628812emailError:Label;
        private var username:String;
        private var _1743177494regiserName:TextInput;
        private var _110371416title:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":460,
                    "height":510,
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
                        "type":Label,
                        "id":"title",
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.horizontalCenter = "0";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Save Game",
                                "percentWidth":100,
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SaveGameStep1Win_Button1_click"},
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
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "55";
                            this.cornerRadius = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "selectable":false,
                                "editable":false,
                                "verticalScrollPolicy":"off",
                                "text":"Saving will keep your kingdom in the game world permanently, where it will continue to grow and gain resources while you are offline! When you return to Evony later, you can resume building your great empire!",
                                "height":75
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "141";
                            this.bottom = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"doubleLineBlue",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 22;
                                        this.left = "33";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":9,
                                            "text":"Do you use Facebook?"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.left = "33";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":43,
                                            "text":"Connect with Facebook and play with your friends!"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 16;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":69,
                                            "y":90,
                                            "text":"Or"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.left = "33";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":117,
                                            "text":"Create account with your email"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":36,
                                            "y":147,
                                            "text":"Email Address:"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":38,
                                            "y":191,
                                            "text":"Password:"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "editable":false,
                                            "x":24,
                                            "y":235,
                                            "text":"*Evony will always be free and will never use your e-mail address outside of registration purposes and a single reminder if your status becomes inactive.",
                                            "width":323,
                                            "height":57,
                                            "alpha":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___SaveGameStep1Win_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":303,
                                            "label":"Register",
                                            "styleName":"b75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"regiserName",
                                    "events":{"change":"__regiserName_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "145";
                                        this.cornerRadius = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "tabIndex":0,
                                            "y":145,
                                            "width":183
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"regiserpass",
                                    "events":{"change":"__regiserpass_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "145";
                                        this.cornerRadius = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "tabIndex":1,
                                            "displayAsPassword":true,
                                            "y":189,
                                            "width":183
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___SaveGameStep1Win_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":57,
                                            "y":63,
                                            "label":"Connect with Facebook"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"emailError",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                        this.left = "48";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":169,
                                            "width":280
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"passwordError",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                        this.left = "48";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":215,
                                            "width":280
                                        });
                                    }
                                })]
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

        public function SaveGameStep1Win()
        {
            mx_internal::_document = this;
            this.width = 460;
            this.height = 510;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SaveGameStep1Win._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():SaveGameStep1Win
        {
            if (instance == null)
            {
                instance = new (SaveGameStep1Win)();
            };
            return (instance);
        }


        public function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            this.focusManager.setFocus(regiserName);
        }

        private function onPassTextChange():void
        {
            if (passwordError.text != "")
            {
                passwordError.text = "";
            };
        }

        override public function initialize():void
        {
            var target:SaveGameStep1Win;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SaveGameStep1Win_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_guide_SaveGameStep1WinWatcherSetupUtil");
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
                if (((!(Context.getInstance().voteUserName == null)) && (Context.getInstance().voteUserName.length > 0)))
                {
                    Context.getInstance().voteToName = Context.getInstance().voteUserName;
                    ActionFactory.getInstance().getVoteToPlayerCommands().voteToPlayerByName(Context.getInstance().voteUserName);
                };
                MainWin.instance.saveGameBtn.visible = false;
                Context.getInstance().saveGame = true;
                Context.getInstance().userName = this.username;
                EvonyClient.isTryUser = false;
                EvonyClient.isTryGame = false;
                SaveGameStep2Win.getInstance().show();
                JSUtil.getInstance().exitGameSet(false);
                TargetCount.clickCount(TargetCount.REGISTER_LOGIN_OWNER);
                TargetCount.clickCount(TargetCount.CREATE_PLAYER_COUNT);
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("tour_by_flash", Context.getInstance().iPicId, "save", GuideStep.getInstance().currentStep, Context.getInstance().userName, GameConfig.instance.serverID);
                };
            }
            else
            {
                emailError.text = _arg_1.errorMsg;
            };
        }

        [Bindable(event="propertyChange")]
        public function get regiserName():TextInput
        {
            return (this._1743177494regiserName);
        }

        public function set emailError(_arg_1:Label):void
        {
            var _local_2:Object = this._1294628812emailError;
            if (_local_2 !== _arg_1)
            {
                this._1294628812emailError = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "emailError", _local_2, _arg_1));
            };
        }

        private function onRegister():void
        {
            registerHandle();
        }

        private function saveEmail():void
        {
            var _local_1:String = ((SHA1.hash(password) + "=") + MD5.hash(password));
            ActionFactory.getInstance().getCommonCommands().saveUnregisteredPlayer(username, _local_1, checkRegisterInfo);
        }

        private function registerHandle():void
        {
            emailError.text = "";
            passwordError.text = "";
            if (regiserName.text == "")
            {
                emailError.text = Lang.msg("输入不能为空");
                return;
            };
            if (regiserpass.text == "")
            {
                passwordError.text = Lang.msg("输入不能为空");
                return;
            };
            if (!validateEmail(this.regiserName.text))
            {
                emailError.text = Lang.msg("邮箱格式不正确");
                return;
            };
            if (this.regiserpass.text.length < 6)
            {
                passwordError.text = Lang.msg("密码不能少于六位");
                return;
            };
            if (InputTextFilter.isChinese(this.regiserpass.text))
            {
                passwordError.text = Lang.msg("密码不合法");
                return;
            };
            username = StringUtil.trim(this.regiserName.text);
            password = StringUtil.trim(this.regiserpass.text);
            saveEmail();
        }

        [Bindable(event="propertyChange")]
        public function get passwordError():Label
        {
            return (this._385585197passwordError);
        }

        public function ___SaveGameStep1Win_Button3_click(_arg_1:MouseEvent):void
        {
            connectFB();
        }

        public function __regiserpass_change(_arg_1:Event):void
        {
            onPassTextChange();
        }

        private function _SaveGameStep1Win_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (!(emailError.text == ""));
            }, function (_arg_1:Boolean):void
            {
                emailError.includeInLayout = _arg_1;
            }, "emailError.includeInLayout");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(emailError.text == ""));
            }, function (_arg_1:Boolean):void
            {
                emailError.visible = _arg_1;
            }, "emailError.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(passwordError.text == ""));
            }, function (_arg_1:Boolean):void
            {
                passwordError.includeInLayout = _arg_1;
            }, "passwordError.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(passwordError.text == ""));
            }, function (_arg_1:Boolean):void
            {
                passwordError.visible = _arg_1;
            }, "passwordError.visible");
            result[3] = binding;
            return (result);
        }

        public function set title(_arg_1:Label):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        private function _SaveGameStep1Win_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (!(emailError.text == ""));
            _local_1 = (!(emailError.text == ""));
            _local_1 = (!(passwordError.text == ""));
            _local_1 = (!(passwordError.text == ""));
        }

        public function set regiserName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1743177494regiserName;
            if (_local_2 !== _arg_1)
            {
                this._1743177494regiserName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "regiserName", _local_2, _arg_1));
            };
        }

        public function ___SaveGameStep1Win_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
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

        private function connectFB():void
        {
            FbUtil.getInstance().connectRequst();
        }

        [Bindable(event="propertyChange")]
        public function get emailError():Label
        {
            return (this._1294628812emailError);
        }

        [Bindable(event="propertyChange")]
        public function get title():Label
        {
            return (this._110371416title);
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        public function __regiserName_change(_arg_1:Event):void
        {
            onNameTextChange();
        }

        public function set passwordError(_arg_1:Label):void
        {
            var _local_2:Object = this._385585197passwordError;
            if (_local_2 !== _arg_1)
            {
                this._385585197passwordError = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "passwordError", _local_2, _arg_1));
            };
        }

        private function onNameTextChange():void
        {
            if (emailError.text != "")
            {
                emailError.text = "";
            };
        }

        public function ___SaveGameStep1Win_Button2_click(_arg_1:MouseEvent):void
        {
            onRegister();
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


    }
}//package view.module.guide

