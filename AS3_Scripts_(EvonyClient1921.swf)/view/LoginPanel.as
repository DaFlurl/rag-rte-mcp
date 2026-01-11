// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.LoginPanel

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.CheckBox;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.containers.HBox;
    import mx.controls.LinkButton;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import com.evony.GameConfig;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.Event;
    import com.evony.util.InputTextControl;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import flash.events.FocusEvent;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.events.TryGameEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.net.SharedObject;
    import com.evony.MsgDispacther;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.utils.StringUtil;
    import com.evony.events.LoginEvent;
    import com.evony.util.InputTextFilter;
    import com.evony.events.RegisterEvent;
    import flash.external.ExternalInterface;
    import com.evony.EvonyVersion;
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

    public class LoginPanel extends Canvas implements IBindingClient 
    {

        public static var instance:LoginPanel = new (LoginPanel)();
        public static const OTHER_WINDOW_CALLBACK:String = "otherWindowCallBack";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1602127645save_password:CheckBox;
        private var _1744190588regiserpass:TextInput;
        private var _1182526632ip_txt:TextInput;
        private var cookieName:String = "userInfo";
        private var _470485238registerTabBtn:Button;
        private var _1762040805loginPanel:Canvas;
        private var _1216275778pass_txt:TextInput;
        private var _1325435728loginTabBtn:Button;
        private var _274626191regiserRepass:TextInput;
        private var _1346545910bulletinStr:String;
        private var _317625827regiserSubmit:Button;
        private var canLogin:Boolean = true;
        private var _153085257myViewstack:ViewStack;
        private var _1069971177useEnglish:CheckBox;
        public var _LoginPanel_HBox1:HBox;
        private var userPassWord:String;
        private var _1114738393default_password:String = "";
        private var _266141700user_txt:TextInput;
        public var _LoginPanel_Button3:Button;
        public var _LoginPanel_Button5:Button;
        private var _368914124default_userName:String = "";
        private var _190700521savePassSelected:Boolean = false;
        public var _LoginPanel_LinkButton1:LinkButton;
        public var _LoginPanel_Label2:Label;
        public var _LoginPanel_Label5:Label;
        public var _LoginPanel_Label6:Label;
        public var _LoginPanel_Label7:Label;
        public var _LoginPanel_Label8:Label;
        public var _LoginPanel_Label1:Label;
        private var _1743177494regiserName:TextInput;
        private var userName:String;
        private var _183119256save_UserName:CheckBox;
        private var _1794224423regiserPanel:Canvas;
        private var _1180563037saveUserSelected:Boolean = true;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":1200,
                    "height":700,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":870,
                                "height":260,
                                "width":357,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginPanel_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 10;
                                        this.color = 0xFFFFFF;
                                        this.left = "10";
                                        this.bottom = "30";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginPanel_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 10;
                                        this.color = 0xFFFFFF;
                                        this.left = "10";
                                        this.bottom = "10";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_LoginPanel_HBox1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":890,
                                "y":591,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"ip_txt",
                                    "events":{
                                        "enter":"__ip_txt_enter",
                                        "focusIn":"__ip_txt_focusIn"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"loginInput",
                                            "width":177,
                                            "height":28
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"useEnglish",
                                    "events":{"click":"__useEnglish_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"英文",
                                            "visible":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"registerTabBtn",
                        "events":{"click":"__registerTabBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "263";
                            this.horizontalCenter = "156";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"register",
                                "label":"register",
                                "width":109,
                                "height":32,
                                "toggle":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"loginTabBtn",
                        "events":{"click":"__loginTabBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "263";
                            this.horizontalCenter = "-98";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"login",
                                "width":109,
                                "label":"login",
                                "height":32,
                                "selected":true,
                                "toggle":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "440";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":375,
                                "percentHeight":100,
                                "width":490,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"myViewstack",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":490,
                                            "height":250,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"loginPanel",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.fontSize = 14;
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"USERNAME",
                                                                    "x":70,
                                                                    "y":36
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.fontSize = 10;
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Your Email",
                                                                    "x":95,
                                                                    "y":53
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"user_txt",
                                                            "events":{"enter":"__user_txt_enter"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":184,
                                                                    "y":32,
                                                                    "styleName":"YellowInput",
                                                                    "height":39,
                                                                    "width":240
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_LoginPanel_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.fontSize = 14;
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":69,
                                                                    "y":80,
                                                                    "width":100
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"pass_txt",
                                                            "events":{"enter":"__pass_txt_enter"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "displayAsPassword":true,
                                                                    "x":184,
                                                                    "y":76,
                                                                    "styleName":"YellowInput",
                                                                    "height":39,
                                                                    "width":240
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_LoginPanel_Button3",
                                                            "events":{"click":"___LoginPanel_Button3_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"y125",
                                                                    "x":172,
                                                                    "y":170
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "center";
                                                                this.horizontalGap = 10;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "y":137,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"save_UserName",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"cb2"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"save_password",
                                                                        "events":{"change":"__save_password_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"cb2"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "y":110,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":LinkButton,
                                                                        "id":"_LoginPanel_LinkButton1",
                                                                        "events":{"click":"___LoginPanel_LinkButton1_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.fontWeight = "normal";
                                                                            this.color = 0x3F1F00;
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"regiserPanel",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_LoginPanel_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":10,
                                                                    "y":36,
                                                                    "width":179
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"regiserName",
                                                            "events":{
                                                                "enter":"__regiserName_enter",
                                                                "change":"__regiserName_change"
                                                            },
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":204,
                                                                    "y":32,
                                                                    "styleName":"YellowInput",
                                                                    "height":39,
                                                                    "width":240
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_LoginPanel_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":89,
                                                                    "y":75,
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
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "displayAsPassword":true,
                                                                    "x":204,
                                                                    "y":71.5,
                                                                    "styleName":"YellowInput",
                                                                    "height":39,
                                                                    "width":240,
                                                                    "maxChars":20
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_LoginPanel_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 0x3F1F00;
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "x":36,
                                                                    "y":114,
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
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "displayAsPassword":true,
                                                                    "x":204,
                                                                    "y":111.5,
                                                                    "styleName":"YellowInput",
                                                                    "height":39,
                                                                    "width":240,
                                                                    "maxChars":20
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"regiserSubmit",
                                                            "events":{"click":"__regiserSubmit_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "45";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"y125",
                                                                    "x":172
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 10;
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Clicking Register and Login, you are indicating that you have read and agree to our",
                                                                    "x":45,
                                                                    "y":210
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":LinkButton,
                                                            "events":{"click":"___LoginPanel_LinkButton2_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.fontWeight = "normal";
                                                                this.fontSize = 10;
                                                                this.color = 0xFF;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Terms of Use",
                                                                    "x":170,
                                                                    "y":225
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":LinkButton,
                                                            "events":{"click":"___LoginPanel_LinkButton3_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.fontWeight = "normal";
                                                                this.fontSize = 10;
                                                                this.color = 0xFF;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Privacy Policy",
                                                                    "x":260,
                                                                    "y":225
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingBottom = 0;
                                                                this.fontSize = 10;
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"and",
                                                                    "x":239,
                                                                    "y":227
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
                        "id":"_LoginPanel_Button5",
                        "events":{"click":"___LoginPanel_Button5_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95,
                                "x":890,
                                "y":479
                            });
                        }
                    })]
                });
            }
        });
        private var _678651877default_ip:String = GameConfig.instance.serverIp;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function LoginPanel()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalCenter = "0";
                this.verticalCenter = "0";
            };
            this.width = 1200;
            this.height = 700;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___LoginPanel_Canvas1_creationComplete);
            this.addEventListener("removedFromStage", ___LoginPanel_Canvas1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LoginPanel._watcherSetupUtil = _arg_1;
        }


        public function __save_password_change(_arg_1:Event):void
        {
            savePassword();
        }

        public function __regiserName_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
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

        public function __loginTabBtn_click(_arg_1:MouseEvent):void
        {
            btnHandel(1);
        }

        public function ___LoginPanel_LinkButton3_click(_arg_1:MouseEvent):void
        {
            onTermsLinkClick2();
        }

        public function __ip_txt_enter(_arg_1:FlexEvent):void
        {
            doLogin();
        }

        public function __ip_txt_focusIn(_arg_1:FocusEvent):void
        {
            this.ip_txt.setSelection(11, this.ip_txt.length);
        }

        private function init():void
        {
            trace((this.className + ".init()"));
            this.readLocal();
        }

        private function set savePassSelected(_arg_1:Boolean):void
        {
            var _local_2:Object = this._190700521savePassSelected;
            if (_local_2 !== _arg_1)
            {
                this._190700521savePassSelected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "savePassSelected", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get registerTabBtn():Button
        {
            return (this._470485238registerTabBtn);
        }

        [Bindable(event="propertyChange")]
        public function get loginPanel():Canvas
        {
            return (this._1762040805loginPanel);
        }

        [Bindable(event="propertyChange")]
        public function get regiserSubmit():Button
        {
            return (this._317625827regiserSubmit);
        }

        [Bindable(event="propertyChange")]
        public function get regiserName():TextInput
        {
            return (this._1743177494regiserName);
        }

        [Bindable(event="propertyChange")]
        public function get regiserPanel():Canvas
        {
            return (this._1794224423regiserPanel);
        }

        [Bindable(event="propertyChange")]
        public function get useEnglish():CheckBox
        {
            return (this._1069971177useEnglish);
        }

        public function set registerTabBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._470485238registerTabBtn;
            if (_local_2 !== _arg_1)
            {
                this._470485238registerTabBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "registerTabBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get save_password():CheckBox
        {
            return (this._1602127645save_password);
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

        [Bindable(event="propertyChange")]
        public function get user_txt():TextInput
        {
            return (this._266141700user_txt);
        }

        public function set save_UserName(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._183119256save_UserName;
            if (_local_2 !== _arg_1)
            {
                this._183119256save_UserName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "save_UserName", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        private function get default_userName():String
        {
            return (this._368914124default_userName);
        }

        public function set loginPanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1762040805loginPanel;
            if (_local_2 !== _arg_1)
            {
                this._1762040805loginPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginPanel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bulletinStr():String
        {
            return (this._1346545910bulletinStr);
        }

        private function savePassword():void
        {
            if (save_password.selected == true)
            {
                AlertWin.show(Lang.msg("确定要保存密码吗"), savePasswordOrNot);
            };
        }

        public function set save_password(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1602127645save_password;
            if (_local_2 !== _arg_1)
            {
                this._1602127645save_password = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "save_password", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        private function get savePassSelected():Boolean
        {
            return (this._190700521savePassSelected);
        }

        public function __regiserRepass_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        private function set bulletinStr(_arg_1:String):void
        {
            var _local_2:Object = this._1346545910bulletinStr;
            if (_local_2 !== _arg_1)
            {
                this._1346545910bulletinStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bulletinStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pass_txt():TextInput
        {
            return (this._1216275778pass_txt);
        }

        private function set saveUserSelected(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180563037saveUserSelected;
            if (_local_2 !== _arg_1)
            {
                this._1180563037saveUserSelected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saveUserSelected", _local_2, _arg_1));
            };
        }

        public function __regiserRepass_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
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

        private function tryGame():void
        {
            if (GameConfig.instance.ServerState == "ServerMaintaining")
            {
                AlertWin.show(Lang.msg("服务器维护中"), null);
                return;
            };
            this.dispatchEvent(new TryGameEvent(this.ip_txt.text, true));
        }

        private function onTermsLinkClick2():void
        {
            navigateToURL(new URLRequest("http://www.evony.com/index.do?PageModule=Static&type=PrivacyPolicy"), "_blank");
        }

        [Bindable(event="propertyChange")]
        public function get loginTabBtn():Button
        {
            return (this._1325435728loginTabBtn);
        }

        public function __regiserSubmit_click(_arg_1:MouseEvent):void
        {
            registerHandle();
        }

        [Bindable(event="propertyChange")]
        private function get default_password():String
        {
            return (this._1114738393default_password);
        }

        public function ___LoginPanel_Canvas1_removedFromStage(_arg_1:Event):void
        {
            onRemoved();
        }

        [Bindable(event="propertyChange")]
        public function get ip_txt():TextInput
        {
            return (this._1182526632ip_txt);
        }

        private function set default_userName(_arg_1:String):void
        {
            var _local_2:Object = this._368914124default_userName;
            if (_local_2 !== _arg_1)
            {
                this._368914124default_userName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "default_userName", _local_2, _arg_1));
            };
        }

        public function ___LoginPanel_Button3_click(_arg_1:MouseEvent):void
        {
            doLogin();
        }

        public function set myViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._153085257myViewstack;
            if (_local_2 !== _arg_1)
            {
                this._153085257myViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myViewstack", _local_2, _arg_1));
            };
        }

        private function checkOutText():void
        {
            var _local_1:String = regiserName.text;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (((((_local_1.charAt(_local_2) == '"') || (_local_1.charAt(_local_2) == "'")) || (_local_1.charAt(_local_2) == "\\")) || (_local_1.charAt(_local_2) == " ")))
                {
                    _local_1 = _local_1.substr(0, _local_2);
                };
                regiserName.text = _local_1;
                _local_2++;
            };
        }

        private function readLocal():void
        {
            var _local_1:SharedObject = SharedObject.getLocal(cookieName, "/");
            if (((_local_1.data.ip) && (GameConfig.instance.debugMode)))
            {
                this.default_ip = _local_1.data.ip;
            };
            if (_local_1.data.username)
            {
                this.default_userName = _local_1.data.username;
            };
            if (this.userName != null)
            {
                this.default_userName = this.userName;
            };
            if (_local_1.data.password)
            {
                this.default_password = _local_1.data.password;
            };
            if (this.userPassWord != null)
            {
                this.default_password = this.userPassWord;
            };
            MsgDispacther.getInstance().useEnglish = true;
            this.saveUserSelected = _local_1.data.saveUserSelected;
            this.savePassSelected = _local_1.data.savePassSelected;
        }

        public function __pass_txt_enter(_arg_1:FlexEvent):void
        {
            doLogin();
        }

        private function onRemoved():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get regiserpass():TextInput
        {
            return (this._1744190588regiserpass);
        }

        public function __regiserpass_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
        }

        public function set pass_txt(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1216275778pass_txt;
            if (_local_2 !== _arg_1)
            {
                this._1216275778pass_txt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pass_txt", _local_2, _arg_1));
            };
        }

        public function __regiserName_enter(_arg_1:FlexEvent):void
        {
            registerHandle();
        }

        override public function initialize():void
        {
            var target:LoginPanel;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _LoginPanel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_LoginPanelWatcherSetupUtil");
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

        public function __useEnglish_click(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().useEnglish = this.useEnglish.selected;
        }

        private function savePasswordOrNot(_arg_1:Boolean):void
        {
            save_password.selected = _arg_1;
        }

        public function playLoginMovie():void
        {
        }

        public function ___LoginPanel_LinkButton1_click(_arg_1:MouseEvent):void
        {
            onForgetPwdLinkClick();
        }

        public function ___LoginPanel_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function doLogin():void
        {
            if (GameConfig.instance.ServerState == "ServerMaintaining")
            {
                AlertWin.show(Lang.msg("服务器维护中"), null);
                return;
            };
            var _local_1:String = StringUtil.trim(this.user_txt.text);
            var _local_2:String = StringUtil.trim(this.pass_txt.text);
            if (((_local_1.length == 0) || (_local_2.length == 0)))
            {
                AlertWin.show(Lang.msg("输入不能为空"), null);
                return;
            };
            this.writeLocal();
            this.dispatchEvent(new LoginEvent(_local_1, _local_2, this.ip_txt.text, true));
        }

        public function set loginTabBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1325435728loginTabBtn;
            if (_local_2 !== _arg_1)
            {
                this._1325435728loginTabBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginTabBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get saveUserSelected():Boolean
        {
            return (this._1180563037saveUserSelected);
        }

        private function registerHandle():void
        {
            if ((((this.regiserpass.text == "") || (this.regiserRepass.text == "")) || (this.regiserName.text == "")))
            {
                AlertWin.show(Lang.msg("输入不能为空"), null);
                return;
            };
            if (!validateEmail(this.regiserName.text))
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
            var _local_1:String = StringUtil.trim(this.regiserName.text);
            var _local_2:String = StringUtil.trim(this.regiserpass.text);
            this.dispatchEvent(new RegisterEvent(_local_1, _local_2, this.ip_txt.text, true));
        }

        private function onTermsLinkClick():void
        {
            navigateToURL(new URLRequest("http://www.evony.com/index.do?PageModule=Static&type=TandC"), "_blank");
        }

        public function set ip_txt(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1182526632ip_txt;
            if (_local_2 !== _arg_1)
            {
                this._1182526632ip_txt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ip_txt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get regiserRepass():TextInput
        {
            return (this._274626191regiserRepass);
        }

        public function set regiserPanel(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1794224423regiserPanel;
            if (_local_2 !== _arg_1)
            {
                this._1794224423regiserPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "regiserPanel", _local_2, _arg_1));
            };
        }

        public function __regiserpass_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        public function __user_txt_enter(_arg_1:FlexEvent):void
        {
            doLogin();
        }

        [Bindable(event="propertyChange")]
        public function get myViewstack():ViewStack
        {
            return (this._153085257myViewstack);
        }

        private function set default_password(_arg_1:String):void
        {
            var _local_2:Object = this._1114738393default_password;
            if (_local_2 !== _arg_1)
            {
                this._1114738393default_password = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "default_password", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get save_UserName():CheckBox
        {
            return (this._183119256save_UserName);
        }

        private function onForgetPwdLinkClick():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.password), "_blank");
        }

        public function set regiserSubmit(_arg_1:Button):void
        {
            var _local_2:Object = this._317625827regiserSubmit;
            if (_local_2 !== _arg_1)
            {
                this._317625827regiserSubmit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "regiserSubmit", _local_2, _arg_1));
            };
        }

        public function ___LoginPanel_LinkButton2_click(_arg_1:MouseEvent):void
        {
            onTermsLinkClick();
        }

        private function writeLocal():void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:int;
            var _local_1:SharedObject = SharedObject.getLocal(cookieName, "/");
            if (this.save_password.selected)
            {
                _local_1.data.password = pass_txt.text;
            }
            else
            {
                _local_1.data.password = "";
            };
            if (_local_1.data.OneAccountRecorded == null)
            {
                _local_1.data.username = user_txt.text;
            }
            else
            {
                _local_2 = "";
                if (ExternalInterface.available)
                {
                    _local_2 = ExternalInterface.call("getPageUrl");
                };
                _local_3 = "";
                if (((!(_local_2 == null)) && (_local_2.length > 0)))
                {
                    _local_4 = _local_2.indexOf("?debug=", 0);
                    if (_local_4 > 0)
                    {
                        _local_3 = _local_2.substring((_local_4 + 7)).toString();
                    };
                };
                if (_local_3 == "true")
                {
                    _local_1.data.DebugFlag = "true";
                }
                else
                {
                    if (_local_3 == "false")
                    {
                        _local_1.data.DebugFlag = "false";
                    };
                };
            };
            if (this.save_UserName.selected)
            {
                _local_1.data.username = user_txt.text;
            }
            else
            {
                _local_1.data.username = "";
            };
            _local_1.data.saveUserSelected = this.save_UserName.selected;
            _local_1.data.savePassSelected = this.save_password.selected;
            _local_1.data.useEnglish = MsgDispacther.getInstance().useEnglish;
            _local_1.data.ip = ip_txt.text;
            _local_1.data.DebugFlag = "true";
            _local_1.flush();
        }

        private function btnHandel(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 0:
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("adt_log", "civony_evony");
                    };
                    myViewstack.selectedChild = this.regiserPanel;
                    registerTabBtn.selected = true;
                    loginTabBtn.selected = false;
                    return;
                case 1:
                    myViewstack.selectedChild = this.loginPanel;
                    registerTabBtn.selected = false;
                    loginTabBtn.selected = true;
                    return;
            };
        }

        private function _LoginPanel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = GameConfig.instance.debugMode;
            _local_1 = EvonyClientVersion.VERSION;
            _local_1 = ("V " + EvonyVersion.VERSION);
            _local_1 = GameConfig.instance.debugMode;
            _local_1 = this.default_ip;
            _local_1 = MsgDispacther.getInstance().useEnglish;
            _local_1 = this.default_userName;
            _local_1 = Lang.msg("密码");
            _local_1 = this.default_password;
            _local_1 = Lang.msg("登录");
            _local_1 = Lang.msg("SaveUserName");
            _local_1 = this.saveUserSelected;
            _local_1 = Lang.msg("SavePassword");
            _local_1 = this.savePassSelected;
            _local_1 = Lang.msg("忘记密码的链接");
            _local_1 = (Lang.msg("邮箱") + ":");
            _local_1 = (Lang.msg("密码") + ":");
            _local_1 = (Lang.msg("确认密码") + ":");
            _local_1 = Lang.msg("注册并登陆");
            _local_1 = Lang.msg("试玩");
        }

        public function set useEnglish(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1069971177useEnglish;
            if (_local_2 !== _arg_1)
            {
                this._1069971177useEnglish = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useEnglish", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get default_ip():String
        {
            return (this._678651877default_ip);
        }

        public function stopLoginMovie():void
        {
        }

        private function _LoginPanel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (GameConfig.instance.debugMode);
            }, function (_arg_1:Boolean):void
            {
                this.visible = _arg_1;
            }, "this.visible");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = EvonyClientVersion.VERSION;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label1.text = _arg_1;
            }, "_LoginPanel_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("V " + EvonyVersion.VERSION);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label2.text = _arg_1;
            }, "_LoginPanel_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GameConfig.instance.debugMode);
            }, function (_arg_1:Boolean):void
            {
                _LoginPanel_HBox1.visible = _arg_1;
            }, "_LoginPanel_HBox1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.default_ip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ip_txt.text = _arg_1;
            }, "ip_txt.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (MsgDispacther.getInstance().useEnglish);
            }, function (_arg_1:Boolean):void
            {
                useEnglish.selected = _arg_1;
            }, "useEnglish.selected");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.default_userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                user_txt.text = _arg_1;
            }, "user_txt.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("密码");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label5.text = _arg_1;
            }, "_LoginPanel_Label5.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.default_password;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                pass_txt.text = _arg_1;
            }, "pass_txt.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("登录");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Button3.label = _arg_1;
            }, "_LoginPanel_Button3.label");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("SaveUserName");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                save_UserName.label = _arg_1;
            }, "save_UserName.label");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.saveUserSelected);
            }, function (_arg_1:Boolean):void
            {
                save_UserName.selected = _arg_1;
            }, "save_UserName.selected");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("SavePassword");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                save_password.label = _arg_1;
            }, "save_password.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.savePassSelected);
            }, function (_arg_1:Boolean):void
            {
                save_password.selected = _arg_1;
            }, "save_password.selected");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("忘记密码的链接");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_LinkButton1.label = _arg_1;
            }, "_LoginPanel_LinkButton1.label");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("邮箱") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label6.text = _arg_1;
            }, "_LoginPanel_Label6.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("密码") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label7.text = _arg_1;
            }, "_LoginPanel_Label7.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("确认密码") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Label8.text = _arg_1;
            }, "_LoginPanel_Label8.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("注册并登陆");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                regiserSubmit.label = _arg_1;
            }, "regiserSubmit.label");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("试玩");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LoginPanel_Button5.label = _arg_1;
            }, "_LoginPanel_Button5.label");
            result[19] = binding;
            return (result);
        }

        public function ___LoginPanel_Button5_click(_arg_1:MouseEvent):void
        {
            tryGame();
        }

        public function __registerTabBtn_click(_arg_1:MouseEvent):void
        {
            btnHandel(0);
        }

        private function set default_ip(_arg_1:String):void
        {
            var _local_2:Object = this._678651877default_ip;
            if (_local_2 !== _arg_1)
            {
                this._678651877default_ip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "default_ip", _local_2, _arg_1));
            };
        }

        private function onRegLinkClick():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.acount), "_blank");
        }


    }
}//package view

